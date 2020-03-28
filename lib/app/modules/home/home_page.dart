import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';
import 'models/todo_model.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Observer(builder: (_) {
          if (controller.todoList.hasError) {
            return Center(
                child: RaisedButton(
              onPressed: controller.getList,
              child: Text('Error'),
            ));
          }

          if (controller.todoList.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<TodoModel> list = controller.todoList.data;

          return ReorderableListView(
            onReorder: (oldIndex, newIndex) {
              list[oldIndex].position = newIndex > oldIndex ? newIndex - 1 : newIndex;
              for (TodoModel model in list) {
                int index = list.indexOf(model);

                if(oldIndex != index && oldIndex > index && newIndex <= index) {
                  list[index].position = index + 1;
                  list[index].save();
                } else if (oldIndex != index && oldIndex < index && newIndex >= index) {
                  list[index].position = index - 1;
                  list[index].save();
                }
              }
              list[oldIndex].save();
              
            },
            children: [
              for (TodoModel model in list)
                ListTile(
                  key: ValueKey(model.reference),
                  title: Text(model.title),
                  onTap: () {
                    _showDialog(model);
                  },
                  leading: IconButton(
                    icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                    onPressed: model.delete,
                  ),
                  trailing: Checkbox(
                    value: model.check,
                    onChanged: (check) {
                      model.check = check;
                      model.save();
                    },
                  ),
                ),
            ]
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: _showDialog,
          child: Icon(Icons.add),
        ),
      );
  }

  _showDialog([TodoModel model]) {
    model ??= TodoModel();

    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(model.title.isEmpty ? 'Adicionar' : 'Editar'),
            content: TextFormField(
              initialValue: model.title,
              onChanged: (value) => model.title = value,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Tarefa",
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Modular.to.pop();
                },
                child: Text("Cancelar"),
              ),
              FlatButton(
                onPressed: () async {
                  await model.save();
                  Modular.to.pop();
                },
                child: Text("Salvar"),
              ),
            ],
          );
        });
  }
}
