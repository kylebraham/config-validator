FROM python:3
COPY . /validate
WORKDIR /validate
RUN pip install ruamel.yaml jsonschema 
ENTRYPOINT ["./config-validator.py"]
CMD ["test-files/doc.yaml", "schemas/schema.json"]