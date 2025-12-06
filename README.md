<h2>Dhimas Wildan Nur Zakariya - H1D023050</h2>
<h3>Responsi 2 Praktikum Pem.Mobile - Shift H ke Shift C</h3>

<img src="cuplikanlayar/ss1.gif">

<h3>Spesifikasi API</h3>

<h4>Kredensial Koneksi</h4>
<p>
Project URL:<br>
<pre><code>https://jaczwexgttsaf*******.supabase.co</code></pre>

Anon Key:<br>
<pre><code>eyJhbGciOiJI...</code></pre>
</p>

<h3>Basis Data</h3>

<b>.from('buku'):</b>
<ol>
  <li><pre><code>select()</code></pre> Mengambil daftar semua buku</li>
  <li><pre><code>insert()</code></pre> Menambahkan buku baru</li>
  <li><pre><code>update()</code></pre> Mengubah data buku yang ada</li>
  <li><pre><code>delete()</code></pre> Menghapus buku berdasarkan id</li>
</ol>

<b>.from('member'):</b>
<ol>
  <li><pre><code>select()</code></pre> Mengambil data profil pengguna yang sedang login</li>
</ol>

<h3>Struktur Tabel</h3>

<p><b>Tabel buku</b> berfungsi sebagai katalog inventaris lengkap.  
Kolom <i>id</i> bertipe bigint sebagai Primary Key (auto increment).  
Kolom <i>created_at</i> bertipe timestamp with time zone.  
Kolom utama: <i>judul</i> (text), <i>penulis</i> (varchar), <i>penerbit</i> (varchar).  
Kolom numerik: <i>harga</i> dan <i>volume</i> (numeric).  
Kolom <i>jumlah</i> (integer) dan <i>tanggal_masuk</i> (date).</p>

<p><b>Tabel member</b> menyimpan profil publik pengguna.  
Kolom <i>id</i> bertipe uuid dan menjadi Primary Key sekaligus Foreign Key ke auth.users.id (ONE-TO-ONE, ON DELETE CASCADE).  
Kolom lain: <i>full_name</i> (text) dan <i>email</i> (text).</p>

<h3>Fungsi-fungsi</h3>

<p>
<b>_redirect():</b><br>
Memeriksa sesi login melalui:
<pre><code>supabase.auth.currentSession</code></pre>
Jika ada → ke HomePage, jika tidak → ke LoginPage.
</p>

<p>
<b>_signUp():</b><br>
Dipanggil saat tombol DAFTAR.  
Mengirim email, password, dan metadata full_name ke Supabase.  
Jika berhasil → kembali ke halaman login.
</p>

<p>
<b>_signIn():</b><br>
Mengambil email dan password, lalu memverifikasi ke Supabase.  
Jika sukses → pindah ke HomePage dan menghapus riwayat halaman sebelumnya.
</p>

<p>
<b>_loadUserData():</b><br>
Mengambil kolom <i>full_name</i> dari tabel member dan menampilkannya di AppBar.
</p>

<p>
<b>_loadBooks():</b><br>
Memuat ulang data buku saat halaman dibuka, setelah penambahan buku, atau saat pull-to-refresh.
</p>

<p>
<b>_getBooks():</b><br>
Query pengambilan buku:
<pre><code>
.from('buku')
  .select()
  .order('created_at', { ascending: false })
</code></pre>
</p>

<p>
<b>_deleteBook(id):</b><br>
Menghapus buku berdasarkan id:
<pre><code>
.from('buku')
  .delete()
  .eq('id', id)
</code></pre>
</p>

<p>
<b>_filterBooks():</b><br>
Menjalankan pencarian berdasarkan judul, penulis, atau penerbit.
</p>

<p>
<b>_signOut():</b><br>
Logout dengan:
<pre><code>supabase.auth.signOut()</code></pre>
Mengembalikan pengguna ke halaman splash.
</p>
