FROM python:3.9-slim-buster
LABEL maintainer="jpark@keti.re.kr"
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
EXPOSE 8080
ENTRYPOINT ["python"]
CMD ["app/app.py"]
