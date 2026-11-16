# myportofolio_mobile

Aplikasi mobile portofolio pribadi berbasis Flutter untuk mata kuliah Pemrograman Berbasis Platform (CSGE602022) - Fakultas Ilmu Komputer, Universitas Indonesia.

Aplikasi ini merupakan kelanjutan dari proyek portofolio web Django (`myportofolio`), yang dikembangkan sebagai klien mobile multiplatform dengan antarmuka modern Material Design 3, navigasi drawer terpadu, dan formulir interaktif dengan validasi data.

---

## 📱 Fitur Utama Aplikasi

1. **Halaman Utama (`MyHomePage`)**:
   - Menampilkan kartu identitas pemilik portofolio (**NPM**, **Nama**, **Kelas**) menggunakan reusable widget `InfoCard`.
   - Grid menu interaktif (`ItemCard`) dengan efek sentuh Material (*ripple effect* via `InkWell`), umpan balik pesan `SnackBar`, dan kustomisasi warna berbeda untuk setiap tombol aksi:
     - **Lihat Proyek**: Menampilkan daftar proyek portofolio.
     - **Tambah Proyek**: Membuka formulir pembuatan proyek baru.
     - **Tambah Pengalaman**: Membuka formulir pembuatan riwayat pengalaman baru.
     - **Logout**: Tombol keluar dari sesi portofolio.

2. **Navigasi Global (`LeftDrawer`)**:
   - Panel samping navigasi konsisten di seluruh halaman aplikasi.
   - Menyediakan navigasi cepat menuju:
     - **Halaman Utama** (menggunakan `Navigator.pushReplacement`)
     - **Tambah Proyek** (menggunakan `Navigator.push`)
     - **Tambah Pengalaman** (menggunakan `Navigator.push`)

3. **Formulir Tambah Proyek (`ProjectFormPage`)**:
   - Input nama proyek, deskripsi, teknologi, URL repositori/demo, dan URL gambar banner.
   - Validasi kelengkapan data sebelum penyimpanan.
   - Menampilkan pop-up ringkasan dalam `AlertDialog`.

4. **Formulir Baru: Tambah Pengalaman (`ExperienceFormPage`)**:
   - Dibuat secara modular di `lib/screens/experience_form.dart` menggunakan `StatefulWidget`, `Form`, dan `GlobalKey<FormState>`.
   - Menyediakan 5 jenis input data yang disesuaikan dengan tipe datanya:
     - **Judul Pengalaman**: `TextFormField` (wajib diisi, minimal 3 karakter).
     - **Kategori Pengalaman**: `DropdownButtonFormField` (pilihan tipe: *full-time*, *part-time*, *internship*, *research*, *volunteer*, *freelance*).
     - **Deskripsi Tanggung Jawab**: `TextFormField` *multiline* (wajib diisi, minimal 10 karakter).
     - **URL Thumbnail**: `TextFormField` dengan validasi format URI protokol `http` / `https`.
     - **Tanggal Selesai**: Interaktif dengan kalender pemilih tanggal `showDatePicker()`.
   - Validasi ketat terhadap spasi kosong, batas karakter, dan keabsahan URL.
   - Dialog ringkasan `AlertDialog` setelah lolos validasi serta pembersihan form saat tombol dialog ditekan.

---

## 🚀 Setup & Cara Menjalankan

1. **Prasyarat**:
   - Flutter SDK (versi 3.x atau terbaru)
   - Dart SDK (pre-bundled dengan Flutter)
   - Google Chrome (untuk eksekusi Web) atau Android Studio / Emulator (untuk eksekusi Android)

2. **Langkah Menjalankan**:
   ```bash
   # Unduh dependensi
   flutter pub get

   # Periksa kebersihan kode
   flutter analyze

   # Jalankan aplikasi pada peramban Chrome
   flutter run -d chrome
   ```

---

## 📝 Jawaban Pertanyaan Reflektif

### Tugas 8

