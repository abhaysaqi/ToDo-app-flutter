// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/models/todos.dart';
import 'package:todo_app/widgets/to_do_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todolist = ToDo.todo_list();
  List<ToDo> found_todo = [];
  final TextEditingController add_item_controller = TextEditingController();
  final TextEditingController search_controller = TextEditingController();

  @override
  void initState() {
    found_todo = todolist;
    // TODO: implement i nitState
    super.initState();
  }

  void handle_todo_add(String todo) {
    setState(() {
      todolist.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todo_text: todo));
    });
    add_item_controller.clear();
  }

  void handle_todo_change(ToDo todo) {
    setState(() {
      todo.is_done = !todo.is_done;
    });
  }

  void handel_todo_delete(String id) {
    setState(() {
      todolist.removeWhere((item) => item.id == id);
    });
  }

  void run_filter(String search) {
    List<ToDo> result = [];
    if (search.isEmpty) {
      result = todolist;
    } else {
      result = todolist
          .where((item) =>
              item.todo_text!.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }
    setState(() {
      found_todo = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: tdBGColor,
        appBar: buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  Search_box(),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(bottom: 65),
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 30, bottom: 20),
                          child: Text('All ToDos',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w500)),
                        ),
                        for (ToDo todos in found_todo.reversed)
                          if (todolist.isNotEmpty)
                            To_do_item(
                              todo: todos,
                              todo_changed: handle_todo_change,
                              todo_delete: handel_todo_delete,
                            )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: add_item_controller,
                      decoration: InputDecoration(
                          hintText: "Add a New ToDo Item",
                          hintStyle: TextStyle(fontSize: 18),
                          border: InputBorder.none),
                    ),
                  )),
                  Container(
                    height: 60,
                    width: 60,
                    margin: EdgeInsets.only(bottom: 20, right: 20),
                    child: ElevatedButton(
                        child: Text(
                          "+",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (add_item_controller.text.isNotEmpty) {
                            handle_todo_add(add_item_controller.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: tdBlue,
                            minimumSize: Size(60, 60),
                            elevation: 10,
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.zero)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Search_box() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25.0)),
      child: TextField(
        // controller: search_controller,
        onChanged: (value) => run_filter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 2),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Icon(
                Icons.search_rounded,
                color: tdBlack,
                size: 20,
              ),
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: tdGrey)),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu_rounded,
            color: tdBlack,
            size: 40,
          ),
          Container(
            width: 40,
            height: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatar.jpeg'),
            ),
          )
        ],
      ),
    );
  }
}
