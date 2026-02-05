#!/usr/bin/env node

// Usage: ./disable-all-workflows.js <owner> <repo>
// Written by AI

const util = require('util');
const exec = util.promisify(require('child_process').exec);

async function main() {
  if (process.argv.length !== 4) {
    console.error('Usage: node disable-all-workflows.js <owner> <repo>');
    process.exit(1);
  }

  const owner = process.argv[2];
  const repo = process.argv[3];

  // ensure GH CLI is logged in
  try {
    await exec('gh auth status');
  } catch (error) {
    console.error('❌ GitHub CLI not authenticated. Run \'gh auth login\' first.');
    process.exit(1);
  }

  // get IDs of only active workflows
  let activeIds = [];
  try {
    const { stdout } = await exec(
      `gh api --method GET /repos/${owner}/${repo}/actions/workflows --paginate --jq '.workflows[] | select(.state=="active") | .id'`
    );
    
    const trimmed = stdout.trim();
    if (trimmed) {
      activeIds = trimmed.split('\n').map(id => id.trim());
    }
  } catch (error) {
    console.error(`Failed to fetch workflows: ${error.message}`);
    process.exit(1);
  }

  if (activeIds.length === 0) {
    console.log(`No active workflows to disable in ${owner}/${repo}.`);
    process.exit(0);
  }

  for (const id of activeIds) {
    process.stdout.write(`Disabling workflow ID ${id}… `);
    try {
      await exec(`gh api --method PUT /repos/${owner}/${repo}/actions/workflows/${id}/disable`);
      console.log('OK');
    } catch (error) {
      console.log('FAILED');
    }
  }

  console.log(`✅ Done—disabled all active workflows in ${owner}/${repo}.`);
}

main().catch(error => {
  console.error(error);
  process.exit(1);
});
