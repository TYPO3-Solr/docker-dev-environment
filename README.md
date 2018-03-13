# Apache Solr for TYPO3 docker test system

## Thanks

This dev environment is a combination of:

* TYPO3 Docker Boilerplate (https://static.webdevops.io/)
* TYPO3 Console (https://github.com/TYPO3-Console/TYPO3-Console)
* TYPO3 Sitepackage generated with (https://sitepackagebuilder.com/)


## How to use

Clone the repository:

```
git clone https://github.com/TYPO3-Solr/docker-dev-environment.git
```

Run the setup (start containers, install TYPO3 with composer)

```
cd docker-dev-environment
make setup
```

Afterwards you can login into the TYPO3 backend

```
http://localhost:8000/typo3/
```


