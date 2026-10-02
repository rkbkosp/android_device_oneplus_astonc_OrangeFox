#!/usr/bin/env python3
"""Supply measured target OS identity to recovery's QTI KeyMint constructor.

Host packaging only: no device access, runtime property spoof command, or
changes to compiled SDK/API and boot/AVB version fields. See CRYPTO_NOTES.md.
"""
import argparse
import datetime
import json
from pathlib import Path
import re

parser = argparse.ArgumentParser()
parser.add_argument('properties', type=Path)
parser.add_argument('inventory', type=Path)
args = parser.parse_args()
inventory = json.loads(args.inventory.read_text())
baseline = inventory['recovery_userspace']
expected = {
    'ro.build.version.release': inventory['system_release'],
    'ro.build.version.security_patch': inventory['system_security_patch'],
}
original = {
    'ro.build.version.release': baseline['release'],
    'ro.build.version.security_patch': baseline['system_security_patch'],
}
if not re.fullmatch(r'\d+(?:\.\d+){0,2}', expected['ro.build.version.release']):
    raise SystemExit('Invalid recorded target system release')
datetime.date.fromisoformat(expected['ro.build.version.security_patch'])
lines = args.properties.read_text().splitlines(keepends=True)
values = {}
for line in lines:
    if line.startswith('#') or '=' not in line:
        continue
    name, value = line.rstrip('\n').split('=', 1)
    values.setdefault(name, []).append(value)
if values.get('ro.build.version.sdk') != [baseline['sdk']]:
    raise SystemExit('Recovery SDK differs from pinned userspace; refuse identity rewrite')
for name, target in expected.items():
    if values.get(name) not in ([original[name]], [target]):
        raise SystemExit(f'Unexpected or duplicate recovery property: {name}')
new_lines = []
for line in lines:
    name = line.split('=', 1)[0]
    new_lines.append(f'{name}={expected[name]}\n' if name in expected else line)
args.properties.write_text(''.join(new_lines))
print('Recovery KeyMint OS identity uses measured target values; SDK stays', baseline['sdk'])
