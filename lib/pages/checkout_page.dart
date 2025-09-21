// lib/pages/checkout_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_okr/models/product.dart';
import 'package:flutter_okr/pages/product_page.dart' show Product;

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key, required this.product});
  final Product product;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

enum DeliveryOption { pickupPoint, home }

class _CheckoutPageState extends State<CheckoutPage> {
  // --- Fake user data (edit sheets will change these) ---
  String _fullAddress =
      'Sulaiman BELLO\n31 Abiodun Street, Appartment 303\n23401, Lagos';
  String _phone = '+2348077777777';
  String _card = 'Visa ending with 8888';

  // --- Options / fees (tweak freely) ---
  DeliveryOption _option = DeliveryOption.pickupPoint;
  static const double _buyerProtectionFee = 1.45;
  static const double _shipPickup = 2.79;
  static const double _shipHome = 4.38;

  double get _shipping =>
      _option == DeliveryOption.pickupPoint ? _shipPickup : _shipHome;

  double get _order => widget.product.price;
  double get _total => _order + _buyerProtectionFee + _shipping;

  // ----------------- simple editors -----------------
  Future<void> _editAddress() async {
    final ctrl = TextEditingController(text: _fullAddress);
    final res = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (c) => _EditSheet(
        title: 'Edit address',
        child: TextField(
          controller: ctrl,
          minLines: 4,
          maxLines: 8,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Type your address…',
          ),
        ),
        onSave: () => Navigator.pop(c, ctrl.text.trim()),
      ),
    );
    if (res != null && res.isNotEmpty) setState(() => _fullAddress = res);
  }

  Future<void> _editPhone() async {
    final ctrl = TextEditingController(text: _phone);
    final res = await showModalBottomSheet<String>(
      context: context,
      builder: (c) => _EditSheet(
        title: 'Contact number',
        child: TextField(
          controller: ctrl,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: '+234 …',
          ),
        ),
        onSave: () => Navigator.pop(c, ctrl.text.trim()),
      ),
    );
    if (res != null && res.isNotEmpty) setState(() => _phone = res);
  }

  Future<void> _editCard() async {
    final ctrl = TextEditingController(text: _card);
    final res = await showModalBottomSheet<String>(
      context: context,
      builder: (c) => _EditSheet(
        title: 'Payment method',
        child: TextField(
          controller: ctrl,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'e.g. Visa ending with 4308',
          ),
        ),
        onSave: () => Navigator.pop(c, ctrl.text.trim()),
      ),
    );
    if (res != null && res.isNotEmpty) setState(() => _card = res);
  }

  // ----------------- UI -----------------
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 140),
        children: [
          // Item summary
          _section(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.product.images.first,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 120,
                      height: 120,
                      color: Colors.black12,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.title,
                          style: t.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(widget.product.brand, style: t.bodyMedium),
                        Text(widget.product.size, style: t.bodyMedium),
                        const SizedBox(height: 10),
                        Text(
                          '€${_order.toStringAsFixed(2)}',
                          style: t.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Address
          _header('Address'),
          _section(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(_fullAddress),
              trailing: IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: _editAddress,
              ),
            ),
          ),

          // Delivery option
          _header('Delivery option'),
          _section(
            child: Column(
              children: [
                RadioListTile<DeliveryOption>(
                  value: DeliveryOption.pickupPoint,
                  groupValue: _option,
                  onChanged: (v) => setState(() => _option = v!),
                  title: const Text('Ship to pick-up point'),
                  subtitle: const Text('From €2.79'),
                  secondary: _option == DeliveryOption.pickupPoint
                      ? const Icon(Icons.check_circle, color: Colors.teal)
                      : null,
                ),
                const Divider(height: 1),
                RadioListTile<DeliveryOption>(
                  value: DeliveryOption.home,
                  groupValue: _option,
                  onChanged: (v) => setState(() => _option = v!),
                  title: const Text('Ship to home'),
                  subtitle: const Text('€4.38'),
                ),
              ],
            ),
          ),

          // Delivery details (changes by option)
          _header('Delivery details'),
          _section(
            child: _option == DeliveryOption.pickupPoint
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _badgeRow(
                        'Vinted Go',
                        '€${_shipPickup.toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 8),
                      _detailLine(
                        Icons.store_mall_directory_outlined,
                        'P. Prescillia',
                      ),
                      _detailLine(
                        Icons.location_on_outlined,
                        '30 Rue de Castille, 80000, Amiens',
                      ),
                      _detailLine(
                        Icons.access_time,
                        'At pick-up point in 5 - 7 business days',
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _badgeRow(
                        'Home delivery',
                        '€${_shipHome.toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 8),
                      _detailLine(Icons.home_outlined, 'Ship to home'),
                      _detailLine(Icons.access_time, '3 – 5 business days'),
                    ],
                  ),
          ),

          // Contact
          _header('Your contact details'),
          _section(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(_phone),
              trailing: IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: _editPhone,
              ),
            ),
          ),

          // Payment
          _header('Payment'),
          _section(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.credit_card),
              title: Text(_card),
              trailing: IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: _editCard,
              ),
            ),
          ),

          // Price summary
          _header('Price summary'),
          _section(
            child: Column(
              children: [
                _priceRow('Order', _order),
                _priceRow(
                  'Buyer Protection fee',
                  _buyerProtectionFee,
                  info: true,
                ),
                _priceRow('Shipping', _shipping),
              ],
            ),
          ),
        ],
      ),

      // Sticky bottom total + Pay
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.06),
                blurRadius: 12,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Total line
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Total to pay',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    '€${_total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Payment flow not implemented (demo).'),
                      ),
                    );
                  },
                  child: const Text('Pay'),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.lock, size: 16, color: cs.onSurfaceVariant),
                  const SizedBox(width: 6),
                  Text(
                    'Your payment details are encrypted and secure',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- tiny helpers ----------
  Widget _header(String text) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
    child: Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    ),
  );

  Widget _section({required Widget child}) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: child,
    ),
  );

  Widget _detailLine(IconData icon, String text) => Padding(
    padding: const EdgeInsets.only(top: 6),
    child: Row(
      children: [
        Icon(icon, size: 18, color: Colors.black54),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    ),
  );

  Widget _badgeRow(String left, String right) => Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.teal.withOpacity(.12),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.verified, size: 16, color: Colors.teal),
            const SizedBox(width: 6),
            Text(left),
          ],
        ),
      ),
      const Spacer(),
      Text(right, style: const TextStyle(fontWeight: FontWeight.w600)),
    ],
  );

  Widget _priceRow(String label, double value, {bool info = false}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text(label),
              if (info) ...[
                const SizedBox(width: 6),
                const Icon(Icons.info_outline, size: 16, color: Colors.grey),
              ],
            ],
          ),
        ),
        Text('€${value.toStringAsFixed(2)}'),
      ],
    ),
  );
}

// Simple reusable bottom-sheet editor
class _EditSheet extends StatelessWidget {
  const _EditSheet({
    required this.title,
    required this.child,
    required this.onSave,
  });

  final String title;
  final Widget child;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final viewInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 16 + viewInset,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          child,
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(onPressed: onSave, child: const Text('Save')),
          ),
        ],
      ),
    );
  }
}
