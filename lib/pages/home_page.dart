import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsi2mobilepaket3h1d023050/main.dart';
import 'package:responsi2mobilepaket3h1d023050/pages/add_book_page.dart';
import 'package:responsi2mobilepaket3h1d023050/pages/edit_book_page.dart';
import 'package:responsi2mobilepaket3h1d023050/pages/splash_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  Future<List<Map<String, dynamic>>>? _futureBooks;
  List<Map<String, dynamic>> _allBooks = [];
  List<Map<String, dynamic>> _filteredBooks = [];
  String? _userName;

  final NumberFormat _currencyFormatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  String _formatTanggal(String dateStr) {
    try {
      final dateTime = DateTime.parse(dateStr);
      return DateFormat('d MMMM yyyy', 'id_ID').format(dateTime);
    } catch (e) {
      return dateStr;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadBooks();
    _searchController.addListener(_filterBooks);
  }

  Future<void> _loadUserData() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      final data = await supabase
          .from('member')
          .select('full_name')
          .eq('id', user.id)
          .single();
      setState(() {
        _userName = data['full_name'];
      });
    }
  }

  Future<void> _loadBooks() async {
    setState(() {
      _futureBooks = _getBooks();
    });
  }

  void _filterBooks() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredBooks = _allBooks.where((book) {
        final title = book['judul'].toString().toLowerCase();
        final author = book['penulis'].toString().toLowerCase();
        final publisher = book['penerbit'].toString().toLowerCase();
        return title.contains(query) ||
            author.contains(query) ||
            publisher.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> _getBooks() async {
    final data =
        await supabase.from('buku').select().order('created_at', ascending: false);
    if (mounted) {
      setState(() {
        _allBooks = data;
        _filteredBooks = _allBooks;
        _filterBooks();
      });
    }
    return data;
  }

  Future<void> _deleteBook(int id) async {
    try {
      await supabase.from('buku').delete().eq('id', id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Buku berhasil dihapus!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        _loadBooks();
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menghapus buku: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_userName != null ? 'Selamat Datang, ${_userName!}' : 'Inventaris Buku'),
        elevation: 4,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari judul, penulis, penerbit...',
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.zero,
                hintStyle: const TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await supabase.auth.signOut();
              if (mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SplashPage()),
                  (route) => false,
                );
              }
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          )
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureBooks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.brown));
          }
          if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    textAlign: TextAlign.center));
          }
          if (_allBooks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sentiment_dissatisfied,
                      size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  const Text('Inventaris Anda masih kosong.',
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                  const SizedBox(height: 8),
                  const Text('Tekan tombol + untuk menambah buku pertama Anda.',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center),
                ],
              ),
            );
          }
          if (_filteredBooks.isEmpty && _searchController.text.isNotEmpty) {
            return Center(
              child: Text(
                'Buku dengan kata kunci "${_searchController.text}" tidak ditemukan.',
                textAlign: TextAlign.center,
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: _loadBooks,
            color: Colors.brown,
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _filteredBooks.length,
              itemBuilder: (context, index) {
                final book = _filteredBooks[index];

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  clipBehavior: Clip.antiAlias,
                  child: ExpansionTile(
                    title: Text(
                      book['judul'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.brown,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text('oleh: ${book['penulis']}'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            _buildDetailRow(Icons.business_outlined, 'Penerbit', book['penerbit']),
                            _buildDetailRow(Icons.view_in_ar_outlined, 'Volume', book['volume'].toString()),
                            _buildDetailRow(Icons.inventory_2_outlined, 'Jumlah Stok', book['jumlah'].toString()),
                            _buildDetailRow(Icons.calendar_today_outlined, 'Tanggal Masuk', _formatTanggal(book['tanggal_masuk'])),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Chip(
                                  label: Text(
                                    _currencyFormatter.format(book['harga']),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit_note, color: Colors.blueAccent, size: 28),
                                      onPressed: () async {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditBookPage(book: book),
                                          ),
                                        );
                                        if (result == true) {
                                          _loadBooks();
                                        }
                                      },
                                      tooltip: 'Edit Buku',
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_sweep_outlined, color: Colors.redAccent, size: 28),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15)),
                                              title: const Text('Konfirmasi Hapus'),
                                              content: Text('Hapus buku "${book['judul']}" dari inventaris?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('Batal', style: TextStyle(color: Colors.grey)),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    _deleteBook(book['id']);
                                                  },
                                                  child: const Text('Hapus'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      tooltip: 'Hapus Buku',
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBookPage()),
          );
          _loadBooks();
        },
        backgroundColor: Colors.brown,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Buku'),
        tooltip: 'Tambah Inventaris',
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
