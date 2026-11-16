# myportofolio_mobile

Aplikasi mobile portofolio pribadi berbasis Flutter untuk mata kuliah Pemrograman Berbasis Platform (CSGE602022) - Fakultas Ilmu Komputer, Universitas Indonesia.

Aplikasi ini merupakan implementasi mobile dari proyek portofolio pribadi (`myportofolio`), dibangun menggunakan framework **Flutter** dan bahasa pemrograman **Dart** dengan pendekatan modern Material Design 3.

---

## 📱 Fitur Utama Aplikasi (Tugas 7)

1. **Struktur Proyek Modular & Clean Code**:
   - Pemisahan kode bootstrap utama pada `lib/main.dart` dan halaman menu utama pada `lib/menu.dart`.
   - Penerapan `StatelessWidget` pada `MyHomePage` untuk efisiensi render antarmuka statis.

2. **Informasi Profil Pemilik Portofolio (`InfoCard`)**:
   - Menampilkan tiga kartu informasi identitas pemilik portofolio secara sejajar di bagian atas halaman:
     - **NPM**: `2506656394`
     - **Name**: `Alena Aura`
     - **Class**: `PBP C`
   - Dibuat sebagai komponen yang dapat digunakan kembali (*reusable widget*) dengan lebar adaptif proporsional (`MediaQuery.of(context).size.width / 3.5`) dan efek elevasi Material.

3. **Menu Aksi Portofolio (`ItemCard`) & Kustomisasi Warna Unik**:
   - Grid interaktif (`GridView.count` dengan 3 kolom) yang menyusun tombol aksi portofolio:
     - **Lihat Proyek**: Ikon folder dengan warna latar **Biru** (`Colors.blue`).
     - **Tambah Proyek**: Ikon tambah lingkaran dengan warna latar **Hijau** (`Colors.green`).
     - **Logout**: Ikon logout dengan warna latar **Merah** (`Colors.red`).
   - Setiap kartu dibungkus dengan efek sentuh responsif (`InkWell`) yang memunculkan animasi sentuhan (*ripple effect*).
   - Menampilkan notifikasi visual interaktif di bawah layar menggunakan `SnackBar`:
     > *"Kamu telah menekan tombol [Nama Tombol]!"*

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

---

#### 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!
Berikut adalah seluruh widget yang digunakan pada proyek `myportofolio_mobile`:
1. **`MyApp`** (`StatelessWidget`): Widget root aplikasi yang bertugas mengonfigurasi `MaterialApp`.
2. **`MaterialApp`**: Widget pembungkus utama aplikasi yang menyediakan tema global, judul aplikasi, dan rute navigasi.
3. **`MyHomePage`** (`StatelessWidget`): Widget halaman utama yang menyusun seluruh tata letak antarmuka portofolio.
4. **`Scaffold`**: Menyediakan kerangka dasar arsitektur Material Design (slot untuk `appBar` dan `body`).
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
15. **`Icon`**: Menampilkan grafis ikon simbolik dari pustaka Material (seperti `Icons.folder`, `Icons.add_circle`, `Icons.logout`).
16. **`Material`**: Komponen visual Material Design yang menyediakan latar belakang warna kartu dan sudut melengkung (`BorderRadius.circular(12)`).
17. **`InkWell`**: Memberikan area respons sentuhan interaktif yang menampilkan efek riak air (*ripple effect*) ketika kartu diklik.
18. **`InfoCard`** (*Custom Reusable Widget*): Komponen kartu identitas pemilik portofolio yang menampilkan judul (`title`) dan konten (`content`).
19. **`ItemCard`** (*Custom Reusable Widget*): Komponen kartu menu aksi yang menampilkan ikon, teks aksi, dan latar belakang warna unik dari objek model `ItemHomepage`.

---

#### 3. Apa fungsi dari widget `MaterialApp`? Jelaskan mengapa widget ini umumnya digunakan sebagai *root widget* pada aplikasi Flutter!
- **Fungsi Widget `MaterialApp`**:
  `MaterialApp` adalah widget tingkat atas (*top-level widget*) yang mengintegrasikan berbagai layanan fundamental Material Design Google untuk aplikasi Flutter, antara lain:
  - Mengelola navigasi dan perpindahan antar-halaman (*routing system*).
  - Menyediakan konfigurasi tema terpusat (`ThemeData`, `ColorScheme`), termasuk warna dasar, tipografi, dan gaya tombol.
  - Mengelola lokalisasi bahasa (*internationalization/l10n*) dan orientasi arah pembacaan teks (*text direction*, seperti LTR atau RTL).
  - Menyediakan akses ke objek `MediaQuery` untuk mengetahui resolusi layar, orientasi gawai, dan batas aman layar (*safe area*).
- **Mengapa Umumnya Digunakan Sebagai *Root Widget***:
  Sebagian besar komponen antarmuka Material Design di Flutter (seperti `Scaffold`, `AppBar`, `Theme.of(context)`, `ScaffoldMessenger`, dan `Navigator`) **bergantung penuh** pada konfigurasi yang disediakan oleh `MaterialApp`. Jika widget-widget Material tersebut dijalankan tanpa `MaterialApp` di atasnya, Flutter akan menghasilkan *runtime error* karena tidak ditemukannya penentu arah teks (*No Directionality widget found*) maupun ketiadaan konteks tema. Oleh sebab itu, `MaterialApp` hampir selalu ditempatkan pada puncak pohon widget aplikasi.

---

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

---

