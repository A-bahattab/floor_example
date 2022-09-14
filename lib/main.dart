import 'package:floor_example/app_entity.dart';
import 'package:floor_example/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.getDatabaseObj();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Floor Database with Bahattab',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Floor Database with Bahattab'),
        ),
        body: Body(),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  DB.appDao!.addOneProduct(Product(name: "prod1", price: 200));
                },
                child: Text('Add')),
            ElevatedButton(
                onPressed: () {
                  DB.appDao!.updateOneProduct(Product(id: 1, name: 'pppp'));
                },
                child: Text('Update')),
            ElevatedButton(
                onPressed: () {
                  DB.appDao!.deleteOneProduct(Product(id: 2));
                },
                child: Text('delete')),
            ElevatedButton(
                onPressed: () {
                  DB.appDao!.deleteAll();
                },
                child: Text('delete All')),
          ],
        ),
        StreamBuilder(
          stream: DB.appDao!.getAllProducts(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(snapshot.data![index].name!),
                      subtitle: Text(snapshot.data![index].price.toString()),
                    );
                  },
                );
              } else {
                return Text('NoData');
              }
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
