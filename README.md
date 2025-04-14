# Recipe Circle

## Getting Started

Instructions to run the project

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- VS Code with Flutter extension
- An Android or iOS device/emulator

### Installation

1. Clone the repository:

   ```
   git clone https://github.com/midhununni457/recipe_share.git
   cd recipe_share
   ```

2. Install dependencies:

   ```
   flutter pub get
   ```

3. Run the app:

   **Method 1: Command Line**

   ```
   flutter run
   ```

   **Method 2: Using IDE**

   - Open the project in VS Code or Android Studio
   - Connect a physical device or start an emulator/simulator
     - For Android Studio: Open AVD Manager and launch a virtual device
     - For VS Code: Use the device selector in the status bar to choose a device
   - Open `lib/main.dart`
   - Select "Run Without Debugging" option
   - Alternatively, click the Run icon in the editor toolbar

## Dependencies

This project uses the following Flutter packages:

| Package       | Version | Purpose                                              |
| ------------- | ------- | ---------------------------------------------------- |
| flutter       | SDK     | The base Flutter framework                           |
| provider      | ^6.1.2  | State management solution                            |
| http          | ^1.2.1  | Making API requests to fetch recipe and product data |
| flutter_lints | ^5.0.0  | Recommended lints for good coding practices          |

## Architecture and State Management

### Provider

This app uses Provider for state management. The key components include:

- **ProductProvider**: Manages product data, favorites, and category filtering.
- **ChangeNotifierProvider**: Makes the state available throughout the widget tree.
- **Consumer and Provider.of**: Used to access state in widgets efficiently.

This approach was chosen for:

- Simplified state access across different parts of the app
- Efficient rebuilding of only affected widgets
- Separation of state management logic from UI

### Project Structure

```
lib/
├── models/              # Data models
├── providers/           # State management
├── screens/             # UI screens
├── services/            # API and data services
├── widgets/             # Reusable UI components
│   ├── cards/           # Card UI components
│   ├── categories/      # Category-related widgets
│   ├── lists/           # List view components
│   └── sections/        # Content section widgets
└── main.dart            # Application entry point
```
