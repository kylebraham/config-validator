#!/usr/bin/env python3
import sys, json, os, jsonschema, click
from ruamel.yaml import YAML

###################################################################################
###################################################################################
###################################################################################

def load_file (file_data):
    yaml=YAML(typ='safe')
    try:
        file_load = yaml.load(file_data)
    except yaml.YAMLError as yaml_error:
        print(yaml_error)
        sys.exit()
    return file_load

def load_multi_doc_file (file_data):
    yaml=YAML(typ='safe')
    try:
        multi_doc_load = yaml.load_all(file_data)
    except yaml.YAMLError as yaml_error:
        print(yaml_error)
        sys.exit()
    return multi_doc_load

def is_valid(doc, schema):
    result =''
    try:
        result=jsonschema.validate(doc, schema)
    except jsonschema.exceptions.ValidationError as json_schema_error:
        result = json_schema_error
    return result

###################################################################################
###################################################################################
###################################################################################

@click.command()
@click.option('--verbose', is_flag=True ,default=False, help="Enables verbose messages.")
@click.argument('config_file', type=click.File('rb'))
@click.argument('schema_file', type=click.File('rb'))

def validate_config(config_file, schema_file, verbose):
    """Validates a CONFIG_FILE using a (JSON) SCHEMA_FILE."""
    loaded_schema=load_file(schema_file)

    for doc in load_multi_doc_file(config_file):
        r = is_valid(doc, loaded_schema)
        if (r):
            print ("Validation Faild:")
            if (verbose):
                print("\nSchema:\n {} \nConfig:\n {}".format(loaded_schema, doc) )
            print("\n\n {}".format(r) )
        else:
            print("{} is valid.".format( os.path.basename(config_file.name) ) )


###################################################################################
###################################################################################
###################################################################################

if __name__ == '__main__':
    validate_config()