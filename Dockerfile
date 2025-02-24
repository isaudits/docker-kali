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
                # remove gcc after pip packages are installed
                gcc \
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
                # remove python3-dev after pip packages are installed
                python3-dev \ 
                python3-libnmap \
                python3-pip \
                python3-venv \
                python2 \
                pipx \
                nano \
                gh"

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

RUN apt update && \
    apt dist-upgrade -y && \
    apt install -y --no-install-recommends $TOOLS_BASE && \
    apt install -y --no-install-recommends $TOOLS_KALI && \
    apt install -y --no-install-recommends $TOOLS_${TARGETARCH} && \
    pipx install bbot && \
    apt remove -y gcc python3-dev && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
    
RUN git clone --depth=1 https://github.com/danielmiessler/SecLists /opt/SecLists && \
    rm -rf /opt/SecLists/.git* && \
    rm -rf /opt/SecLists/*.gz && \
    rm -rf /opt/SecLists/Ai && \
    rm -rf /opt/SecLists/Discovery/Web-Content/dutch && \
    rm -rf /opt/SecLists/Fuzzing && \
    rm -rf /opt/SecLists/IOCs && \
    rm -rf /opt/SecLists/Miscellaneous && \
    rm -rf /opt/SecLists/Pattern-Matching && \
    rm -rf /opt/SecLists/Passwords/BiblePass && \
    rm -rf /opt/SecLists/Passwords/Common-Credentials/Language-Specific && \
    rm -rf /opt/SecLists/Passwords/Cracked-Hashes && \
    rm -rf /opt/SecLists/Passwords/Honeypot-Captures && \
    rm -rf /opt/SecLists/Passwords/Leaked-Databases && \
    rm -rf /opt/SecLists/Passwords/Malware && \
    rm -rf /opt/SecLists/Passwords/Permutations && \
    rm -rf /opt/SecLists/Passwords/PHP-Hashes && \
    rm -rf /opt/SecLists/Passwords/Pwdb-Public/Wordlists/Language-Specifics && \
    rm -rf /opt/SecLists/Passwords/Software && \
    rm -rf /opt/SecLists/Passwords/Wikipedia && \
    rm -rf /opt/SecLists/Passwords/WiFi-WPA && \
    rm /opt/SecLists/Passwords/dutch* && \
    rm /opt/SecLists/Passwords/german* && \
    rm /opt/SecLists/Passwords/richelieu*
    
RUN git clone --depth=1 https://github.com/isaudits/scripts /opt/scripts && \
    rm -rf /opt/scripts/.git && \
    ln -s /opt/scripts/iker.py /usr/bin/iker && \
    ln -s /opt/scripts/email_crawler.py /usr/bin/email_crawler && \
    ln -s /opt/scripts/externalIP /usr/bin/externalIP && \
    git clone --depth=1 https://github.com/isaudits/autoenum /opt/autoenum && \
    rm -rf /opt/autoenum/.git && \
    ln -s /opt/autoenum/autoenum.py /usr/bin/autoenum

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended" && \
    chsh -s $(which zsh)

RUN mkdir /data 

CMD ["/bin/zsh"]