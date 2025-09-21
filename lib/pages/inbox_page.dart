// lib/pages/inbox_page.dart
import 'package:flutter/material.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Inbox'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Messages'),
              Tab(text: 'Notifications'),
            ],
          ),
        ),
        body: const TabBarView(children: [_MessagesTab(), _NotificationsTab()]),
      ),
    );
  }
}

/* -------------------------- Messages tab -------------------------- */

class _MessagesTab extends StatelessWidget {
  const _MessagesTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final conversations = _demoConversations;

    return ListView.separated(
      itemCount: conversations.length + 2 /* banner + spacer row */,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        // 0 -> top banner
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                color: cs.primary.withOpacity(.08),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Icon(Icons.notifications_active_outlined),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text('Get instant mobile notifications'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          );
        }

        // 1 -> spacer (keeps visual rhythm after banner)
        if (index == 1) return const SizedBox.shrink();

        // Items start from 2
        final conv = conversations[index - 2];
        return InkWell(
          onTap: () {
            // TODO: open chat thread
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                CircleAvatar(
                  radius: 26,
                  backgroundImage: conv.avatarUrl != null
                      ? NetworkImage(conv.avatarUrl!)
                      : null,
                  child: conv.avatarUrl == null
                      ? Text(
                          conv.initial,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      : null,
                ),
                const SizedBox(width: 12),

                // Name + snippet (+ optional tiny photo)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name + verified tick (if any)
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              conv.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (conv.verified) ...[
                            const SizedBox(width: 6),
                            Icon(Icons.verified, size: 16, color: cs.primary),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        conv.snippet,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.black54),
                      ),
                      if (conv.thumbUrl != null) ...[
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            conv.thumbUrl!,
                            width: 44,
                            height: 44,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 44,
                              height: 44,
                              color: Colors.black12,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Time ago
                const SizedBox(width: 8),
                Text(
                  _timeAgo(conv.time),
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/* ------------------------ Notifications tab ------------------------ */

class _NotificationsTab extends StatelessWidget {
  const _NotificationsTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 72, color: Colors.black26),
          SizedBox(height: 12),
          Text(
            'No notifications yet',
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

/* ----------------------------- Model ------------------------------ */

class Conversation {
  final String id;
  final String name;
  final String snippet;
  final DateTime time;
  final String? avatarUrl;
  final String? thumbUrl; // small inline image preview
  final bool verified;

  const Conversation({
    required this.id,
    required this.name,
    required this.snippet,
    required this.time,
    this.avatarUrl,
    this.thumbUrl,
    this.verified = false,
  });

  String get initial => name.isNotEmpty ? name[0].toUpperCase() : '?';
}

/* Demo data */
final _demoConversations = <Conversation>[
  Conversation(
    id: '0',
    name: 'Okrika',
    verified: true,
    snippet: 'Earn from old tech accessories',
    time: DateTime.now().subtract(const Duration(days: 2)),
    avatarUrl:
        'https://upload.wikimedia.org/wikipedia/commons/2/26/Vinted_logo.png',
  ),
  Conversation(
    id: '1',
    name: 'adruntri10',
    snippet: 'Chaussure Running Nike Vaporfly NEXT%…',
    time: DateTime.now().subtract(const Duration(days: 27)),
    thumbUrl:
        'https://images.unsplash.com/photo-1519741497674-611481863552?w=400',
    avatarUrl:
        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200',
  ),
  Conversation(
    id: '2',
    name: 'mehdilgm',
    snippet: 'Dr. Martens - Chaussures 1461 Black Sm…',
    time: DateTime.now().subtract(const Duration(days: 35)),
    thumbUrl:
        'https://images.unsplash.com/photo-1517260913691-1f9b7f72b59e?w=400',
    avatarUrl:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
  ),
  Conversation(
    id: '3',
    name: 'martvitt70',
    snippet: 'Grazie mille!',
    time: DateTime.now().subtract(const Duration(days: 120)),
  ),
  Conversation(
    id: '4',
    name: 'wouterstap',
    snippet: 'Gymshark black sweat short. Size M',
    time: DateTime.now().subtract(const Duration(days: 120)),
    avatarUrl:
        'https://images.unsplash.com/photo-1496307042754-b4aa456c4a2d?w=200',
  ),
  Conversation(
    id: '5',
    name: 'ninetysome',
    snippet: 'Pantaloncino a compressione under arm…',
    time: DateTime.now().subtract(const Duration(days: 150)),
    avatarUrl:
        'https://avatars.githubusercontent.com/u/9919?s=200&v=4', // placeholder
  ),
];

/* --------------------------- Utilities ---------------------------- */

String _timeAgo(DateTime time) {
  final diff = DateTime.now().difference(time);
  if (diff.inDays >= 365) {
    final y = (diff.inDays / 365).floor();
    return '$y ${y == 1 ? 'year' : 'years'} ago';
  } else if (diff.inDays >= 30) {
    final m = (diff.inDays / 30).floor();
    return '$m ${m == 1 ? 'month' : 'months'} ago';
  } else if (diff.inDays >= 1) {
    return '${diff.inDays} ${diff.inDays == 1 ? 'day' : 'days'} ago';
  } else if (diff.inHours >= 1) {
    return '${diff.inHours}h ago';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes}m ago';
  } else {
    return 'just now';
  }
}
