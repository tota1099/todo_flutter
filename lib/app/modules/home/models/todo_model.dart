import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String title;
  bool check;
  DocumentReference reference;
  int position;

  TodoModel(
      {this.reference, this.title = '', this.check = false, this.position});

  factory TodoModel.fromDocument(DocumentSnapshot doc) {
    return TodoModel(
      title: doc['title'],
      check: doc['check'],
      reference: doc.reference,
      position: doc['position']
    );
  }

  Future save() async {
    if(title.isEmpty) {
      throw("Por favor, preencha o campo título!");
    }

    if (reference == null) {
      int total = (await Firestore.instance.collection('todo').getDocuments())
          .documents
          .length;
      reference = await Firestore.instance
          .collection('todo')
          .add({'title': title, 'check': check, 'position': total});
    } else {
      reference
          .updateData({'title': title, 'check': check, 'position': position});
    }
  }

  Future delete() {
    return reference.delete();
  }
}
