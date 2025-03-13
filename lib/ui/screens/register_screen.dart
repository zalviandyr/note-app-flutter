import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/blocs/bloc.dart';
import 'package:note_app/configs/configs.dart';
import 'package:note_app/ui/screens/screens.dart';
import 'package:note_app/ui/widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late AuthBloc _authBloc;
  final GlobalKey<FormState> _form = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _passwordErrorText;
  bool _isObscure = true;
  bool _isObscure2 = true;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);

    super.initState();
  }

  void _passwordToggleAction() {
    setState(() => _isObscure = !_isObscure);
  }

  void _confirmPasswordToggleAction() {
    setState(() => _isObscure2 = !_isObscure2);
  }

  void _toLoginAction() {
    Navigator.of(context).pop();
  }

  void _registerAction() {
    if (_form.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String confirmPassword = _confirmPasswordController.text.trim();

      if (password != confirmPassword) {
        setState(() => _passwordErrorText = ValidationWord.passwordMustSame);
      } else {
        setState(() => _passwordErrorText = null);

        _authBloc.add(AuthRegister(email: email, password: password));
      }
    }
  }

  void _authListener(BuildContext context, AuthState state) {
    if (state is AuthRegisterSuccess) {
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
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: _authListener,
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
                      Word.register,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  TextFormField(
                    validator: Validation.inputRequired,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: Word.email,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    obscureText: _isObscure,
                    validator: Validation.inputRequired,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      errorText: _passwordErrorText,
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
                  const SizedBox(height: 10.0),
                  TextFormField(
                    validator: Validation.inputRequired,
                    obscureText: _isObscure2,
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      errorText: _passwordErrorText,
                      hintText: Word.confirmPassword,
                      suffixIcon: GestureDetector(
                        onTap: _confirmPasswordToggleAction,
                        child: Icon(
                          _isObscure2 ? Icons.visibility_off : Icons.visibility,
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
                        onPressed: _registerAction,
                        label: Word.register,
                      );
                    },
                  ),
                  MaterialButton(
                    onPressed: _toLoginAction,
                    child: Text(
                      Word.loginAppeal,
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
