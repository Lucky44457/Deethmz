FROM mysterysd/wzmlx:latest

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Copy dependencies and install
COPY requirements.txt .
RUN pip3 install --upgrade setuptools wheel
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy bot code
COPY . .

# Start bot with healthcheck
CMD ["bash", "-c", "python3 healthcheck.py && bash start.sh"]
