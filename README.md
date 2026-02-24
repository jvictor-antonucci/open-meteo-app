# Open Meteo App

A Flutter weather application built with clean architecture, BLoC state management, and the free [Open-Meteo API](https://open-meteo.com). It displays current conditions, hourly and 10-day forecasts, and adapts its theme dynamically based on weather conditions.

| Home | Saved Locations | Search Locations |
| -- | -- | -- |
| <img width="1320" height="2868" alt="Simulator Screenshot - iPhone 16 Pro Max - 2026-02-24 at 19 55 25" src="https://github.com/user-attachments/assets/098ec319-caf0-4ba1-a663-a4d9f6c5003a" /> | <img width="1320" height="2868" alt="Simulator Screenshot - iPhone 16 Pro Max - 2026-02-24 at 19 55 33" src="https://github.com/user-attachments/assets/c0d5aecb-0c3e-4024-96de-d220eb6f68b7" /> | <img width="1320" height="2868" alt="Simulator Screenshot - iPhone 16 Pro Max - 2026-02-24 at 19 55 53" src="https://github.com/user-attachments/assets/cfe9ba5d-9762-43e2-9d34-7802c495132c" /> |



---

## Table of Contents

- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Modules](#modules)
- [Data Flow](#data-flow)
- [Navigation](#navigation)
- [Local Storage & Caching](#local-storage--caching)
- [Dynamic Theming](#dynamic-theming)
- [API Integration](#api-integration)
- [Getting Started](#getting-started)

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart ^3.11.0) |
| State Management | [flutter_bloc](https://pub.dev/packages/flutter_bloc) ^9.1.1 |
| Navigation | [go_router](https://pub.dev/packages/go_router) ^17.1.0 |
| HTTP Client | [dio](https://pub.dev/packages/dio) ^5.9.1 |
| Local Storage | [hive_flutter](https://pub.dev/packages/hive_flutter) ^1.1.0 |
| Geolocation | [geolocator](https://pub.dev/packages/geolocator) ^14.0.2 |
| Icons | [lucide_icons_flutter](https://pub.dev/packages/lucide_icons_flutter) ^3.1.9 |
| Fonts | [google_fonts](https://pub.dev/packages/google_fonts) ^8.0.2 |
| Equality | [equatable](https://pub.dev/packages/equatable) ^2.0.8 |
| Formatting | [intl](https://pub.dev/packages/intl) ^0.20.2 |

---

## Architecture

The app follows **MVVM** with three distinct layers and the **BLoC pattern** for state management.

```mermaid
graph TD
    subgraph Presentation
        P1[Pages]
        P2[Widgets]
        P3[BLoC / Cubit]
    end

    subgraph Domain
        D1[Entities]
        D2[Enums]
    end

    subgraph Data
        DA1[Repositories]
        DA2[Services / API Clients]
        DA3[Local Storage - Hive]
    end

    P1 --> P3
    P2 --> P3
    P3 --> DA1
    DA1 --> DA2
    DA1 --> DA3
    DA2 --> D1
    DA3 --> D1
    P3 --> D1
    P3 --> D2
```

### State Management

Each feature module owns its BLoC. Global state is handled by Cubits at the app level.

| BLoC / Cubit | Responsibility |
|---|---|
| `LocationDetailsBloc` | Fetches and exposes weather data for a given location |
| `SavedLocationsBloc` | Manages the list of saved/favorite locations |
| `SearchLocationsBloc` | Handles location search queries and recent searches |
| `BottomNavigationCubit` | Tracks the active bottom navigation tab |
| `OpenMeteoThemeCubit` | Derives and exposes the app color theme from weather status |

---

## Project Structure

```
lib/
├── core/
│   ├── controllers/cubit/     # Global cubits (theme)
│   ├── entities/              # Shared data models (Location, WeatherDetail, etc.)
│   ├── enums/                 # WeatherStatus enum (WMO code mapping)
│   ├── route/                 # Go Router configuration
│   ├── services/              # API clients and Hive client
│   ├── shared/widgets/        # Reusable UI components
│   ├── theme/                 # Colors and typography
│   └── utils/                 # Helper functions
├── modules/
│   ├── bottom_navigation/     # Navigation shell page
│   ├── location/              # Home tab — current location weather
│   ├── saved/                 # Saved tab — favorite locations
│   └── search/                # Search tab — location search
└── main.dart
```

---

## Modules

### `location`

Displays full weather information for the user's current GPS location.

- Current temperature, weather status and description
- Hourly forecast (next 24 hours, horizontal scroll)
- 10-day daily forecast with min/max temperature range bar
- Detail cards: humidity, wind speed, UV index, visibility, precipitation probability, surface pressure

### `saved`

Manages saved (favorite) locations.

- Lists saved locations with a weather summary card each
- Allows toggling save/unsave
- Navigates to full weather detail for any saved location

### `search`

Location search and discovery.

- Search any city worldwide via the Geocoding API
- Displays weather preview for each result
- Maintains recent searches history (persisted in Hive)
- Save/unsave locations directly from search results

---

## Data Flow

### Fetching Weather for a Location

```mermaid
sequenceDiagram
    participant Page as LocationPage
    participant Bloc as LocationDetailsBloc
    participant Repo as LocationRepository
    participant GeoSvc as GeolocatorClient
    participant WeatherSvc as WeatherApiClient
    participant Hive as HiveClient

    Page->>Bloc: LocationDetailsRequested(location?)
    Bloc->>GeoSvc: getCurrentPosition() [if no location]
    GeoSvc-->>Bloc: Coordinate
    Bloc->>Hive: getCachedWeather(coordinate)
    alt Cache valid (< 15 min)
        Hive-->>Bloc: WeatherDetail
    else Cache expired or missing
        Bloc->>Repo: getWeatherDetail(coordinate)
        Repo->>WeatherSvc: GET /forecast
        WeatherSvc-->>Repo: Raw JSON
        Repo-->>Bloc: WeatherDetail
        Bloc->>Hive: cacheWeather(WeatherDetail)
    end
    Bloc-->>Page: LocationDetailsLoaded(WeatherDetail)
```

### Search Flow

```mermaid
sequenceDiagram
    participant Page as SearchLocationsPage
    participant Bloc as SearchLocationsBloc
    participant LocSvc as LocationApiClient
    participant Hive as HiveClient

    Page->>Bloc: SearchLocationsRequested(query)
    Bloc->>LocSvc: GET /search?name=query
    LocSvc-->>Bloc: List<Location>
    Bloc-->>Page: SearchLocationsLoaded(locations)

    Page->>Bloc: SearchLocationSelected(location)
    Bloc->>Hive: saveRecentSearch(location)
    Bloc-->>Page: Navigate to /search/details
```

### Save / Unsave Location

```mermaid
sequenceDiagram
    participant UI as Any Page
    participant Bloc as SavedLocationsBloc
    participant Hive as HiveClient

    UI->>Bloc: SaveLocationToggled(location)
    alt Location not saved
        Bloc->>Hive: saveLocation(location)
    else Location already saved
        Bloc->>Hive: removeLocation(location)
    end
    Bloc->>Hive: getSavedLocations()
    Hive-->>Bloc: List<Location>
    Bloc-->>UI: SavedLocationsLoaded(locations)
```

---

## Navigation

Navigation is handled by **Go Router** with type-safe routes via `TypedGoRoute`. Three persistent branches are mounted under a `StatefulShellRoute` (bottom navigation shell).

```mermaid
graph LR
    Shell["BottomNavigationShell"]

    Shell --> Home["/ — Home"]
    Shell --> Saved["/saved — Saved"]
    Shell --> Search["/search — Search"]

    Saved --> SavedDetails["/saved/details — Weather Detail"]
    Search --> SearchDetails["/search/details — Weather Detail"]
```

Routes pass `Location` objects as **extra parameters** to avoid encoding complex data in the URL path.

---

## Local Storage & Caching

Hive is used for three independent boxes:

| Box | Key | Value | Purpose |
|---|---|---|---|
| `saved_locations` | location id | `Location` JSON | Persisted favorites |
| `recent_searches` | location id | `Location` JSON | Recent search history |
| `cached_weather_locations` | coordinate string | `{data, timestamp}` JSON | Weather cache |

**Cache policy:** Cached weather entries are considered stale after **15 minutes**. On each request, `HiveClient` checks the timestamp before returning cached data; stale entries trigger a fresh API call.

---

## Dynamic Theming

The `OpenMeteoThemeCubit` derives a `ColorScheme` from the current `WeatherStatus`. This makes the entire app palette respond to weather conditions.

```mermaid
flowchart LR
    WS[WeatherStatus] -->|isClear| T1[Sunny Theme]
    WS -->|isRain| T2[Rainy Theme]
    WS -->|isSnow| T3[Snowy Theme]
    WS -->|isCloudy| T4[Cloudy Theme]
    WS -->|isThunderstorm| T5[Storm Theme]

    T1 & T2 & T3 & T4 & T5 --> CM[ColorScheme]
    CM --> App[MaterialApp theme]
```

`WeatherStatus` is a Dart enum that maps all **WMO weather interpretation codes** (0–99) and exposes boolean getters (`isClear`, `isRain`, `isSnow`, `isThunderstorm`, etc.) along with icon, label, and description properties.

---

## API Integration

### Open-Meteo Geocoding API

```
Base URL: https://geocoding-api.open-meteo.com/v1
```

| Endpoint | Usage |
|---|---|
| `GET /search?name=<query>` | Search locations by name |

### Open-Meteo Weather API

```
Base URL: https://api.open-meteo.com/v1
```

| Endpoint | Usage |
|---|---|
| `GET /forecast?latitude=<latitude>&longitude=<longitude>` | Fetch weather data for a coordinate |

**Key forecast parameters requested:**

- `current`: temperature_2m, weather_code
- `hourly`: temperature_2m, precipitation_probability, weather_code
- `daily`: weather_code, temperature_2m_max, temperature_2m_min, precipitation_probability_max, uv_index_max
- `current` extras: relative_humidity_2m, wind_speed_10m, surface_pressure, visibility

Both APIs are free and require no authentication for non-comercial usage.

---

## Getting Started

### Prerequisites

- Flutter SDK (stable channel)
- Dart ^3.11.0

### Installation

```bash
git clone https://github.com/<your-username>/open_meteo_app.git
cd open_meteo_app
flutter pub get
```

### Run

```bash
flutter run
```
