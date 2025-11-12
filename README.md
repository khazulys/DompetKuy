# DompetKuy 💰

Aplikasi pengelola keuangan pribadi dengan tampilan hitam-putih (black & white) yang modern, profesional, dan minimalis.

## 🎨 Fitur Utama

### 1. Dashboard Ringkasan Keuangan
- Menampilkan total saldo, pemasukan, dan pengeluaran bulan ini
- Visualisasi grafik pengeluaran per kategori dengan tone grayscale
- Pratinjau target tabungan aktif

### 2. Manajemen Transaksi
- Tambah, edit, dan hapus transaksi (pemasukan/pengeluaran)
- Filter transaksi berdasarkan kategori
- Kategori yang tersedia:
  - **Pemasukan**: Gaji, Bisnis, Investasi, Lainnya
  - **Pengeluaran**: Makanan, Transport, Belanja, Hiburan, Kesehatan, Pendidikan, Tagihan

### 3. Target Tabungan (Goal Saving)
- Buat target tabungan dengan nama dan nominal
- Set tenggat waktu untuk setiap target
- Progress bar menunjukkan pencapaian
- Tambah dana ke target tabungan secara berkala
- Notifikasi visual untuk target yang hampir tercapai

### 4. Statistik & Analisis
- Grafik lingkaran (pie chart) pengeluaran per kategori
- Analisis keuangan bulanan
- Visualisasi monokrom dengan fl_chart

### 5. Pengaturan Profil
- Toggle dark/light mode
- Pengaturan keamanan (untuk implementasi future)
- Info aplikasi

## 🛠️ Teknologi

- **Framework**: Flutter 3.35.7
- **UI Library**: ForUI 0.16.0 (minimalistic black & white design system)
- **State Management**: Provider 6.0.0
- **Charts**: FL Chart 0.60.0
- **Storage**: SharedPreferences (local), Firebase/Cloud Firestore (optional cloud sync)
- **Security**: Local Auth (biometric & PIN - ready for implementation)
- **Fonts**: Google Fonts (Inter)

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  forui: ^0.16.0
  provider: ^6.0.0
  fl_chart: ^0.60.0
  shared_preferences: ^2.0.0
  firebase_core: ^2.0.0
  cloud_firestore: ^4.0.0
  local_auth: ^2.0.0
  intl: any
  uuid: ^4.0.0
  google_fonts: ^6.0.0
```

## 🚀 Cara Menjalankan

### Prerequisites
- Flutter SDK 3.35.0 atau lebih baru
- Android Studio / VS Code dengan Flutter extension
- Android SDK untuk build APK

### Instalasi

1. Clone repository:
```bash
git clone <repository-url>
cd dompetkuy
```

2. Install dependencies:
```bash
flutter pub get
```

3. Jalankan aplikasi:
```bash
flutter run
```

### Build APK Release

```bash
flutter build apk --release
```

APK akan tersimpan di `build/app/outputs/flutter-apk/app-release.apk`

## 📱 Screenshot

_Coming soon..._

## 🏗️ Struktur Proyek

```
lib/
├── main.dart                 # Entry point aplikasi
├── models/                   # Data models
│   ├── transaction.dart
│   └── goal.dart
├── providers/                # State management
│   ├── transaction_provider.dart
│   ├── goal_provider.dart
│   └── theme_provider.dart
├── screens/                  # UI Screens
│   ├── home_screen.dart
│   ├── dashboard_screen.dart
│   ├── transactions_screen.dart
│   ├── goals_screen.dart
│   └── profile_screen.dart
├── services/                 # Business logic & services
│   └── storage_service.dart
├── utils/                    # Utilities & helpers
│   └── theme.dart
└── widgets/                  # Reusable widgets
```

## 🎨 Tema Black & White

Aplikasi menggunakan custom theme dengan ForUI:
- **Dark Mode**: Background hitam (#000000) dengan teks putih
- **Light Mode**: Background putih (#FFFFFF) dengan teks hitam
- **Accent**: Grayscale colors (#212121 - #F5F5F5)
- **Font**: Inter (Google Fonts)

## 🔄 CI/CD

GitHub Actions workflow sudah dikonfigurasi untuk:
- Analisis kode otomatis (`flutter analyze`)
- Running tests (`flutter test`)
- Build APK release otomatis saat push ke branch `main`
- Upload artifact APK ke GitHub Actions

## 🔐 Keamanan

Aplikasi mendukung (ready for implementation):
- PIN code protection
- Biometric authentication (fingerprint/face recognition)

## 📝 TODO / Future Improvements

- [ ] Implementasi Firebase authentication
- [ ] Sinkronisasi data dengan Cloud Firestore
- [ ] Implementasi PIN & biometric security
- [ ] Export data ke CSV/PDF
- [ ] Reminder/notification untuk target tabungan
- [ ] Multi-currency support
- [ ] Backup & restore data
- [ ] Widgets Android untuk quick add transaction

## 🤝 Kontribusi

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 Lisensi

This project is open source and available under the [MIT License](LICENSE).

## 👨‍💻 Author

DompetKuy - Personal Finance Manager

---

**Built with ❤️ using Flutter & ForUI**
