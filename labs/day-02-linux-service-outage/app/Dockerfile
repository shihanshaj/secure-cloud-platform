FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1
WORKDIR /srv/app
COPY requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
COPY main.py ./main.py
EXPOSE 8000
CMD ["sh", "-c", "exec uvicorn main:app --host \"${API_HOST:-0.0.0.0}\" --port 8000 --no-access-log"]
