#!/bin/bash

# Activate virtual environment
source /app/mltbenv/bin/activate

# Run update.py and then bot
python3 update.py && python3 -m bot
