import 'package:flutter/material.dart';
import 'package:home1/core/di/injection.dart';
import 'package:home1/core/service/storage_service/storage_service.dart';
import 'package:home1/features/auth/ui/presentation/auth_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const _items = [
    'ACCOUNT',
    'SETTINGS',
    'ORDER PREFERENCES',
    'LOGOUT',
  ];

  Future<void> _onLogoutTap(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Вы уверены?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Нет'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Да'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await getIt<StorageService>().clearAuth();
    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const AuthPage()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Preferences',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 24),
              const Divider(height: 1),
              ..._items.map(
                (title) => Column(
                  children: [
                    InkWell(
                      onTap: title == 'LOGOUT'
                          ? () => _onLogoutTap(context)
                          : () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ),
                            const Icon(Icons.chevron_right, size: 18),
                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}