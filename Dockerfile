FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y \
	apache2 \
	apt-utils \
	curl \
	dialog \
	git \
	vim \
    unzip \
    wget \
    nano

COPY ./timezone.sh /root/timezone.sh
RUN bash /root/timezone.sh

RUN apt-get install -y \
    php7.2 \
	php7.2-cli \
	php7.2-gd \
	php7.2-mbstring \
	php7.2-xml \
	php7.2-mysql \
    libapache2-mod-php7.2

COPY ./composer.sh  /root/composer.sh
RUN /root/composer.sh

RUN rm /var/www/html/index.html
RUN curl https://releases.wikimedia.org/mediawiki/1.31/mediawiki-1.31.7.tar.gz -o /root/mediawiki.tar.gz
RUN tar -xvf /root/mediawiki.tar.gz
RUN cp -r mediawiki-1.31.7/* /var/www/html
RUN rm /root/mediawiki.tar.gz 
RUN rm -r /mediawiki-1.31.7
# Activate Apache PHP module
#RUN a2enmod php7.2

RUN echo "ServerName test.local" >> /etc/apache2/apache2.conf

EXPOSE 80
EXPOSE 443

COPY ./startup.sh /root/startup.sh
RUN chmod 777 /root/startup.sh
CMD /root/startup.sh
#CMD ["apachectl", "-k", "restart"] 
#RUN source /root/.bashrc 
#CMD /bin/bash -c apachectl -f /etc/apache2/apache2.conf 
#CMD ["/bin/bash", "-c", "source", "/root/.bashrc", "&&", "/etc/init.d/apache2", "start"]
#CMD /etc/init.d/apache2 start
#CMD ["/etc/init.d/apache2", "start", "&&", "/bin/bash", "-c", "while true; do sleep 1000; done"]
#CMD ["/bin/bash", "-c", "while true; do sleep 1000; done"]
#CMD ["/etc/init.d/apache2", "start", "&&", "while true; do sleep 1000; done"]
#CMD ["/bin/bash", "-c", "source /root/.bashrc", "&&", "apachectl", "-f", "/etc/apache2/apache2.conf"] 
##"-f", "/etc/apache2/apache2.conf", "start"]
#CMD ["/etc/init.d/apache2 start & /bin/bash -c while true; do sleep 1000; done"]