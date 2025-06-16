import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/data/models/user_model.dart';
import 'package:social_media_app/presentation/controllers/auth_controller.dart';
import 'package:social_media_app/presentation/providers/theme_provider.dart';
import 'package:social_media_app/presentation/providers/user_provider.dart';
import 'package:social_media_app/presentation/widgets/input/input.dart';
import 'package:social_media_app/presentation/widgets/switch_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _formIsValid = false;

  // Validador do campo e-mail
  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    if (email == null || email.isEmpty) {
      return 'E-mail obrigatório';
    } else if (!emailRegex.hasMatch(email)) {
      return 'Por favor, forneça um e-mail válido';
    }
    return null;
  }

  // Validador do campo e-mail
  String? validatePassword(String? senha) {
    if (senha == null || senha.isEmpty) {
      return 'Senha obrigatória';
    }
    return null;
  }

  void _updateFormValidity() {
    setState(() {
      _formIsValid =
          validateEmail(emailController.text) == null &&
          validatePassword(passwordController.text) == null;
    });
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(_updateFormValidity);
    passwordController.addListener(_updateFormValidity);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    Future<void> login() async {
      String email = emailController.text;
      String password = passwordController.text;

      try {
        final user = await loginRequest(User(email: email, password: password));
        await userProvider.setUser(user);

        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        print('Erro ao tentar realizar login: $e');
      }
    }

    return GestureDetector(
      onTap: () {
        // Remove foco do widget quando pressionado fora da tela
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        // Cabeçalho e logo do aplicativo
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.network(
                      Theme.of(context).brightness == Brightness.light
                          ? 'https://mostlovedworkplace.com/wp-content/uploads/2024/01/logo-fullcolor-RGB-transBG.png'
                          : 'https://vertigo.com.br/wp-content/uploads/2023/08/neo4j-1024x512.png',
                      width: 70,
                      fit: BoxFit.cover,
                    ),

                    SwitchButton(
                      inactiveThumbIcon: CupertinoIcons.sun_max_fill,
                      activeThumbIcon: CupertinoIcons.moon_fill,
                      onChanged: (bool value) {
                        Provider.of<ThemeProvider>(
                          context,
                          listen: false,
                        ).toggleTheme();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),

                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Login',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 48.0),

                      Text.rich(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        TextSpan(
                          text: 'Bem-vindo ao ',
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: 'Neo4j Social Media',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ', sua rede social orientada a grafos.',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48.0),

                // Formulário com inputs de login
                Column(
                  children: [
                    Form(
                      child: Column(
                        children: [
                          Input(
                            label: 'E-mail',
                            prefixIcon: CupertinoIcons.person,
                            controller: emailController,
                            validator: validateEmail,
                          ),
                          const SizedBox(height: 14.0),
                          Input(
                            label: 'Senha',
                            prefixIcon: CupertinoIcons.lock,
                            controller: passwordController,
                            validator: validatePassword,
                            isPassword: true,
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Par de botões de login e para redirecionar para tela de cadastro
                Column(
                  children: [
                    Container(
                      height: 42,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: _formIsValid
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(
                                context,
                              ).textTheme.bodyMedium!.color!.withAlpha(60),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ElevatedButton(
                        onPressed: _formIsValid ? login : null,
                        child: Text(
                          'Entrar',
                          style: TextStyle(
                            color: Theme.of(context).canvasColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
                const SizedBox(height: 40.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
