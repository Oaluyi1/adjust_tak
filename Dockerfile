# official Python image
FROM python:3.9-slim-buster

# set the working directory to /app
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# expose the app port
EXPOSE 5000

# run the app.py when the container launches
CMD ["python", "app.py"]
