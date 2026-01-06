# BloodLink Application Blueprint

## Overview

BloodLink is a mobile application designed to connect blood donors with those in need, streamlining the process of blood donation and requests. The app provides a user-friendly interface for users to register, manage their donor status, and see recent activity in their community.

## Implemented Features, Style, and Design

### 1. Project Foundation & Theming

- **Framework:** Built with Flutter using Material 3 design principles.
- **Color Scheme:** A clear and energetic theme rooted in a primary seed color of `Colors.red`.
- **Typography:** A modern and readable type hierarchy is established using `google_fonts`:
  - **Display/Headlines:** Oswald
  - **Titles:** Roboto
  - **Body Text:** Open Sans
- **Themes:** The application supports both **Light and Dark** modes, with distinct and consistent styling for components like `AppBar` in each mode.
- **State Management:** The application has been refactored to use Flutter's built-in `ValueNotifier` for efficient and simple local state management, particularly for UI elements like the bottom navigation bar.

### 2. Application Screens

- **Home Screen (`HomeScreen`):**
  - This is the main screen of the application.
  - It features a `CustomScrollView` for a flexible and performant layout.
  - A welcoming `SliverAppBar` greets the user by name and displays their location.
  - **Bottom Navigation:** Provides access to four main sections: Home, Search, Requests, and Profile.
  - **Home Tab Content (`HomeTab`):**
    - `HeroActionCard`: A prominent card for a primary call-to-action, like finding a donor.
    - `DonorStatusCard`: Displays the user's current donor status.
    - `Recent Updates`: A placeholder list showing recent blood request fulfillments.

- **Login Screen (`LoginScreen`):**
  - A clean and simple login interface.
  - Includes fields for email and password, a "Forgot Password?" link, and a button to navigate to the registration screen.

- **Registration Screen (`RegisterScreen`):**
  - A comprehensive, form-based registration page.
  - Collects essential user information (name, email, phone, password, address).
  - Features an optional section for users to register as a donor by providing their blood group and last donation date, utilizing a `DropdownButtonFormField` and a `DatePicker`.

### 3. Reusable Widgets

- **`CustomTextField`:** A standardized text input field to ensure a consistent look and feel across all forms.
- **`HeroActionCard`:** A reusable card for high-priority actions.
- **`DonorStatusCard`:** A card for displaying donor-specific information.

### 4. Data Models

- **`UserModel`:** Represents a logged-in user, containing their name, blood group, and location.
- **`UserRegistrationModel`:** A model to hold user data during the registration process.

### 5. Routing and Navigation

- **Declarative Navigation:** The application uses the `go_router` package for a centralized and declarative approach to navigation.
- **Routes:**
  - `/`: The initial route, which displays the `LoginScreen`.
  - `/register`: Navigates to the `RegisterScreen`.
  - `/home`: Navigates to the main `HomeScreen` after successful login.

## Current Development Plan

**Status:** The core UI, theming, and navigation are now complete. The application is in a stable state.

**Next Steps:**
1.  **Implement Authentication:** Connect the login and registration forms to a backend service (like Firebase Authentication) to manage user accounts.
2.  **Data Persistence:** Store and retrieve user data from a database (like Firestore).
