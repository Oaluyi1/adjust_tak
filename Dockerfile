# Set the default user
# Install dependencies, including uwsgi, in a separate stage to reduce image size
FROM python:3.9-slim-buster as build
ARG USER_UID=1000
ARG USER_GID=100
RUN groupadd -r app && useradd -r -g app -u ${USER_UID}
WORKDIR /app
COPY --chown=app:app . .
RUN pip install --upgrade pip --no-cache-dir \
    && pip install -r requirements.txt

# Copy the built dependencies from the build stage to the final stage
FROM python:3.9-slim-buster
USER app
WORKDIR /app
COPY --from=build /app /app

# Expose the app port
EXPOSE 5000

CMD ["uwsgi", "--ini", "uwsgi.ini"]