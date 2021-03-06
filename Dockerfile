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

COPY ./root-dir/timezone.sh /root/timezone.sh
RUN bash /root/timezone.sh

RUN apt-get install -y \
    php7.2 \
	php7.2-cli \
	php7.2-gd \
	php7.2-mbstring \
	php7.2-xml \
	php7.2-mysql \
    libapache2-mod-php7.2

COPY ./root-dir/composer.sh  /root/composer.sh
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

RUN cp /composer.phar /usr/local/bin/composer
#RUN mv /var/www/html/composer.json /var/www/html/mediawiki.composer.json 
COPY ./root-dir/semantic-compoer.sh /root/semantic-compoer.sh
#RUN cd /var/www/html && composer update --prefer-source
RUN bash /root/semantic-compoer.sh

# Good artists copy; great artists steal - wirehead/semantic-mediawiki-docker
# Download the non-Composer-based extensions
RUN curl -o /tmp/JsonConfig-REL1_34-f877d87.tar.gz https://extdist.wmflabs.org/dist/extensions/JsonConfig-REL1_34-f877d87.tar.gz \
  && tar -xzf /tmp/JsonConfig-REL1_34-f877d87.tar.gz -C /var/www/html/extensions \
  && curl -o /tmp/Graph-REL1_34-eb3412d.tar.gz https://extdist.wmflabs.org/dist/extensions/Graph-REL1_34-eb3412d.tar.gz \
  && tar -xzf /tmp/Graph-REL1_34-eb3412d.tar.gz -C /var/www/html/extensions \
  && curl -o /tmp/SubPageList3-REL1_34-3f1045e.tar.gz https://extdist.wmflabs.org/dist/extensions/SubPageList3-REL1_34-3f1045e.tar.gz \
  && tar -xzf /tmp/SubPageList3-REL1_34-3f1045e.tar.gz -C /var/www/html/extensions \
  && curl -o /tmp/MsUpload-REL1_34-f70d1c8.tar.gz https://extdist.wmflabs.org/dist/extensions/MsUpload-REL1_34-f70d1c8.tar.gz \
  && tar -xzf /tmp/MsUpload-REL1_34-f70d1c8.tar.gz -C /var/www/html/extensions \
  && curl -o /tmp/TemplateStyles-REL1_34-c4d6f25.tar.gz https://extdist.wmflabs.org/dist/extensions/TemplateStyles-REL1_34-c4d6f25.tar.gz \
  && tar -xzf /tmp/TemplateStyles-REL1_34-c4d6f25.tar.gz -C /var/www/html/extensions \
  && rm /tmp/*.tar.gz

EXPOSE 80
EXPOSE 443
COPY ./root-dir/startup.sh /root/startup.sh
RUN chmod 777 /root/startup.sh
#COPY ./root-dir/LocalSettings.php /var/www/html/LocalSettings.php
COPY ./root-dir/update.sh /root/update.sh
CMD /root/startup.sh
