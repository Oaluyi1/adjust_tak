# Use the official Python image
FROM python:3.9-slim

# Arguments for user configuration
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG USERNAME=nonrootuser

# Set the default user
USER $USER_UID:$USER_GID

# Set the working directory to /app
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /app
COPY . /usr/src/app

# Install dependencies, including gunicorn
RUN pip install --upgrade pip \
    && pip install -vvv -r requirements.txt

# Expose the app port
EXPOSE 5000

# Command to run Gunicorn with the application
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
