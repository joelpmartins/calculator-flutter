import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  String eq = "", resultado = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('calculator-flutter'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey[900],
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                child: Text(
                  eq,
                  style: const TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                child: Text(
                  resultado,
                  style: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 25, right: 45, bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        buttonPressed(17, "");
                      },
                      icon: const Icon(Icons.backspace_rounded),
                      color: Colors.white,
                      iconSize: 42,
                    ),
                    IconButton(
                      onPressed: () {
                        buttonPressed(16, "");
                      },
                      icon: const Icon(Icons.refresh),
                      color: Colors.white,
                      iconSize: 42,
                    ),
                  ],
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton(7, "7", 0xDD000000),
                        buildButton(8, "8", 0xDD000000),
                        buildButton(9, "9", 0xDD000000),
                      ]),
                      TableRow(children: [
                        buildButton(4, "4", 0xDD000000),
                        buildButton(5, "5", 0xDD000000),
                        buildButton(6, "6", 0xDD000000),
                      ]),
                      TableRow(children: [
                        buildButton(1, "1", 0xDD000000),
                        buildButton(2, "2", 0xDD000000),
                        buildButton(3, "3", 0xDD000000),
                      ]),
                      TableRow(children: [
                        buildButton(10, ".", 0xFFF57C00),
                        buildButton(0, "0", 0xDD000000),
                        buildButton(11, "=", 0xFF4CAF50),
                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton(12, "/", 0xFFF57C00),
                      ]),
                      TableRow(children: [
                        buildButton(13, "x", 0xFFF57C00),
                      ]),
                      TableRow(children: [
                        buildButton(14, "-", 0xFFF57C00),
                      ]),
                      TableRow(children: [
                        buildButton(15, "+", 0xFFF57C00),
                      ]),
                    ],
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  buildButton(int id, String buttonText, int buttonColor) {
    return FlatButton(
      onPressed: () {
        buttonPressed(id, buttonText);
      },
      child: Text(
        buttonText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 32,
        ),
      ),
      color: Color(buttonColor),
      padding: const EdgeInsets.all(15),
      shape: const CircleBorder(
        side: BorderSide(
          color: Colors.transparent,
          style: BorderStyle.solid,
        ),
      ),
    );
  }

  buttonPressed(int id, String buttonText) {
    setState(() {
      if (id == 11) {
        eq = eq.replaceAll('x', '*');
        try {
          Parser p = Parser();
          Expression expression = p.parse(eq);
          ContextModel contextModel = ContextModel();
          resultado =
              '${expression.evaluate(EvaluationType.REAL, contextModel)}';
        } catch (e) {
          resultado = "";
        }
      } else if (id > 11 && id < 16) {
        String str = eq[eq.length - 1];
        if (str == "+" || str == "-" || str == "x" || str == "/") {
          eq = eq.substring(0, eq.length - 1) + buttonText;
        } else {
          eq = eq + buttonText;
        }
      } else if (id == 16) {
        eq = "";
        resultado = "";
      } else if (id == 17) {
        if (eq == "") {
        } else {
          eq = eq.substring(0, eq.length - 1);
          resultado = "";
        }
      } else {
        if (eq == "") {
          eq = buttonText;
        } else {
          eq = eq + buttonText;
        }
      }
    });
  }
}
