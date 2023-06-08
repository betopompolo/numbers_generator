import 'package:flutter/material.dart';
import 'dart:math';

const maxValue = 21;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: NumberGenerator(
                maxValue: maxValue,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: VerticalDivider(
                width: 2,
              ),
            ),
            Flexible(
              flex: 1,
              child: NumberGenerator(
                maxValue: maxValue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberGenerator extends StatefulWidget {
  const NumberGenerator({
    super.key,
    required this.maxValue,
  });

  final int maxValue;

  @override
  State<NumberGenerator> createState() => _NumberGeneratorState();
}

class _NumberGeneratorState extends State<NumberGenerator> {
  int? _randomNumber;
  final Set<int> _previousRandomNumbers = {};

  @override
  Widget build(BuildContext context) {
    final reachMaxGenerations =
        _previousRandomNumbers.length >= widget.maxValue;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_previousRandomNumbers.isNotEmpty)
          Wrap(
            direction: Axis.horizontal,
            children: [Text("Números sorteados: $_previousRandomNumbers")],
          ),
        if (_randomNumber != null)
          Text(
            _randomNumber.toString(),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        const SizedBox.square(dimension: 16),
        OutlinedButton(
          onPressed: reachMaxGenerations ? _reset : _getNextNumber,
          child: Text(
            reachMaxGenerations ? "Começar de novo" : "Sortear número",
          ),
        ),
      ],
    );
  }

  void _getNextNumber() {
    bool wasAdded = false;
    do {
      final randomNumber = Random().nextInt(widget.maxValue) + 1;
      wasAdded = _previousRandomNumbers.add(randomNumber);
      if (wasAdded) {
        setState(() {
          _randomNumber = randomNumber;
        });
      }
    } while (!wasAdded);
  }

  void _reset() {
    _previousRandomNumbers.clear();
    setState(() {
      _randomNumber = null;
    });
  }
}
