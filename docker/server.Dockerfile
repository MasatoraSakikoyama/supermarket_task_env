FROM python:3.13-slim

RUN apt-get update \
    && apt-get install -y build-essential curl default-mysql-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install pipenv
RUN pip install --no-cache-dir pipenv

# Copy Pipfile and Pipfile.lock
COPY Pipfile ./
COPY Pipfile.lock ./

# Install dependencies using pipenv (system-wide, not in a virtualenv)
# RUN pipenv install --dev --system --skip-lock
RUN pipenv install --dev --deploy --system --ignore-pipfile

# Copy the rest of the application
COPY . .

# Expose the FastAPI port
EXPOSE 8000

# Start the FastAPI server
CMD ["python", "-m", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
