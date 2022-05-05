import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_it/constant/color_map.dart';
import 'package:note_it/model/note.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_it/screens/add_note.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
            child: Text(
          "Note It",
          style: TextStyle(color: Colors.black),
        )),
        elevation: 5,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<Note>>(
          stream: readNotes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final written_notes = snapshot.data!;
              final noteId = snapshot.data!;
              return StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: written_notes.map(buildNote).toList(),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddNote()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Stream<List<Note>> readNotes() => FirebaseFirestore.instance
      .collection('notes')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Note.fromJson(doc.data())).toList());
  Widget buildNote(Note note) => GestureDetector(
        onDoubleTap: () {
          final docNote =
              FirebaseFirestore.instance.collection('notes').doc(note.id);
          docNote.delete();
        },
        child: ListTile(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          tileColor: colorMap[note.color],
          title: Text(note.title),
          subtitle: Text(note.content),
        ),
      );
}
