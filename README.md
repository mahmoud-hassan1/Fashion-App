# Online Shopping

This app is a feature-rich e-commerce platform designed for a seamless shopping experience. It includes user authentication, order management, favorite items, a personalized profile, reviews, a shopping bag, and a powerful search functionality. The app also features an engaging splash screen for a professional first impression. We use clean architecture for File Structure.

## Table of contents 📑

- ### [Main Packages Used =>](#main-packages-used)
- ### [Folder Structure =>](#folder-structure)
- ### [App Link =>](#app-link)
- ### [Video Link =>](#app-link)
- ### [Screen Shots =>](#screen-shots)

## Main Packages Used 🛠

- [bloc](https://pub.dev/packages/bloc) -> For state management with predictable patterns.
- [google_fonts](https://pub.dev/packages/google_fonts) -> For custom fonts from Google Fonts library.
- [firebase_core](https://pub.dev/packages/firebase_core) -> For initializing Firebase in the project.
- [firebase_auth](https://pub.dev/packages/firebase_auth) -> For authentication using Firebase, including email and password or third-party logins.
- [cloud_firestore](https://pub.dev/packages/cloud_firestore) -> For integrating Firestore, a cloud-hosted NoSQL database.
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) -> For integrating Bloc state management into Flutter applications.
- [modal_progress_hud_nsn](https://pub.dev/packages/modal_progress_hud_nsn) -> For displaying a modal progress indicator during asynchronous operations.
- [device_preview](https://pub.dev/packages/device_preview) -> For previewing and testing the app on different devices and resolutions.
- [google_sign_in](https://pub.dev/packages/google_sign_in) -> For implementing Google Sign-In functionality.
- [flutter_svg](https://pub.dev/packages/flutter_svg) -> For rendering SVG images natively in Flutter.
- [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) -> For adapting the UI layout to different screen sizes and densities.
- [carousel_slider_plus](https://pub.dev/packages/carousel_slider_plus) -> For creating image and content carousels with smooth animations.
- [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) -> For securely storing sensitive data like tokens.
- [firebase_storage](https://pub.dev/packages/firebase_storage) -> For uploading and retrieving files from Firebase Cloud Storage.
- [flutter_rating_bar](https://pub.dev/packages/flutter_rating_bar) -> For adding customizable star rating bars.
- [lottie](https://pub.dev/packages/lottie) -> For displaying animations created using Lottie.
- [image_picker](https://pub.dev/packages/image_picker) -> For picking images or videos from the device gallery or camera.
- [permission_handler](https://pub.dev/packages/permission_handler) -> For handling runtime permissions in the app.
- [fl_chart](https://pub.dev/packages/fl_chart) -> For creating beautiful and interactive charts.
- [get_it](https://pub.dev/packages/get_it) -> For implementing a simple service locator pattern.
- [cached_network_image](https://pub.dev/packages/cached_network_image) -> For efficient image loading and caching.
- [barcode_scan2](https://pub.dev/packages/barcode_scan2) -> For scanning barcodes and QR codes.
- [get](https://pub.dev/packages/get) -> For lightweight state management and navigation.
- [page_transition](https://pub.dev/packages/page_transition) -> For adding custom page transition animations.
- [barcode_widget](https://pub.dev/packages/barcode_widget) -> For generating barcodes and QR codes.
- [speech_to_text](https://pub.dev/packages/speech_to_text) -> For converting spoken words into text.
- [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter) -> For using Font Awesome icons in the app.
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) -> For customizing app launcher icons.

## Folder Structure 📂

Here is the folder structure we have been using in this project:

```
lib
├── core
├── features
├── constants
├── firebase_options.dart
└── main.dart
```

### Core

This folder contains all services and tools related to the application

```
core
├── models
├── utils
└── widgets
```

### Features

This folder containes everything related to the screen of the application and the business logic of the application specificly state management.

```
features
├── auth: Secure user authentication with login, registration, and logout functionality.
├── bag: A shopping bag to manage selected items before checkout.
├── favourite: Save and manage favorite products for quick access.
├── home: The main dashboard showcasing featured products and categories.
├── product_details: Detailed view of product information, including pricing, specifications, and reviews.
├── product_management: Manage products with options to add, edit, and delete items (admin functionality).
├── profiles: Personalized user profiles with account details and settings.
├── reviews: Add and browse product reviews to assist with purchasing decisions.
├── search: Find products quickly using keywords or filters.
├── shop: Explore and browse products by categories or collections.
└── splash: An engaging introductory screen displayed during app startup.
```

# [App Link](https://drive.google.com/file/d/1LwjnEdVqJ9B4dDm1i3med2kfBjdm0s4k/view?usp=sharing)

# [Video Link](https://drive.google.com/file/d/1_C1TZkdopRxD_1PeiAX68jr0hwXnPapK/view?usp=drive_link)

## Screen Shots 📸

<img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-04-02-249_com.example.online_shopping.jpg" width="300"><img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-04-05-331_com.example.online_shopping.jpg" width="300"><img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-04-25-593_com.example.online_shopping.jpg" width="300">

<img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-04-29-986_com.example.online_shopping.jpg" width="300"><img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-04-34-741_com.example.online_shopping.jpg" width="300"><img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-04-37-172_com.example.online_shopping.jpg" width="300">

<img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-04-40-121_com.example.online_shopping.jpg" width="300"><img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-04-55-011_com.example.online_shopping.jpg" width="300"><img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-05-05-194_com.example.online_shopping.jpg" width="300">

<img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-05-11-516_com.example.online_shopping.jpg" width="300"><img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-05-14-552_com.example.online_shopping.jpg" width="300"><img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-05-27-655_com.example.online_shopping.jpg" width="300">

<img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-05-33-450_com.example.online_shopping.jpg" width="300"><img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-05-39-749_com.example.online_shopping.jpg" width="300"><img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-05-57-457_com.example.online_shopping.jpg" width="300">

<img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-06-12-365_com.example.online_shopping.jpg" width="300"><img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-06-18-687_com.example.online_shopping.jpg" width="300"><img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-06-32-252_com.example.online_shopping.jpg" width="300">

<img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-06-53-690_com.example.online_shopping.jpg" width="300"><img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-06-58-141_com.example.online_shopping.jpg" width="300"><img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-07-06-277_com.example.online_shopping.jpg" width="300">

<img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-12-16-079_com.example.online_shopping.jpg" width="300"><img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-12-34-182_com.example.online_shopping.jpg" width="300"><img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-15-02-605_com.example.online_shopping.jpg" width="300">

<img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-15-10-723_com.example.online_shopping.jpg" width="300"><img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-15-12-902_com.example.online_shopping.jpg" width="300"><img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-15-36-435_com.example.online_shopping.jpg" width="300">

<img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-15-41-227_com.example.online_shopping.jpg" width="300"><img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-16-05-591_com.example.online_shopping.jpg" width="300"><img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-16-41-807_com.example.online_shopping.jpg" width="300">

<img src="https://github.com/mahmoud-hassan1/Fashion-App/blob/main/screen_shots/Screenshot_2025-01-25-17-16-47-532_com.example.online_shopping.jpg" width="300">
