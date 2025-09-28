# Leather Ecommerce App

A modern, minimalist ecommerce website built with Flutter and Firebase, inspired by Leatherology's design.

## Features

- **Modern UI/UX**: Clean, minimalist design with premium feel
- **Product Catalog**: Browse products by category with search functionality
- **Shopping Cart**: Add/remove items with quantity management
- **Checkout Process**: Simple checkout with customer information form
- **Firebase Integration**: Real-time data with Firestore
- **Responsive Design**: Works on all screen sizes
- **State Management**: Provider pattern for efficient state management

## Project Structure

```
lib/
├── main.dart                 # App entry point and routing
├── models/                   # Data models
│   ├── product.dart         # Product model
│   ├── cart_item.dart       # Cart item model
│   └── order.dart           # Order model
├── providers/               # State management
│   ├── cart_provider.dart   # Cart state management
│   └── product_provider.dart # Product state management
├── screens/                 # App screens
│   ├── home_screen.dart     # Home page
│   ├── shop_screen.dart     # Product catalog
│   ├── product_detail_screen.dart # Product details
│   ├── cart_screen.dart     # Shopping cart
│   ├── checkout_screen.dart # Checkout process
│   └── contact_screen.dart  # Contact page
├── widgets/                 # Reusable widgets
│   ├── announcement_bar.dart # Top announcement bar
│   ├── navigation_bar.dart  # Main navigation
│   ├── hero_banner.dart     # Hero section
│   ├── product_card.dart    # Product display card
│   └── footer.dart          # Footer component
├── services/                # External services
│   └── firebase_service.dart # Firebase operations
└── utils/                   # Utilities
    └── app_theme.dart       # App styling and theme
```

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Firebase project
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd leather_ecommerce_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase**
   - Follow the instructions in `firebase_setup_instructions.md`
   - Run `flutterfire configure` to set up Firebase

4. **Run the app**
   ```bash
   flutter run
   ```

## Customization Guide

### Colors

The app uses a carefully selected color palette inspired by Leatherology. To customize colors, edit `lib/utils/app_theme.dart`:

```dart
class AppTheme {
  // Primary colors
  static const Color primaryColor = Color(0xFF2C2C2C);     // Dark charcoal
  static const Color secondaryColor = Color(0xFF8B4513);   // Saddle brown
  static const Color accentColor = Color(0xFFD4AF37);      // Gold accent
  
  // Background colors
  static const Color backgroundColor = Color(0xFFFFFFFF);  // Pure white
  static const Color surfaceColor = Color(0xFFF8F8F8);     // Light gray
  
  // Text colors
  static const Color textPrimary = Color(0xFF2C2C2C);      // Dark text
  static const Color textSecondary = Color(0xFF666666);    // Medium gray
  static const Color textLight = Color(0xFF999999);        // Light gray
}
```

### Fonts

The app uses the Inter font family. To change fonts:

1. **Add font files** to `assets/fonts/` directory
2. **Update pubspec.yaml**:
   ```yaml
   fonts:
     - family: YourFontFamily
       fonts:
         - asset: assets/fonts/YourFont-Regular.ttf
         - asset: assets/fonts/YourFont-Bold.ttf
           weight: 700
   ```
3. **Update app_theme.dart**:
   ```dart
   static const String fontFamily = 'YourFontFamily';
   ```

### Images

To customize images:

1. **Hero Banner**: Update the `backgroundImageUrl` in `home_screen.dart`
2. **Product Images**: Replace URLs in `product_provider.dart` or use Firebase Storage
3. **Logo**: Add your logo to `assets/images/` and update the navigation bar
4. **Favicon**: Replace `android/app/src/main/res/mipmap-*/ic_launcher.png`

### Content

#### Product Data
Update product information in `lib/providers/product_provider.dart`:

```dart
Product(
  id: '1',
  name: 'Your Product Name',
  price: 99.99,
  imageUrl: 'https://your-image-url.com/image.jpg',
  description: 'Your product description',
  category: 'Your Category',
  specifications: {
    'material': 'Your Material',
    'dimensions': 'Your Dimensions',
  },
)
```

#### Company Information
Update company details in:
- `lib/widgets/footer.dart` - Footer contact info
- `lib/screens/contact_screen.dart` - Contact page details
- `lib/widgets/announcement_bar.dart` - Promotional messages

#### Navigation
Modify categories in `lib/widgets/navigation_bar.dart`:

```dart
final List<String> _categories = ['Your', 'Custom', 'Categories'];
```

### Layout Customization

#### Spacing
Adjust spacing throughout the app in `app_theme.dart`:

```dart
static const double spacingXS = 4.0;
static const double spacingS = 8.0;
static const double spacingM = 16.0;
static const double spacingL = 24.0;
static const double spacingXL = 32.0;
static const double spacingXXL = 48.0;
```

#### Border Radius
Customize rounded corners:

```dart
static const double radiusS = 4.0;
static const double radiusM = 8.0;
static const double radiusL = 12.0;
static const double radiusXL = 16.0;
```

### Firebase Configuration

#### Firestore Collections
The app expects two main collections:

1. **products** - Product catalog
2. **orders** - Customer orders

#### Security Rules
Update Firestore rules for production:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /products/{document} {
      allow read: if true;
      allow write: if request.auth != null; // Admin only
    }
    
    match /orders/{document} {
      allow read, write: if request.auth != null; // Authenticated users only
    }
  }
}
```

## Deployment

### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Create an issue in the repository
- Check the Firebase setup instructions
- Review the Flutter documentation

## Acknowledgments

- Design inspired by [Leatherology](https://www.leatherology.com/)
- Built with [Flutter](https://flutter.dev/)
- Backend powered by [Firebase](https://firebase.google.com/)
- Icons from [Material Design](https://material.io/icons/)