#### 1. Perbedaan antara `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()`, metode pada kartu aksi, serta cara opsi Home di drawer membawa pengguna kembali ke halaman utama:
- **`Navigator.push()`**:
  Menambahkan (*push*) sebuah *route* baru ke atas tumpukan (*navigation stack*). Halaman sebelumnya tetap tersimpan di bawah tumpukan memori. Pengguna dapat kembali ke halaman sebelumnya menggunakan tombol kembali (*back button*) bawaan perangkat maupun panah kembali pada `AppBar`.
- **`Navigator.pushReplacement()`**:
  Menggantikan (*replace*) rute yang sedang aktif di puncak *stack* dengan rute yang baru tanpa menumpuknya di atas rute lama. Rute sebelumnya dibuang (*disposed*) dari *stack*. Metode ini sangat ideal untuk alur perpindahan yang tidak memerlukan riwayat kembali ke rute sebelumnya, seperti dari halaman *Login* atau *Splash Screen* ke *Dashboard*, atau saat berpindah antar menu utama via *Drawer*.
- **`Navigator.pop()`**:
  Menghapus (*pop*) rute teratas dari tumpukan navigasi dan kembali ke halaman sebelumnya. Metode ini lazim digunakan untuk menutup dialog (`AlertDialog`), lembar bawah (*modal bottom sheet*), *drawer*, atau saat menekan tombol batal/kembali.
- **Metode yang digunakan untuk membuka formulir dari kartu aksi**:
  Menggunakan **`Navigator.push()`**. Alasan pemilihannya adalah agar formulir diperlakukan sebagai halaman sub-tugas yang ditumpuk di atas halaman utama, sehingga setelah pengguna selesai melihat formulir atau ingin membatalkannya, pengguna dapat langsung kembali ke halaman utama dengan mudah menekan tombol panah kembali pada `AppBar` atau tombol *back* perangkat.
- **Bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama**:
  Opsi *Home* pada drawer menggunakan **`Navigator.pushReplacement()`**:
  ```dart
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => MyHomePage(),
    ),
  );
  ```
  Dengan metode ini, rute halaman formulir saat ini langsung digantikan oleh `MyHomePage` tanpa menambah kedalaman *stack*. Ini mencegah penumpukan rute yang tidak perlu di memori apabila pengguna berulang kali berpindah halaman melalui *drawer*.

---

#### 2. Bagaimana susunan `Scaffold`, `AppBar`, dan `Drawer` membantu menjaga struktur halaman tetap konsisten, serta contoh penggunaan warna tema portofolio di lebih dari satu halaman:
- **Peran Susunan `Scaffold`, `AppBar`, dan `Drawer`**:
  - **`Scaffold`** bertindak sebagai kerangka arsitektur visual utama berstandar Material Design. `Scaffold` menyediakan slot struktural yang konsisten untuk elemen antarmuka tingkat tinggi: bar atas (`appBar`), area konten dinamis (`body`), panel navigasi samping (`drawer`), dan *snack bar* (`ScaffoldMessenger`).
  - **`AppBar`** memberikan penanda identitas dan judul halaman yang seragam di bagian atas, memastikan letak judul, ukuran teks, elevasi bayangan, dan posisi tombol aksi/menu tetap sejajar di setiap layar aplikasi.
  - **`Drawer`** diekstrak menjadi satu komponen *reusable widget* independen (`LeftDrawer`). Dengan menyematkan widget `LeftDrawer()` yang sama ke properti `drawer:` pada setiap `Scaffold` (`MyHomePage`, `ProjectFormPage`, `ExperienceFormPage`), pengguna disajikan menu navigasi dengan tata letak, hierarki teks, dan ikonografi yang identik di seluruh aplikasi.
