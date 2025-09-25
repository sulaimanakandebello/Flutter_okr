import 'package:flutter/material.dart';
import 'package:flutter_okr/models/product.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key, required this.product});
  final Product product;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // very simple mock state
  String _delivery = 'Standard';
  String _payment = 'Card';
  bool _buyerProtection = true;

  double get _buyerProtectionFee =>
      _buyerProtection ? 0.09 * widget.product.price : 0.0;
  double get _deliveryFee => _delivery == 'Express' ? 5.99 : 2.79;
  double get _total =>
      widget.product.price + _buyerProtectionFee + _deliveryFee;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;
    final p = widget.product;

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),

      body: ListView(
        padding: const EdgeInsets.only(bottom: 120),
        children: [
          // Item summary
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 60,
                height: 60,
                child: p.images.isEmpty
                    ? const ColoredBox(color: Color(0xFFEFEFEF))
                    : Image.network(p.images.first, fit: BoxFit.cover),
              ),
            ),
            title: Text(p.title, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text('${p.brand} • ${p.size} • ${p.condition}'),
            trailing: Text('€${p.price.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.w700)),
          ),
          const _SectionRule(),

          // Delivery options
          _BlockHeader('Delivery'),
          _BorderCard(
            child: Column(
              children: [
                RadioListTile<String>(
                  value: 'Standard',
                  groupValue: _delivery,
                  onChanged: (v) => setState(() => _delivery = v!),
                  title: const Text('Standard (2–5 days)'),
                  secondary: const Text('€2.79'),
                ),
                const Divider(height: 1),
                RadioListTile<String>(
                  value: 'Express',
                  groupValue: _delivery,
                  onChanged: (v) => setState(() => _delivery = v!),
                  title: const Text('Express (1–2 days)'),
                  secondary: const Text('€5.99'),
                ),
              ],
            ),
          ),
          const _SectionRule(),

          // Address
          _BlockHeader('Delivery address'),
          _BorderCard(
            child: ListTile(
              title: const Text('Add / Select address'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Address picker (mock)')),
                );
              },
            ),
          ),
          const _SectionRule(),

          // Payment
          _BlockHeader('Payment'),
          _BorderCard(
            child: Column(
              children: [
                RadioListTile<String>(
                  value: 'Card',
                  groupValue: _payment,
                  onChanged: (v) => setState(() => _payment = v!),
                  title: const Text('Credit / Debit Card'),
                ),
                const Divider(height: 1),
                RadioListTile<String>(
                  value: 'PayPal',
                  groupValue: _payment,
                  onChanged: (v) => setState(() => _payment = v!),
                  title: const Text('PayPal'),
                ),
              ],
            ),
          ),
          const _SectionRule(),

          // Buyer protection
          _BlockHeader('Buyer protection'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SwitchListTile(
              value: _buyerProtection,
              onChanged: (v) => setState(() => _buyerProtection = v),
              title: const Text('Add Buyer Protection'),
              subtitle: const Text(
                'Covers support, refunds, and secure payments. (9% of item price)',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Order summary
          _BlockHeader('Order summary'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _SummaryRow(label: 'Item', value: p.price),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _SummaryRow(
                label: 'Buyer Protection', value: _buyerProtectionFee),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _SummaryRow(label: 'Delivery', value: _deliveryFee),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(color: Theme.of(context).dividerColor),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              children: [
                const Expanded(
                  child: Text('Total',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ),
                Text(
                  '€${_total.toStringAsFixed(2)}',
                  style: t.titleMedium?.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Pay button
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment (mock)')),
                );
              },
              child: Text('Pay €${_total.toStringAsFixed(2)}'),
            ),
          ),
        ),
      ),
    );
  }
}

/* ========================= shared small widgets ========================= */

class _BlockHeader extends StatelessWidget {
  const _BlockHeader(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
      );
}

class _BorderCard extends StatelessWidget {
  const _BorderCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12), // light grey border
          borderRadius: BorderRadius.circular(12),
        ),
        child: child,
      );
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});
  final String label;
  final double value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Expanded(child: Text(label)),
            Text('€${value.toStringAsFixed(2)}'),
          ],
        ),
      );
}

class _SectionRule extends StatelessWidget {
  const _SectionRule();
  @override
  Widget build(BuildContext context) => Container(
        height: 8,
        color: Theme.of(context).dividerColor.withOpacity(.12),
      );
}
