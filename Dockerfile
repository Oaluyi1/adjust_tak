# Use the official Python image
FROM python:3.9-slim

# Arguments for user configuration
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG USERNAME=nonrootuser

# Create the user with limited sudo privileges
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y --no-install-recommends sudo \
    && echo "$USERNAME ALL=(root) NOPASSWD:/usr/bin/pip,/usr/local/bin/gunicorn" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && rm -rf /var/lib/apt/lists/*

# Set the default user
USER $USER_UID:$USER_GID

# Set the working directory to /app
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /app
COPY . /usr/src/app

# Install dependencies, including gunicorn
RUN pip install --upgrade pip \
    && pip install -r requirements.txt \
    && pip install gunicorn

# Expose the app port
EXPOSE 5000

# Command to run Gunicorn with the application
CMD ["/usr/local/bin/gunicorn", "-w", "4", "--bind", "0.0.0.0:5000", "--preload", "app:app"]
