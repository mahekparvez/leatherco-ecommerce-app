# Firebase Setup Instructions

## 1. Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Enter project name: `leather-ecommerce-app`
4. Enable Google Analytics (optional)
5. Click "Create project"

## 2. Enable Authentication

1. In Firebase Console, go to "Authentication" in the left sidebar
2. Click "Get started"
3. Go to "Sign-in method" tab
4. Enable "Email/Password" provider
5. Click "Save"

## 3. Create Firestore Database

1. In Firebase Console, go to "Firestore Database" in the left sidebar
2. Click "Create database"
3. Choose "Start in test mode" (for development)
4. Select a location for your database
5. Click "Done"

## 4. Get Firebase Configuration

### For Web:
1. In Firebase Console, go to Project Settings (gear icon)
2. Scroll down to "Your apps" section
3. Click "Add app" and select Web (</>) icon
4. Register your app with a nickname
5. Copy the Firebase configuration object
6. Replace the placeholder values in `lib/firebase_options.dart`:

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'your-actual-api-key',
  appId: 'your-actual-app-id',
  messagingSenderId: 'your-actual-sender-id',
  projectId: 'your-actual-project-id',
  authDomain: 'your-actual-project-id.firebaseapp.com',
  storageBucket: 'your-actual-project-id.appspot.com',
);
```

### For Android:
1. Click "Add app" and select Android icon
2. Enter package name: `com.example.leather_ecommerce_app`
3. Download `google-services.json`
4. Place it in `android/app/` directory
5. Update `lib/firebase_options.dart` with Android configuration

### For iOS:
1. Click "Add app" and select iOS icon
2. Enter bundle ID: `com.example.leatherEcommerceApp`
3. Download `GoogleService-Info.plist`
4. Place it in `ios/Runner/` directory
5. Update `lib/firebase_options.dart` with iOS configuration

## 5. Install FlutterFire CLI (Optional but Recommended)

```bash
npm install -g firebase-tools
dart pub global activate flutterfire_cli
```

Then run:
```bash
flutterfire configure
```

This will automatically configure Firebase for all platforms.

## 6. Security Rules (Important!)

### Firestore Rules:
Go to Firestore Database > Rules and update:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read/write their own user document
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Products are readable by all authenticated users
    match /products/{productId} {
      allow read: if request.auth != null;
      allow write: if false; // Only admins should write products
    }
  }
}
```

## 7. Test the Setup

1. Run the app: `flutter run`
2. Navigate to `/login` or `/register`
3. Try creating an account
4. Check Firebase Console > Authentication to see the user
5. Check Firestore Database to see user data

## 8. Production Considerations

1. **Security Rules**: Update Firestore rules for production
2. **Authentication**: Enable additional providers if needed
3. **Database**: Switch from test mode to production mode
4. **Monitoring**: Set up Firebase Analytics and Crashlytics
5. **Backup**: Set up automated backups

## Troubleshooting

- **Build errors**: Make sure all Firebase dependencies are properly installed
- **Authentication errors**: Check if Email/Password is enabled in Firebase Console
- **Database errors**: Verify Firestore rules allow the operations
- **Configuration errors**: Double-check all API keys and project IDs

## Next Steps

1. Implement user profile management
2. Add order history functionality
3. Set up product management for admins
4. Add email verification
5. Implement password reset functionality