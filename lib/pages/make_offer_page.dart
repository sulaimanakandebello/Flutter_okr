import 'package:flutter/material.dart';

class MakeOfferPage extends StatefulWidget {
  const MakeOfferPage({
    super.key,
    required this.productTitle,
    required this.productPrice,
    this.thumbUrl,
  });

  final String productTitle;
  final double productPrice;
  final String? thumbUrl;

  @override
  State<MakeOfferPage> createState() => _MakeOfferPageState();
}

class _MakeOfferPageState extends State<MakeOfferPage> {
  late final TextEditingController _priceCtrl;
  int _selectedPreset = -1;

  @override
  void initState() {
    super.initState();
    _priceCtrl = TextEditingController(
      text: widget.productPrice.toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    _priceCtrl.dispose();
    super.dispose();
  }

  void _applyPreset(double value, int index) {
    setState(() {
      _selectedPreset = index;
      _priceCtrl.text = value.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.productPrice;
    final tenOff = (p * .90);
    final twentyOff = (p * .80);

    final parsed = double.tryParse(_priceCtrl.text.replaceAll(',', '.')) ?? 0;
    final canOffer = parsed > 0 && parsed < p;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Make an offer'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox.square(
                  dimension: 56,
                  child: widget.thumbUrl == null
                      ? const ColoredBox(color: Color(0xFFEFEFEF))
                      : Image.network(widget.thumbUrl!, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.productTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Item price: €${p.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              _PresetCard(
                label: '€${tenOff.toStringAsFixed(2)}',
                sub: '10% off',
                selected: _selectedPreset == 0,
                onTap: () => _applyPreset(tenOff, 0),
              ),
              const SizedBox(width: 12),
              _PresetCard(
                label: '€${twentyOff.toStringAsFixed(2)}',
                sub: '20% off',
                selected: _selectedPreset == 1,
                onTap: () => _applyPreset(twentyOff, 1),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PresetCard(
                  label: 'Custom',
                  sub: 'Set a price',
                  selected: _selectedPreset == 2,
                  onTap: () => setState(() => _selectedPreset = 2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _priceCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              prefixText: '€',
              border: UnderlineInputBorder(),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 6),
          Text(
            '€${(parsed * 1.09).toStringAsFixed(2)} incl. Buyer Protection fee',
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 24),
          Text(
            '25 offers left for today.',
            style: TextStyle(color: Colors.grey[700]),
          ),
        ],
      ),

      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: FilledButton(
            onPressed: canOffer
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Offer sent: €${parsed.toStringAsFixed(2)} (mock)',
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  }
                : null,
            child: const Text('Offer'),
          ),
        ),
      ),
    );
  }
}

class _PresetCard extends StatelessWidget {
  const _PresetCard({
    required this.label,
    required this.sub,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String sub;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? cs.primary : cs.outline,
              width: selected ? 2 : 1,
            ),
            color: selected ? cs.primary.withOpacity(.06) : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(sub, style: const TextStyle(color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }
}
