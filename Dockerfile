FROM python:3.8-slim-buster

ARG PUID=1000
ENV PYTHONIOENCODING=utf-8

RUN set -x \
        && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo 'Asia/Shanghai' >/etc/timezone \
        && apt-get clean \
        && apt-get update \
        && apt-get install git gcc linux-libc-dev libc6-dev -y --no-install-recommends --no-install-suggests \
        && useradd -u $PUID -m HoshinoBot \
        && su HoshinoBot -c "mkdir -p /home/HoshinoBot/HoshinoBot"

USER HoshinoBot

WORKDIR /home/HoshinoBot

COPY ./* /home/HoshinoBot/HoshinoBot/

RUN pip3 install -r /home/HoshinoBot/HoshinoBot/requirements.txt

EXPOSE 9222

VOLUME /home/HoshinoBot/HoshinoBot

ENTRYPOINT python3 /home/HoshinoBot/HoshinoBot/run.py