FROM python:3.9-alpine3.13
LABEL maintainer="github.com/guimassoqueto"

ENV PYTHONUNBUFFERED 1 

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false

RUN apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-build-deps \
        build-base postgresql-dev musl-dev

RUN python -m venv /py && \
    /py/bin/python -m pip install --upgrade pip && \
    /py/bin/python -m pip install -r /tmp/requirements.txt

RUN if [[ $DEV == "true" ]]; \
        then /py/bin/python -m pip install -r /tmp/requirements.dev.txt; \
    fi;

RUN rm -rf /tmp && apk del .tmp-build-deps

RUN adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"
USER django-user
