import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/components/my_drawer.dart';
import 'package:crud_firebase/services/firestone.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //firestose
  final FirestoneService firestoneService = FirestoneService();
  //text controller
  final TextEditingController textController = TextEditingController();
  //open a dialog box to add a note
  void openNoteBox({String? docID}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      //add a new note
                      if (docID == null) {
                        firestoneService.addNote(textController.text);
                      } else {
                        firestoneService.updateNote(docID, textController.text);
                      }
                      //clear the text controller
                      textController.clear();
                      //close the dialog box
                      Navigator.pop(context);
                    },
                    child: const Text(("add")))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('N O T E S'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestoneService.getNotesStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List notesList = snapshot.data!.docs;

              //return as a list
              return ListView.builder(
                  itemCount: notesList.length,
                  itemBuilder: (context, index) {
                    //get individual document
                    DocumentSnapshot document = notesList[index];
                    String docID = document.id;

                    //Get the note from the document
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    String noteText = data["note"];

                    //display as a list tile
                    return ListTile(
                      title: Text(noteText),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () => openNoteBox(docID: docID),
                              icon: const Icon(Icons.settings)),
                          IconButton(
                              onPressed: () =>
                                  firestoneService.deleteNote(docID),
                              icon: const Icon(Icons.delete)),
                        ],
                      ),
                    );
                  });
              // if there
            } else {
              return const Text("No notes...");
            }
          }),
    );
  }
}
