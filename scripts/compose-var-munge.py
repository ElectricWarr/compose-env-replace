#!/usr/bin/env python
# Written for Python 3.
# Author: Michael Warr

'''
Will replace the environment section of each service in a Compose file,
given a CSV file called 'environment.csv' and a docker-compose file called 'docker-compose.yml'.

A new file is created, the original is not overwritten unless you specify the "output" option as the same as the input.

The CSV must contain the following column headings in the first line:
  - 'Service':      Values must match service names in Compose file
  - 'Env Variable': Variable names to be applied
  - 'Value':        Value of this variable for the relevant service
'''

# -- Imports --

import argparse, csv, os, yaml

# -- Init/Variables --

workdir = '/work'

# -- Arguments --
def parse_args():
  ap = argparse.ArgumentParser('Modifies the environment variables in a Docker Compose file based on an input csv')
  ap.add_argument('-i', '--input',
                  type=str,
                  required=False,
                  default='docker-compose.yml',
                  help='Input path to docker-compose file'
  )
  ap.add_argument('-o', '--output',
                  type=str,
                  required=False,
                  default='docker-compose-mungified.yml',
                  help='Output path to docker-compose file'
  )
  ap.add_argument('-v', '--vars',
                  type=str,
                  required=False,
                  default='environment.csv',
                  help='Path to variables CSV file'
  )
  return ap.parse_args()


# Argument setup
args = parse_args()

# Apply path prefix
compose_in_path = os.path.join(workdir, args.input)
compose_out_path = os.path.join(workdir, args.output)
env_path = os.path.join(workdir, args.vars)

# Get new environment details
with open(env_path, 'r') as env_in:
  env_reader = csv.DictReader(env_in, dialect='excel')
  full_newenv = {}
  for row in env_reader:
    if row['Service'] not in full_newenv:
      full_newenv[row['Service']] = {}
    full_newenv[row['Service']][row['Env Variable']] = row['Value']

# Get compose data
with open(compose_in_path, 'rb') as compose_in:
  try:
    compose = yaml.safe_load(compose_in)
  except yaml.YAMLError as exception:
    print(exception)

# Process
for service in compose['services']:
  if 'environment' in compose['services'][service]:
    compose['services'][service]['environment'] = full_newenv[service]

# Write out compose data
with open(compose_out_path, 'w') as compose_out:
  try:
    yaml.dump(compose, compose_out, default_flow_style=False)
  except yaml.YAMLError as exception:
    print(exception)
