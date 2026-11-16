# myportofolio_mobile

Aplikasi mobile portofolio pribadi berbasis Flutter untuk mata kuliah Pemrograman Berbasis Platform (CSGE602022) - Fakultas Ilmu Komputer, Universitas Indonesia.

Aplikasi ini merupakan implementasi mobile dari ekosistem portofolio pribadi (`myportofolio`), dibangun menggunakan framework **Flutter** dan bahasa pemrograman **Dart** dengan antarmuka modern Material Design 3, navigasi drawer terpadu, dan formulir interaktif dengan validasi input.

---

## 📱 Fitur Utama Aplikasi

1. **Halaman Utama (`MyHomePage`)**:
   - Menampilkan kartu identitas pemilik portofolio (**NPM: 2506656394**, **Name: Alena Aura**, **Class: PBP C**) menggunakan *reusable widget* `InfoCard`.
   - Grid menu interaktif (`GridView.count` dengan 3 kolom) yang mengimplementasikan efek sentuhan Material (`InkWell`), feedback notifikasi `SnackBar`, dan pewarnaan kontras unik untuk setiap kartu aksi:
     - **Lihat Proyek**: Ikon folder dengan latar Biru (`Colors.blue`).
     - **Tambah Proyek**: Ikon tambah lingkaran dengan latar Hijau (`Colors.green`), membuka formulir pembuatan proyek baru.
     - **Tambah Pengalaman**: Ikon kerja dengan latar Teal (`Colors.teal`), membuka formulir pembuatan riwayat pengalaman baru.
     - **Logout**: Ikon keluar dengan latar Merah (`Colors.red`).

2. **Navigasi Global Terpadu (`LeftDrawer`)**:
   - Panel drawer di sisi kiri layar yang konsisten di semua halaman aplikasi.
   - Pilihan menu:
     - **Halaman Utama**: Membawa kembali ke beranda dengan `Navigator.pushReplacement()`.
     - **Tambah Proyek**: Menavigasi ke formulir proyek dengan `Navigator.push()`.
     - **Tambah Pengalaman**: Menavigasi ke formulir pengalaman dengan `Navigator.push()`.

3. **Formulir Tambah Proyek (`ProjectFormPage`) - Tutorial 09**:
   - Menggunakan `StatefulWidget`, `Form`, dan `GlobalKey<FormState>()`.
   - Field input: Nama Proyek, Deskripsi Proyek, Dropdown Kategori Proyek, Teknologi yang Digunakan, dan Tautan Proyek.
   - Validasi data kosong dan notifikasi pesan kesalahan.
   - Ringkasan isian dalam pop-up dialog interaktif `AlertDialog` setelah tombol *Save* ditekan.

4. **Formulir Tambah Pengalaman (`ExperienceFormPage`) - Tugas 8**:
   - Dibuat secara modular di `lib/screens/experience_form.dart` menggunakan `StatefulWidget`, `Form`, dan `GlobalKey<FormState>()`.
   - Menyediakan 5 jenis input data yang disesuaikan dengan tipe datanya:
     - **Judul Pengalaman**: `TextFormField` (wajib diisi, minimal 3 karakter).
     - **Kategori Pengalaman**: `DropdownButtonFormField` (*full-time, part-time, internship, research, volunteer, freelance*).
     - **Deskripsi**: `TextFormField` *multiline* (wajib diisi, minimal 10 karakter).
     - **URL Thumbnail**: `TextFormField` dengan validasi protokol `http`/`https` via `Uri.tryParse()`.
     - **Tanggal Selesai**: Interaktif dengan kalender pemilih tanggal `showDatePicker()`.
   - Dibungkus dalam `SingleChildScrollView` agar responsif dan tidak mengalami *render overflow* saat keyboard virtual muncul.
   - Dialog konfirmasi `AlertDialog` yang menampilkan ringkasan data dan tombol `OK` untuk menutup dialog sekaligus mereset form.

---

## 🚀 Setup & Cara Menjalankan

1. **Prasyarat**:
   - Flutter SDK (versi 3.x ke atas)
   - Dart SDK
   - Peramban web Google Chrome (atau Android Studio Emulator / Perangkat Android Fisik)

2. **Langkah Menjalankan**:
   ```bash
   # Unduh paket dependensi
   flutter pub get

   # Analisis sintaks dan kebersihan kode
   flutter analyze

   # Jalankan aplikasi pada Google Chrome
   flutter run -d chrome
   ```

---

## 📝 Jawaban Pertanyaan Reflektif

### Tugas 7

