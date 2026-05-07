# Harry Potter Character Explorer ✨

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Riverpod](https://img.shields.io/badge/Riverpod-%234285F4.svg?style=flat)](https://riverpod.dev)
[![GoRouter](https://img.shields.io/badge/GoRouter-%230175C2.svg?style=flat)](https://pub.dev/packages/go_router)

A premium, feature-rich Flutter application that allows you to explore the magical world of Harry Potter. Discover characters, filter by Hogwarts houses, and dive into the details of your favorite wizards and witches.

---

## 📸 Screenshots

| Home Screen | Detail Screen | Settings |
| :---: | :---: | :---: |
| ![TODO: Add Home Screenshot]() | ![TODO: Add Detail Screenshot]() | ![TODO: Add Settings Screenshot]() |

---

## ✨ Features

- **Magical Discovery**: Browse a comprehensive list of characters from the Harry Potter universe.
- **House Sorting**: Filter characters by their Hogwarts House (Gryffindor, Slytherin, Ravenclaw, Hufflepuff) with beautiful visual cues.
- **Quick Search**: Effortlessly find characters using the responsive search functionality.
- **Detailed Profiles**: View in-depth information about each character.
- **Premium UI/UX**: Built with Material 3, featuring smooth animations, custom themes, and a "wow" factor.
- **Adaptive Design**: Fully responsive across mobile, tablet, and desktop platforms.
- **Dark Mode Support**: Seamlessly switches between Light and Dark modes based on system settings.

---

## 🛠️ Tech Stack

- **Core**: [Flutter](https://flutter.dev) & [Dart](https://dart.dev)
- **State Management**: [Riverpod](https://riverpod.dev) (using code generation for safety and performance)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
- **Networking**: [Dio](https://pub.dev/packages/dio) for robust API communication
- **JSON Handling**: [json_serializable](https://pub.dev/packages/json_serializable)
- **UI Components**:
  - `google_fonts` for premium typography
  - `shimmer` for elegant loading states
  - `cached_network_image` for optimized image loading

---

## 🌐 API Reference

This application utilizes the **[HP-API](https://hp-api.onrender.com/)**, a free and open-source API providing comprehensive data about the Harry Potter universe.

- **Base URL**: `https://hp-api.onrender.com/`
- **Endpoints used**:
  - `/api/characters`: Fetches all characters.
  - `/api/characters/house/:house`: Fetches characters by house.
  - `/api/characters/students`: Fetches all students.
  - `/api/characters/staff`: Fetches all staff members.

---

## 🏗️ Architecture

The project follows a **Feature-Based Layered Architecture**, ensuring scalability and maintainability:

- **`core/`**: Shared utilities, theme definitions, and global constants.
- **`data/`**: Repository implementations, API services, and data models (DTOs).
- **`domain/`**: Business logic, domain models, and repository interfaces.
- **`presentation/`**: UI widgets, screens, and Riverpod providers.

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/Joevandyta/Harry-Potter-Character-Explorer-FlutterApp.git
    cd harry_potter_char_app
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Generate code**:
    (Since this project uses code generation for Riverpod and JSON serialization)
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the app**:
    ```bash
    flutter run
    ```

---

*Made with ❤️ for the Wizarding World.*
