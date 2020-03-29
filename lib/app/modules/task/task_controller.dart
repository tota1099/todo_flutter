import 'package:mobx/mobx.dart';
import 'package:todo_flutter/app/modules/task/models/todo_model.dart';
import 'repositories/todo_repository_interface.dart';

part 'task_controller.g.dart';

class TaskController = _TaskControllerBase with _$TaskController;

abstract class _TaskControllerBase with Store {
  final ITodoRepository repository;

  @observable
  ObservableStream<List<TodoModel>> todoList;

  _TaskControllerBase(ITodoRepository this.repository) {
    getList();
  }

  @action
  getList(){
    todoList = repository.getTodos().asObservable();
  }
}
