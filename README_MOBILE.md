# Bruno's Kitchen - Mobile Application

The Bruno's Kitchen mobile app is a high-performance, cross-platform application (iOS & Android) designed to provide pet owners with a seamless way to manage their dog's health and nutrition on the go.

## 1. Stack & Installation

### Tech Stack
*   **Framework:** [Flutter](https://flutter.dev/)
*   **Language:** Dart
*   **State Management:** Provider
*   **Local Notifications:** flutter_local_notifications
*   **Maps & Location:** google_maps_flutter, geolocator, map_launcher
*   **Storage:** Firebase Storage (for puppy profiles)
*   **Payments:** flutter_stripe (Native SDK integration)
*   **UI/UX:** Flutter ScreenUtil (for adaptive sizing), Carousel Slider, Intro Slider

### Running Locally
1.  **Prerequisites:** Install [Flutter SDK](https://docs.flutter.dev/get-started/install) and configure Android Studio / Xcode.
2.  **Clone the Repository:**
    ```bash
    git clone <repository-url>
    cd bruno-mobile
    ```
3.  **Install Dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Run Application:**
    *   Connect a physical device or start an emulator.
    *   `flutter run`
5.  **Build Release:**
    *   **Android:** `flutter build apk` or `flutter build appbundle`
    *   **iOS:** `flutter build ios` (requires macOS and Xcode)

## 2. Project Structure & Design Pattern

The mobile app implements a strict **MVVM (Model-View-ViewModel)** architecture:

*   **View Layer (`lib/screens/`):** Utilizes mobile-specific navigation patterns like `BottomNavigationBar` and `RouteGenerator`.
*   **ViewModel Layer (`lib/view_models/`):** Manages the reactive state of the UI. For example, `PuppyViewModel` handles the real-time calculation of pet nutritional needs as the user inputs data.
*   **Service Layer (`lib/services/`):** Interfaces with external APIs and device hardware. This includes `LocalNotificationService` for delivery reminders and `FirebaseUploadImageService` for pet profile photos.
*   **Navigation (`lib/route_generator.dart`):** A centralized named-routing system that manages transitions between complex onboarding flows and the dashboard.

## 3. Application Flow (Mobile)

The mobile experience is centered around convenience and pet profile management:
1.  **Onboarding:** Interactive `IntroSlider` explaining the benefits of fresh pet food.
2.  **Puppy Creation:** A multi-step wizard (`PuppyCreationScreen`) where users input their dog's breed, weight, age, and activity level.
3.  **Personalized Dashboard:** A mobile-optimized home screen featuring pet-specific nutritional summaries and quick links to order management.
4.  **Meal Planning:** A fluid UI for selecting "Transitional" or "Monthly" plans with a focus on ease of selection through `CarouselSlider`.
5.  **Offline Support & Notifications:** Uses `shared_preferences` for quick data retrieval and local notifications to remind owners of feeding schedules or upcoming deliveries.

## 4. Business Logic

The mobile app handles the heavy lifting of **Canine Nutritional Analytics**:
*   **Precision Feeding Engine:** Uses the metabolic weight formula (`activityLevel * pow(currentWeight, 0.75)`) to determine base calorie requirements.
*   **Adjustment Logic:** The engine dynamically adjusts the portion size (+/- 5-7%) if the dog is classified as underweight or overweight.
*   **Transition Management:** Generates a daily feeding schedule that tells the user exactly how many grams of Bruno's Kitchen food to mix with their dog's old food over a 10-day period.
*   **Paw Points:** A loyalty logic integrated into the user profile to reward recurring subscriptions and referrals.
