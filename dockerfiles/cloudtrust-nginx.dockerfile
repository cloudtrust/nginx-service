FROM cloudtrust-baseimage:f27

ARG service_git_tag

ARG nginx_version=1.12.1-1.fc27

RUN dnf update -y && \
    dnf install -y nginx-$nginx-version && \
    dnf clean all

WORKDIR /cloudtrust
RUN git clone git@github.com:cloudtrust/nginx-service.git

WORKDIR /cloudtrust/nginx-service
RUN git checkout ${service_git_tag} && \
    install -m664 deploy/etc/systemd/system/nginx.service /etc/systemd/system/nginx.service

RUN systemctl enable nginx
