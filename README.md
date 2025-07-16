# Sakudok

A comprehensive document management application built with Flutter, designed to help users organize, manage, and bundle their important documents efficiently.

## Features

### 📁 Document Management
- Upload and store various document types (PDF, images, etc.)
- Organize documents with tags and categories
- OCR text extraction from images and scanned documents
- Document search and filtering capabilities

### 📋 Smart Document Bundles
- Create custom document bundles for specific purposes
- Pre-defined templates for common use cases (work, travel, education, finance)
- Smart bundle suggestions based on document analysis
- Track bundle completion status
- Required vs optional document tracking

### 🔐 Security & Privacy
- Secure local storage with encryption
- Biometric authentication support
- Data backup and restore functionality

### 🎨 User Experience
- Modern Material Design 3 UI
- Dark and light theme support
- Responsive design for various screen sizes
- Intuitive navigation and user-friendly interface

## Architecture

This project follows Clean Architecture principles with the following structure:

```
lib/
├── core/                 # Core utilities and shared components
├── features/            # Feature-based modules
│   ├── documents/       # Document management feature
│   ├── bundles/         # Document bundling feature
│   ├── auth/           # Authentication feature
│   └── main_navigation/ # App navigation
└── main.dart           # App entry point
```

Each feature follows the Clean Architecture pattern:
- **Domain Layer**: Entities, use cases, and repository interfaces
- **Data Layer**: Repository implementations and data sources
- **Presentation Layer**: UI components, pages, and state management

## Tech Stack

- **Framework**: Flutter (Dart)
- **State Management**: Riverpod
- **Database**: SQLite with Drift ORM
- **Architecture**: Clean Architecture + Feature-based structure
- **UI**: Material Design 3
- **File Handling**: File picker, image cropper
- **Security**: Flutter Secure Storage, Local Authentication
- **Notifications**: Flutter Local Notifications

## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android device/emulator or iOS device/simulator

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Najwanyusnianda/sakudok.git
cd sakudok
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate code (if needed):
```bash
flutter packages pub run build_runner build
```

4. Run the application:
```bash
flutter run
```

### Building for Production

#### Android
```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

#### iOS
```bash
flutter build ios --release
```

## Project Structure

### Core Components
- **Database**: SQLite database with Drift for type-safe SQL operations
- **Authentication**: Biometric and PIN-based authentication
- **File Management**: Secure file storage and organization
- **State Management**: Riverpod for reactive state management

### Key Features Implementation
- **Document OCR**: Text extraction from images using ML Kit
- **Bundle Templates**: Pre-configured document collections
- **Smart Suggestions**: AI-powered document organization recommendations
- **Search & Filter**: Advanced document discovery capabilities

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support and questions, please open an issue in the GitHub repository.
