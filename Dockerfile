# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Install git
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    unzip && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get install -y git \
    pip install gdown

# Set the working directory in the container
WORKDIR /app

# Download the zip file from Google Drive
RUN gdown "https://drive.google.com/uc?id=1X76smI1ZPtaVXWqBBIxA4OWGNeBuuhQ9" -O model.zip

# Extract the contents of the zip file
RUN unzip model.zip -d tts_models && \
    rm model.zip

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 5000 available to the world outside this container (if applicable)
EXPOSE 5000

# Command to run your application (replace 'main.py' with your script)
CMD ["python", "dubbing.py", "--link", "https://www.youtube.com/watch?v=fsoi6faumrw"]
