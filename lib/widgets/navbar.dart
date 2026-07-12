import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({super.key});

  static const _navItems = [
    ('Home', '/'),
    ('Products', '/products'),
    ('Services', '/services'),
    ('About', '/about'),
    ('Careers', '/careers'),
    ('Contact', '/contact'),
  ];

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isNarrow = width < 900;
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '/';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        border: const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isNarrow ? 16 : 32,
            vertical: 12,
          ),
          child: Row(
            children: [
              _Logo(onTap: () => Navigator.pushNamed(context, '/')),
              const Spacer(),
              if (isNarrow)
                IconButton(
                  icon: const Icon(Icons.menu_rounded),
                  onPressed: () => _showMobileMenu(context, currentRoute),
                )
              else ...[
                ..._navItems.map(
                  (item) => _NavLink(
                    label: item.$1,
                    route: item.$2,
                    isActive: currentRoute == item.$2,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/contact'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Get Connected'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context, String currentRoute) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ..._navItems.map(
                (item) => ListTile(
                  title: Text(
                    item.$1,
                    style: TextStyle(
                      fontWeight: currentRoute == item.$2
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: currentRoute == item.$2
                          ? AppColors.primary
                          : AppColors.textPrimary,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    Navigator.pushNamed(context, item.$2);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      Navigator.pushNamed(context, '/contact');
                    },
                    child: const Text('Get Connected'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: AppTheme.heroGradient.gradient,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.wifi_tethering,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Bazu Telecom',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final String route;
  final bool isActive;

  const _NavLink({
    required this.label,
    required this.route,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, route),
      style: TextButton.styleFrom(
        foregroundColor: isActive ? AppColors.primary : AppColors.textSecondary,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }
}
