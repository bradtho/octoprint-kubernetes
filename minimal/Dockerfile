ARG PYTHON_BASE_IMAGE=3.11-slim-bookworm

FROM python:${PYTHON_BASE_IMAGE} AS build

SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  libffi-dev
  
RUN groupadd --gid 1000 octoprint \
  && useradd --uid 1000 --gid octoprint -G dialout --shell /bin/bash -m octoprint \
  && mkdir -p /octoprint/octoprint /octoprint/plugins \
  && chown -R octoprint:octoprint /octoprint

USER octoprint

WORKDIR /home/octoprint

SHELL ["/bin/bash", "-c"]
RUN	mkdir octoprint && cd octoprint \
  && python3 -m venv venv \
  && source venv/bin/activate \
  && pip install --no-cache-dir octoprint

WORKDIR /home/octoprint/octoprint/venv/bin  

VOLUME /octoprint
EXPOSE 5000

CMD ["/home/octoprint/octoprint/venv/bin/octoprint", "--basedir", "/octoprint/octoprint", "serve"]
