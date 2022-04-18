import 'package:flutter/material.dart';
import 'package:mobile_todolist_task3/models/todo_model.dart';

class UserInput extends StatelessWidget {
  var textController = TextEditingController();
  final Function insertFunction; //this will receive the addItem function
  UserInput({required this.insertFunction, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Row(
        children: [
          //this is input box
          Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45),
                  borderRadius: BorderRadius.circular(15),
                ),
                // color: const Color(0xFFDAB5FF),
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: 'Add new todo',
                    border: InputBorder.none,
                  ),
                ),
              )),
          const SizedBox(width: 10),
          //this is button
          GestureDetector(
            onTap: () {
              //create todo
              var myTodo = Todo(
                  title: textController.text,
                  creationDate: DateTime.now(),
                  isChecked: false);
              //pass this to insertFunction as parameter
              insertFunction(myTodo);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 17),
              child: const Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
