import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //drawer header
              DrawerHeader(
                child: Icon(
                  Icons.favorite,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),

              const SizedBox(height: 25),
              //home title
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text("H O M E"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              //profile title
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text("P R O F I L E"),
                  onTap: () {
                    Navigator.pop(context);

                    // navigate to profile page
                    Navigator.pushNamed(context, "/profile_page");
                  },
                ),
              ),

              //users title
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.group),
                  title: Text("U S E R S"),
                  onTap: () {
                    Navigator.pop(context);

                    // navigate to users page
                    Navigator.pushNamed(context, "/users_page");
                  },
                ),
              ),
            ],
          ),

          //logout title
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 25),
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text("L O G O U T"),
              onTap: () {
                Navigator.pop(context);

                logout();
              },
            ),
          )
        ],
      ),
    );
  }
}
