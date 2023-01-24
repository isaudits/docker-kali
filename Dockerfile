FROM kalilinux/kali-rolling

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="mcjon3z" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-url="https://github.com/isaudits/docker-kali" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.schema-version="1.0.0-rc1"

ARG TOOLS_BASE="dnsutils \
                wget \
                git \
                curl \
                net-tools \
                traceroute \
                tcptraceroute \
                iputils-ping \
                pciutils \
                openssh-server \
                mosh \
                zsh \
                python3 \
                python2"

#NOTE - metasploit installed in later build; not included in base
ARG TOOLS_KALI="crackmapexec \
                dirb \
                dnsenum \
                dnsmap \
                dnsrecon \
                enum4linux \
                exploitdb \
                fierce \
                hydra \
                ike-scan \
                impacket-scripts \
                joomscan \
                nbtscan \
                netcat-traditional \
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
                theharvester \
                tcptraceroute \
                whatweb \
                whois \
                wpscan"

# These fail to install on ARM version due to dependency issues
ARG TOOLS_linux/amd64="sslyze"

# Dummy install just so we don't pass an empty string to the install command
ARG TOOLS_linux/arm64="dnsutils"

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends $TOOLS_BASE && \
    apt-get install -y --no-install-recommends $TOOLS_KALI && \
    apt-get install -y --no-install-recommends $TOOLS_${TARGETARCH} && \
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
    ln -s /opt/scripts/externalIP /usr/bin/externalIP

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended" && \
    chsh -s $(which zsh)

RUN mkdir /data 

CMD ["/bin/zsh"]