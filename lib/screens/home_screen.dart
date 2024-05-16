import 'package:crud_flutter_app/screens/add_product_screen.dart';
import 'package:crud_flutter_app/screens/edit_screen.dart';
import 'package:crud_flutter_app/services/firebase_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  static const String _title = 'Crud Application';
  final FireStoreService firebaseService = FireStoreService("products");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(_title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return AddProductScreen();
            }));
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Products",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            Card(
              child: StreamBuilder(
                  stream: firebaseService.retriveData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(snapshot.data!.docs[index].id),
                              onDismissed: (direction) {
                                firebaseService.col
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete();
                              },
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              child: ListTile(
                                title: Text(
                                    snapshot.data!.docs[index].get("name")),
                                subtitle: Text(
                                  snapshot.data!.docs[index].get("description"),
                                ),
                                trailing: Text(
                                    snapshot.data!.docs[index].get("price")),
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return EditProductScreen(
                                        id: snapshot.data!.docs[index].id);
                                  }));
                                },
                              ),
                            );
                          });
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            )
          ],
        ));
  }
}
