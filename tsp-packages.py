#!/usr/bin/env python3

import asyncio
import subprocess

packages = [
    "@azure-tools/typespec-apiview",
    "@azure-tools/typespec-autorest",
    "@azure-tools/typespec-azure-core",
    "@azure-tools/typespec-autorest",
    "@azure-tools/typespec-azure-core",
    "@azure-tools/typespec-azure-resource-manager",
    "@azure-tools/typespec-client-generator-core",
    "@azure-tools/typespec-providerhub",
    "@typespec/compiler",
    "@typespec/http",
    "@typespec/openapi",
    "@typespec/rest",
    "@typespec/versioning",
]

async def get_package_version(package_name):
    process = await asyncio.create_subprocess_exec(
        'npm', 'view', package_name, 'version',
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.PIPE
    )
    stdout, _ = await process.communicate()
    return package_name, stdout.decode().strip()

async def print_versions_in_order():
    tasks = [get_package_version(package) for package in packages]
    results = await asyncio.gather(*tasks)

    for package, version in results:
        print(f'{package}: {version}')

asyncio.run(print_versions_in_order())
