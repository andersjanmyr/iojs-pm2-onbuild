# Docker iojs pm2 onbuild image

This image installs [Pm2](https://github.com/Unitech/pm2) and
zlib. It is meant to be used as a base image for Node projects.

The image has the following `ONBUILD` and `CMD` and `ENV` instructions.  This
means that it adds all files in the current directory, installs the
dependencies declared in `package.json`, and provides the environment variable `NODE_ENV=production`

```sh
ONBUILD COPY package.json /usr/src/app/
ONBUILD RUN npm install
ONBUILD COPY . /usr/src/app
CMD ["start"]
```

A typical project that uses this image will have a structure similar to
the this.

```
$ tree .
.
├── server.js
├── Dockerfile
├── lib
└── package.json
```

The inheriting `Dockerfile` will only contain a `FROM` and a `MAINTAINER`
field, unless it needs to `EXPOSE` any ports.

```
# my-express-service
FROM andersjanmyr/iojs-pm2-onbuild:latest
MAINTAINER Anders Janmyr "anders@janmyr.com"
ENV PORT 80
EXPOSE 80
```

To build a new container with the above `Dockerfile` and name it
**my-express-service**, run:

```sh
$ npm install --production
$ docker build -t my-express-service .
```

To start the newly built container;

```sh
# Start service
$ docker run -it --rm my-express-service
# or
$ make run

# Start with environment variable
$ docker run -e "NODE_ENV=development" -it --rm my-express-service
```
