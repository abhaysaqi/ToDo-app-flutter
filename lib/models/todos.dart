class ToDo {
  String? id;
  String? todo_text;
  bool is_done;

  ToDo({required this.id, required this.todo_text, this.is_done = false});

  static List<ToDo> todo_list() {
    return [
      ToDo(id: '1', todo_text: "1 project", is_done: true),
      ToDo(id: '2', todo_text: "2 project", is_done: true),
      ToDo(id: '3', todo_text: "3 project"),
      ToDo(id: '4', todo_text: "4 project"),
      ToDo(id: '5', todo_text: "5 project")
    ];
  }
}
