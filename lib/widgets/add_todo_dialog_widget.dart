import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:flutter_todo/provider/todos.dart';
import 'package:flutter_todo/widgets/todo_form_widget.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class AddTodoDialogWidget extends StatefulWidget {
  const AddTodoDialogWidget({Key? key}) : super(key: key);

  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add todo',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 8),
            TodoFormWidget(
              onChangeTitle: (title) => setState(() => this.title = title),
              onChangeDescription: (description) =>
                  setState(() => this.description = description),
              onSaveTodo: addTodo,
            )
          ],
        ),
      ),
    );
  }

  void addTodo() {
    final isValid = _formKey.currentState?.validate();

    if (!isValid!) {
      return;
    } else {
      var date = DateTime.now();

      final todo = Todo(
        title: title,
        id: Key(date.toString()),
        description: description,
        createdTime: date,
      );

      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.addTodo(todo);

      Navigator.of(context).pop();
    }
  }
}
