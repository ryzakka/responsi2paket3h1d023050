<h2>Dhimas Wildan Nur Zakariya - H1D023050</h2>
<h3>Responsi 2 Praktikum Pem.Mobile — Shift H ke Shift C</h3>

<img src="cuplikanlayar/ss1.gif" alt="Demo Aplikasi">

<br><br>

<h3>Spesifikasi API</h3>

<h4>Kredensial Koneksi</h4>
<p>Project URL:</p>
<pre><code>https://jaczwexgttsaf*******.supabase.co
</code></pre>

<p>Anon Key:</p>
<pre><code>eyJhbGciOiJI...
</code></pre>

<br>

<h3>Basis Data</h3>

<p><b>.from('buku')</b></p>
<ul>
  <li><pre><code>select()</code></pre> Mengambil daftar semua buku</li>
  <li><pre><code>insert()</code></pre> Menambahkan buku baru</li>
  <li><pre><code>update()</code></pre> Mengubah data buku yang ada</li>
  <li><pre><code>delete()</code></pre> Menghapus buku berdasarkan ID</li>
</ul>

<p><b>.from('member')</b></p>
<ul>
  <li><pre><code>select()</code></pre> Mengambil data profil pengguna yang sedang login</li>
</ul>

<br>

<h3>Struktur Tabel</h3>

<p><b>Tabel buku</b> dirancang sebagai katalog inventaris lengkap.  
Kolom <i>id</i> bertipe bigint (Primary Key, auto increment), kolom <i>created_at</i> bertipe timestamp with time zone, serta kolom inti seperti <i>judul</i> (text), <i>penulis</i> (varchar), <i>penerbit</i> (varchar).  
Kolom numerik mencakup <i>harga</i> dan <i>volume</i>, sedangkan <i>jumlah</i> menggunakan tipe integer.  
Tanggal buku masuk disimpan dalam kolom <i>tanggal_masuk</i> (date).</p>

<p><b>Tabel member</b> menyimpan data profil publik pengguna.  
Kolom <i>id</i> bertipe uuid dan terhubung langsung (FK) dengan <i>auth.users.id</i> sebagai relasi satu-ke-satu, lengkap dengan <i>ON DELETE CASCADE</i>.  
Kolom <i>full_name</i> dan <i>email</i> bertipe text.</p>

<br>

<h3>Fungsi-fungsi</h3>

<p><b>_redirect()</b><br>
Memeriksa sesi login menggunakan:
<pre><code>supabase.auth.currentSession
</code></pre>
Jika sesi ada → ke HomePage. Jika tidak → ke LoginPage.</p>

<p><b>_signUp()</b><br>
Dijalankan ketika tombol DAFTAR ditekan.  
Mengirim email, password, dan metadata <i>full_name</i> ke Supabase.  
Jika berhasil, kembali ke halaman login.</p>

<p><b>_signIn()</b><br>
Mengambil email dan password, mengirim ke Supabase untuk verifikasi.  
Jika berhasil → masuk ke HomePage dan membersihkan stack navigasi.</p>

<p><b>_loadUserData()</b><br>
Mengambil <i>full_name</i> dari tabel member untuk ditampilkan sebagai sapaan di AppBar.</p>

<p><b>_loadBooks()</b><br>
Memuat ulang daftar buku saat halaman dibuka, setelah insert, atau saat pull-to-refresh.</p>

<p><b>_getBooks()</b><br>
Query utama untuk mengambil daftar buku:
<pre><code>
.from('buku')
  .select()
  .order('created_at', { ascending: false })
</code></pre>
</p>

<p><b>_deleteBook(id)</b><br>
Menghapus data buku berdasarkan id:
<pre><code>
.from('buku')
  .delete()
  .eq('id', id)
</code></pre>
</p>

<p><b>_filterBooks()</b><br>
Menyaring daftar buku berdasarkan teks pencarian (judul, penulis, penerbit).</p>

<p><b>_signOut()</b><br>
Logout menggunakan:
<pre><code>supabase.auth.signOut()
</code></pre>
Mengembalikan user ke halaman splash.</p>
