FROM ubuntu:latest
MAINTAINER Joy NDJAMA <joy.ndjama@gmail.com>

RUN apt-get update
RUN apt-get -y upgrade

RUN DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common

RUN add-apt-repository "deb http://cran.rstudio.com/bin/linux/ubuntu $(lsb_release -sc)/" && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 

RUN add-apt-repository ppa:marutter/rdev &&\
    add-apt-repository ppa:jonathonf/python-3.6

RUN apt-get update && apt-get -y install \
	 r-base --allow-unauthenticated \
	 libzmq3-dev \
	 libcurl4-openssl-dev \
 	 libssl-dev \
	 python3.6 \
	 python3-pip

RUN pip3 install --upgrade pip
RUN pip3 install jupyter

RUN su - -c "R -e \"install.packages(c('crayon', 'pbdZMQ', 'devtools'), repos = 'http://cran.rstudio.com/')\""  &&\
	 su - -c "R -e \"devtools::install_github(paste0('IRkernel/', c('repr', 'IRdisplay', 'IRkernel')))\""  &&\
	su - -c "R -e \"IRkernel::installspec(user = FALSE)\""

RUN su - -c "R -e \"install.packages('swirl', repos = 'https://cloud.r-project.org/')\""

#Configure environment //idea comming from https://github.com/jupyter/docker-stacks

ENV JN_USER=joy \
    JN_UID=1000 \
    JN_GID=100 
    
ENV HOME=/home/$JN_USER


# Create joy user with UID=1000 and in the 'users' group
# and make sure these dirs are writable by the `users` group.
RUN useradd -m -s /bin/bash -N -u $JN_UID $JN_USER && \
    chmod 764 $HOME 

EXPOSE 8888
WORKDIR $HOME

CMD jupyter notebook --ip=*
USER $JN_USER
