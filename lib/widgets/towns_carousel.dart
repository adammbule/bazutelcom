import 'dart:async';
import 'package:flutter/material.dart';
import '../models/town_location.dart';
import '../theme/app_theme.dart';

class TownsCarousel extends StatefulWidget {
  const TownsCarousel({super.key});

  @override
  State<TownsCarousel> createState() => _TownsCarouselState();
}

class _TownsCarouselState extends State<TownsCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.85);
  Timer? _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || !_controller.hasClients) return;
      final next = (_currentPage + 1) % TownLocation.all.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void _goToPage(int page) {
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final showArrows = width >= 700;

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: TownLocation.all.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final town = TownLocation.all[index];
                  final isActive = index == _currentPage;
                  return AnimatedScale(
                    scale: isActive ? 1.0 : 0.92,
                    duration: const Duration(milliseconds: 300),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: _TownCard(town: town),
                    ),
                  );
                },
              ),
              if (showArrows) ...[
                Positioned(
                  left: 0,
                  child: _CarouselArrow(
                    icon: Icons.chevron_left,
                    onPressed: () {
                      final prev = _currentPage == 0
                          ? TownLocation.all.length - 1
                          : _currentPage - 1;
                      _goToPage(prev);
                    },
                  ),
                ),
                Positioned(
                  right: 0,
                  child: _CarouselArrow(
                    icon: Icons.chevron_right,
                    onPressed: () {
                      final next =
                          (_currentPage + 1) % TownLocation.all.length;
                      _goToPage(next);
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(TownLocation.all.length, (index) {
            final isActive = index == _currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive ? AppColors.accent : AppColors.border,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _TownCard extends StatelessWidget {
  final TownLocation town;

  const _TownCard({required this.town});

  @override
  Widget build(BuildContext context) {
    final isActive = town.status == TownStatus.active;

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: isActive
            ? AppTheme.heroGradient.gradient
            : null,
        color: isActive ? null : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isActive ? null : Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: isActive ? 0.2 : 0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.white.withValues(alpha: 0.2)
                  : AppColors.accentSoft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.location_city,
              color: isActive ? Colors.white : AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      town.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: isActive ? Colors.white : AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(width: 10),
                    _StatusChip(status: town.status, inverted: isActive),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  town.region,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isActive
                            ? Colors.white.withValues(alpha: 0.8)
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  town.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isActive
                            ? Colors.white.withValues(alpha: 0.9)
                            : AppColors.textSecondary,
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

class _StatusChip extends StatelessWidget {
  final TownStatus status;
  final bool inverted;

  const _StatusChip({required this.status, this.inverted = false});

  @override
  Widget build(BuildContext context) {
    final isActive = status == TownStatus.active;
    final label = isActive ? 'Active' : 'Coming Soon';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: inverted
            ? Colors.white.withValues(alpha: 0.2)
            : (isActive ? AppColors.accentSoft : AppColors.surfaceAlt),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: inverted
                  ? Colors.white
                  : (isActive ? AppColors.primary : AppColors.textSecondary),
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _CarouselArrow extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _CarouselArrow({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: AppColors.primary.withValues(alpha: 0.15),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
      ),
    );
  }
}
