# Localization Guide

This guide shows how to use localization throughout the Flutter Bloc Starter Kit.

## Setup Complete ✅

The localization system is already set up with:
- **AppLocalizations** delegate configured in `app.dart`
- **Extension method** `context.l10n` for easy access
- **Utility functions** for common patterns like greetings
- **Example strings** in `app_en.arb`

## How to Use Localization

### 1. Using the Extension Method (Recommended)

```dart
import '../../../../core/localization/l10n_extensions.dart';

// In your widget build method:
Text(context.l10n.homePageTitle)
Text(context.l10n.welcomeMessage)
```

### 2. Using AppLocalizations Directly

```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// In your widget build method:
Text(AppLocalizations.of(context)!.homePageTitle)
```

### 3. With Parameters

```dart
// For strings with placeholders
Text(context.l10n.itemsCount(42))  // "42 items"
Text(context.l10n.greetingWithName("Good Morning", "John"))  // "Good Morning, John!"
```

## Adding New Strings

### Step 1: Add to .arb file

Edit `lib/core/localization/app_en.arb`:

```json
{
  "newStringKey": "Your new string",
  "stringWithParam": "Hello {name}!",
  "@stringWithParam": {
    "placeholders": {
      "name": {
        "type": "String"
      }
    }
  }
}
```

### Step 2: Generate localization files

```bash
flutter gen-l10n
```

### Step 3: Use in your widgets

```dart
Text(context.l10n.newStringKey)
Text(context.l10n.stringWithParam("World"))
```

## Common Patterns

### 1. Error Messages
```dart
// Add to .arb
"networkError": "Network connection failed"
"tryAgainLater": "Please try again later"

// Usage
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text(context.l10n.networkError)),
);
```

### 2. Dialog Titles and Actions
```dart
// Add to .arb
"confirmAction": "Confirm Action"
"confirmMessage": "Are you sure you want to proceed?"
"yes": "Yes"
"no": "No"

// Usage
AlertDialog(
  title: Text(context.l10n.confirmAction),
  content: Text(context.l10n.confirmMessage),
  actions: [
    TextButton(
      onPressed: () => Navigator.pop(context, false),
      child: Text(context.l10n.no),
    ),
    TextButton(
      onPressed: () => Navigator.pop(context, true),
      child: Text(context.l10n.yes),
    ),
  ],
)
```

### 3. Form Labels and Hints
```dart
// Add to .arb
"emailLabel": "Email Address"
"emailHint": "Enter your email"
"passwordLabel": "Password"
"passwordHint": "Enter your password"

// Usage
TextFormField(
  decoration: InputDecoration(
    labelText: context.l10n.emailLabel,
    hintText: context.l10n.emailHint,
  ),
)
```

### 4. Navigation and Buttons
```dart
// Add to .arb
"save": "Save"
"cancel": "Cancel"
"next": "Next"
"previous": "Previous"
"done": "Done"

// Usage
ElevatedButton(
  onPressed: _onSave,
  child: Text(context.l10n.save),
)
```

## Best Practices

### 1. Use Semantic Keys
```json
// Good ✅
"loginButtonLabel": "Sign In"
"userProfileTitle": "My Profile"

// Avoid ❌
"button1": "Sign In"
"title": "My Profile"
```

### 2. Group Related Strings
```json
{
  "authLoginTitle": "Sign In",
  "authLoginEmail": "Email",
  "authLoginPassword": "Password",
  "authLoginButton": "Sign In",
  "authLoginForgotPassword": "Forgot Password?",
  
  "authRegisterTitle": "Create Account",
  "authRegisterButton": "Create Account"
}
```

### 3. Use Parameters for Dynamic Content
```json
{
  "itemsFound": "Found {count} items",
  "@itemsFound": {
    "placeholders": {
      "count": {"type": "int"}
    }
  },
  
  "lastUpdated": "Last updated: {date}",
  "@lastUpdated": {
    "placeholders": {
      "date": {"type": "DateTime", "format": "yMd"}
    }
  }
}
```

### 4. Use the L10nUtils for Common Patterns
```dart
// For time-based greetings
final greeting = L10nUtils.getGreeting(context.l10n);
final greetingWithName = L10nUtils.getGreetingWithName(context.l10n, username);
```

## Adding More Languages

### 1. Create new .arb file
Create `lib/core/localization/app_es.arb` for Spanish:

```json
{
  "@@locale": "es",
  "homePageTitle": "Página de Inicio",
  "welcomeMessage": "¡Bienvenido al Kit de Inicio de Flutter Bloc!"
}
```

### 2. Update supported locales
In `lib/core/app.dart`:

```dart
supportedLocales: const [
  Locale('en', ''),
  Locale('es', ''),
],
```

### 3. Regenerate
```bash
flutter gen-l10n
```

## Examples in the Codebase

Check these files to see localization in action:
- `lib/features/fruits/presentation/pages/fruits_page.dart` - Complete example
- `lib/features/home/presentation/pages/home_page.dart` - Simple example
- `lib/core/localization/l10n_extensions.dart` - Extension and utilities

## Pro Tips

1. **Use the extension**: `context.l10n.stringKey` is cleaner than `AppLocalizations.of(context)!.stringKey`

2. **Group by feature**: Consider prefixing keys by feature (`fruitsPageTitle`, `authLoginButton`)

3. **Test with long strings**: Some languages are much longer than English

4. **Use descriptive names**: Make it clear what the string is used for

5. **Add context comments**: Use the `@stringKey` pattern to provide context for translators
