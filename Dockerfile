FROM kalilinux/kali-rolling

LABEL maintainer="mcjon3z"

ARG BUILD_DATE
ARG VCS_REF

ARG TOOLS_BASE="dnsutils \
                git \
                curl \
                net-tools \
                pciutils \
                bash-completion"

#NOTE - metasploit installed in later build; not included in base
ARG TOOLS_KALI="crackmapexec \
                dirb \
                dnsenum \
                dnsmap \
                dnsrecon \
                enum4linux \
                fierce \
                hydra \
                ike-scan \
                impacket-scripts \
                joomscan \
                nbtscan \
                netcat \
                nfs-common \
                nikto \
                nmap \
                onesixtyone \
                python3-scrapy \
                recon-ng \
                responder \
                rpcbind \
                snmpcheck \
                sqlmap \
                sslscan \
                sslyze \
                theharvester \
                tcptraceroute \
                whatweb \
                whois \
                wpscan"

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends $TOOLS_BASE && \
    apt-get install -y --no-install-recommends $TOOLS_KALI && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
RUN git clone --depth=1 https://github.com/danielmiessler/SecLists /opt/SecLists && \
    rm -rf /opt/SecLists/.git && \
    rm -rf /opt/SecLists/*.gz && \
    rm -rf /opt/SecLists/Fuzzing && \
    rm -rf /opt/SecLists/IOCs && \
    rm -rf /opt/SecLists/Pattern-Matching && \
    rm -rf /opt/SecLists/Payloads && \
    rm -rf /opt/SecLists/Web-Shells && \
    rm -rf /opt/SecLists/Passwords/Cracked-Hashes && \
    rm -rf /opt/SecLists/Passwords/Honeypot-Captures && \
    rm -rf /opt/SecLists/Passwords/Leaked-Databases && \
    rm -rf /opt/SecLists/Passwords/Malware && \
    rm -rf /opt/SecLists/Passwords/Permutations && \
    rm -rf /opt/SecLists/Passwords/Software && \
    rm -rf /opt/SecLists/Passwords/WiFi-WPA
    
RUN git clone --depth=1 https://github.com/isaudits/scripts /opt/scripts && \
    rm -rf /opt/scripts/.git && \
    ln -s /opt/scripts/iker.py /usr/bin/iker && \
    ln -s /opt/scripts/email_crawler.py /usr/bin/email_crawler && \
    ln -s /opt/scripts/externalIP /usr/bin/externalIP && \
    git clone --depth=1 https://github.com/wereallfeds/webshag /opt/webshag && \
    rm -rf /opt/webshag/.git && \
    cd /opt/webshag/ && \
    echo -e "\n" | python setup.linux.py && \
    ln -s /opt/webshag/webshag_cli.py /usr/bin/webshag-cli

#RUN git clone --depth=1 -b dev https://github.com/DedSecInside/TorBot /opt/TorBot && \
#    cd /opt/TorBot/ && \
#    rm -rf .git && \
#    apt-get install -y python3-pyqt5 tor && \
#    pip3 install -r requirements.txt && \
#    ./install.sh && \
#    apt-get autoremove -y && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/*

#Bash completion
RUN printf "alias ll='ls $LS_OPTIONS -l'\nalias l='ls $LS_OPTIONS -lA'\n\n# enable bash completion in interactive shells\nif [ -f /etc/bash_completion ] && ! shopt -oq posix; then\n    . /etc/bash_completion\nfi\n" > /root/.bashrc

RUN mkdir /data

CMD ["/bin/bash"]

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/isaudits/docker-kali" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc1"