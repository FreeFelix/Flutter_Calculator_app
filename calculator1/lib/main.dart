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
        primaryColor: Colors.blue, // Set your primary color
        hintColor: Colors.orange, // Set your accent color
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
        // When "=" is pressed, calculate the result and set the input to the result
        result = _performCalculation();
        input = result; // Set input to the result for further calculations
      } else if (buttonText == 'C') {
        // Clear the input and result
        input = '';
        result = '';
      } else {
        // Append the pressed button's text to the input
        input += buttonText;
      }
    });
  }

  String _performCalculation() {
    try {
      // Use the 'input' string to evaluate the expression
      final calculatedResult = calculateExpression(input);
      return calculatedResult.toString();
    } catch (e) {
      // Handle errors during calculation
      return 'Error';
    }
  }

  double calculateExpression(String expression) {
    // Parse and evaluate the expression using 'dart:math' library
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
                border: Border.all(color: Colors.blue), // Add a border for style
                borderRadius: BorderRadius.circular(12.0), // Optional: Add rounded corners
              ),
              child: TextField(
                controller: TextEditingController(text: input),
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.headline6,
                readOnly: true,
                decoration: const InputDecoration.collapsed(hintText: ''),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(120.0),
              child: SizedBox(height: 2.0),
            ), // Added space between headline and text box
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
