
# Docker container with Jupyter Notebook for Python 3 and R

## What it gives you?
	
* Jupyter Notebook last version
* Support Python and R 
* R base-core with common utilities
* devtools
	

## Basic Use 
	
To start use this container you must run this command:

```
docker run -it --rm -p 8888:8888 joyndjama/rjupyter
```
Note that to run this command you must be in root mode, so if not you may add a sudo before running this command.
The execution of this command will provide you an url with a randomly generated authentication token. You have the choice either to use that link or to connect through you browser using the address you want with the 8888 port and the generated token as parameter.

## Docker hub

You can also pull this container through the docker hub by running this command:

```
docker pull joyndjama/rjupyter
```

Or you can browse the [repository](https://hub.docker.com/r/joyndjama/rjupyter/)
	
