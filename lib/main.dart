import 'package:flutter/material.dart';
import 'package:olivias_gehirn/custom_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;
  int firstNumber = 0;
  int secondNumber = 0;
  int operation = 0;
  int state = 2;
  bool refresh = true;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double padding = 24;
  double fontsize = 25;

  @override
  Widget build(BuildContext context) {

    fontsize = ((MediaQuery.of(context).size.width-2*padding)*1.4)/displayText().length;
    if(fontsize > 50) fontsize = 50;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [GestureDetector(
          child: Container(height: 50, width: 50, color: Colors.blue,),
        ), ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            children: [
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width - 2* padding,
                color: Colors.pinkAccent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(displayText(), style: TextStyle(
                      color: Colors.blue,
                      fontSize: fontsize,
                    ), textAlign: TextAlign.right),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width - 2 * padding,
                color: Colors.pink,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CustomButton("1", true, numberButton),
                              CustomButton("2", true, numberButton),
                              CustomButton("3", true, numberButton)
                            ],
                          ),
                          Row(
                            children: [
                              CustomButton("4", true, numberButton),
                              CustomButton("5", true, numberButton),
                              CustomButton("6", true, numberButton)
                            ],
                          ),
                          Row(
                            children: [
                              CustomButton("7", true, numberButton),
                              CustomButton("8", true, numberButton),
                              CustomButton("9", true, numberButton)
                            ],
                          ),
                          Row(
                            children: [
                              CustomButton("AC", false, delete),
                              CustomButton("0", true, numberButton),
                              CustomButton("=", false, equals)
                            ],
                          )
                        ],
                      )
                    ),
                    Column(
                      children: [
                        CustomButton("+", false, operationButton),
                        CustomButton("-", false, operationButton),
                        CustomButton("×", false, operationButton),
                        CustomButton("÷", false, operationButton),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  String displayText(){
    String displayText = "";
    switch(widget.state){
      case 0:
        displayText = widget.firstNumber.toString();
        break;
      case 1:
        displayText = widget.firstNumber.toString()
            + getOperationString(widget.operation)
            + widget.secondNumber.toString();
        break;
      case 2:
        displayText = widget.firstNumber.toString()
            + getOperationString(widget.operation)
            + widget.secondNumber.toString()
            + " = " + calc(widget.firstNumber, widget.operation, widget.secondNumber).toString();
        break;
    }
    return displayText;
  }

  void numberButton(String s){
    if(widget.state == 0) widget.firstNumber = widget.firstNumber * 10 + int.parse(s);
    else if(widget.state == 1) widget.secondNumber = widget.secondNumber * 10 + int.parse(s);
    else {
      delete("AC");
      widget.state = 0;
      widget.firstNumber = widget.firstNumber * 10 + int.parse(s);
    }
    setState(() {});
  }

  void operationButton(String s){
    if(widget.state == 0){
      widget.state = 1;
      switch(s){
        case "+":
          widget.operation = 0;
          break;
        case "-":
          widget.operation = 1;
          break;
        case "×":
          widget.operation = 2;
          break;
        case "÷":
          widget.operation = 3;
          break;
      }
      setState(() {});
    }
  }

  void delete(String s){
    widget.firstNumber = 0;
    widget.state = 2;
    widget.operation = 0;
    widget.secondNumber = 0;
    setState(() {});
  }

  void equals(String s){
    if(widget.state == 1){
      widget.state = 2;
      setState(() {});
    }
  }

  String getOperationString(int id){
    switch(id){
      case 0:
        return " + ";
      case 1:
        return " - ";
      case 2:
        return " × ";
      case 3:
        return " ÷ ";
    }
    return "";
  }

  double calc(int first, int operation, int second){
    switch(operation){
      case 0:
        return first + second + 0.0;
      case 1:
        return first - second + 0.0;
      case 2:
        return first * second + 0.0;
      case 3:
        return first / second + 0.0;
    }
    return 0;
  }
}
