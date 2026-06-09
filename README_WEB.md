# Bruno's Kitchen - Web Application

A sophisticated web-based platform designed for pet owners to manage, customize, and subscribe to tailored nutritional meal plans for their dogs. The web application provides a responsive experience for browsing products, managing subscriptions, and accessing pet health resources.

## 1. Stack & Installation

### Tech Stack
*   **Framework:** [Flutter Web](https://flutter.dev/multi-platform/web)
*   **Language:** Dart
*   **State Management:** Provider (MVVM Architecture)
*   **Backend Services:** Firebase (Authentication, Cloud Messaging, Storage)
*   **Payments:** Stripe Integration
*   **Responsiveness:** Responsive Framework & Flutter ScreenUtil
*   **Deployment:** Vercel (via GitHub Actions)

### Running Locally
1.  **Prerequisites:** Install [Flutter SDK](https://docs.flutter.dev/get-started/install).
2.  **Clone the Repository:**
    ```bash
    git clone <repository-url>
    cd bruno-mobile
    ```
3.  **Install Dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Run for Web:**
    ```bash
    flutter run -d chrome
    ```
5.  **Build for Production:**
    ```bash
    flutter build web --release
    ```

## 2. Project Structure & Design Pattern

The project follows the **MVVM (Model-View-ViewModel)** design pattern to ensure a clean separation of concerns, scalability, and testability.

*   **Models (`lib/models/`):** Defines data structures for Recipes, Puppies (Pets), Orders, and Cart items.
*   **Views (`lib/screens/` & `lib/widgets/`):** Pure UI components. The Web version utilizes `ResponsiveFramework` to adapt layouts from mobile-first designs to desktop-friendly views.
*   **ViewModels (`lib/view_models/`):** Acts as a bridge between Models and Views. It handles state management using `ChangeNotifier` and `Provider`, managing business logic like plan calculations and API interactions.
*   **Services (`lib/services/`):** Abstracted API layers (Auth, Order, Plan, Card) using `ApiBaseHelper` for consistent networking.
*   **Utils (`lib/utils/`):** Contains complex business logic (e.g., `calculations.dart`), theme constants, and helper methods.

## 3. Application Flow (Web)

The Web application is optimized for direct commerce and efficient management:
1.  **Direct Entry (Shop):** Unlike the mobile experience, web users are directed straight to the **Shop page** to immediately explore the product catalog and recipe varieties.
2.  **Authentication:** Secure login/registration integrated with Firebase for personalized nutrition profiles.
3.  **Subscription Management:** Users can select between "Transitional Plans" (for introducing new food) or "Monthly Subscriptions."
4.  **Checkout:** A streamlined web checkout flow using Stripe, integrated with address management.
5.  **Blog & FAQs:** Rich content pages to educate pet owners on canine nutrition.

## 4. Business Logic

The core value of Bruno's Kitchen lies in its **Tailored Nutrition Engine**:
*   **Daily Intake Calculation:** Automatically calculates the precise calorie and gram requirements for a dog based on its breed, life stage (Puppy/Adult), activity level, and current weight.
*   **Plan Differentiation:**
    *   **Transitional Plan:** A 10-day structured introduction to Bruno's Kitchen food, gradually increasing the ratio from 25% to 100% to ensure digestive safety.
    *   **Monthly Subscription:** A recurring meal plan tailored to the dog's specific needs, with logic to handle multiple recipes and delivery schedules.
*   **Dynamic Pricing:** Prices are not static; they scale based on the weight of the pet and the volume of food required, ensuring fair and accurate billing per subscription cycle.
