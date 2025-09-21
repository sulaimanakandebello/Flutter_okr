import 'package:flutter/material.dart';

class PricePage extends StatefulWidget {
  const PricePage({super.key, this.initial});
  final double? initial;

  @override
  State<PricePage> createState() => _PricePageState();
}

class _PricePageState extends State<PricePage> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(
      text: widget.initial == null ? '' : widget.initial!.toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _save() {
    final text = _ctrl.text.replaceAll(',', '.').trim();
    final value = double.tryParse(text);
    if (value == null || value < 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter a valid price')));
      return;
    }
    Navigator.pop(context, value); // return the price
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('Price'),
        actions: [TextButton(onPressed: _save, child: const Text('Save'))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: _ctrl,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Price',
            prefixText: '€ ',
            hintText: 'e.g. 19.99',
            border: OutlineInputBorder(),
          ),
          style: t.titleMedium,
          onSubmitted: (_) => _save(),
        ),
      ),
    );
  }
}
