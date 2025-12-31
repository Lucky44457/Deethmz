#!/bin/bash
# Make sure this script is executable: chmod +x start.sh

# Run update.py using venv Python
./mltbenv/bin/python3 update.py

# Start the bot using venv Python
./mltbenv/bin/python3 -m bot
