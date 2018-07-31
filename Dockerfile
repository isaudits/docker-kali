FROM kalilinux/kali-linux-docker

LABEL maintainer="mcjon3z"

RUN apt-get -y update && apt-get -y upgrade && \
   apt-get install -y \
   crackmapexec \
   dirb \
   dnsenum \
   dnsmap \
   dnsrecon \
   enum4linux \
   fierce \
   hydra \
   ike-scan \
   joomscan \
   metasploit-framework \
   nbtscan \
   nikto \
   nmap \
   recon-ng \
   snmpcheck \
   sqlmap \
   theharvester \
   tcptraceroute \
   whois \
   wpscan \
   dnsutils \
   curl \
   net-tools \
   pciutils \
   bash-completion && \
   apt-get autoremove -y && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/*

#Bash completion
RUN printf "alias ll='ls $LS_OPTIONS -l'\nalias l='ls $LS_OPTIONS -lA'\n\n# enable bash completion in interactive shells\nif [ -f /etc/bash_completion ] && ! shopt -oq posix; then\n    . /etc/bash_completion\nfi\n" > /root/.bashrc

RUN mkdir /data

CMD "/bin/bash"