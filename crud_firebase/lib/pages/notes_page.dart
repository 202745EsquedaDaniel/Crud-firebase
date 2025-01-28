import 'package:crud_firebase/components/my_back_button.dart';
import 'package:crud_firebase/components/my_list_tile.dart';
import 'package:crud_firebase/components/my_post_button.dart';
import 'package:crud_firebase/components/my_textfield.dart';
import 'package:crud_firebase/services/notes.firestone.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatelessWidget {
  NotesPage({super.key});

  //firestone acces
  final NotesFirestoneDatabase database = NotesFirestoneDatabase();

//text controller
  final TextEditingController newPostController = TextEditingController();

  // post message
  void postMessage() {
    //only post if there is text
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    //clear the textfield
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        //back button
        const Padding(
          padding: EdgeInsets.only(
            top: 50,
            left: 25,
          ),
          child: Row(
            children: [MyBackButton()],
          ),
        ),

        //Textfiel box
        Padding(
          padding: const EdgeInsets.all(25),
          child: Row(
            children: [
              // textfield
              Expanded(
                child: MyTextField(
                    hintText: "Say something...",
                    obscureText: false,
                    controller: newPostController),
              ),

              //post button
              PostButton(
                onTap: postMessage,
              )
            ],
          ),
        ),

        //posts
        StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              //show loading circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              // get all posts
              final posts = snapshot.data!.docs;
              //no data?
              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("No posts"),
                  ),
                );
              }
              //return as a list
              return Expanded(
                  child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        //get each indivudual post
                        final post = posts[index];

                        //get data from each post
                        String message = post["PostMessage"];
                        String userEmail = post["UserEmail"];

                        //return as a list tile
                        return MyListTile(title: message, subtitle: userEmail);
                      }));
            })
      ])),
    );
  }
}
