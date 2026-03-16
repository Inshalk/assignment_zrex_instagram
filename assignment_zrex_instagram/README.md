# assignment_zrex_instagram

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

I have created my backend using node js ,express and mongoDB
I have Decided to fetch all data from my mongoDB backend but that pinch to zoom thing ruined everything(it consumed my most time but i have successfully implemented it) so the rest as you see I have signUp and signIn screen(with hashed password) that is connected to Backend i have done created token but i have not implemented token authentication (we send request from frontend to backend to validate token based on it we will login we can also set token expiry) 


Instructions to run Backend

1. if you have cloned my repo 

if required package is not installed so please install these package you will find it in package.json file 

"dependencies": {
    "bcryptjs": "^3.0.3",
    "cors": "^2.8.6",
    "dotenv": "^17.3.1",
    "express": "^5.2.1",
    "jsonwebtoken": "^9.0.3",
    "mongodb": "^7.1.0",
    "mongoose": "^9.3.0"
  }

  make sure your dependencies look like this


  2. environment file .env file
  you don't find it in my repo you have to create that file in root directory of backend_insta before running server

  .env
  DATABASE="Your_API_KEY"

  3. how to get api key
    1. open mongodb's official site create or login with your account
    2. Create new project
    3. Click next and click new project after seeing members access permission
    4. then you will redirected to a screen where you see create cluster click create cluster named it as you want 
    5. now click free in deploy your cluster screen leave the rest as it is now click go to advance 
    6. now you will redirected to Create a Dedicated Cluster page now click free and create cluster
    7. now you will be redirected to cluster page click on get Connection string 
    8. now enter any user name and password and remember it now click on add ip address add 0.0.0.0 to allow access to anyone and click on add ip address and add your ip address also
    
    9. After that click on choose connection method after that click on Drivers leave eveything as it is copy the connection string and finally You got your api key or connection string now paste it on your .env file DATABASE="Your_API_KEY"

To run the server type "node index.js"

Instructions for Frontend(Flutter app)

1. install all the dependencies for that run in you terminal "flutter pub get"
2. before running open your cmd type "ipconfig" after that copy IPv4 Address and replace the ip address of your with the existing one in global_varibale.dart file 
String uri="http://yourIP:3000";
3. now in your flutter app project terminal type "flutter run" and you will good to go  

i hope you like my work i look forward for this opportunity
and i have used provider , sharedPreference and stateful widget
