## demo app - developing with Docker

This demo app shows a simple user profile app set up using 
- index.html with pure js and css styles
- nodejs backend with express module
- mongodb for data storage

All components are docker-based
In case you deploy this app successfully, let's fill some information in the form on website
Then check if data would be updated into database using mongo-express to show data.

### To prepair environment

Step 1: Create docker network and install attached file node-v18.13.0-linux-x64.tar.xz
1.1 Create docker network

    docker network create mongo-network

1.2 Install attached file node-v18.13.0-linux-x64.tar.xz
- copy file node-v18.13.0-linux-x64.tar.xz to directory /home/ubuntu on server (root directory)
- cd to the `/home/ubuntu` directory
- extract file tar.xz:

    tar -xvf node-v18.13.0-linux-x64.tar.xz

- copy path to ~/.bashrc file using root privilege

    sudo su // or `sudo -s`

    sudo cp -r node-v18.13.0-linux-x64/{bin,include,lib,share} /usr/

    nano ~/.bashrc

    // write this path to the bottom of the file
    #Nodejs
    export PATH=/usr/node-v18.13.0-linux-x64/bin:$PATH
    
    // press [Ctrl+O] => [Enter] to save file then [Ctrl+X] to escape nano editor

    // check version of Nodejs

    node -v

    // ==> the output of this command will have to be: v18.13.0

### With Docker
#### To start the application step by step

Step 2: pull mongo image from Dockerhub and start mongodb

    docker pull mongo

    docker run -d -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=password --name mongodb --net mongo-network mongo    

Step 3: pull mongo-express from Dockerhub and start mongo-express

    docker pull mongo-express
    
    docker run -d -p 8081:8081 -e ME_CONFIG_MONGODB_ADMINUSERNAME=admin -e ME_CONFIG_MONGODB_ADMINPASSWORD=password --net mongo-network --name mongo-express -e ME_CONFIG_MONGODB_SERVER=mongodb mongo-express   

_NOTE: creating docker-network in optional. You can start both containers in a default network. In this case, just emit `--net` flag in `docker run` command_

Step 4: open mongo-express from browser

    http://XXX.XXX.XXX.XXX:8080 (XXX.XXX.XXX.XXX: ipv4 server ec2)
    // or http://localhost:8080 (running on local machine)

Step 5: create `user-account` _db_ and `users` _collection_ in mongo-express

Step 6: Start your nodejs application locally - go to `app` directory of project 

    npm install 
    node server.js
    
Step 7: Access you nodejs application UI from browser

    http://XXX.XXX.XXX.XXX:3000 (XXX.XXX.XXX.XXX: ipv4 server ec2)
    // or http://localhost:3000 (running on local machine)

### With Docker Compose
#### To start the application

Step 8: start mongodb and mongo-express

    docker compose -f docker-compose.yaml up
    
_You can access the mongo-express under localhost:8080 from your browser_
    
Step 9: in mongo-express UI - create a new database `my-db`

Step 10: in mongo-express UI - create a new collection `users` in the database `my-db`       
    
Step 11: Start your nodejs application locally - go to `app` directory of project on node server 

    npm install
    node server.js
    
Step 12: access the nodejs application from browser 

    http://XXX.XXX.XXX.XXX:3000 (XXX.XXX.XXX.XXX: ipv4 server ec2)
    // or http://localhost:3000 (running on local machine)

#### To build a docker image from the application

    docker build -t my-app:1.0 .       
    
The dot "." at the end of the command denotes location of the Dockerfile.

    docker run -d -p 3000:3000 --net mongo-network my-app:1.0

To create container running the app with the image my-app:1.0
*_NOTE: Substitute the variable `mongoUrlLocal` in `server.js` file as the variable `mongoUrlDocker` for both POST and GET method*
