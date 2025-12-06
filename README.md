<h2>Dhimas Wildan Nur Zakariya - H1D023050</h2>
<h3>Responsi 2 Praktikum Pem.Mobile - Shift H ke Shift C</h3> <br>

![](cuplikanlayar/ss1.gif)

<br><br>
<h3>Spesifikasi API</h3>
<h4>Kredensial Koneksi</h4>
Menggunakan project URL ```https://jaczwexgttsaf*******.supabase.co``` dan token API kunci anonim ```eyJhbGciOiJI...```

<h3>Basis Data</h3>
<b>.from('buku'):</b>
1. ```select()```: Mengambil daftar semua buku
2. ```insert()```: Menambahkan buku baru
3. ```update()```: mengubah data buku yang ada
4. ```delete()```: Menghapus bukunya

<b>.from('member'):</b>
1. ```select()```: Mengambil data profil pengguna yang sedang login

<h3>Struktur Tabel</h3>
<p>Untuk tabel buku, tabel ini dirancang sebagai katalog lengkap inventaris. Kolom id bertipe bigint yang berfungsi sebagai Primary Key unik dan nilainya akan dibuat secara otomatis untuk setiap buku baru. Kolom created_at mencatat waktu pembuatan data dengan tipe timestamp with time zone dan secara otomatis diisi dengan waktu saat itu. Informasi inti buku disimpan dalam kolom-kolom seperti judul (tipe text), serta penulis dan penerbit (keduanya varchar). Untuk data numerik, terdapat kolom harga dan volume (keduanya numeric), serta jumlah (tipe integer) untuk melacak stok. Terakhir, ada kolom tanggal_masuk bertipe date untuk mencatat kapan buku tersebut ditambahkan.Selanjutnya, tabel member berfungsi sebagai tabel profil publik. Kolom id di sini sangat krusial; tipenya adalah uuid dan ia berperan ganda sebagai Primary Key sekaligus Foreign Key yang merujuk langsung ke kolom id di tabel auth.users. Pengaturan ini menciptakan hubungan satu-ke-satu yang kuat dan memastikan integritas data. Jika seorang pengguna dihapus dari sistem autentikasi, datanya di tabel member akan ikut terhapus secara otomatis (ON DELETE CASCADE). Tabel ini juga memiliki kolom full_name dan email yang keduanya bertipe text untuk menyimpan nama lengkap dan alamat email pengguna.</p>

<h3>Fungsi-fungsi</h3>
<p>_redirect(): Fungsi ini adalah inti dari halaman splash. Tujuannya adalah memeriksa status login pengguna. Ia akan mengecek apakah ada sesi aktif di Supabase (supabase.auth.currentSession). Jika ada, pengguna akan langsung diarahkan ke HomePage. Jika tidak ada sesi (pengguna belum login), pengguna akan diarahkan ke LoginPage. Proses ini terjadi sangat cepat setelah halaman dimuat. <br>
_signUp(): Fungsi ini dipanggil saat pengguna menekan tombol "DAFTAR". Ia akan memvalidasi input dari form, lalu mengirimkan email, password, dan nama lengkap (full_name sebagai metadata) ke Supabase untuk membuat akun baru. Jika berhasil, ia akan menampilkan pesan sukses dan mengembalikan pengguna ke halaman sebelumnya (halaman login). <br>
_signIn(): Fungsi ini dieksekusi saat tombol "LOGIN" ditekan. Fungsinya adalah mengambil email dan password dari form, lalu mengirimkannya ke Supabase untuk diverifikasi. Jika kredensial benar, pengguna akan berhasil login dan diarahkan ke HomePage, serta semua halaman sebelumnya akan dihapus dari tumpukan navigasi agar pengguna tidak bisa kembali ke halaman login. <br>
_loadUserData(): Fungsi ini dipanggil saat halaman dimuat untuk mengambil nama lengkap (full_name) dari pengguna yang sedang login dari tabel member dan menampilkannya di AppBar sebagai sapaan selamat datang. <br>
_loadBooks(): Memuat ulang data buku dari Supabase. Fungsi ini dipanggil saat halaman pertama kali dibuka, setelah buku baru ditambahkan, atau saat pengguna melakukan "pull-to-refresh". <br>
_getBooks(): Fungsi inti yang melakukan permintaan select ke tabel buku di Supabase untuk mengambil semua data inventaris buku, mengurutkannya berdasarkan tanggal pembuatan terbaru. <br>
_deleteBook(id): Mengirim permintaan delete ke Supabase untuk menghapus buku berdasarkan id-nya. <br>
_filterBooks(): Fungsi ini berjalan setiap kali pengguna mengetik di kolom pencarian. Ia akan menyaring daftar buku yang ditampilkan berdasarkan judul, penulis, atau penerbit yang cocok dengan teks pencarian. <br>
_signOut() (di dalam IconButton): Memanggil supabase.auth.signOut() untuk mengeluarkan pengguna dan mengarahkannya kembali ke halaman splash, yang kemudian akan membawanya ke halaman login. </p>
