FROM node:18.13.0-alpine3.16

ENV MONGO_DB_USERNAME=admin \
    MONGO_DB_PWD=password

RUN mkdir -p /home/app

# set default dir so that next commands executes in /home/app dir
WORKDIR /home/app

COPY ./app /home/app

# will execute npm install in /home/app because of WORKDIR
RUN npm install

EXPOSE 3000

# no need for /home/app/server.js because of WORKDIR
CMD ["node", "server.js"]
