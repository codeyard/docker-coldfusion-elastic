# docker-coldfusion-elastic

ColdFusion 10 and Elasticsearch 7 as a Docker image on Ubuntu 16.04.

## What's included?

* Adobe ColdFusion 10
   * with the latest hotfix applied (hotfix_023)
   * with my recommended settings for local development
* Elasticsearch 7.2


## Installation

Pull the image from Docker Hub:
`docker pull raphaelgerber/coldfusion-elastic:latest`

Run the container:
```bash
docker run -d -p 8880:80 -v /local/webroot:/var/www -v /local/apache/vhosts:/etc/apache2/sites-enabled -v /local/elasticsearch/config:/usr/share/config -v /local/elasticsearch/data:/var/lib/elasticsearch --name cfelastic raphaelgerber/coldfusion-elastic
```

The following volumes are mounted:

* **/var/www**: point to your local webroot
* **/etc/apache2/sites-enabled**: point to a local folder containing config files for virtual hosts (see folder `sample-config/vhosts`)
* **/usr/share/config**: point to a local folder containing config files for Elasticsearch like elasticsearch.yml, synonyms.txt & typos.txt (see folder `sample-config/elastic`)
* **/var/lib/elasticsearch**: point to a local folder where Elasticsearch should save its index data



## Build

If you prefer to build the image yourself instead of pulling it from Docker Hub, these are the required steps:

* Clone this repository: `git clone https://github.com/codeyard/docker-coldfusion-elastic.git /local/path`
* Change directory: `cd /local/path/docker-coldfusion-elastic`
* Download the ColdFusion binary and patch files by running `./prepare.sh` if you are testing (so the ColdFusion install files don't get downloaded with every new build).
* Build the container: `docker build . -t raphaelgerber/coldfusion-elastic:latest`
* Run the container: `docker run -d -p 8880:80 -v /local/webroot:/var/www -v /local/apache/vhosts:/etc/apache2/sites-enabled -v /local/elasticsearch/config:/usr/share/config -v /local/elasticsearch/data:/var/lib/elasticsearch --name cfelastic raphaelgerber/coldfusion-elastic`


***

## Info

The ColdFusion Administrator is located at [http://localhost:8880/CFIDE/administrator/index.cfm](http://localhost:8880/CFIDE/administrator/index.cfm). The Password is `Adm1n$`.

Elasticsearch does not automatically startup with the container. You need to manually start the service:
```bash
docker exec -it cfelastic bash
service elasticsearch start
```



## Credits

This is based on [finalcut/coldfusion10](https://github.com/finalcut/docker-coldfusion10) and [Fridus/docker-coldfusion10](https://github.com/Fridus/docker-coldfusion10).