- **Contoh Penggunaan Warna Tema Portofolio**:
  Warna tema aplikasi dikonfigurasi secara terpusat (*single source of truth*) pada `lib/main.dart` melalui `ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo, secondary: Colors.amber[700]))`.
  Konsistensi warna ini dimanfaatkan lintas halaman melalui:
  1. **`Theme.of(context).colorScheme.primary`** (warna indigo):
     - Digunakan sebagai `backgroundColor` pada `AppBar` di halaman utama (`menu.dart`), halaman formulir proyek (`project_form.dart`), dan formulir pengalaman (`experience_form.dart`).
     - Digunakan sebagai warna latar belakang `DrawerHeader` di `left_drawer.dart`.
     - Digunakan sebagai warna latar belakang tombol `Simpan` (`ElevatedButton`) pada formulir pengalaman.
  2. **`Theme.of(context).colorScheme.secondary`** (warna amber):
     - Digunakan sebagai warna aksen default pada kartu aksi `ItemCard`.

---

#### 3. Alasan pemilihan tata letak untuk formulir, serta peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas:
- **Alasan Pemilihan Tata Letak Formulir**:
  Formulir disusun menggunakan kombinasi hierarki: `Form` $\rightarrow$ `SingleChildScrollView` $\rightarrow$ `Padding` $\rightarrow$ `Column` $\rightarrow$ daftar field input (`TextFormField`, `DropdownButtonFormField`, dll.) $\rightarrow$ tombol `Simpan`.
  Tata letak vertikal ini dipilih karena sangat ergonomis untuk interaksi mobile, di mana pengguna secara alami mengisi kolom data dari atas ke bawah.
- **Peran Widget Pengatur Jarak (`Padding`, `SizedBox`)**:
  - `Padding` di sekeliling formulir dan di setiap field mencegah elemen input menempel ke tepi layar fisik perangkat, memberikan ruang napas (*whitespace*) visual yang rapi.
  - `SizedBox(height: ...)` memisahkan label dan input secara konsisten, memperbesar target sentuhan (*touch target area*) sehingga mengurangi kemungkinan salah ketuk (*misclick*) oleh jari pengguna.
- **Peran Widget Penggulir (`SingleChildScrollView`)**:
  - Pada layar ponsel berukuran ringkas atau saat keyboard virtual perangkat lunak (*software keyboard/IME*) aktif muncul ke layar, ruang tinggi tampilan (*viewport*) yang tersisa dapat menyusut hingga lebih dari separuh tinggi layar fisik.
  - Tanpa widget penggulir, elemen formulir yang terdorong ke bawah akan melebihi batas batas layar, memicu kesalahan visual *render overflow* (garis bergaris kuning-hitam *"A RenderFlex overflowed by xxx pixels"*).
  - Dengan membungkus kolom menggunakan `SingleChildScrollView`, seluruh form dapat digulirkan secara mulus ke atas dan ke bawah, memastikan setiap kolom masukan dan tombol `Simpan` di bagian bawah tetap dapat diakses dan dijangkau dengan mudah oleh pengguna.

---

#### 4. Peran `GlobalKey<FormState>`, `validator`, dan `validate()` saat tombol Simpan ditekan, contoh nilai yang ditolak, serta alasan mengapa jenis input atau papan ketik saja belum cukup:
- **Peran Komponen Formulir**:
  - **`GlobalKey<FormState>`**: Berfungsi sebagai identifier unik global yang memberikan akses langsung ke state internal widget `Form` (`FormState`). Kunci ini memungkinkan kita berinteraksi dengan seluruh elemen form di dalam widget tree, memicu validasi serentak, serta mereset seluruh isian form via method `reset()`.
  - **`validator`**: Properti fungsi callback pada tiap field input yang menerima string teks input saat ini dan mengevaluasinya berdasarkan aturan bisnis. Jika nilai memenuhi syarat, fungsi mengembalikan `null`; jika melanggar syarat, fungsi mengembalikan string pesan kesalahan.
  - **`validate()`**: Method yang dipanggil pada `_formKey.currentState!.validate()`. Saat tombol Simpan ditekan, method ini secara berurutan mengeksekusi fungsi `validator` pada setiap field turunan di dalam `Form`. Method mengembalikan nilai `true` jika **seluruh** field valid, atau `false` jika terdapat minimal satu field yang tidak valid, sekaligus secara otomatis menampilkan teks peringatan berwarna merah di bawah masing-masing field yang bermasalah.
