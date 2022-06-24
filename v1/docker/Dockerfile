FROM python:3.7.10-slim-buster

RUN echo 'nameserver 8.8.8.8'>/etc/resolv.conf
RUN apt-get update
RUN apt-get install -y apt-utils build-essential gcc

COPY webserver /webserver
RUN pip3 install -I -r /webserver/requirements.txt -v --no-cache-dir
EXPOSE 8080

ENTRYPOINT [ "python3", "/webserver/run.py" ]