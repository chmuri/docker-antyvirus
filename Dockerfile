FROM ubuntu:20.04ENV TZ="Europe/Warsaw"
ENV DEBIAN_FRONTEND="noninteractive"
RUN ln -fs /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
RUN apt update
RUN apt install tzdata -y  &&  dpkg-reconfigure --frontend noninteractive tzdata
RUN apt install wget chkrootkit sudo gnupg2 -y
RUN cd tmp && wget https://www.clamav.net/downloads/production/clamav-0.104.1.linux.x86_64.deb && dpkg -i clamav-0.104.1.linux.x86_64.deb
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 013baa07180c50a7101097ef9de922f1c2fde6c4
RUN sudo apt install apt-transport-https -y
RUN echo 'Acquire::Languages "none";' | sudo tee /etc/apt/apt.conf.d/99disable-translations
RUN echo "deb https://packages.cisofy.com/community/lynis/deb/ stable main" | sudo tee /etc/apt/sources.list.d/cisofy-lynis.list
RUN apt update
RUN apt install lynis  -y
RUN apt-get install clamav-daemon -y
RUN cd tmp && wget https://secure.eicar.org/eicar.com && wget https://secure.eicar.org/eicar.com.txt && wget https://secure.eicar.org/eicar_com.zip && wget https://secure.eicar.org/eicarcom2.zip
