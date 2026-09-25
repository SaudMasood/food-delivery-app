# 🍔 Food Delivery App — Week 8 Internship Project

<p align="center">
  <img src="assets/images/food_logo.svg" width="120" alt="Food Delivery App Logo">
</p>

<p align="center">
  <b>Modern Food Delivery Mobile Application built with Flutter</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter">
  <img src="https://img.shields.io/badge/Dart-3.x-blue?logo=dart">
  <img src="https://img.shields.io/badge/BLoC-State%20Management-purple">
  <img src="https://img.shields.io/badge/Clean%20Architecture-orange">
  <img src="https://img.shields.io/badge/Week%208-Internship-red">
  <img src="https://img.shields.io/badge/Owasoft-Technologies-green">
</p>

---

## 🚀 About The Project

**Food Delivery App** is my **Week 8 Flutter Internship Project** at **Owasoft Technologies Pvt. Ltd.**

The project was developed from a provided **Figma Food Delivery App design** and converted into a functional Flutter mobile application.

The main focus of Week 8 was:

* 🎨 Figma to Flutter UI implementation
* 📱 Responsive mobile UI
* 🧩 Reusable Flutter widgets
* 🏗️ Clean Architecture
* 🔄 BLoC state management
* 🧭 Screen navigation
* 🛒 Food ordering flow
* 💳 Payment flow
* 📍 Order tracking
* 👤 Profile and address management
* ✨ UI animations and interactive elements

---

# ✨ Key Features

### 🏠 Home

* Food categories
* Popular foods
* Search
* Restaurants
* Promotional offers
* Food cards
* Navigation to food details

### 🔎 Search

* Search foods
* Search restaurants
* Recent searches
* Suggested restaurants
* Search results

### 🍔 Food Details

* Food image
* Restaurant information
* Rating
* Description
* Food size selection
* Ingredients
* Quantity selector
* Price
* Add to cart

### 🛒 Cart

* Cart items
* Quantity management
* Price calculation
* Edit cart
* Remove items
* Checkout

### 💳 Payment

Supported payment options:

* Cash
* Visa
* Mastercard
* PayPal

Also includes:

* Add new card
* Saved card
* Payment confirmation
* Payment success screen

### 📍 Order Tracking

* Order information
* Estimated delivery time
* Delivery progress
* Delivery person details
* Call delivery person
* Message delivery person
* Tracking interface

### 📦 My Orders

* Ongoing orders
* Completed orders
* Canceled orders
* Track order
* Cancel order
* Rate order
* Re-order

### 👤 Profile

* Personal information
* Edit profile
* Address management
* Add address
* Edit address
* Delete address

---

# ✨ Animations & Interactive UI

The application also includes **UI animations and interactive elements** to make the experience smoother and more engaging.

Animation/interaction areas include:

* 🚀 Splash screen transitions
* 🔄 Screen navigation transitions
* 🎯 Category selection feedback
* 🛒 Cart quantity interactions
* ❤️ Food interaction buttons
* 💳 Payment selection feedback
* 📦 Order status interactions
* 🧭 Bottom navigation selection
* 🎨 Button and card interactions
* 🪄 Dialog and overlay interactions

The animation work focuses on keeping the UI smooth while maintaining the Figma-inspired design.

---

# 🧭 Application Flow

```text
                    ┌──────────────┐
                    │    Splash    │
                    └──────┬───────┘
                           ↓
                    ┌──────────────┐
                    │     Login    │
                    └──────┬───────┘
                           ↓
                    ┌──────────────┐
                    │     Home     │
                    └──────┬───────┘
                           │
             ┌─────────────┼─────────────┐
             ↓             ↓             ↓
          Search       Categories    Restaurant
             │             │             │
             └─────────────┼─────────────┘
                           ↓
                    ┌──────────────┐
                    │ Food Details │
                    └──────┬───────┘
                           ↓
                    ┌──────────────┐
                    │     Cart     │
                    └──────┬───────┘
                           ↓
                    ┌──────────────┐
                    │   Payment    │
                    └──────┬───────┘
                           ↓
                 ┌───────────────────┐
                 │ Payment Successful│
                 └─────────┬─────────┘
                           ↓
                    ┌──────────────┐
                    │   Tracking   │
                    └──────────────┘
```

---

# 🧱 Architecture

The application follows **Clean Architecture**.

```text
lib/
│
├── core/
│   ├── constants/
│   ├── theme/
│   ├── routes/
│   ├── utils/
│   └── widgets/
│
└── features/
    ├── home/
    ├── food_details/
    ├── restaurant/
    ├── cart/
    ├── payment/
    ├── tracking/
    ├── my_orders/
    └── profile/
```

### Architecture Flow

```text
UI
 ↓
BLoC
 ↓
Use Case
 ↓
Repository
 ↓
Data Source
 ↓
Local Data / API
```

---

# 🔄 BLoC State Management

BLoC is used to separate UI from application logic.

```text
User Action
     ↓
   Event
     ↓
    BLoC
     ↓
 Business Logic
     ↓
   State
     ↓
    UI
```

