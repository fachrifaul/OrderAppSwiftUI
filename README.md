# 📦 OrderAppSwiftUI
A simple SwiftUI-based app that allows users to select products, auto-package them under business constraints (price and weight), and calculate courier charges.

---

## 🚀 Features
- Select products from a list
- Total price of selected items is less than or equal to $250, all items should be placed into a
- Total price exceeds $250 automatically group into packages:
  - No package has a total price equal to or exceeding $250
  - The total weight of the items should be evenly distributed across packages
- Each package incurs a fixed courier charge of $15
- Random selection for quick testing

---

## 🛠 Instructions to Run the Application

### 📱 Requirements
- Xcode 16 or newer
- iOS 15+ simulator or device
- SwiftUI support

### ▶️ Run in Simulator
1. Clone this repository
```bash
git clone https://github.com/fachrifaul/OrderAppSwiftUI.git
cd OrderAppSwiftUI
```

2. Open the project in Xcode
```bash
open OrderAppSwiftUI.xcodeproj
```

3. Select a simulator (e.g. iPhone 16)
4. Click **Run** ▶️ or press **Cmd + R**

### 📲 Run on Real Device
1. Plug in your iPhone
2. Select your device in the Xcode target bar
3. Make sure your Apple Developer Account is configured in Xcode (Preferences → Accounts)
4. Click **Run** ▶️

---

## 🧪 Testing
- Unit tests are provided for the business logic in `PlaceOrderUseCaseTests`
- Run tests via the **Product → Test** menu or `Cmd + U`

---

## 📂 Folder Structure
```
OrderAppSwiftUI
├── Data
│   ├── Local                  # Local JSON files (couriers, products)
│   └── Repository             # Data access layer (CourierRepository, ProductRepository)
├── Domain
│   ├── Entity                 # Core models: CourierRule, Package, Product
│   ├── Interface              # Abstractions: CourierProviding, ProductProviding
│   └── UseCase                # Business logic layer
├── Resource
│   ├── Assets                 # Asset catalog (images, colors, etc.)
│   └── Preview Content        # SwiftUI preview assets 
├── UI
│   └── Order                  # SwiftUI view and view model
├── OrderAppSwiftUIApp.swift   # App entry point
├── OrderAppSwiftUITests       # Unit tests
```