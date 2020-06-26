# edisonspencer/docker-nodejs-chrome-java

This docker image was created in order to run node.js tests that require Selenium Server, nightwatch and chrome as dependencies.

## The latest image contains
| Package name | Version |
| ------ | ------ |
| node.js | v10.21.0 |
| npm | 5.8.0 |
| chromedriver | 80.0.3987.162 |
| Java | 1.8.0_252 |

## Usage example on Bitbucket Pipelines

```
image: edisonspencer/docker-nodejs-chrome-java:latest

pipelines:
  tags:
   '*.*.*':

# ...
```

## Automatically build and publish the image

This repository is configured on Docker Hub to publish a new version of the image upon a commit on master (tag `latest`), or a specific tag (e.g. tag `1.0.0`).

## Manual steps to build and publish the image

After logging in to your Docker Hub account, do the following:

```
docker build .
docker tag <IMAGE_ID> edisonspencer/docker-nodejs-chrome-java:latest
docker push edisonspencer/docker-nodejs-chrome-java
```

## Steps to run tests on the image locally

```
docker pull edisonspencer/docker-nodejs-chrome-java
docker run -it --entrypoint /bin/bash -v /path/to/project/folder:/docker/project/location -w /docker/project/location <IMAGE_ID>
```

Once inside the image:

```
npm install
npm test
```