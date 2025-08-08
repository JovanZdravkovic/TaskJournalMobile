# What is Task Journal?

**Task Journal** is a cross-platform personal task management app designed to help users organize, prioritize, and track their daily activities.  
The app is available on the web at [taskjournal.online](https://taskjournal.online), as well as on mobile devices running Android and iOS.

## Features

Task Journal offers the following features:

- Creating, searching and filtering, updating and deleting daily and long-term tasks  
- Custom designed icons that help user association with tasks  
- Synched across devices and platforms  
- Tasks history with searching and filtering features

## Technology Stack

- **Web frontend:** Angular, Tailwind CSS  
- **Mobile app:** Flutter (Dart)  
- **Backend:** Golang, PostgreSQL

---

# TaskJournalMobile

**TaskJournalMobile** is the repository for the mobile version of Task Journal (Android and iOS).  
The app is written in **Dart** using the **Flutter** framework, primarily utilizing the Material Design library for UI.

The app establishes communication with the backend via HTTPS (the same backend is used for the web app, enabling synchronization between devices).

Authentication cookies are stored in a Cookie Jar and secured via `HttpOnly` and `Secure` flags.

## Installation and requirements

# Requirements
- Flutter SDK (the app is built on version 3.24.5)
- Android/iOS emulator or connected physical device

# Installation
Before running the app, ensure that Flutter and the project dependencies are properly installed.
Check Flutter version via command: flutter --version.
Dependencies and their versions are available in the pubspec.yaml file. Run the following command to install the required dependencies: flutter pub get.

**Note:** The version available on Github is production ready. The variable baseUrl, in the file base_service.dart, is set to point to the backend hosted at taskjournal.online.
For testing purposes set it to wherever your backend is hosted (TaskJournalBackend is set to be hosted at localhost:8080).

# Running the app

To run the mobile app, use the following command: flutter run --release. The --release flag helps prevent issues such as the app not working after the device is unplugged and the app is restarted.
