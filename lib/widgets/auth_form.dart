import 'package:clothes_store/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthenticantionForm extends StatefulWidget {
  const AuthenticantionForm({Key? key}) : super(key: key);

  @override
  State<AuthenticantionForm> createState() => _AuthenticantionFormState();
}

class _AuthenticantionFormState extends State<AuthenticantionForm> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _formData = {
    'email': '',
    'password': '',
  };
  bool _isLoading = false;
  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.Signup;

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.Signup;
      } else {
        _authMode = AuthMode.Login;
      }
    });
  }

  Future<void> _submit() async {
    final _isValid = _formKey.currentState?.validate() ?? false;

    if (!_isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    Auth auth = Provider.of(
      context,
      listen: false,
    );

    if (_isLogin()) {
      // LOGIN
      await auth.login(
        _formData['email']!,
        _formData['password']!,
      );
    } else {
      // SIGNUP
      await auth.signup(
        _formData['email']!,
        _formData['password']!,
      );
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: _isLogin() ? 320 : 400,
        width: deviceSize.width * 0.75,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _formData['email'] = email ?? '',
                validator: (email) {
                  final _email = email ?? '';
                  if (_email.trim().isEmpty || !_email.contains('@')) {
                    return 'Informe um e-mail válido.';
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                onSaved: (password) => _formData['password'] = password ?? '',
                controller: _passwordController,
                validator: (password) {
                  final _password = password ?? '';
                  if (_password.isEmpty || _password.length < 5) {
                    return 'Informe uma senha válida.';
                  }
                  return null;
                },
              ),
              if (_isSignup())
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Confirmar senha',
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: _isLogin()
                      ? null
                      : (password) {
                          final _password = password ?? '';
                          if (_password != _passwordController.text) {
                            return 'As senhas informadas não conferem.';
                          }
                          return null;
                        },
                ),
              const SizedBox(height: 24),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 8,
                    ),
                  ),
                  child: Text(
                    _authMode == AuthMode.Login ? 'ENVIAR' : 'REGISTRAR',
                  ),
                ),
              Spacer(),
              TextButton(
                onPressed: _switchAuthMode,
                child:
                    Text(_isLogin() ? 'DESEJA REGISTRAR?' : 'JÁ POSSUI CONTA?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
