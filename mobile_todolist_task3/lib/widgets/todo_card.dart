import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import 'package:intl/intl.dart';

class Todocard extends StatefulWidget {
  //create variables that todocard will receive data for
  final int id;
  final String title;
  final DateTime creationDate;
  bool isChecked;
  final Function insertFunction;
  final Function deleteFunction;
  Todocard(
      {
      required this.id,
      required this.title,
      required this.creationDate,
      required this.isChecked,
      required this.insertFunction,
      required this.deleteFunction,
      Key? key, })
    : super(key: key);

  @override
  _TodocardState createState() => _TodocardState();
}

class _TodocardState extends State<Todocard> {
  @override
  Widget build(BuildContext context) {
    //create a local todo
    var anotherTodo = Todo(id: widget.id, title: widget.title,
    creationDate: widget.creationDate, isChecked: widget.isChecked);

    return Card(
      child: Row(
        children: [
          //checkbox
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Checkbox(
              value: widget.isChecked,
              onChanged: (bool? value) {
                setState(() {
                  widget.isChecked = value!;
                });
                //change the value of anotherTodo's isCheck
                anotherTodo.isChecked = value!;
                //insert to db
                widget.insertFunction(anotherTodo);
              },
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  DateFormat('dd MMM yyyy - hh:mm aaa').format(widget.creationDate),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF8F8F8F),
                  ),
                ),
              ],
            ),
          ),
          //the delete button
          IconButton(
            onPressed: () {
              //add delete function
              widget.deleteFunction(anotherTodo);
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}

