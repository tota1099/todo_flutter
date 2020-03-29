import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_flutter/app/components/InputFields.dart';
import 'package:todo_flutter/app/components/SignInButton.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.more,
                  color: Colors.yellowAccent,
                  size: 40.0,
                ),
                label: Text(
                  'TODO',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                )
              ),
              Form(
                  child: Column(
                children: <Widget>[
                  InputFieldArea(
                    hint: "Username",
                    obscure: false,
                    icon: Icons.person_outline,
                  ),
                  InputFieldArea(
                    hint: "Password",
                    obscure: true,
                    icon: Icons.lock_outline,
                  ),
                ],
              )),
              SignIn()
            ],
          )
      )),
    );
  }
}
