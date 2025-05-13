
import 'package:flutter/material.dart';
import 'package:khutbah_finder_app/pages/home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final _signupEmailController = TextEditingController();
  final _signupPasswordController = TextEditingController();
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  bool _signupPasswordVisible = false;
  bool _loginPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _signupEmailController.dispose();
    _signupPasswordController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    VoidCallback? toggleVisibility,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        suffixIcon: toggleVisibility != null
            ? IconButton(
                icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: toggleVisibility,
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: Container(
                height: 230,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F4F8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 72),
                  child: Text(
                    'Khutbah Finder',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600, color: Color(0xFF101213)),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 170),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 570),
                      padding: const EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFF1F4F8), width: 2),
                        boxShadow: const [BoxShadow(blurRadius: 4, color: Color(0x33000000), offset: Offset(0, 2))],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          TabBar(
                            controller: _tabController,
                            labelColor: const Color(0xFF101213),
                            unselectedLabelColor: const Color(0xFF57636C),
                            indicatorColor: const Color(0xFF4B39EF),
                            indicatorWeight: 3,
                            tabs: const [
                              Tab(text: 'Create Account'),
                              Tab(text: 'Log In'),
                            ],
                          ),
                          SizedBox(
                            height: 500,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Create Account', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 8),
                                      const Text('Let''s get started by filling out the form below.', style: TextStyle(color: Color(0xFF57636C))),
                                      const SizedBox(height: 24),
                                      _buildTextField(label: 'Email', controller: _signupEmailController),
                                      const SizedBox(height: 16),
                                      _buildTextField(
                                        label: 'Password',
                                        controller: _signupPasswordController,
                                        obscureText: !_signupPasswordVisible,
                                        toggleVisibility: () {
                                          setState(() {
                                            _signupPasswordVisible = !_signupPasswordVisible;
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 24),
                                      Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF1E4D2B),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                                          ),
                                          onPressed: () {
                                              // TODO: Add real signup logic here
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(builder: (context) => const HomePage()),
                                              );
                                          },
                                          child: const Text('Get Started'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Welcome Back', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 8),
                                      const Text('Fill out the information below to log in.', style: TextStyle(color: Color(0xFF57636C))),
                                      const SizedBox(height: 24),
                                      _buildTextField(label: 'Email', controller: _loginEmailController),
                                      const SizedBox(height: 16),
                                      _buildTextField(
                                        label: 'Password',
                                        controller: _loginPasswordController,
                                        obscureText: !_loginPasswordVisible,
                                        toggleVisibility: () {
                                          setState(() {
                                            _loginPasswordVisible = !_loginPasswordVisible;
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 24),
                                      Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF1E4D2B),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                                          ),
                                          onPressed: () {
                                              // TODO: Add real login logic here
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(builder: (context) => const HomePage()),
                                              );
                                          },
                                          child: const Text('Sign In'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
