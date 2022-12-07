import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

import '../../helpers/validators.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final UserModel user = UserModel();
  SignUpScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
        centerTitle: true,
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
                      enabled: !userManager.loading,
                      decoration:
                          const InputDecoration(hintText: 'Nome completo'),
                      autocorrect: false,
                      validator: (nomeCompleto) {
                        if (nomeCompleto.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (nomeCompleto.trim().split(' ').length <= 1) {
                          return 'Preencha seu nome completo';
                        }
                        return null;
                      },
                      onSaved: (nomeCompleto) {
                        user.name = nomeCompleto;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
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
                      onSaved: (email) {
                        user.email = email;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      enabled: !userManager.loading,
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
                      onSaved: (senhaRepetida) {
                        user.password = senhaRepetida;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      enabled: !userManager.loading,
                      decoration:
                          const InputDecoration(hintText: 'Repita a senha'),
                      obscureText: true,
                      autocorrect: false,
                      validator: (senhaRepetida) {
                        if (senhaRepetida != null &&
                            senhaRepetida.trim().isEmpty) {
                          return 'Campo obrigatório';
                        }
                        if (senhaRepetida != null &&
                            senhaRepetida.trim().length < 6) {
                          return 'Senha inválida';
                        }
                        return null;
                      },
                      onSaved: (senhaRepetida) {
                        user.confirmPassword = senhaRepetida;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: userManager.loading
                            ? null
                            : () {
                                if (formKey.currentState.validate()) {
                                  formKey.currentState.save();
                                  if (user.password != user.confirmPassword) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Senhas não coincidem!'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return;
                                  }
                                  userManager.signUp(
                                    userModel: user,
                                    onSucess: () {
                                      Navigator.of(context).pop();
                                    },
                                    onFail: (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Falha ao cadastrar: $e'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
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
                                'Criar conta',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
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
