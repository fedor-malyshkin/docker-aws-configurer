FROM ubuntu:20.04

RUN apt-get update && apt -y --no-install-recommends install curl unzip wget gnupg software-properties-common ca-certificates python3.8 python3-pip python3.8-venv
# terraform (https://learn.hashicorp.com/tutorials/terraform/install-cli)
RUN wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/hashicorp.list
RUN apt update && apt-get install terraform
# AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip &&  ./aws/install

RUN mkdir -p  /configurer
COPY docker-entrypoint.sh /configurer

RUN chmod +x /configurer/docker-entrypoint.sh
WORKDIR /configurer
ENTRYPOINT ["./docker-entrypoint.sh"]



