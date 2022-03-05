import 'package:flutter/material.dart';
import 'package:flutter_todo/provider/todos.dart';
import 'package:flutter_todo/widgets/todo_widget.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class CompletedListWidget extends StatelessWidget {
  const CompletedListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.completedTodos;

    return todos.isEmpty
        ? const Center(
            child: Text(
              'No completed todos',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return TodoWidget(todo: todo);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 8,
            ),
          );
  }
}
