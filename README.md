<h2>Dhimas Wildan Nur Zakariya - H1D023050</h2>
<h3>Responsi 2 Praktikum Pem.Mobile - Shift H ke Shift C</h3> <br>

![](cuplikanlayar/ss1.gif)

<br><br>
<h3>Spesifikasi API</h3>
<h4>Kredensial Koneksi</h4>
Menggunakan project URL ```https://jaczwexgttsaf*******.supabase.co``` dan token API kunci anonim ```eyJhbGciOiJI...````

<h3>Basis Data</h3>
<b>.from('buku'):</b>
1. ```select()```: Mengambil daftar semua buku
2. ```insert()```: Menambahkan buku baru
3. ```update()```: mengubah data buku yang ada
4. ```delete()```: Menghapus bukunya

<b>.from('member'):
1. ```select()```: Mengambil data profil pengguna yang sedang login

<h3>Struktur Tabel</h3>
<p>Untuk tabel buku, tabel ini dirancang sebagai katalog lengkap inventaris. Kolom id bertipe bigint yang berfungsi sebagai Primary Key unik dan nilainya akan dibuat secara otomatis untuk setiap buku baru. Kolom created_at mencatat waktu pembuatan data dengan tipe timestamp with time zone dan secara otomatis diisi dengan waktu saat itu. Informasi inti buku disimpan dalam kolom-kolom seperti judul (tipe text), serta penulis dan penerbit (keduanya varchar). Untuk data numerik, terdapat kolom harga dan volume (keduanya numeric), serta jumlah (tipe integer) untuk melacak stok. Terakhir, ada kolom tanggal_masuk bertipe date untuk mencatat kapan buku tersebut ditambahkan.Selanjutnya, tabel member berfungsi sebagai tabel profil publik. Kolom id di sini sangat krusial; tipenya adalah uuid dan ia berperan ganda sebagai Primary Key sekaligus Foreign Key yang merujuk langsung ke kolom id di tabel auth.users. Pengaturan ini menciptakan hubungan satu-ke-satu yang kuat dan memastikan integritas data. Jika seorang pengguna dihapus dari sistem autentikasi, datanya di tabel member akan ikut terhapus secara otomatis (ON DELETE CASCADE). Tabel ini juga memiliki kolom full_name dan email yang keduanya bertipe text untuk menyimpan nama lengkap dan alamat email pengguna.</p>
