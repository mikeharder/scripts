#!/usr/bin/env node

const util = require('util');
const exec = util.promisify(require('child_process').exec);

const packages = [
    "@azure-tools/typespec-apiview",
    "@azure-tools/typespec-autorest",
    "@azure-tools/typespec-azure-core",
    "@azure-tools/typespec-azure-resource-manager",
    "@azure-tools/typespec-client-generator-core",
    "@azure-tools/typespec-providerhub",
    "@typespec/compiler",
    "@typespec/http",
    "@typespec/openapi",
    "@typespec/openapi3",
    "@typespec/rest",
    "@typespec/versioning",
];

async function getPackageVersion(packageName) {
    const { stdout } = await exec(`npm view ${packageName} version`);
    return stdout.trim();
}

async function printVersionsInOrder() {
    const promises = packages.map(async (package) => {
        const version = await getPackageVersion(package);
        return { package, version };
    });

    const results = await Promise.all(promises);

    results.forEach(({ package, version }) => {
        console.log(`${package}: ${version}`);
    });
}

printVersionsInOrder().catch(console.error);
