FROM python:3
RUN pip install ruamel.yaml jsonschema click

ARG SCHEMA_DIR
ARG CONFIG_DIR

COPY ${CONFIG_DIR} /configs
COPY ${SCHEMA_DIR} /schemas
COPY config-validator.py /
   
ENTRYPOINT ["./validator.py"]
CMD ["--help]