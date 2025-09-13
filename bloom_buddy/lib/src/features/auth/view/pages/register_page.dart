import 'package:bloom_buddy/src/core/loading_widget.dart';
import 'package:bloom_buddy/src/core/theme/app_borders.dart';
import 'package:bloom_buddy/src/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../controller/auth_controller.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;
  bool _isObscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final isConform = password == confirmPassword;
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        firstName.isNotEmpty &&
        lastName.isNotEmpty) {
      if (isConform) {
        setState(() {
          _isLoading = true;
        });
        try {
          await ref
              .read(authRepositoryProvider)
              .createAccount(email, password, firstName, lastName);
          if (mounted) _showSnackbar("inscription reussie");
        } on AuthException catch (error) {
          if (mounted) _showSnackbar(error.message);
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        _showSnackbar("les mots de passe ne correspondent pas");
      }
    } else {
      _showSnackbar('Veuiller remplir tous les champs');
    }
  }

  // Methode utilitaire pour les Snacbar
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(height: 70, "assets/animations/Lotus Flower.json"),
              Text(
                "Bienvenue sur Bloom buddy",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 7),
              Text(
                "Créér un compte",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(color: Colors.black54),
              ),
              SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppBorders.circularSmall,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 3 / 2,
                            offset: Offset(0, 3 / 2),
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _firstNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: 'Prénom',
                          hintStyle: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: Colors.grey.shade400),
                          prefixIcon: Icon(Icons.person),
                          prefixIconColor: Colors.green,
                          border: OutlineInputBorder(
                            borderRadius: AppBorders.circularSmall,
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Flexible(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppBorders.circularSmall,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 3 / 2,
                            offset: Offset(0, 3 / 2),
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _lastNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: 'Nom',
                          hintStyle: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: Colors.grey.shade400),
                          prefixIcon: Icon(Icons.person),
                          prefixIconColor: Colors.green,
                          border: OutlineInputBorder(
                            borderRadius: AppBorders.circularSmall,
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.md),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppBorders.circularSmall,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 3 / 2,
                      offset: Offset(0, 3 / 2),
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Mail',
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade400,
                    ),
                    prefixIcon: Icon(Icons.mail),
                    prefixIconColor: Colors.green,
                    border: OutlineInputBorder(
                      borderRadius: AppBorders.circularSmall,
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.md),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppBorders.circularSmall,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 3 / 2,
                      offset: Offset(0, 3 / 2),
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade400,
                    ),
                    hintText: 'Mot de passe',
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    prefixIcon: Icon(Icons.lock),
                    prefixIconColor: Colors.green,
                    suffixIconColor: Colors.green,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(
                        _isObscure
                            ? Icons.remove_red_eye_sharp
                            : Icons.panorama_fish_eye_sharp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.md),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppBorders.circularSmall,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 3 / 2,
                      offset: Offset(0, 3 / 2),
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade400,
                    ),
                    hintText: ' Confirmer Mot de passe',
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    prefixIcon: Icon(Icons.lock),
                    prefixIconColor: Colors.green,
                    suffixIconColor: Colors.green,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(
                        _isObscure
                            ? Icons.remove_red_eye_sharp
                            : Icons.panorama_fish_eye_sharp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.xxl),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 7,
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadiusGeometry.circular(8),
                    //   side: BorderSide(color: Colors.grey.shade100),
                    // ),
                  ),
                  onPressed: _isLoading ? null : _signIn,
                  child: _isLoading
                      ? Center(child: LoadingWidget())
                      : Text('S\'inscrire'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
