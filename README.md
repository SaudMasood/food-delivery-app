# 🍔 Food Delivery App

<p align="center">
  <img src="assets/images/food_logo.svg" width="120" alt="Food Delivery App Logo">
</p>

<p align="center">
  <b>A modern Flutter Food Delivery Application built during my Flutter Internship at Owasoft Technologies Pvt. Ltd.</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter">
  <img src="https://img.shields.io/badge/Dart-3.x-blue?logo=dart">
  <img src="https://img.shields.io/badge/Architecture-Clean%20Architecture-orange">
  <img src="https://img.shields.io/badge/State%20Management-BLoC-purple">
  <img src="https://img.shields.io/badge/Platform-Android-green?logo=android">
  <img src="https://img.shields.io/badge/Internship-Owasoft%20Technologies-red">
</p>

---

## 📱 About The Project

**Food Delivery App** is a modern Flutter mobile application designed to provide a complete food ordering experience.

The application was developed as part of my **Flutter Internship at Owasoft Technologies Pvt. Ltd.**

The project focuses on:

- Modern Flutter UI development
- Figma-to-Flutter implementation
- Clean Architecture
- BLoC state management
- Food browsing
- Search functionality
- Restaurant browsing
- Food details
- Shopping cart
- Address management
- Payment methods
- Order management
- Order tracking
- User profile management

The application is structured to keep the presentation, business logic, and data layers separated and maintainable.

---

# ✨ Features

## 🏠 Home

- Food delivery home screen
- User greeting
- Search food and restaurants
- Food categories
- Popular foods
- Food cards
- Promotional offers
- Restaurant sections
- Navigation to food details
- Navigation to restaurant details

---

## 🔎 Search

Users can search for:

- Foods
- Restaurants
- Popular keywords

### Search Features

- Search bar
- Recent searches
- Suggested restaurants
- Food search results
- Restaurant search
- Food details navigation
- Category navigation

---

## 🍔 Food Categories

Users can browse foods according to categories.

Available examples:

- Burger
- Pizza
- Sandwich
- Sushi
- Hot Dog

Category selection dynamically updates the displayed food list.

---

## 🍕 Food Details

The food details screen provides:

- Food image
- Food name
- Restaurant name
- Rating
- Delivery information
- Food description
- Size selection
- Ingredient selection
- Quantity selector
- Food price
- Add to cart functionality

---

## 🛒 Shopping Cart

The cart system provides:

- Added food items
- Item quantity
- Item price
- Total price
- Edit cart
- Remove items
- Quantity management
- Checkout navigation

---

## 💳 Payment

The application supports multiple payment methods.

### Payment Methods

- 💵 Cash
- 💳 Visa
- 💳 Mastercard
- 🅿️ PayPal

Users can:

- Select payment method
- Add a new card
- View saved card
- Enter card information
- Confirm payment

---

## 🎉 Payment Success

After successful payment, the application displays:

- Payment confirmation
- Success message
- Order continuation
- Navigation to order tracking

---

## 📍 Order Tracking

Users can track their order through a dedicated tracking screen.

Features include:

- Restaurant information
- Estimated delivery time
- Order status
- Delivery progress
- Delivery person information
- Call delivery person
- Message delivery person
- Map/tracking interface

---

## 📦 My Orders

The My Orders section contains:

### Ongoing Orders

Users can view:

- Restaurant
- Order number
- Price
- Number of items
- Order date
- Track Order
- Cancel Order

### Order History

Completed and canceled orders are displayed separately.

Users can:

- Rate completed orders
- Re-order previous orders
- View order status

---

## 👤 Profile

The profile section provides:

- Personal information
- Edit profile
- Address management
- Add new address
- Address information
- Profile settings

---

## 📍 Address Management

Users can:

- View saved addresses
- Add a new address
- Edit address
- Delete address
- Select address type

Address types can include:

- HOME
- WORK

---

# 🧭 Bottom Navigation

The application uses a bottom navigation system for the main sections.

```text
┌─────────────────────────────────────────┐
│                                         │
│              Application                │
│                                         │
├─────────────────────────────────────────┤
│  🏠       📋       🛒       👤          │
│ Home    Orders    Cart    Profile       │
└─────────────────────────────────────────┘
````

The bottom navigation remains available while navigating through the application's internal screens.

---

# 🏗️ Architecture

The project follows **Clean Architecture** principles.

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
    │
    ├── home/
    │
    ├── food_details/
    │
    ├── restaurant/
    │
    ├── cart/
    │
    ├── payment/
    │
    ├── tracking/
    │
    ├── my_orders/
    │
    └── profile/
```

---

# 🔄 Clean Architecture Flow

The application follows this general data flow:

```text
UI
 ↓
BLoC
 ↓
Use Case
 ↓
Repository Interface
 ↓
Repository Implementation
 ↓
Data Source
 ↓
Local Data / API
```

### Presentation Layer

Responsible for:

* Pages
* Widgets
* BLoC
* Events
* States

### Domain Layer

Responsible for:

* Entities
* Repository contracts
* Use cases
* Business rules

### Data Layer

Responsible for:

* Models
* Data sources
* Repository implementations
* Local/API data handling

---

# 🧠 State Management

The application uses **BLoC** for state management.

BLoC separates UI from business logic.

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

The BLoC processes the event and emits a new state.

---

# 📂 Project Structure

```text
lib/
│
├── core/
│   │
│   ├── constants/
│   │
│   ├── routes/
│   │
│   ├── theme/
│   │
│   ├── utils/
│   │
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

# 🎨 UI / Design

The application UI was implemented from a **Figma Food Delivery App design**.

The development process included:

```text
Figma Design
     ↓
