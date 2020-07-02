FROM nvidia/cuda:10.0-base

RUN ln -snf /bin/bash /bin/sh

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV DEVICE cpu

RUN apt-get -y update && apt-get -y install python-dev python3 python3-dev python3-setuptools python3-pip

RUN pip3 install virtualenv

# virtualenv
WORKDIR /home
RUN mkdir ubuntu
WORKDIR /home/ubuntu
RUN mkdir app
WORKDIR /home/ubuntu/app
RUN virtualenv -p /usr/bin/python3 venv

# requirements
COPY requirements.txt /home/ubuntu/requirements.txt
RUN /bin/bash -c "source /home/ubuntu/app/venv/bin/activate && pip3 install -r /home/ubuntu/requirements.txt"

COPY . /home/ubuntu/app/
WORKDIR /home/ubuntu/app

EXPOSE 80

CMD /bin/bash -c "source /home/ubuntu/app/venv/bin/activate && python job.py"
