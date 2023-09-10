import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../views/home_page.dart';
import '../../models/member.dart';

class Login extends StatefulWidget {
  const Login({Key? key, this.cameFrom = 1}) : super(key: key);
  final int cameFrom;

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login>{
  int cameFrom = 1;

  @override
  void initState() {
    super.initState();
    cameFrom = widget.cameFrom;
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
          return false;
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Login in',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.mail),
                                ),
                                validator: (value) {
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.lock),
                                ),
                                validator: (value) {
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20.0),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final user = Provider.of<Member>(context, listen: false);
                                     bool isLoggedIn = await user.login(
                                         emailController.text, passwordController.text);
                                    if (!isLoggedIn) {
                                      emailController.clear();
                                      passwordController.clear();
                                      if (context.mounted) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text('Error'),
                                              content: const Text(
                                                  "Incorrect credentials. Try again."),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('Ok'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    } else if (context.mounted) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage(initialIndex: cameFrom)),
                                      );
                                    }
                                  } else {
                                    emailController.clear();
                                    passwordController.clear();
                                  }
                                },
                                child: const Text('Login in'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}