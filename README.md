# drone-fabric8-docker

Drone plugin to build and publish [fabric8/docker-maven-plugin](https://dmp.fabric8.io) Docker images.

## Alternates

Maven fabric8 based project can be build in drone using [maven docker image](https://hub.docker.com/_/maven).


But either external docker host or docker socket needs to be mounted to maven docker image - `volumes: /var/run/docker.sock:/var/run/docker.sock`.


For the same the repository needs to be trusted in drone via an drone admin, which is not scalable or appropriate solution. [^reference](https://discourse.drone.io/t/maven-image-can-not-build-docker-image-var-run-docker-sock)

## What this plugin does

* This plugin builds layer of openJdk, Maven on top of docker-dind
* Provide an entry point to support slice type parameter `scripts`
* Brings up docker daemon using DinD.
* Slice type parameters get converted to `;` separated commands and get executed

## Plugin Usage

Example -
```yaml
pipeline:
  build_unit_test:
    image: ciscosso/drone-fabric8-docker
    pull: true
    scripts:
      - mvn -B clean package docker:build
```

## Docker

Build the Docker image with the following commands:

```
docker build --rm=true -f Dockerfile -t ciscosso/drone-fabric8-docker .
```

## Usage

Execute from the working directory:

```
docker run --rm \
  -e PLUGIN_SCRIPTS="mvn -B clean package docker:build" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  --privileged \
  ciscosso/drone-fabric8-docker
```
