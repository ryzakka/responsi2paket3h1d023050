import 'package:flutter/material.dart';
import 'package:responsi2mobilepaket3h1d023050/main.dart';
import 'package:responsi2mobilepaket3h1d023050/pages/home_page.dart';
import 'package:responsi2mobilepaket3h1d023050/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    // Tunggu frame pertama selesai di-render untuk memastikan context tersedia.
    await Future.delayed(Duration.zero);

    if (!mounted) return;

    final session = supabase.auth.currentSession;
    if (session != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: Colors.brown),
      ),
    );
  }
}
