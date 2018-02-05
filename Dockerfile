FROM python:2.7-slim
        # Set the working directory to /app
WORKDIR /cloudops
        # Copy the current directory contents into the container at /app
ADD . /cloudops

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt
