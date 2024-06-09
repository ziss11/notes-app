# Notes App

[Brief description of the project]

## Table of Contents

- [Notes App](#notes-app)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running the Application](#running-the-application)
  - [Building the Application](#building-the-application)
  - [Testing](#testing)
  - [Troubleshooting](#troubleshooting)

## Prerequisites

Before you begin, ensure you have met the following requirements:

- You have a machine running on Windows, macOS, or Linux.
- You have installed the [Flutter](https://flutter.dev/docs/get-started/install). I recommend to use the latest version of Flutter (v3.22.2) to avoid differences in writing code, compatibility with the libraries used and so on
- You have set up an editor such as [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/).

## Installation

To install the project, follow these steps:

1. **Clone the repository:**

   ```sh
   git clone https://github.com/ziss11/notes-app.git
   cd notes-app
   ```

2. **Install Flutter dependencies:**

   ```sh
   flutter pub get
   ```

## Running the Application

To run the application on an emulator or a physical device, follow these steps:

1. **Connect your device or start an emulator.**

2. **Run the app:**

   ```sh
   flutter run
   ```

   This command will compile the app and launch it on your connected device or emulator.

## Building the Application

To build the application for production, use the following commands:

1. **Build for Android:**

   ```sh
   flutter build apk --release
   ```

2. **Build for iOS:**

   ```sh
   flutter build ios --release
   ```

   **Note:** Building for iOS requires a macOS system with Xcode installed.

## Testing

To run the tests for the application, use the following command:

```sh
flutter test
```

## Troubleshooting

If you encounter any issues, consider the following steps:

- **Check Flutter doctor:** Ensure your Flutter setup is correct.

  ```sh
  flutter doctor
  ```

- **Verbose mode:** Run the app in verbose mode to get more detailed logs.

  ```sh
  flutter run -v
  ```

- **Search issues:** Look for solutions on [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter) or the [Flutter GitHub issues](https://github.com/flutter/flutter/issues).

---
