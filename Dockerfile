FROM metabrainz/python:3.8-20201201

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                       build-essential \
                       git \
                       libpq-dev \
                       libffi-dev \
                       libssl-dev \
                       sudo \
    && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /bin/bash art

WORKDIR /home/art/artwork-redirect
RUN chown art:art /home/art/artwork-redirect

# Python dependencies
RUN sudo -E -H -u art pip install --user -U cffi
COPY requirements.txt ./
RUN sudo -E -H -u art pip install --user -r requirements.txt

COPY . ./
RUN chown -R art:art ./

############
# Services #
############

COPY ./docker/prod/redirect.service /etc/service/redirect/run
COPY ./docker/prod/uwsgi.ini /etc/uwsgi/

RUN chmod 755 /etc/service/redirect/run

# Configuration
COPY ./docker/prod/consul-template-redirect.conf /etc/

EXPOSE 8080