Analyze Screen
     ↓
Identify Components
     ↓
Export Assets
     ↓
Create Flutter Widgets
     ↓
Implement Screens
     ↓
Add Navigation
     ↓
Connect BLoC
     ↓
Test UI
```

The application uses reusable Flutter widgets for:

* Food cards
* Category cards
* Search bars
* Buttons
* Order cards
* Address cards
* Payment cards
* Navigation elements

---

# 🖼️ Assets

Application assets include:

```text
assets/
│
├── images/
│   ├── food_logo.svg
│   ├── splash_top.svg
│   ├── splash_bottom.svg
│   ├── burger.png
│   ├── pizza.png
│   ├── hotdog.png
│   └── rose_garden.png
│
└── icons/
    ├── cash.svg
    ├── visa.svg
    ├── master.svg
    └── paypal.svg
```

---

# 🔀 Application Flow

```text
Splash
   ↓
Login
   ↓
Home
   │
   ├── Search
   │
   ├── Categories
   │
   ├── Restaurant
   │
   └── Food Details
          ↓
        Cart
          ↓
      Checkout
          ↓
      Payment
          ↓
   Payment Success
          ↓
      Tracking
```

---

# 🔐 Authentication Flow

```text
Login
 │
 ├──→ Home
 │
 └──→ Forgot Password
          ↓
      Verification
          ↓
         Login

Sign Up
   ↓
 Home
```

---

# 📦 Technologies Used

| Technology         | Purpose                        |
| ------------------ | ------------------------------ |
| Flutter            | Mobile application development |
| Dart               | Programming language           |
| BLoC               | State management               |
| Clean Architecture | Application architecture       |
| Figma              | UI/UX design reference         |
| SVG                | Vector assets                  |
| Git                | Version control                |
| GitHub             | Source code hosting            |
| Android Studio     | Development                    |
| VS Code            | Development                    |

---

# 📚 Flutter Concepts Used

The project demonstrates practical use of:

* StatelessWidget
* StatefulWidget
* Scaffold
* SafeArea
* Column
* Row
* Stack
* Container
* ListView
* GridView
* GestureDetector
* Navigator
* MaterialPageRoute
* BlocProvider
* BlocBuilder
* BlocListener
* BLoC Events
* BLoC States
* Models
* Entities
* Repository
* Use Cases
* Data Sources
* Clean Architecture
* Reusable Widgets
* Form validation
* TextEditingController
* Dialogs
* SVG assets
* Local data handling

---

# 🛠️ Installation

## 1. Clone Repository

```bash
git clone https://github.com/SaudMasood/food-delivery-app.git
```

## 2. Open Project

```bash
cd food-delivery-app
```

## 3. Get Dependencies

```bash
flutter pub get
```

## 4. Run Application

```bash
flutter run
```

---

# 📱 Build APK

To generate a release APK:

```bash
flutter build apk --release
```

Generated APK:

```text
build/app/outputs/flutter-apk/app-release.apk
```

For architecture-specific APKs:

```bash
flutter build apk --split-per-abi
```

---

# 🧹 Clean Build

If you face Flutter or Gradle build issues:

```bash
flutter clean
flutter pub get
flutter build apk --release
```

---

# 🧪 Testing

Before creating the final APK, check:

```bash
flutter analyze
```

Then:

```bash
flutter run
```

Test:

* Navigation
* Search
* Categories
* Food details
* Cart
* Payment
* Orders
* Profile
* Address management
* Bottom navigation

---

# 🚀 Future Improvements

Possible future improvements include:

* Firebase Authentication
* Firebase Firestore
* Real restaurant API
* Real food API
* Real payment gateway
* Google Maps integration
* Real-time order tracking
* Push notifications
* User reviews
* Restaurant dashboard
* Admin dashboard
* Online order management
* Backend API integration

---

# 🎯 Internship Project

This project was developed as part of my **Flutter Internship at Owasoft Technologies Pvt. Ltd.**

### Internship

**Owasoft Technologies Pvt. Ltd.**

### Project

**Food Delivery App**

### Role

**Flutter Developer Intern**

### Main Responsibilities

* Converted Figma UI into Flutter screens
* Developed reusable widgets
* Implemented application navigation
* Implemented BLoC state management
* Applied Clean Architecture
* Developed food browsing functionality
* Developed cart functionality
* Developed payment screens
* Developed order management
* Developed profile and address management
* Fixed Flutter and Gradle issues
* Tested application UI and navigation

---

# 📈 Learning Outcomes

Through this project, I practiced:

```text
Flutter
   ↓
Dart
   ↓
UI Development
   ↓
Figma → Flutter
   ↓
Reusable Widgets
   ↓
Navigation
   ↓
BLoC
   ↓
Clean Architecture
   ↓
Repository Pattern
   ↓
Use Cases
   ↓
Application Development
```

---

# 👨‍💻 Developer

**Saud Masood**

BS Computer Science Student
National Skills University, Islamabad

### Skills

* Flutter
* Dart
* Firebase
* BLoC
* Clean Architecture
* REST APIs
* Git & GitHub
* Python
* Machine Learning
* React.js
* Node.js

---

# 🔗 Repository

GitHub:

[https://github.com/SaudMasood/food-delivery-app](https://github.com/SaudMasood/food-delivery-app)

---

# 📄 License

This project was developed for educational and internship purposes.

---

<p align="center">
  Made with ❤️ using Flutter
</p>

<p align="center">
  <b>Food Delivery App • Owasoft Technologies Internship</b>
</p>
