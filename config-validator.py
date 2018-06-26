#!/usr/bin/env python3
import sys, json, os
from jsonschema import validate
from ruamel.yaml import YAML

def validate_config(config_file, schema_file):
    with open(config_file) as f:
       yaml=YAML(typ='safe')
       try:
           for doc in yaml.load_all(f): 
               validate(doc, load_schema(schema_file))
       except yaml.YAMLError as exc:
           print(exc)
    return config_file + " is valid ... "

def load_schema (file_path):
    yaml=YAML(typ='safe')
    with open(file_path) as f:
        try:
            schema_data = yaml.load(f)
        except yaml.YAMLError as exc:
            print(exc)
    return schema_data

if sys.argv[1] and sys.argv[2]:
    config = '/configs/' + sys.argv[1]
    schema = '/schemas/' + sys.argv[2]

    print (validate_config(config, schema))