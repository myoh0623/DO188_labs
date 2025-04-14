FROM registry.access.redhat.com/ubi8/python-39

WORKDIR /app

# 코드 복사
COPY ./fastapi_app /app

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]