- **Contoh Nilai yang Ditolak oleh Validasi**:
  1. Pada field *Judul Pengalaman*:
     - Nilai berupa teks kosong `""` atau teks yang hanya berisi spasi `"   "` ditolak dengan pesan: *"Judul pengalaman tidak boleh kosong!"*.
     - Nilai dengan panjang karakter kurang dari 3 (misal: `"AB"`) ditolak dengan pesan: *"Judul pengalaman minimal 3 karakter!"*.
  2. Pada field *URL Thumbnail*:
     - Nilai seperti `"ftp://image.png"` atau teks bukan tautan `"gambar-saya"` ditolak dengan pesan: *"Format URL thumbnail tidak valid (harus diawali http/https)!"*.
- **Mengapa Memilih Jenis Input atau Papan Ketik Saja Belum Cukup**:
  - Konfigurasi keyboard seperti `keyboardType: TextInputType.url` atau `emailAddress` hanya berfungsi sebagai **petunjuk visual (UI hint)** kepada sistem operasi perangkat untuk memunculkan tombol tertentu (seperti tombol `.com`, `/`, atau `@`).
  - Jenis papan ketik **sama sekali tidak membatasi atau memeriksa** apakah pengguna mengosongkan kolom, mengetik karakter spasi berulang, memasukkan nilai negatif, melanggar batas panjang karakter, atau menyalin-tempel (*paste*) teks dengan format yang cacat.
  - Validasi programatik melalui `validator` dan `validate()` adalah mekanisme pertahanan utama (*data integrity guarantee*) yang memastikan hanya data yang benar-benar bersih dan valid yang dapat diproses dan dikirim ke backend.

---

## 🤖 Keterangan Penggunaan AI (AI Disclosure)

Sesuai dengan ketentuan integritas akademik mata kuliah Pemrograman Berbasis Platform:

1. **Alat AI yang Digunakan**:
   - Google Antigravity Assistant (berbasis Gemini) sebagai asisten perancangan arsitektur, verifikasi kode, dan perumusan jawaban konseptual.

2. **Strategi Prompting**:
   - Menerapkan pendekatan *chain-of-thought* bertahap:
     - Tahap analisis spesifikasi kebutuhan formulir model baru (*Experience/Pengalaman*).
     - Tahap perancangan antarmuka modular: pemisahan file screen dan widget.
     - Tahap penerapan validasi formulir dan dialog ringkasan.
     - Tahap pengayaan UI/UX dan penyusunan refleksi analitis.

3. **Bagian yang Dibantu oleh AI**:
   - Perumusan struktur kode modular `ExperienceFormPage` dengan integrasi `DropdownButtonFormField`, `showDatePicker()`, dan `Uri.tryParse()`.
   - Penyusunan jawaban reflektif konseptual mengenai siklus navigasi, struktur arsitektur Scaffold/AppBar/Drawer, layout scrollable, dan mekanisme validasi FormState.
   - Pengecekan konsistensi tema warna Material Design 3 di seluruh berkas proyek.

4. **Keterbatasan AI & Perbaikan Manual yang Dilakukan**:
   - *Keterbatasan*: Saran awal AI sempat menggunakan implementasi warna default tunggal pada seluruh `ItemCard` dan pemanggilan `MyHomePage()` tanpa penyesuaian parameter.
   - *Perbaikan Manual*:
     - Menyesuaikan model `ItemHomepage` agar menerima parameter `Color? color` sehingga tiap tombol aksi memiliki warna latar tersendiri yang estetis dan mudah dibedakan (*distinct action cards*).
     - Menyesuaikan penanganan reset controller tanggal `TextEditingController` dan state form secara menyeluruh pada callback tombol dialog agar tidak meninggalkan sisa nilai setelah penutupan dialog.