#### 5. Apa itu `BuildContext` dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode `build`?
- **Definisi `BuildContext`**:
  `BuildContext` adalah objek referensi yang merepresentasikan **posisi atau lokasi spesifik suatu widget di dalam hierarki *widget tree***. Setiap widget memiliki konteksnya masing-masing yang unik.
- **Mengapa Penting di Flutter**:
  - `BuildContext` menjadi jembatan yang menghubungkan widget dengan widget leluhurnya (*ancestors*).
  - Memungkinkan widget mengakses data global atau layanan yang berada di atasnya pada pohon widget melalui pemanggilan metode statis `of(context)`.
- **Penggunaannya di dalam Metode `build`**:
  Di dalam metode `Widget build(BuildContext context)`:
  1. **Mengakses Tema Global**: Pada `AppBar`, kita menggunakan `Theme.of(context).colorScheme.primary` untuk mengambil warna primer dari tema yang didefinisikan di `MaterialApp`.
  2. **Mengakses Dimensi Layar**: Pada `InfoCard`, kita menggunakan `MediaQuery.of(context).size.width` untuk menghitung lebar kartu secara adaptif (dibagi 3.5) sesuai resolusi fisik perangkat.
  3. **Menampilkan Notifikasi**: Pada `ItemCard`, kita memanggil `ScaffoldMessenger.of(context)` untuk mencari scaffold terdekat dan menampilkan pesan `SnackBar` di layar.

---

#### 6. Jelaskan konsep *hot reload* di Flutter dan apa perbedaannya dengan *hot restart*! Kapan kita tidak bisa hanya mengandalkan *hot reload* dan harus melakukan *hot restart* atau *full restart*?
- **Konsep *Hot Reload***:
  *Hot reload* adalah fitur unggulan Flutter yang memanfaatkan kompilasi *Just-In-Time* (JIT) pada Dart VM. Saat kode diubah dan disimpan, Flutter langsung menyuntikkan (*inject*) kode yang diperbarui ke dalam VM yang sedang berjalan dan mengeksekusi ulang metode `build()`.
  - **Karakteristik**: Berjalan sangat cepat (< 1 detik) dan **tetap mempertahankan status (*state*) aplikasi saat ini**. Misalnya, nilai formulir atau posisi navigasi tidak tereset.
- **Perbedaannya dengan *Hot Restart***:
  *Hot restart* memuat ulang seluruh basis kode aplikasi dari awal, menghancurkan seluruh state yang sedang aktif, memanggil kembali fungsi `main()`, dan mereset antarmuka ke halaman awal. Waktu eksekusinya sedikit lebih lama (1–3 detik) dibanding hot reload, namun jauh lebih cepat daripada kompilasi ulang penuh (*full build/cold start*).
- **Kapan TIDAK BISA Hanya Mengandalkan *Hot Reload***:
  Kita harus melakukan **hot restart** atau **full restart** pada skenario berikut:
  1. **Perubahan pada fungsi `main()`** atau inisialisasi awal aplikasi sebelum `runApp()`.
  2. **Perubahan pada variabel global, variabel statis, atau nilai inisialisasi di konstruktor** yang sudah tersimpan di memori runtime.
  3. **Mengubah sifat widget**, misalnya mengubah kelas dari `StatelessWidget` menjadi `StatefulWidget` atau sebaliknya.
  4. **Menambahkan dependensi baru atau aset baru** pada berkas `pubspec.yaml` (memerlukan `flutter pub get` dan *cold restart*).
  5. **Modifikasi kode native platform** pada folder `android/`, `ios/`, atau `windows/` (seperti `AndroidManifest.xml` atau dependensi Gradle), yang mengharuskan kompilasi ulang menyeluruh (*cold start*).

---

## 🤖 Keterangan Penggunaan AI (*AI Disclosure*)

Sesuai dengan ketentuan integritas akademik mata kuliah Pemrograman Berbasis Platform:

1. **Alat AI yang Digunakan**:
   - Google Antigravity Assistant (berbasis Gemini) digunakan sebagai asisten dalam mendiskusikan konsep arsitektur widget Flutter dan memverifikasi kualitas struktur kode.

2. **Strategi Prompting**:
   - Menggunakan pendekatan bertahap (*step-by-step reasoning*):
     - Memeriksa kesesuaian checklist tugas terhadap rubrik penilaian.
     - Menyusun model data yang rapi dan modular untuk pewarnaan kartu tombol aksi tanpa percabangan *hardcoded*.
     - Merumuskan jawaban reflektif yang mendalam dan komprehensif dengan menyertakan contoh implementasi konkret dari kode proyek.

3. **Bagian yang Dibantu oleh AI**:
   - Membantu perumusan penjelasan konseptual mengenai *widget tree*, daur hidup widget, peran `BuildContext`, dan perbedaan mendalam antara *hot reload* dan *hot restart*.
   - Memastikan struktur data `ItemHomepage` mematuhi prinsip *clean code* dengan menyertakan atribut `Color color`.

4. **Keterbatasan AI & Perbaikan Manual**:
   - *Keterbatasan*: Rekomendasi awal AI sempat menerapkan warna statis seragam pada kartu aksi yang mengabaikan kriteria pewarnaan kontras per tombol pada rubrik tugas.
   - *Perbaikan Manual*:
     - Menyesuaikan konstruktor `ItemHomepage` untuk menerima `final Color color` dan mendaftarkan warna kontras individual (`Colors.blue`, `Colors.green`, `Colors.red`) pada masing-masing item kartu.
     - Memastikan identitas asli pemilik portofolio (**Alena Aura**, **2506656394**, **PBP C**) terpasang akurat pada `InfoCard`.
