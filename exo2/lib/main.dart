import 'package:exo2/pages/results.dart';
import 'package:flutter/material.dart';
import 'package:exo2/consts.dart';
import 'package:exo2/components.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  late double _value1;
  late double _value2;
  late FocusNode _op1Focus;

  @override
  void initState() {
    super.initState();
    _op1Focus = FocusNode();
  }

  @override
  void dispose() {
    _op1Focus.dispose();
    super.dispose();
  }

  _displayResult(String operation) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ResultsPage(operation)));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ResultsPage(operation)))
        .then((value) {
      setState(() {
        _formKey.currentState?.reset();
        _op1Focus.requestFocus();
      });
    });
  }

  String? _operandValidator(value) {
    if (value == null ||
        value.trim().isEmpty ||
        double.tryParse(value) == null) {
      return "veuillez saisir un nombre";
    }
    return null;
  }

  _add() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();
    _displayResult("$_value1 + $_value2 = ${_value1 + _value2}");
  }

  _sub() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();
    _displayResult("$_value1 - $_value2 = ${_value1 - _value2}");
  }

  _mul() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();
    _displayResult("$_value1 * $_value2 = ${_value1 * _value2}");
  }

  _div() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();
    _displayResult("$_value1 / $_value2 = ${_value1 / _value2}");
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
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    onSaved: (value) =>
                        _value1 = double.parse(value.toString()),
                    validator: _operandValidator,
                    style: defaultTextStyle,
                    keyboardType: TextInputType.number,
                    focusNode: _op1Focus,
                  ),
                ),
                SizedBox(
                    width: 200,
                    child: TextFormField(
                      onSaved: (value) =>
                          _value2 = double.parse(value.toString()),
                      validator: _operandValidator,
                      style: defaultTextStyle,
                      keyboardType: TextInputType.number,
                    ))
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MySizedBox(
                      child:
                          ElevatedButton(onPressed: _add, child: MyText("+"))),
                  MySizedBox(
                      child:
                          ElevatedButton(onPressed: _sub, child: MyText("-"))),
                  MySizedBox(
                      child:
                          ElevatedButton(onPressed: _mul, child: MyText("*"))),
                  MySizedBox(
                      child:
                          ElevatedButton(onPressed: _div, child: MyText("/"))),
                ],
              )
            ])));
  }
}
