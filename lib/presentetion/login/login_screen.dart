import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:loja_virtual/models/user.dart';

import '../../helpers/validators.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({
    Key key,
  }) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            child: Text(
              'CRIAR CONTA',
              style: Theme.of(context).textTheme.bodyMedium.copyWith(
                    color: Colors.white,
                  ),
            ),
          )
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      controller: emailController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        if (email.isEmpty || !emailValid(email)) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      enabled: !userManager.loading,
                      controller: passwordController,
                      decoration: const InputDecoration(hintText: 'Senha'),
                      obscureText: true,
                      autocorrect: false,
                      validator: (senha) {
                        if (senha != null && senha.trim().isEmpty) {
                          return 'Campo obrigatório';
                        }
                        if (senha != null && senha.trim().length < 6) {
                          return 'Senha inválida';
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          'Esqueci minha senha',
                          style:
                              Theme.of(context).textTheme.bodyMedium.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: userManager.loading
                            ? null
                            : () {
                                if (formKey.currentState.validate()) {
                                  context.read<UserManager>().signIn(
                                        userModel: UserModel(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                        onFail: (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text('Falha ao entrar: $e'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        },
                                        onSucess: () {
                                          Navigator.of(context).pop();
                                        },
                                      );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          disabledBackgroundColor:
                              Theme.of(context).primaryColor.withAlpha(200),
                        ),
                        child: userManager.loading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : Text(
                                'Entrar',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
