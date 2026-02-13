![telegram-cloud-photo-size-2-5219895667659054405-y](https://github.com/user-attachments/assets/d8154ce6-6d21-435e-b3ff-74197e01bd30)

# NBU Currency Rates

Flutter application for tracking official currency exchange rates from the National Bank of Ukraine (NBU).

This project demonstrates scalable architecture, strict separation of concerns, and clean engineering practices suitable for long-term product growth.

## Features

- Latest NBU currency rates
- Search by currency code or name
- Historical chart (7 / 30 / 90 / 180 / 365 days)
- Statistics (min / max / average / change)
- Light / Dark theme
- Ukrainian / English localization
- Adaptive layout (Mobile / Web / Desktop)

## Architecture

The project follows Clean Architecture principles with strict separation of concerns.

### Layers

**Presentation**
- UI (Screens)
- BLoC state management
- Navigation (go_router)
- Themes & Localization

**Domain**
- Entities
- Repository interfaces
- Pure business logic (framework-independent)

**Data**
- Models (JSON)
- Mappers (Model ↔ Entity)
- Repository implementations
- API client (Dio)
- Local storage (SharedPreferences)

### Dependency Rule

All dependencies point inward toward the Domain layer.

## Tech Stack

- flutter_bloc
- go_router
- dio
- get_it
- shared_preferences
- fl_chart

## Getting Started

### Requirements

- Flutter SDK >= 3.8.0
- Dart SDK >= 3.8.0

### Install

```bash
flutter pub get
flutter gen-l10n
```

## Run Application

### Mobile (Android / iOS)

```bash
flutter run
```

To specify device:

```bash
flutter run -d android
flutter run -d ios
```

### Web

**Important for Web**: Due to CORS restrictions, you need to run the backend proxy server.

**Option 1 - Automated (recommended):**

```bash
./start-web-dev.sh
```

**Option 2 - Manual (two terminals):**

Terminal 1 - Start backend proxy:
```bash
cd backend
npm install
npm run dev
```

Terminal 2 - Start Flutter web:
```bash
flutter run -d chrome
```

### Build Release

```bash
flutter build apk --release
flutter build ios --release
flutter build web
```

## Project Structure

```
lib/
├── main.dart
├── di/
├── domain/
├── data/
├── presentation/
└── l10n/
```

## API

Official NBU API: https://bank.gov.ua/en/open-data/api-dev

**CORS Proxy for Web:**

For Flutter web builds, the app uses a local proxy server to bypass CORS restrictions.

- Mobile/Desktop: Direct API access
- Web: Proxy server at `http://localhost:3000/api`
