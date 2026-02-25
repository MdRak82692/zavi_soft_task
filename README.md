# Flutter Product Listing App (Daraz-Style)

A premium, fully functional Flutter mobile application that mimics a **Daraz-style** product listing and details experience. The app demonstrates advanced Flutter concepts like **Sliver-based single-scroll architecture**, custom gesture coordination, and real-time state management.

## 🚀 Key Features

### 1. Advanced Scroll Architecture (Sliver-Powered)

- **Single Vertical Scroll**: The entire screen (Header, Search, Tabs, and Product Grid) is owned by a single `CustomScrollView`. This ensures **zero scroll jitter** and no nested scroll conflicts.
- **Sticky Tab Bar**: Implemented using `SliverPersistentHeader` to keep categories accessible while browsing products.
- **Collapsible Premium Header**: A dynamic `SliverAppBar` with gradient backgrounds, user profile integration, and decorative elements that adapt as the user scrolls.

### 2. Intelligent Gesture Coordination

- **Horizontal Navigation**: Smooth horizontal swipe gestures specifically tailored for tab switching.
- **Conflict Resolution**: Custom gesture logic ensures that horizontal swipes exclusively control the `TabController`, while vertical swipes remain reserved for scrolling, providing a fluid native-like experience.

### 3. Real-Time Search & Filtering

- **Dynamic Search Bar**: Integrated into the header to filter products across all categories in real-time.
- **Contextual Hinting**: The search hint automatically updates based on the currently selected tab (e.g., "Search in Electronics").

### 4. Seamless API Integration

- Fetches real-time data from the [Fakestore API](https://fakestoreapi.com/):
  - **Products**: Paginated-style browsing of all products.
  - **Categories**: Dynamic category loading.
  - **User Profile**: Fetches and displays real user metadata (Name, Email, Address) in the premium header.
  - **Product Details**: Dedicated endpoint logic for deep-diving into product specifics.

### 5. Premium Visual Experience

- **Hero Animations**: High-quality visual transitions between the grid and detail screens.
- **Shimmer Loading**: custom skeletal loading screens for both Home and Detail pages to reduce perceived wait times.
- **Modern UI Components**: Usage of HSL-based colors, elevated cards, and typography hierarchies for a "Wired" premium aesthetic.

## 🛠️ Tech Stack

- **Framework**: Flutter (Dart)
- **State Management**: Provider (ChangeNotifier)
- **Networking**: HTTP
- **Animations**: Hero, AnimatedOpacity, Shimmer

## 📂 Project Structure

```text
lib/
├── data/
│   ├── models/        # Product, User, Address models
│   └── services/      # ApiService (HTTP logic)
├── state/
│   └── app_state.dart # Provider logic (Single source of truth)
├── ui/
│   ├── screens/       # Home and Detail screens
│   └── widgets/       # Custom Slivers, Product Cards, Shimmers
└── main.dart          # Entry point and Theme configuration
```

## 🏗️ Architectural Decisions & Trade-offs

- **Why a Single CustomScrollView?**
  Using a single `CustomScrollView` with slivers is the most robust way to handle sticky headers and lists in Flutter. It avoids the performance overhead and "touch-fighting" problems associated with nesting multiple local scrollables.

- **Tab Persistence**
  To maintain a premium feel, the app caches product lists per category in `AppState`, ensuring that switching back to an already-loaded tab is instantaneous with zero additional API hits.

- **Gesture Priority**
  Horizontal navigation is prioritized via a `GestureDetector` wrapper. We chose this over a standard `TabBarView` to maintain a single vertical scroll body that doesn't "break" when swiping horizontally.

## 🏁 How to Run

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   ```
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the app**:
   ```bash
   flutter run
   ```

---

_Built with ❤️ for the Zavi Soft Task._