#### 1. Jelaskan apa yang dimaksud dengan *widget tree* pada Flutter dan bagaimana hubungan induk-anak (*parent-child*) bekerja antar-widget!
- **Konsep *Widget Tree***:
  Pada Flutter, hampir seluruh elemen antarmuka (mulai dari teks, tombol, padding, hingga struktur halaman) adalah widget. *Widget tree* (pohon widget) adalah struktur data hierarkis berbentuk graf berarah (*acyclic tree*) yang merepresentasikan bagaimana widget-widget tersebut tersusun dan bertingkat dari elemen paling atas (*root widget*, misalnya `MaterialApp`) hingga elemen paling dasar di daun (*leaf widgets*, misalnya `Text` atau `Icon`).
- **Hubungan Induk-Anak (*Parent-Child*)**:
  - Hubungan antar-widget mengikuti prinsip hierarki *parent-child*.
  - Widget *parent* mendefinisikan batasan ukuran (*layout constraints*, seperti lebar dan tinggi minimal/maksimal) dan meneruskannya ke bawah kepada widget *child*.
  - Widget *child* kemudian menentukan ukurannya sendiri (*geometry size*) berdasarkan batasan tersebut dan melaporkannya kembali ke *parent*.
  - Widget *parent* bertanggung jawab menentukan posisi (*offset coordinates*) widget *child* di layar.
  - Di dalam kode Flutter, hubungan ini didefinisikan melalui properti:
    - `child`: Digunakan ketika sebuah widget induk hanya memiliki satu widget anak langsung (contoh: `Container`, `Padding`, `Center`, `Card`).
    - `children`: Digunakan ketika sebuah widget induk menampung daftar (*list*) berisi banyak widget anak (contoh: `Column`, `Row`, `GridView`).
  - Aliran data dan konfigurasi tema mengalir dari atas ke bawah (*top-down*), sedangkan *event callback* seperti ketukan tombol (*tap events*) mengalir dari bawah ke atas (*bottom-up*).

#### 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!
1. **`MyApp`** (`StatelessWidget`): Widget root aplikasi yang bertugas mengonfigurasi `MaterialApp`.
2. **`MaterialApp`**: Widget pembungkus utama aplikasi yang menyediakan tema global, judul aplikasi, dan rute navigasi.
3. **`MyHomePage`** (`StatelessWidget`): Widget halaman utama yang menyusun seluruh tata letak antarmuka portofolio.
4. **`Scaffold`**: Menyediakan kerangka dasar arsitektur Material Design (slot untuk `appBar`, `drawer`, dan `body`).
5. **`AppBar`**: Menampilkan bilah judul di bagian atas layar aplikasi bertuliskan `'MyPortfolio'` dengan teks tebal putih dan latar belakang tema primer.
6. **`Padding`**: Memberikan margin/jarak kosong internal di sekeliling widget anaknya agar tampilan tidak menempel ke tepi layar.
7. **`Column`**: Menyusun widget-widget anaknya secara vertikal berurutan dari atas ke bawah.
8. **`Row`**: Menyusun widget-widget anaknya secara horizontal berurutan dari kiri ke kanan.
9. **`SizedBox`**: Memberikan jarak kosong tetap (vertikal/horizontal) antar elemen widget.
10. **`Center`**: Memosisikan widget anaknya tepat berada di tengah area yang tersedia.
11. **`GridView.count`**: Menyusun kartu-kartu menu aksi ke dalam tata letak kisi (*grid*) 3 kolom (`crossAxisCount: 3`).
12. **`Card`**: Menampilkan komponen panel persegi dengan sudut melengkung dan efek elevasi/bayangan halus (`elevation: 2.0`).
13. **`Container`**: Kotak layout serbaguna untuk mengatur lebar kartu proporsional (`MediaQuery.of(context).size.width / 3.5`) dan padding.
14. **`Text`**: Menampilkan konten teks string pada layar dengan konfigurasi gaya font (`TextStyle`).
15. **`Icon`**: Menampilkan grafis ikon simbolik dari pustaka Material (seperti `Icons.folder`, `Icons.add_circle`, `Icons.work_outline`, `Icons.logout`).
16. **`Material`**: Komponen visual Material Design yang menyediakan latar belakang warna kartu dan sudut melengkung (`BorderRadius.circular(12)`).
17. **`InkWell`**: Memberikan area respons sentuhan interaktif yang menampilkan efek riak air (*ripple effect*) ketika kartu diklik.
18. **`InfoCard`** (*Custom Reusable Widget*): Komponen kartu identitas pemilik portofolio yang menampilkan judul (`title`) dan konten (`content`).
19. **`ItemCard`** (*Custom Reusable Widget*): Komponen kartu menu aksi yang menampilkan ikon, teks aksi, dan latar belakang warna unik dari objek model `ItemHomepage`.

