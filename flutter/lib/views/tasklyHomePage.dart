import 'package:flutter/material.dart';
import 'package:taskly/components/homePageButton/homePageButton.dart';
import 'package:taskly/constants/strings.dart';
import 'package:taskly/views/user/loginPage.dart';
import 'package:taskly/views/user/registerPage.dart';

class TasklyHomePage extends StatefulWidget {
  const TasklyHomePage({super.key});

  @override
  State<TasklyHomePage> createState() => _TasklyHomePageState();
}

class _TasklyHomePageState extends State<TasklyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(
          Strings.appTitle,
          style: TextStyle(
            letterSpacing: 1
          )
          )),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.asset("lib/asset/homePageImage.jpg"),
              HomePageButton(backgroundColor: Colors.black, title: "Login", onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage())
                );
              },),
              HomePageButton(backgroundColor: Colors.white, title: Strings.signUpTitle, onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage())
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}