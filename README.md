# DompetKuy 💰

Aplikasi pengelola keuangan pribadi dengan tampilan hitam-putih (black & white) yang modern, profesional, dan minimalis.

**✨ 100% Offline - Semua data disimpan lokal di device Anda!**

## 🎨 Fitur Utama

### 1. Onboarding Personalisasi
- Sheet welcome pertama kali buka aplikasi
- Input nama pengguna untuk personalisasi
- Welcome message "Welcome, <nama> 👋" di dashboard

### 2. Dashboard Ringkasan Keuangan
- Menampilkan total saldo, pemasukan, dan pengeluaran bulan ini
- Visualisasi grafik pengeluaran per kategori dengan tone grayscale
- Pratinjau target tabungan aktif

### 3. Manajemen Transaksi
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

### 5. Statistik & Analisis
- Grafik lingkaran (pie chart) pengeluaran per kategori
- Analisis keuangan bulanan
- Visualisasi monokrom dengan fl_chart

### 6. Pengaturan Profil
- Menampilkan nama pengguna dengan initial avatar
- Edit nama pengguna kapan saja
- Toggle dark/light mode
- Info aplikasi

## 🛠️ Teknologi

- **Framework**: Flutter 3.35.7
- **UI Library**: ForUI 0.16.0 (minimalistic black & white design system)
- **State Management**: Provider 6.0.0
- **Charts**: FL Chart 0.60.0
- **Storage**: SharedPreferences (100% offline, no internet required)
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
│   ├── user_provider.dart
│   ├── transaction_provider.dart
│   ├── goal_provider.dart
│   └── theme_provider.dart
├── screens/                  # UI Screens
│   ├── home_screen.dart
│   ├── dashboard_screen.dart
│   ├── transactions_screen.dart
│   ├── goals_screen.dart
│   ├── profile_screen.dart
│   └── onboarding_sheet.dart
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

## 🔐 Privasi & Keamanan

- ✅ **100% Offline** - Tidak ada koneksi internet yang dibutuhkan
- ✅ **Data Lokal** - Semua data disimpan di device Anda sendiri
- ✅ **No Login Required** - Tidak perlu akun atau registrasi
- ✅ **Privacy First** - Data Anda, device Anda, kontrol penuh di tangan Anda

## 📝 TODO / Future Improvements

- [ ] Export data ke CSV/PDF
- [ ] Import data dari file backup
- [ ] Reminder/notification untuk target tabungan
- [ ] Multi-currency support
- [ ] Recurring transactions (transaksi berulang)
- [ ] Budget planning per kategori
- [ ] Widgets Android untuk quick add transaction
- [ ] Dark mode auto (follow system)

## 🤝 Kontribusi

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 Lisensi

This project is open source and available under the [MIT License](LICENSE).

## 👨‍💻 Author

DompetKuy - Personal Finance Manager

---

**Built with ❤️ using Flutter & ForUI**
