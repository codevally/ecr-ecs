FROM centos:centos7
MAINTAINER Roshan Pradeep <codevally@gmail.com>

RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install python-pip; yum clean all

ADD . /src

RUN cd /src; pip install -r requirements.txt

EXPOSE 5000

CMD ["python", "/src/routes.py"]
