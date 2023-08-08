FROM python:3.9
WORKDIR /app

COPY FlaskApp /app
COPY MySQL_Queries /docker-entrypoint-initdb.d

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

EXPOSE 5002
CMD ["python", "app.py"]
