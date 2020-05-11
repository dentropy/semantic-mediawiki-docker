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

#RUN mv /var/www/html/composer.json /var/www/html/mediawiki.composer.json 
COPY semantic-compoer.sh /root/semantic-compoer.sh
RUN cd /var/www/html && php /composer.phar install
RUN bash /root/semantic-compoer.sh

EXPOSE 80
EXPOSE 443

COPY ./startup.sh /root/startup.sh
RUN chmod 777 /root/startup.sh
CMD /root/startup.sh