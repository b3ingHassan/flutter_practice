import 'package:crud_operations/services/functions/authentication.dart';
import 'package:flutter/material.dart';

class AuthenticationForm extends StatefulWidget {
  const AuthenticationForm({super.key});

  @override
  State<AuthenticationForm> createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  final _formKey = GlobalKey<FormState>();
  bool isLogin = true;
  String email = '';
  String password = '';
  String fname = '';
  String lname = "";

  changeIsLoginValue() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isLogin)
                TextFormField(
                  key: const ValueKey("first name"),
                  validator: (val) {
                    if (val.toString().length < 2) {
                      return "Enter a valid First name";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (val) {
                    setState(() {
                      fname = val.toString();
                    });
                  },
                  decoration:
                      const InputDecoration(labelText: "Enter First Name"),
                ),
              if (!isLogin)
                TextFormField(
                  key: const ValueKey("last name"),
                  validator: (val) {
                    if (val.toString().length < 2) {
                      return "Enter a valid Last name";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (val) {
                    setState(() {
                      lname = val.toString();
                    });
                  },
                  decoration:
                      const InputDecoration(labelText: "Enter Last Name"),
                ),
              TextFormField(
                key: const ValueKey("email"),
                validator: (val) {
                  if (val.toString().isEmpty || !val.toString().contains("@")) {
                    return "Enter a valid email";
                  } else {
                    return null;
                  }
                },
                onSaved: (val) {
                  setState(() {
                    email = val.toString();
                  });
                },
                decoration: const InputDecoration(labelText: "Enter Email"),
              ),
              TextFormField(
                obscureText: true,
                key: const ValueKey("password"),
                validator: (val) {
                  if (val.toString().length < 6 ||
                      !val.toString().contains("#")) {
                    return "Enter a valid password";
                  } else {
                    return null;
                  }
                },
                onSaved: (val) {
                  setState(() {
                    password = val.toString();
                  });
                },
                decoration: const InputDecoration(labelText: "Enter Password"),
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed: () => changeIsLoginValue(),
                child: isLogin
                    ? const Text("Don't have an account? Signup")
                    : const Text("Already have an account? Singin"),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      isLogin
                          ? AuthenticationFunctions.signIn(
                              context,
                              email,
                              password,
                            )
                          : AuthenticationFunctions.signUp(
                              context,
                              email,
                              password,
                              fname,
                              lname,
                            );
                    }
                  },
                  child: isLogin ? const Text("Login") : const Text("Signup"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
