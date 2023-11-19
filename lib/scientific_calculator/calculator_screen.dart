import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _input = "";

  void _handleButtonPressed(String value) {
    setState(() {
      if (value == "=") {
        try {
          _output = _evaluate(_input);
        } catch (e) {
          _output = "Error";
        }
        _input = "";
      } else if (value == "C") {
        _input = "";
        _output = "0";
      } else {
        // Replace "√" with "sqrt" to correctly handle the square root function.
        if (value == "√") {
          value = "sqrt";
        }
        _input += value;
      }
    });
  }

  String _evaluate(String input) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(input);
      ContextModel cm = ContextModel();
      return exp.evaluate(EvaluationType.REAL, cm).toString();
    } catch (e) {
      return "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scientific Calculator"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _input.isEmpty ? "0" : _input,
                style: const TextStyle(fontSize: 38),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style:
                    const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              color: Colors.grey,
              thickness: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Expanded(
              flex: 2,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton("7"),
                      _buildButton("8"),
                      _buildButton("9"),
                      _buildButton("C"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton("4"),
                      _buildButton("5"),
                      _buildButton("6"),
                      _buildButton("*"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton("1"),
                      _buildButton("2"),
                      _buildButton("3"),
                      _buildButton("-"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton("0"),
                      _buildButton("^"),
                      _buildButton("/"),
                      _buildButton("+"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton("sin"),
                      _buildButton("cos"),
                      _buildButton("√"),
                      _buildButton("="),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .04,
          )
        ],
      ),
    );
  }

  Widget _buildButton(String label) {
    return ElevatedButton(
      onPressed: () => _handleButtonPressed(label),
      child: Text(
        label,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
