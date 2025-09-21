import 'package:flutter/material.dart';
import 'package:flutter_okr/pages/sell_page.dart';
import 'package:flutter_okr/pages/view_my_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: false),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          _ProfileHeader(
            username: 'theslyman',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const ProfileDetailPage(username: 'theslyman'),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          const _BadgesCard(completed: 0, total: 2),
          const SizedBox(height: 16),
          _SellBanner(
            onListNow: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SellPage()));
            },
          ),
          const SizedBox(height: 16),

          _tile(context, icon: Icons.favorite_border, title: 'Favourite Items'),
          _divider(),
          _tile(
            context,
            icon: Icons.lightbulb_outline,
            title: 'Insights',
            trailingText: '€0.00',
          ),
          _divider(),
          _tile(
            context,
            icon: Icons.account_balance_wallet_outlined,
            title: 'Balance',
            trailingText: '€0.00',
          ),
          _divider(),
          _tile(context, icon: Icons.receipt_long_outlined, title: 'My orders'),
          _divider(),
          _tile(context, icon: Icons.tune_outlined, title: 'Personalisation'),

          const SizedBox(height: 24),

          _tile(
            context,
            icon: Icons.local_offer_outlined,
            title: 'Bundle discounts',
            trailingText: 'Off',
          ),
          _divider(),
          _tile(
            context,
            icon: Icons.beach_access_outlined,
            title: 'Holiday mode',
          ),
          _divider(),
          _tile(
            context,
            icon: Icons.menu_book_outlined,
            title: 'Your guide to Okrika',
          ),
          _divider(),
          _tile(context, icon: Icons.help_outline, title: 'Help Centre'),
          _divider(),
          _tile(
            context,
            icon: Icons.sentiment_satisfied_outlined,
            title: 'Send your feedback',
          ),
          _divider(),
          _tile(context, icon: Icons.settings_outlined, title: 'Settings'),
          _divider(),
          _tile(context, icon: Icons.info_outline, title: 'About Okrika'),
          _divider(),
          _tile(
            context,
            icon: Icons.gavel_outlined,
            title: 'Legal information',
          ),
          _divider(),
          _tile(context, icon: Icons.apps_outlined, title: 'Our platform'),

          const SizedBox(height: 24),

          // FOOTER LINKS
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 8,
              children: [
                _footerLink('Privacy Centre', () {}),
                _footerLink('Terms & Conditions', () {}),
                _footerLink('Okrika Pro Terms and Conditions', () {}),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  static Widget _divider() => const Divider(height: 1);
}

/// Tapable header
class _ProfileHeader extends StatelessWidget {
  final String username;
  final VoidCallback onTap;
  const _ProfileHeader({required this.username, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: cs.primaryContainer,
            child: Text(
              username.isNotEmpty ? username[0].toUpperCase() : '?',
              style: TextStyle(
                color: cs.onPrimaryContainer,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'View my profile',
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

class _BadgesCard extends StatelessWidget {
  final int completed;
  final int total;
  const _BadgesCard({required this.completed, required this.total});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.verified_outlined),
            SizedBox(width: 12),
            Expanded(child: Text('Badges')),
            Text('0 of 2'),
          ],
        ),
      ),
    );
  }
}

class _SellBanner extends StatelessWidget {
  final VoidCallback onListNow;
  const _SellBanner({required this.onListNow});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF18244E),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Text block
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sell an item',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Earn cash from the things you don’t need',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: onListNow,
                  style: FilledButton.styleFrom(
                    backgroundColor: cs.tertiary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('List now'),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Image placeholder stack (phone case + plus)
          SizedBox(
            width: 96,
            height: 72,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.image, color: Colors.white70),
                  ),
                ),
                Positioned(
                  right: -4,
                  bottom: -4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add, size: 18, color: cs.primary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _tile(
  BuildContext context, {
  required IconData icon,
  required String title,
  String? trailingText,
  VoidCallback? onTap,
}) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (trailingText != null)
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Text(
              trailingText,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        const Icon(Icons.chevron_right),
      ],
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
    onTap: onTap,
  );
}

Widget _footerLink(String text, VoidCallback onTap) => TextButton(
  onPressed: onTap,
  child: Text(text, textAlign: TextAlign.center),
);
