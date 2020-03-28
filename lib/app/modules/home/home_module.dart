import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_flutter/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_flutter/app/modules/home/home_page.dart';
import 'repositories/todo_repository.dart';
import 'repositories/todo_repository_interface.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController(i.get())),
        Bind<ITodoRepository>((i) => TodoRepository(Firestore.instance)),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
