import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/models/todos.dart';

class To_do_item extends StatelessWidget {
  final ToDo todo;
  final todo_changed;
  final todo_delete;
  const To_do_item(
      {Key? key,
      required this.todo,
      required this.todo_changed,
      required this.todo_delete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: ListTile(
          onTap: () {
            todo_changed(todo);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          tileColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          leading: Icon(
            todo.is_done
                ? Icons.check_box
                : Icons.check_box_outline_blank_rounded,
            color: tdBlue,
          ),
          title: Text(
            todo.todo_text!,
            style: TextStyle(
                fontSize: 16,
                color: tdBlack,
                decoration: todo.is_done ? TextDecoration.lineThrough : null),
          ),
          trailing: Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.symmetric(vertical: 5),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: tdRed, borderRadius: BorderRadius.circular(5)),
              child: IconButton(
                onPressed: () {
                  todo_delete(todo.id);
                },
                iconSize: 18,
                color: Colors.white,
                icon: Icon(Icons.delete_rounded),
              )),
        ));
  }
}
