FROM python:3.9-slim

# Create working directory
WORKDIR /app

# Copy requirements.txt and install python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the service package
COPY service/ service/

# Create a non-root user called theia, change the ownership of the /app folder recursively to theia, and switch to the theia user
RUN useradd -u 1000 theia && chown -R theia:theia /app
USER theia

# Expose port 8080
EXPOSE 8080

# Run the app
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
