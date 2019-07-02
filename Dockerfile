FROM phusion/baseimage:0.10.2
EXPOSE 80 8500
VOLUME ["/var/www", "/etc/apache2/sites-enabled", "/usr/share/config", "/var/lib/elasticsearch"]

ENV DEBIAN_FRONTEND noninteractive
ENV REFRESHED_AT 2019_05_03

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y wget unzip xsltproc apache2 default-jre nano && apt-get clean

ADD ./build/config/ /tmp/
ADD ./build/install/ /tmp/
ADD ./build/service/ /etc/service/
ADD ./build/my_init.d/ /etc/my_init.d/


# Install ColdFusion 10
RUN chmod -R 755 /etc/service/coldfusion10
RUN chmod 755 /tmp/install-cf10.sh
RUN /tmp/install-cf10.sh
RUN rm /tmp/*.bin
RUN rm /tmp/*.sh
RUN rm /tmp/*.jar


# Install Elasticsearch 7.2
RUN apt-get update
RUN apt-get -y upgrade
RUN wget -q https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.2.0-amd64.deb
RUN dpkg -i elasticsearch-7.2.0-amd64.deb
RUN systemctl enable elasticsearch.service
RUN rm elasticsearch-7.2.0-amd64.deb

RUN touch /usr/share/config/elasticsearch.yml
RUN touch /usr/share/config/synonyms.txt
RUN touch /usr/share/config/typos.txt

# Symlink Elasticsearch Config, Synonyms & Typos from Config-Volume
RUN mv /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.bak
RUN ln -s /usr/share/config/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
RUN ln -s /usr/share/config/synonyms.txt /etc/elasticsearch/synonyms.txt
RUN ln -s /usr/share/config/typos.txt /etc/elasticsearch/typos.txt

RUN apt-get clean