#### 3. Apa fungsi dari widget `MaterialApp`? Jelaskan mengapa widget ini umumnya digunakan sebagai *root widget* pada aplikasi Flutter!
- **Fungsi Widget `MaterialApp`**:
  `MaterialApp` adalah widget tingkat atas (*top-level widget*) yang mengintegrasikan berbagai layanan fundamental Material Design Google untuk aplikasi Flutter, antara lain:
  - Mengelola navigasi dan perpindahan antar-halaman (*routing system*).
  - Menyediakan konfigurasi tema terpusat (`ThemeData`, `ColorScheme`), termasuk warna dasar, tipografi, dan gaya tombol.
  - Mengelola lokalisasi bahasa (*internationalization/l10n*) dan orientasi arah pembacaan teks (*text direction*, seperti LTR atau RTL).
  - Menyediakan akses ke objek `MediaQuery` untuk mengetahui resolusi layar, orientasi gawai, dan batas aman layar (*safe area*).
- **Mengapa Umumnya Digunakan Sebagai *Root Widget***:
  Sebagian besar komponen antarmuka Material Design di Flutter (seperti `Scaffold`, `AppBar`, `Theme.of(context)`, `ScaffoldMessenger`, dan `Navigator`) **bergantung penuh** pada konfigurasi yang disediakan oleh `MaterialApp`. Jika widget-widget Material tersebut dijalankan tanpa `MaterialApp` di atasnya, Flutter akan menghasilkan *runtime error* karena tidak ditemukannya penentu arah teks (*No Directionality widget found*) maupun ketiadaan konteks tema.

#### 4. Jelaskan perbedaan antara `StatelessWidget` dan `StatefulWidget`! Kapan kita sebaiknya memilih `StatelessWidget` dan kapan harus menggunakan `StatefulWidget`?
- **Perbedaan Mendasar**:
  - **`StatelessWidget`**:
    - Bersifat tidak dapat berubah (*immutable*). Sekali widget dibuat, konfigurasi dan propertinya tidak akan berubah sepanjang daur hidupnya.
    - Tidak memiliki objek `State` internal. Metode `build()` hanya dijalankan sekali ketika diinisialisasi atau saat widget induk meneruskan argumen baru.
    - Lebih hemat alokasi memori dan proses komputasi.
  - **`StatefulWidget`**:
    - Bersifat dinamis dan dapat berubah sewaktu-waktu selama siklus hidupnya (*mutable state*).
    - Terdiri dari dua kelas terpisah: kelas widget konfigurasi (`StatefulWidget`) dan kelas status (`State`) yang persisten.
    - Tampilan antarmuka dapat di-render ulang secara fleksibel dengan memanggil metode `setState()`.
- **Kapan Memilih `StatelessWidget`**:
  - Ketika tampilan bersifat statis atau hanya bergantung pada data yang diteruskan melalui konstruktor saat inisialisasi.
  - Contoh: Halaman profil sederhana, kartu informasi `InfoCard`, tombol navigasi statis `ItemCard`, teks label, dan ikon dekoratif.
- **Kapan Menggunakan `StatefulWidget`**:
  - Ketika antarmuka memerlukan perubahan data internal secara langsung sebagai respons terhadap interaksi pengguna, waktu, atau data jaringan.
  - Contoh: Formulir isian dengan validasi dinamis, checkbox/sakelar (*toggle switch*), animasi interaktif, aplikasi penghitung angka (*counter*), atau pengambilan data asinkron dari API backend.

#### 5. Apa itu `BuildContext` dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode `build`?
- **Definisi `BuildContext`**:
  `BuildContext` adalah objek referensi yang merepresentasikan **posisi atau lokasi spesifik suatu widget di dalam hierarki *widget tree***. Setiap widget memiliki konteksnya masing-masing yang unik.
- **Mengapa Penting di Flutter**:
  - `BuildContext` menjadi jembatan yang menghubungkan widget dengan widget leluhurnya (*ancestors*).
  - Memungkinkan widget mengakses data global atau layanan yang berada di atasnya pada pohon widget melalui pemanggilan metode statis `of(context)`.
- **Penggunaannya di dalam Metode `build`**:
  1. **Mengakses Tema Global**: Pada `AppBar`, kita menggunakan `Theme.of(context).colorScheme.primary` untuk mengambil warna primer dari tema global.
  2. **Mengakses Dimensi Layar**: Pada `InfoCard`, kita menggunakan `MediaQuery.of(context).size.width` untuk menghitung lebar kartu secara adaptif (dibagi 3.5).
  3. **Menampilkan Notifikasi**: Pada `ItemCard`, kita memanggil `ScaffoldMessenger.of(context)` untuk mencari scaffold terdekat dan memunculkan pesan `SnackBar`.

