# docker-kali

Docker implementation of Kali Linux with installed toolset

## Description

This image has 2 build tags with separate Dockerfiles:
* base / latest - main image based upon official Kali Linux docker image with our custom toolset (excluding Metasploit) installed
* msf - same as base image with metasploit also installed (larger)

If you are viewing this on docker hub, clone the full repo at https://github.com/isaudits/docker-kali
to get the launcher scripts and alias files described below.

## Build Notes

build images locally (this will build both versions; if you only need one, you can just pull that):

    git clone https://github.com/isaudits/docker-kali
    ./build.sh
    
pull main image only:

    docker pull isaudits/kali
    
pull full metasploit image only:

    docker pull isaudits/kali:msf
    

### Aliases
Alias the commands in aliases to your .bash_aliases (kali) or .bash_profile (osx) and launch with aliases
    source /path/to/docker-kali/aliases

Refer to aliases file to see all the available commands
    
--------------------------------------------------------------------------------

Copyright 2019

Matthew C. Jones, CPA, CISA, OSCP, CCFE

IS Audits & Consulting, LLC - <http://www.isaudits.com/>

TJS Deemer Dana LLP - <http://www.tjsdd.com/>

--------------------------------------------------------------------------------

Except as otherwise specified:

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program. If not, see <http://www.gnu.org/licenses/>.