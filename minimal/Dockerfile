ARG PYTHON_BASE_IMAGE=3-slim-bookworm

FROM python:${PYTHON_BASE_IMAGE} AS build

SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  libffi-dev
  
RUN groupadd --gid 1000 octoprint \
  && useradd --uid 1000 --gid octoprint -G dialout --shell /bin/bash -m octoprint \
  && mkdir -p /octoprint/octoprint /octoprint/plugins \
  && chown -R octoprint:octoprint /octoprint

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

USER octoprint

WORKDIR /home/octoprint

SHELL ["/bin/bash", "-c"]
RUN	mkdir octoprint \
  && python3 -m venv octoprint \
  && source octoprint/bin/activate \
  && pip install --no-cache-dir octoprint \
  && pip install --no-cache-dir "https://github.com/tg44/OctoPrint-Prometheus-Exporter/archive/master.zip" \
  && rm -r .cache

USER root
SHELL ["/bin/bash", "-c"]
RUN apt-get purge build-essential libffi-dev -y && apt-get autoremove -y && apt-get clean -y

USER octoprint

VOLUME /octoprint
EXPOSE 5000

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["./octoprint/bin/octoprint", "--basedir", "/octoprint/octoprint", "serve"]
