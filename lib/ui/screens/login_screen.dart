import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/blocs/bloc.dart';
import 'package:note_app/configs/configs.dart';
import 'package:note_app/ui/screens/screens.dart';
import 'package:note_app/ui/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthBloc _authBloc;
  final GlobalKey<FormState> _form = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  void _passwordToggleAction() {
    setState(() => _isObscure = !_isObscure);
  }

  void _toRegisterAction() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => RegisterScreen()),
    );
  }

  void _loginAction() {
    if (_form.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      _authBloc.add(AuthLogin(email: email, password: password));
    }
  }

  void _loginListener(BuildContext context, AuthState state) {
    if (state is AuthLoginSuccess) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => HomeScreen()),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: _loginListener,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Word.login,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  TextFormField(
                    controller: _emailController,
                    validator: Validation.inputRequired,
                    decoration: InputDecoration(
                      hintText: Word.email,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _passwordController,
                    validator: Validation.inputRequired,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      hintText: Word.password,
                      suffixIcon: GestureDetector(
                        onTap: _passwordToggleAction,
                        child: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return PrimaryButton.loading();
                      }

                      return PrimaryButton(
                        onPressed: _loginAction,
                        label: Word.login,
                      );
                    },
                  ),
                  MaterialButton(
                    onPressed: _toRegisterAction,
                    child: Text(
                      Word.registerAppeal,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
