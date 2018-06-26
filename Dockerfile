# FROM python:3
# ENV VALIDATOR_DIR /validator

# RUN mkdir $VALIDATOR_DIR && \
#     pip install ruamel.yaml jsonschema

# ARG SCHEMA_DIR
# ARG CONFIG_DIR

# COPY ${CONFIG_DIR} /configs
# COPY ${SCHEMA_DIR} /schemas
# COPY config-validator.py $VALIDATOR_DIR
# WORKDIR $VALIDATOR_DIR
   
# ENTRYPOINT ["./config-validator.py"]
## CMD ["doc.yaml", "schema.json"]


FROM python:3
RUN pip install ruamel.yaml jsonschema

ARG SCHEMA_DIR
ARG CONFIG_DIR

COPY ${CONFIG_DIR} /configs
COPY ${SCHEMA_DIR} /schemas
COPY config-validator.py /
   
ENTRYPOINT ["./config-validator.py"]
# CMD ["doc.yaml", "schema.json"]