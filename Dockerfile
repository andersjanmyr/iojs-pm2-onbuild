# andersjanmyr/iojs-pm2-onbuild
FROM andersjanmyr/iojs-pm2:latest
MAINTAINER Anders Janmyr "anders@janmyr.com"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD COPY package.json /usr/src/app/
ONBUILD RUN npm install
ONBUILD COPY . /usr/src/app

ENV NODE_ENV production
ENV SCRIPT server.js
ENV PROCESSES 0 # Use all available processes
CMD ["run.sh"]
