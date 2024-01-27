# Use the official Python image
FROM python:3.9-slim

# Arguments for user configuration
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG USERNAME=nonrootuser

# Create the user with limited sudo privileges
RUN if ! getent group $USERNAME > /dev/null; then groupadd --gid $USER_GID $USERNAME; fi \
    && if ! id -u $USERNAME > /dev/null; then useradd --uid $USER_UID --gid $USER_GID -m $USERNAME; fi \
    && apt-get update \
    && apt-get install -y --no-install-recommends sudo \
    && echo "$USERNAME ALL=(root) NOPASSWD:/usr/bin/pip,/usr/bin/uwsgi" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && rm -rf /var/lib/apt/lists/*

# Set the default user
USER $USER_UID:$USER_GID

# Set the working directory to /usr/src/app
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Install dependencies, including uwsgi
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# Expose the app port
EXPOSE 5000

# Create a separate uWSGI configuration file
COPY uwsgi.ini .

# Command to run uWSGI with the application
CMD ["uwsgi", "--ini", "uwsgi.ini"]
