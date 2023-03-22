#! /bin/bash

function install_dependencies {
  # This command creates a new virtual environment called python 
  # using the Python 3.8 interpreter located at /usr/bin/python3.8
  virtualenv --python=/usr/bin/python3.8 python

  # This command activates the virtual environment created in the previous step. 
  # Activating the virtual environment ensures that any Python packages installed 
  # using `pip` are installed into the virtual environment rather than the system 
  # Python installation.
  source python/bin/activate

  # This command installs the Python packages listed in `requirements.txt` into 
  # the python/lib/python3.8/site-packages directory of the virtual environment. 
  # The `-t` option specifies the target directory for installation.
  pip install -r requirements.txt -t python/lib/python3.8/site-packages


  # This command packages the contents of the `python` directory (i.e., the virtual environment and its installed packages) 
  # into a zip file called `python.zip` 
  # The `-r` option tells zip to include subdirectories and 
  # their contents recursively, and the `-9` option specifies the compression level (highest).
  zip -r9 python.zip python

  # mkdir psycopg3
  # mv python.zip pyscopg3
}

install_dependencies