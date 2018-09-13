FROM python:3
RUN pip install ruamel.yaml jsonschema click

COPY validator.py /
   
ENTRYPOINT ["./validator.py"]
CMD ["--help]