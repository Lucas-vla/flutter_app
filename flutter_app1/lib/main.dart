import 'package:flutter/material.dart';
import 'package:flutter_app1/components.dart';
import 'package:flutter_app1/consts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;

  _sayHello(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();
    showDialog(context: context, builder: (BuildContext context) => AlertDialog(
    content: MyText('Bonjour, $_name !'),
    actions: [
      ElevatedButton(
    onPressed: () => Navigator.of(context).pop(),
    child: const MyText('Merci')
    )
    ],));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyPadding(
                child: TextFormField(
              onSaved: (value) => _name = value.toString(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Veuillez saisir un nom";
                }
                return null;
              },
              decoration: const InputDecoration(hintText: "Lucas"),
            )),
            SizedBox(
                width: double.infinity,
                child: MyPadding(
                    child: ElevatedButton(
                        onPressed: () => _sayHello(context),
                        child: const MyText("Dire Bonjour"))))
          ],
        ),
      ),
    );
  }
}
