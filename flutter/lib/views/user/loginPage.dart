import 'package:flutter/material.dart';
import 'package:taskly/components/tasklyTextInput/tasklyTextInput.dart';
import 'package:taskly/components/pageTitle/pageTitle.dart';
import 'package:taskly/constants/strings.dart';
import 'package:taskly/viewmodels/auth.dart';
import 'package:taskly/utils/utils.dart';
import 'package:taskly/views/task/tasksPage.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthViewModel authViewModel = AuthViewModel();

    void handleLoginButton() async {
      if (_formKey.currentState!.validate()) {
        try {
          var success = await authViewModel.login(_emailController.text, _passwordController.text);
          if (success) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TasksPage()),
          );
          } else {
            Utils.showNotificationToUser(context, Strings.errorApi);
          }
        } catch (e) {
          Utils.showNotificationToUser(context, Strings.errorApi);
        }
        
      }
    }
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(Strings.loginTitle)
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PageTitle(title: Strings.loginTitle),
              TasklyTextInput(
                hintText: Strings.enterYourEmail, 
                errorText: "erro text", 
                controller: _emailController),
              TasklyTextInput(
                hintText: Strings.enterYourPassword, 
                errorText: "erro text", 
                controller: _passwordController,
                obscureText: true,
                ),
                ElevatedButton(
                  onPressed: () async {
                    handleLoginButton();
                  }, 
                  child: Text(Strings.loginTitle))
            ],
          ),
        )
      )
    );
    
  }
}