import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_it/constant/color_map.dart';
import 'package:note_it/screens/homePage.dart';
import 'package:sizer/sizer.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final noteTitleController = TextEditingController();
  final noteContentController = TextEditingController();
  var noteColor = "red";
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    noteContentController.dispose();
    noteTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var maxLines = 5;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text("Add note"),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              style: const TextStyle(
                color: Colors.white,
              ),
              controller: noteTitleController,
              decoration: InputDecoration(
                hintText: "Enter Title",
                hintStyle: const TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.blueAccent,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              controller: noteContentController,
              maxLines: 16,
              decoration: InputDecoration(
                hintText: "Type Note",
                fillColor: Colors.grey[300],
                filled: true,
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    noteColor = "green";
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: colorMap["green"],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  height: 45,
                  width: 45,
                ),
              ),
              GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    noteColor = "yellow";
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: colorMap["yellow"],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  height: 45,
                  width: 45,
                ),
              ),
              GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    noteColor = "pink";
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: colorMap["pink"],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  height: 45,
                  width: 45,
                ),
              )
            ],
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final noteTitle = noteTitleController.text;
          final noteContent = noteContentController.text;
          final chosenColor = noteColor;
          final dateTime = DateTime.now().toString();
          if (noteContent.isEmpty || noteContent.isEmpty) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MyHomePage()));
          } else {
            createNote(
                title: noteTitle,
                content: noteContent,
                chosenColor: chosenColor,
                dateTime: dateTime);
          }
          noteContentController.clear();
          noteTitleController.clear();
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const MyHomePage()));
        },
        child: Text("" + noteColor),
      ),
    );
  }

  Future createNote(
      {required String title,
      required String content,
      required String chosenColor,
      required String dateTime}) async {
    final docNote = FirebaseFirestore.instance.collection('notes').doc();
    final json = {
      'id': docNote.id,
      'title': title,
      'content': content,
      'color': chosenColor,
      'dateTime': dateTime
    };
    await docNote.set(json);
  }

  Widget buildColorPlate(var value) => Container(
        decoration: BoxDecoration(
          color: value,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        height: 45,
        width: 45,
      );
}
/*
Container(
                decoration: BoxDecoration(
                  color: colorMap["green"],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                height: 45,
                width: 45,
              )
* */
