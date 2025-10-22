#!/usr/bin/env python3
import json
import sys
import os
import subprocess
from datetime import datetime

# Log to file for debugging
with open('/tmp/claude_hook_debug.log', 'a') as f:
    f.write(f"{datetime.now()}: Stop hook triggered\n")

# Check kill switch
if os.path.exists('/tmp/claude_stop_now'):
    os.remove('/tmp/claude_stop_now')
    with open('/tmp/claude_hook_debug.log', 'a') as f:
        f.write(f"{datetime.now()}: Kill switch found, exiting\n")
    sys.exit(0)

# Write the command we want to execute next
with open('/tmp/claude_next_command', 'w') as f:
    f.write('YOUR_PROMPT_HERE')

with open('/tmp/claude_hook_debug.log', 'a') as f:
    f.write(f"{datetime.now()}: Command written, killing claude\n")

# Send SIGINT to claude-code
result = subprocess.run(['pkill', '-INT', '-f', 'claude'])

with open('/tmp/claude_hook_debug.log', 'a') as f:
    f.write(f"{datetime.now()}: pkill result: {result.returncode}\n")

sys.exit(0)