#### 6. Jelaskan konsep *hot reload* di Flutter dan apa perbedaannya dengan *hot restart*! Kapan kita tidak bisa hanya mengandalkan *hot reload* dan harus melakukan *hot restart* atau *full restart*?
- **Konsep *Hot Reload***:
  *Hot reload* memanfaatkan kompilasi *Just-In-Time* (JIT) pada Dart VM untuk menginjeksi perubahan kode secara instan (< 1 detik) tanpa mereset status (*state*) aplikasi yang sedang berjalan.
- **Perbedaannya dengan *Hot Restart***:
  *Hot restart* memuat ulang seluruh aplikasi dari awal, menghancurkan status aktif, mengeksekusi ulang fungsi `main()`, dan mereset antarmuka ke kondisi inisial (membutuhkan waktu 1–3 detik).
- **Kapan Harus Melakukan *Hot Restart* atau *Full Restart***:
  1. Perubahan pada fungsi `main()` atau inisialisasi awal aplikasi sebelum `runApp()`.
  2. Perubahan pada variabel global, variabel statis, atau nilai inisialisasi di konstruktor.
  3. Mengubah sifat widget dari `StatelessWidget` menjadi `StatefulWidget` atau sebaliknya.
  4. Penambahan/perubahan dependensi atau aset pada berkas `pubspec.yaml`.
  5. Perubahan pada kode platform native (`android/`, `ios/`, `windows/`).

---

### Tugas 8

#### 1. Jelaskan perbedaan antara `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()`. Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama.
- **`Navigator.push()`**:
  Menambahkan (*push*) suatu rute baru ke atas tumpukan navigasi (*navigation stack*). Rute sebelumnya tetap tersimpan di bawah tumpukan. Pengguna dapat kembali ke halaman sebelumnya dengan menekan tombol kembali (*back button*).
- **`Navigator.pushReplacement()`**:
  Menggantikan (*replace*) rute yang sedang aktif di puncak *stack* dengan rute baru tanpa menambah kedalaman tumpukan. Rute lama langsung dibuang (*disposed*).
- **`Navigator.pop()`**:
  Menghapus (*pop*) rute paling atas dari tumpukan navigasi dan kembali ke halaman di bawahnya. Digunakan untuk menutup pop-up dialog (`AlertDialog`), drawer, atau modal.
- **Metode untuk Membuka Formulir dari Kartu Aksi**:
  Menggunakan **`Navigator.push()`**. Hal ini memungkinkan formulir berada di atas halaman utama, sehingga setelah selesai atau jika pengguna membatalkan pengisian formulir, pengguna dapat kembali ke halaman utama dengan mudah via tombol kembali bawaan AppBar atau perangkat.
- **Bagaimana Opsi Home di Drawer Membawa Pengguna Kembali**:
  Opsi *Home* pada drawer menggunakan **`Navigator.pushReplacement()`**:
  ```dart
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => MyHomePage()),
  );
  ```
  Dengan metode ini, rute halaman formulir saat ini langsung digantikan oleh `MyHomePage`, mencegah penumpukan memori berlebihan saat pengguna berulang kali berpindah halaman melalui drawer.

#### 2. Bagaimana susunan `Scaffold`, `AppBar`, dan `Drawer` membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.
- **Konsistensi Struktur**:
  - `Scaffold` menyediakan kerangka struktur visual standar (slot `appBar`, `body`, dan `drawer`) di setiap halaman.
  - `AppBar` memberikan header yang seragam di bagian atas untuk judul halaman dan tombol menu/kembali.
  - `Drawer` diekstrak menjadi satu komponen *reusable widget* global (`LeftDrawer`) yang dipasang pada setiap `Scaffold` (`menu.dart`, `project_form.dart`, `experience_form.dart`), menjamin menu navigasi samping selalu seragam di seluruh aplikasi.
- **Contoh Konsistensi Tema Warna**:
  Penggunaan `Theme.of(context).colorScheme.primary` yang dikonfigurasi terpusat di `main.dart` diterapkan secara seragam pada:
  1. `backgroundColor` milik `AppBar` di halaman utama (`menu.dart`), formulir proyek (`project_form.dart`), dan formulir pengalaman (`experience_form.dart`).
  2. Latar belakang `DrawerHeader` di `left_drawer.dart`.
  3. Latar belakang tombol `Simpan` (`ElevatedButton`) di `experience_form.dart`.

