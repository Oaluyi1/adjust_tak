# Use the official Python image
FROM python:3.11.3-slim-buster

# Arguments
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG USERNAME=nonrootuser

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y --no-install-recommends sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && rm -rf /var/lib/apt/lists/*

# Set the default user
USER $USER_UID:$USER_GID

# Set the working directory to /app
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /app
COPY . /usr/src/app

# Separate the pip install commands
RUN pip install --upgrade pip --no-cache-dir
RUN pip install --no-cache-dir -r requirements.txt

# Update pip and install uwsgi
RUN pip install --upgrade pip
RUN pip install uwsgi

# Expose the app port
EXPOSE 5000

# Command to run uWSGI with the application
CMD ["uwsgi", "--http", "0.0.0.0:5000", "--module", "app:app", "--processes", "4", "--threads", "2", "--master"]
