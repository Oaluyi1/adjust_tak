# official Python image
FROM python:3.10-buster

#set the working directory to /app
WORKDIR /app

# Copy only the requirements file into the container at /app
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . /app/


#expose the app port
EXPOSE 5000

#run the app.py when the container launches
#CMD ["python", "app/app.py"]
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app.app:app"]