#### 3. Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.
- **Alasan Pemilihan Tata Letak Formulir**:
  Tata letak vertikal berbasis `Form` $\rightarrow$ `SingleChildScrollView` $\rightarrow$ `Column` dipilih karena mencerminkan alur pengisian data alami pengguna dari atas ke bawah pada perangkat mobile.
- **Peran Widget Pengatur Jarak (`Padding`, `SizedBox`)**:
  Memberikan jarak visual yang rapi antar-field dan dari tepi layar, serta memperbesar target sentuh (*touch target*) agar pengguna tidak salah ketuk.
- **Peran Widget Penggulir (`SingleChildScrollView`)**:
  Ketika keyboard virtual muncul di layar ponsel, area pandang (*viewport*) menyusut tajam. Tanpa `SingleChildScrollView`, antarmuka akan mengalami *pixel overflow error* (garis kuning-hitam). Dengan widget ini, formulir dapat digulir dengan lancar dan semua field serta tombol `Simpan` tetap dapat dijangkau.

#### 4. Apa peran `GlobalKey<FormState>`, `validator`, dan `validate()` saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.
- **Peran Komponen Formulir**:
  - `GlobalKey<FormState>`: Identifier unik yang memberikan akses langsung ke state internal widget `Form` untuk memanggil method `validate()` dan `reset()`.
  - `validator`: Logika fungsi callback pada setiap field input yang mengembalikan `null` jika input valid, atau pesan string kesalahan jika input tidak memenuhi syarat.
  - `validate()`: Method `_formKey.currentState!.validate()` yang mengeksekusi semua validator turunan dan mengembalikan `true` hanya jika seluruh field valid, serta memicu render teks error merah jika ada yang tidak valid.
- **Contoh Nilai yang Ditolak**:
  - Pada field *Judul Pengalaman*: string kosong `""` atau hanya spasi `"   "` ditolak dengan pesan: *"Judul pengalaman tidak boleh kosong!"*, dan teks kurang dari 3 karakter ditolak dengan pesan: *"Judul pengalaman minimal 3 karakter!"*.
  - Pada field *URL Thumbnail*: teks bukan URL diawali http/https ditolak dengan pesan: *"Format URL thumbnail tidak valid (harus diawali http/https)!"*.
- **Mengapa Jenis Papan Ketik Saja Belum Cukup**:
  Pengaturan papan ketik hanya berfungsi sebagai saran (*hint*) bagi sistem operasi gawai untuk memunculkan layout tombol tertentu (misalnya tombol `@` atau `.com`). Papan ketik **sama sekali tidak memeriksa** apakah isian kosong, apakah format data benar, atau apakah batas panjang karakter terpenuhi. Validasi logika via `validator` adalah satu-satunya pelindung integritas data sebelum diproses lebih lanjut.

---

## 🤖 Keterangan Penggunaan AI (*AI Disclosure*)

Sesuai dengan ketentuan integritas akademik mata kuliah Pemrograman Berbasis Platform:

1. **Alat AI yang Digunakan**:
   - Google Antigravity Assistant (berbasis Gemini) digunakan sebagai asisten dalam merancang arsitektur navigasi, struktur form modular, dan penyusunan refleksi konseptual.

2. **Strategi Prompting**:
   - Menerapkan pendekatan bertahap (*step-by-step reasoning*):
     - Memastikan implementasi checklist Tugas 7 dan Tutorial 09 terpenuhi secara akurat.
     - Menyusun halaman formulir baru `ExperienceFormPage` dengan variasi input (`TextFormField`, `DropdownButtonFormField`, `showDatePicker()`).
     - Menyusun jawaban pertanyaan reflektif untuk Tugas 7 dan Tugas 8 secara terstruktur dan komprehensif.

3. **Bagian yang Dibantu oleh AI**:
   - Perumusan kode modular `ExperienceFormPage`, navigasi drawer terpadu, dan kustomisasi warna kartu aksi portofolio.
   - Penyusunan penjelasan mendalam mengenai arsitektur navigasi Flutter, daur hidup widget, sistem layout, dan validasi form.

4. **Keterbatasan AI & Perbaikan Manual**:
   - *Keterbatasan*: Rekomendasi awal sempat mengabaikan kustomisasi warna per kartu aksi dan penyatuan jawaban reflektif mingguan.
   - *Perbaikan Manual*:
     - Menyesuaikan model `ItemHomepage` agar mendukung parameter `Color color` sehingga tiap tombol aksi memiliki warna latar yang unik dan kontras.
     - Menggabungkan dan menyusun rapi dokumentasi `### Tugas 7` dan `### Tugas 8` secara berdampingan tanpa saling menimpa.
