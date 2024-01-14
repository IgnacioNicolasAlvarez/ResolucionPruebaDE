FROM python:3.11

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN useradd -m nonrootuser

RUN chown -R nonrootuser:nonrootuser /app

USER nonrootuser

CMD ["python", "main.py"]
