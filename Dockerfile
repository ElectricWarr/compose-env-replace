FROM python:3.6.4-alpine3.7

RUN pip3 install pyyaml
COPY scripts/compose-var-munge.py /munge.py

WORKDIR /work

ENTRYPOINT ["python3","/munge.py"]

