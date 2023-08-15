import 'package:flutter/material.dart';

class AuthenticationForm extends StatefulWidget {
  const AuthenticationForm({super.key});

  @override
  State<AuthenticationForm> createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  final _formKey = GlobalKey();
  bool isLogin = true;
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
                  decoration:
                      const InputDecoration(labelText: "Enter First Name"),
                ),
              if (!isLogin)
                TextFormField(
                  key: const ValueKey("last name"),
                  decoration:
                      const InputDecoration(labelText: "Enter Last Name"),
                ),
              TextFormField(
                key: const ValueKey("email"),
                decoration: const InputDecoration(labelText: "Enter Email"),
              ),
              TextFormField(
                obscureText: true,
                key: const ValueKey("password"),
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
                  onPressed: () {},
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