Example:

```dart
context.read<HomeBloc>().add(
  SearchFood(query),
);
```

---

# 🎨 Figma to Flutter

This project was developed using a provided **Figma Food Delivery App design**.

Development process:

```text
Figma Design
     ↓
Analyze UI
     ↓
Identify Screens
     ↓
Export Assets
     ↓
Create Flutter Widgets
     ↓
Implement UI
     ↓
Add Navigation
     ↓
Implement BLoC
     ↓
Add Interactions & Animations
     ↓
Test Application
```

---

# 📂 Project Structure

```text
lib/
│
├── core/
│   ├── constants/
│   ├── routes/
│   ├── theme/
│   ├── utils/
│   └── widgets/
│       └── main_screen.dart
│
├── features/
│   │
│   ├── home/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── food_details/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── restaurant/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── cart/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── payment/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── tracking/
│   │   ├── data/
│   │   └── presentation/
│   │
│   ├── my_orders/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── profile/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
└── main.dart
```

---

# 🧰 Technologies

| Technology         | Usage                  |
| ------------------ | ---------------------- |
| Flutter            | Mobile App Development |
| Dart               | Programming Language   |
| BLoC               | State Management       |
| Clean Architecture | Project Architecture   |
| Figma              | UI/UX Reference        |
| SVG                | Icons & Graphics       |
| Git                | Version Control        |
| GitHub             | Source Code Management |
| Android Studio     | Development            |
| VS Code            | Development            |

---

# 📱 Main Screens

```text
Splash
Login
Sign Up
Forgot Password
Verification

Home
Search
Food Category
Restaurant Details
Food Details

Cart
Edit Cart

Payment Method
Add Card
Payment Success

Order Tracking
Delivery Man Call
Delivery Man Message

My Orders

Profile
Personal Information
Edit Profile
My Address
Add Address
```

---

# 🎓 Week 8 Internship

## Owasoft Technologies Pvt. Ltd.

**Internship:** Flutter Development Internship
**Project:** Food Delivery App
**Week:** Week 8
**Role:** Flutter Developer Intern

### Week 8 Work

During Week 8, I worked on converting a provided Figma Food Delivery App design into a Flutter application.

### Main Tasks

* Analyzed the Figma design
* Created Flutter screen layouts
* Converted Figma components into Flutter widgets
* Created reusable UI components
* Implemented navigation
* Implemented BLoC state management
* Applied Clean Architecture
* Developed food browsing screens
* Developed food details
* Developed cart functionality
* Developed payment screens
* Developed order tracking
* Developed My Orders
* Developed profile screens
* Implemented address management
* Added UI interactions and animations
* Fixed Flutter and Gradle issues
* Tested the application

---

# 📚 Learning Outcomes

Through this Week 8 project, I strengthened my practical knowledge of:

* Flutter UI development
* Dart
* Figma-to-Flutter conversion
* Clean Architecture
* BLoC
* Events and States
* Repository Pattern
* Use Cases
* Data Sources
* Navigation
* Nested navigation
* Reusable widgets
* Responsive UI
* Animation and interaction
* Git and GitHub
* Debugging Flutter applications

---

# 🛠️ Installation

### Clone Repository

```bash
git clone https://github.com/SaudMasood/food-delivery-app.git
```

### Open Project

```bash
cd food-delivery-app
```

### Install Dependencies

```bash
flutter pub get
```

### Run Application

```bash
flutter run
```

---

# 📦 Build APK

### Release APK

```bash
flutter build apk --release
```

APK location:

```text
build/app/outputs/flutter-apk/app-release.apk
```

### Split APK

```bash
flutter build apk --split-per-abi
```

---

# 🧹 Clean Build

If you experience Flutter or Gradle build problems:

```bash
flutter clean
flutter pub get
flutter build apk --release
```

---

# 🧪 Analyze Project

```bash
flutter analyze
```

---

# 🔮 Future Improvements

Possible future improvements:

* Firebase Authentication
* Firebase Firestore
* REST API integration
* Real restaurant data
* Real food ordering backend
* Real payment gateway
* Google Maps integration
* Real-time delivery tracking
* Push notifications
* Restaurant management
* Admin dashboard
* User reviews and ratings

---

# 👨‍💻 Developer

## Saud Masood

**BS Computer Science Student**
**National Skills University, Islamabad**

**Flutter Developer Intern — Owasoft Technologies Pvt. Ltd.**

### Technical Skills

* Flutter
* Dart
* BLoC
* Clean Architecture
* Firebase
* REST APIs
* Git & GitHub
* Python
* Machine Learning
* React.js
* Node.js

---

# 🔗 GitHub Repository

**Food Delivery App**

[https://github.com/SaudMasood/food-delivery-app](https://github.com/SaudMasood/food-delivery-app)

---

# 📄 License

This project was developed for **educational and internship purposes**.

---

<p align="center">

### 🍔 Food Delivery App

**Week 8 Flutter Internship Project**

**Owasoft Technologies Pvt. Ltd.**

Made with ❤️ using Flutter

</p>
```
