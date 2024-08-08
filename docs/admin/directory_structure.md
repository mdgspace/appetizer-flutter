# Directory Structure Summary
## Lib Directory
- **main.dart**: The entry point of the Flutter application. It initializes the app, sets preferred orientations, preserves the splash screen, initializes local storage, sets up Sentry for error tracking, and runs the `AppetizerApp` wrapped in DevicePreview for debugging purposes.
 
- **data**: Contains the core data handling components, including models, repositories, and data sources.
  - **constants**: Defines static values such as error messages, day names, local database keys, and OAuth URLs and all the API endpoint URLs used throughout the app.
  - **core**: Implements intrinsic router for handling navigation within the app, including route definitions and core module lifecycle methods, including boot-up and boot-down processes.
  - **services**: Provides various services for data handling and API communication.
	- **local**: Handles local data operations and in-app interactions. It also provides local storage functionalities for persisting data.
	- **remote**: Manages remote data operations and communications like API requests/responses and notifications.
 
- **domain**: Manages business logic and domain-specific entities.
  - **amenity**: Integrates Firebase Analytics for event tracking and provides an analytics observer. Also, handles Mixpanel analytics and initialization.
  - **core**: Implements routing and navigation logic as defined in the data layer.
  - **models**: Defines data models for various features, namely, coupon, feedback, hostel change requests, leaves, menu, multimessing, transaction and user{authentication and notifications}.
  - **repositories**: Implements repository pattern for data access and manipulation, supporting BLOC architecture.
 
- **enums**: Defines enumerations used throughout the app to enhance code readability and maintainability, more specifically for different meal types, various view states and managing these enumeration values.
 
- **presentation**: Manages the UI layer of the application, including widgets, screens, and related logic.
  - **app**: Implements the main application structure and contains the primary configurations and screens.
  - **bottom_navigator**: Manages the bottom navigation bar logic and UI components.
  - **components**: Includes reusable UI components and widgets for consistent design across the app.
  - The presentation logic for the various model features described earlier is also stated here.
 
- **utils**: Provides utility functions and classes shared across different parts of the application.
  - **app_extensions**: Extension methods for enhancing built-in types and adding additional functionalities.
  - **booters**: Manages the booting process of the application, including initialization and event handling.
  - **interceptors**: Implements the interceptor for handling authentication-related tasks and logging information and errors.
  - Other utility functions for color manipulations and transformations, date and time manipulations, handling feedback logic, re-casing strings to different formats and validating inputs, etc are also implemented here.
 
- **app_theme.dart**: Defines the app's theme, including text styles and color constants to ensure a consistent look and feel.
 
- **globals.dart**: Stores global variables and constants used throughout the application.
 
- **locator.dart**: Manages the service locator setup for dependency injection using the GetIt package. It registers services such as `PushNotificationService`, `AnalyticsService`, `DialogService`, `RemoteConfigService`, and `PackageInfoService`.
