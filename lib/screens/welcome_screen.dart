import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medical_directory/screens/home_screen.dart';
import 'package:medical_directory/main.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});


  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    const Color primaryMint = Color(0xFF70FFD8);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0D1412) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [

          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: primaryMint),
            onPressed: () => MyApp.of(context).toggleTheme(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: primaryMint, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: primaryMint.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 5,
                          )
                        ],
                      ),
                      child: CircleAvatar(
                        radius: isLandscape ? 50 : 80,
                        backgroundColor: Colors.transparent,
                        backgroundImage: const AssetImage('assets/logo.png'),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "MEDICAL DIRECTORY\nMILA",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 40),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryMint,
                          foregroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          elevation: 8,
                        ),
                        child: const Text("ENTER", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // أزرار الاتصال في أسفل الشاشة
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialBtn(
                    icon: Icons.email,
                    color: Colors.redAccent,
                    onTap: () => _launchURL("mailto:benhaouechemina@gmail.com"),
                  ),
                  const SizedBox(width: 25),
                  _buildSocialBtn(
                    icon: Icons.phone,
                    color: Colors.blueAccent,
                    onTap: () => _launchURL("tel:0792614515"),
                  ),
                  const SizedBox(width: 25),
                  _buildSocialBtn(
                    icon: FontAwesomeIcons.whatsapp,
                    color: Colors.green,
                    onTap: () => _launchURL("https://wa.me/213792614515"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialBtn({required IconData icon, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
}