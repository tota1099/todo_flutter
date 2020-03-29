import 'package:cloud_firestore/cloud_firestore.dart';
import 'task_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'task_page.dart';
import 'repositories/todo_repository.dart';
import 'repositories/todo_repository_interface.dart';

class TaskModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => TaskController(i.get())),
        Bind<ITodoRepository>((i) => TodoRepository(Firestore.instance)),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => TaskPage()),
      ];

  static Inject get to => Inject<TaskModule>.of();
}
