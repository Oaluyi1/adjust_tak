# Official Python image
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

# Copy only the requirements file into the container at /app
COPY requirements.txt /usr/src/app/requirements.txt

RUN pip install --upgrade pip --no-cache-dir 
# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose the app port
EXPOSE 5000

# Run the app using python command and disabling the development server message
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0", "--port=5000"]

