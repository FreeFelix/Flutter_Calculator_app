// TODO: organizing  code in this files  and commenting where it necessary for better maintainability.

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        primaryColor: Colors.blue, // Set primary color
        hintColor: Colors.orange, // Set accent color
        textTheme: const TextTheme(
          headline6: TextStyle(fontSize: 44.0), // Set the headline6 text style
          button: TextStyle(fontSize: 30.0), // Set the button text style
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue, // Set the button background color
          ),
        ),
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '';

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        // TODO: Validate input before calculation (prevent empty or invalid expressions)
        result = _performCalculation();
        input = result; // Set input to the result for further calculations
      } else if (buttonText == 'C') {
        // TODO: Implement a confirmation dialog for clearing input and result
        input = '';
        result = '';
      } else {
        input += buttonText;
      }
    });
  }

  String _performCalculation() {
    try {
      final calculatedResult = calculateExpression(input);
      return calculatedResult.toString();
    } catch (e) {
      return 'Error';
    }
  }

  double calculateExpression(String expression) {
    Parser parser = Parser();
    Expression exp = parser.parse(expression);
    ContextModel cm = ContextModel();
    return exp.evaluate(EvaluationType.REAL, cm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display area (TextField for input and output)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 18.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: TextField(
                controller: TextEditingController(text: input),
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.headline6,
                readOnly: true,
                decoration: const InputDecoration.collapsed(hintText: ''),
              ),
            ),
            // TODO: Adjusted space between headline and text box.
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(height: 8.0),
            ),
            // Buttons row 1
            _buildButtonRow(['7', '8', '9', '/']),
            // Buttons row 2
            _buildButtonRow(['4', '5', '6', '*']),
            // Buttons row 3
            _buildButtonRow(['1', '2', '3', '-']),
            // Buttons row 4
            _buildButtonRow(['0', '.', '=', '+']),
            // Additional row for Clear button
            _buildButtonRow(['C']),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttonLabels) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttonLabels
            .map(
              (label) => ElevatedButton(
                onPressed: () => onButtonPressed(label),
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
