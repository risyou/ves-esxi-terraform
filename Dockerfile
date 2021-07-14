FROM buildpack-deps:curl
USER root
ADD VMware-ovftool-4.4.1-16812187-lin.x86_64.bundle /tmp/
WORKDIR /ves-esxi-lab/
ADD variable.tf version.tf main.tf /ves-esxi-lab/
RUN apt-get update \
 && apt-get install -y --no-install-recommends nano unzip\
 && rm -rf /var/lib/apt/lists/*

RUN wget https://releases.hashicorp.com/terraform/1.0.2/terraform_1.0.2_linux_amd64.zip \
 && unzip terraform_1.0.2_linux_amd64.zip -d /usr/local/bin/\
 && rm terraform_1.0.2_linux_amd64.zip

RUN sh /tmp/VMware-ovftool-4.4.1-16812187-lin.x86_64.bundle -p /usr/local --eulas-agreed --required \
 && rm -f VMware-ovftool-4.4.1-16812187-lin.x86_64.bundle

CMD [ "/bin/sh"]
