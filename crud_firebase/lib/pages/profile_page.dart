import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/components/my_back_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  //current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  //future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUsersDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: getUsersDetails(),
            builder: (context, snapshot) {
              //loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              //error
              else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }

              //data received
              else if (snapshot.hasData) {
                //extract here
                Map<String, dynamic>? user = snapshot.data!.data();

                return Center(
                  child: Column(
                    children: [
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

                      const SizedBox(height: 25),

                      //profile pic
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.all(25),
                        child: const Icon(
                          Icons.person,
                          size: 64,
                        ),
                      ),

                      const SizedBox(
                        height: 25,
                      ),
                      // user
                      Text(user!["username"]),
                      // email
                      Text(user["email"]),
                    ],
                  ),
                );
              } else {
                return const Text("No data");
              }
            }));
  }
}
