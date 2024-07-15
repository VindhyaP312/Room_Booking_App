# Room_Booking_App

- This **Room Booking App** is a full-stack application used to book rooms and to view them based on the role of the user. It allows only authenticated users to book-a-room or to view bookings by verifying the JWT tokens generated during signup or login time. It displays bookings done only by that user if role is user whereas if admin is viewing the bookings, it displays all the bookings. 
- It uses **Flutter** for frontend, **Express.js** for backend, **MongoDB** as database for this project.

## Features

- User authentication (login and signup) using JWT tokens 
- Role-based access (admin and user)
- Booking rooms
- Viewing the bookings based on the role 

## Structure

- **'room_booking_app_frontend/'** : Uses Flutter for frontend
    - uses http and shared_preferences dependencies.
- **'room_booking_app_backend/'**  : Uses Node.js and express.js for backend
    - uses express, mongoose, jsonwebtoken, bcryptjs, dotenv etc dependencies.


##  How to use this?

1. **Clone this repositry** <br>
        ```git clone https://github.com/VindhyaP312/Room_Booking_App.git```

2. **Move to this directory** <br>
        ```cd Room_Booking_App```

3. ### Backend 
- **Move to 'room_booking_app_backend' directory**<br>
       ```cd room_booking_app_backend/```
- .env file contains details of MongoDB uri, PORT number and secret string used in JWT token
- **Install dependencies with npm package manager**<br>
        ```npm install```
- **Run the backend code**<br>
        ```npm start```

4. ### Frontend
- **Move to 'room_booking_app_frontend' directory**<br>
        ```cd room_booking_app_frontend/```
- Change the IP address in room_booking_app_frontend/lib/constants.dart file
- **Install dependencies**<br>
        ```flutter pub get```
- **Run the Flutter app and select device - Chrome or mobile emulator**<br>
        ```flutter run```
- **Or select device and click on the run button in main.dart file**

5. Now we can see the login page where you have to enter your email and password if already has an account, but to make an account for the first time, you need to signup by providing user name, email and password.
- It takes you to the home page where two buttons **Book a room** and **View Bookings** are present.
- When pressed **Book a room** button, you can fill the form with Room Number, Purpose, Club name.
- When pressed **View Bookings** button, you can view all the bookings done by you based on role.