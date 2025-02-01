# Use lightweight Python base image
FROM python:3.9-slim

# Set working directory
WORKDIR /src

# Copy files
COPY app/ /src/ 

# upgrade pip and install dependencies
RUN python3 -m pip install --upgrade pip
RUN pip3 install --no-cache-dir -r requirements.txt

# Add a non-root user with a specific UID and group
RUN adduser --uid 1942 --disabled-password --gecos "" myuser

#change to the non-root user by UID
USER 1942

# Expose the app
EXPOSE 8085

# Run the Python file
CMD ["python", "main.py"]
