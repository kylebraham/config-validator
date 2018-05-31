FROM python:2.7 as builder
ENV OPENSHIFT_SCHEMAS_DIR /openshift-schemas/
COPY get-schemas $OPENSHIFT_SCHEMAS_DIR
WORKDIR $OPENSHIFT_SCHEMAS_DIR
RUN  pip install openapi2jsonschema && \
    ./get-schemas


FROM python:3
ENV VALIDATOR_DIR /validator/
ENV OPENSHIFT_SCHEMAS_DIR /openshift-schemas/ 
COPY --from=builder /openshift-schemas/ $OPENSHIFT_SCHEMAS_DIR
COPY config-validator.py $VALIDATOR_DIR
COPY tests $VALIDATOR_DIR/tests/
WORKDIR $VALIDATOR_DIR
RUN pip install ruamel.yaml jsonschema    

ENTRYPOINT ["./config-validator.py"]
CMD ["tests/doc.yaml", "tests/schemas/schema.json"]