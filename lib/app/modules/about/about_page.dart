import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'about_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  final String title;
  const AboutPage({Key key, this.title = "Sobre o aplicativo"})
      : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends ModularState<AboutPage, AboutController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Este aplicativo foi desenvolvido buscando aprender mais sobre a tecnologia flutter!",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Caso você queira saber mais sobre o projeto e até mesmo contribuir, acesse o repositório do projeto:",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          FlatButton.icon(
            onPressed: () => _launchURL(),
            icon: Icon(
              Icons.link,
              color: Colors.blue,
              size: 30.0,
            ),
            label: Text(
              'TODO Flutter GitHub',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          )
        ],
      ),
    );
  }
}

_launchURL() async {
  const url = 'https://github.com/tota1099/todo_flutter';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Ocorreu algum problema para abrir o projeto :(';
  }
}
