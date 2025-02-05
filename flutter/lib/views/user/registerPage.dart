import 'package:flutter/material.dart';
import 'package:taskly/components/tasklyTextInput/tasklyTextInput.dart';
import 'package:taskly/components/pageTitle/pageTitle.dart';
import 'package:taskly/constants/strings.dart';
import 'package:taskly/utils/utils.dart';
import 'package:taskly/viewmodels/auth.dart';

import 'package:taskly/views/user/loginPage.dart';

class SignUpPage extends StatefulWidget{
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthViewModel authViewModel = AuthViewModel();

  void handleRegisterButton() async {
    if (_formKey.currentState!.validate()) {
      try {
        var success = await authViewModel.register(_nameController.text, _emailController.text, _passwordController.text);
        
        if (success) {
          bool finished = await Utils.showNotificationToUser(context, Strings.userCreatedMessage, title: Strings.success);
        
        if (finished) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
        } else {
          Utils.showNotificationToUser(context, Strings.errorApi);
        }
      } catch (e) {
        Utils.showNotificationToUser(context, Strings.errorApi);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(Strings.signUpTitle)
      ),
      body: Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PageTitle(
                title: Strings.signUpTitle
              ),
              TasklyTextInput(
                hintText: Strings.enterYourName, 
                errorText: "erro text",
                controller: _nameController,
              ),
              TasklyTextInput(
                hintText: Strings.enterYourEmail, 
                errorText: "erro text",
                controller: _emailController,
              ),
              TasklyTextInput(
                hintText: Strings.enterYourPassword, 
               errorText: "erro text",
                obscureText: true,
                controller: _passwordController,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 32, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        handleRegisterButton();
                      },
                      child: const Text(Strings.signUpTitle),
                    ),
                  ],
                ),
              )
            ]
          ),
        )
      );
  }
}
