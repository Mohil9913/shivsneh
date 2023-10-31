import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shivsneh/model/product.dart';
import 'package:shivsneh/screens/auth/user_login_screen.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget content(String message) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Sure want to logout?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                        ),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => const UserLoginScreen(),
                            ),
                          );
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  );
                },
              );
            },
            leading: const Icon(Icons.power_settings_new),
            title: const Text('Logout'),
          ),
        ],
      );
    }

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('number', isEqualTo: userPhoneNumber)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return content('Something Went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return content('No Data Found');
          }

          if (snapshot != null && snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(snapshot.data!.docs[index]['name']),
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title:
                            Text('+91-${snapshot.data!.docs[index]['number']}'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.home_filled),
                        title: Text('Address'),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                          left: 57,
                          right: 20,
                        ),
                        child: Text(
                            '${snapshot.data!.docs[index]['address']['blockNo']}, ${snapshot.data!.docs[index]['address']['add1']}\n${snapshot.data!.docs[index]['address']['add2']}\n${snapshot.data!.docs[index]['address']['city']}, ${snapshot.data!.docs[index]['address']['state']}\n${snapshot.data!.docs[index]['address']['pinCode']}'),
                      ),
                      ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Logout'),
                                content: const Text('Sure want to logout?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('No'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                    ),
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (ctx) =>
                                              const UserLoginScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        leading: const Icon(Icons.power_settings_new),
                        title: const Text('Logout'),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
