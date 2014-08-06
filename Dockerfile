FROM ubuntu:14.04
MAINTAINER Frank Lemanschik @ DirektSPEED Europe <frank@dspeed.eu>
# Adding new ubuntu 14.04 Mirror sources to speed the things up
RUN rm -rf /etc/apt/sources.list
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse" > /etc/apt/sources.list
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse" >> /etc/apt/sources.list
# Update APT Source
RUN apt-get -y update #makesure
RUN apt-get install -y docker.io git build-essential wget
RUN git clone https://github.com/docker/docker
# TODO: Make it auto Create the File
RUN wget https://raw.githubusercontent.com/DirektSPEED/docker-nightly-build/master/run
# Make Symbolic link to Ubuntu Docker Package
RUN ln -s /usr/bin/docker.io /usr/bin/docker
# Make build & upload script execute able
# TODO: Rename to /build-binary --upload ftp://user:pass@host.tld git://user:pass@github.com/username/repo s3://username:pass
RUN chmod +x /run.1
# Clean up apt-get to save some space.
RUN apt-get -y clean
CMD /run.1
