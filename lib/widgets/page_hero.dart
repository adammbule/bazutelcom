import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PageHero extends StatelessWidget {
  final String title;
  final Widget? titleWidget;
  final String? subtitle;
  final List<Widget>? actions;
  final bool compact;

  const PageHero({
    super.key,
    required this.title,
    this.titleWidget,
    this.subtitle,
    this.actions,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isNarrow = width < 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isNarrow ? 24 : 48,
        vertical: compact ? 48 : (isNarrow ? 56 : 80),
      ),
      decoration: AppTheme.heroGradient,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              if (titleWidget != null)
                DefaultTextStyle(
                  style:
                      Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontSize: isNarrow ? 32 : 48,
                      ) ??
                      const TextStyle(color: Colors.white, fontSize: 48),
                  textAlign: TextAlign.center,
                  child: titleWidget!,
                )
              else
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontSize: isNarrow ? 32 : 48,
                  ),
                ),
              if (subtitle != null) ...[
                const SizedBox(height: 16),
                Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: isNarrow ? 16 : 18,
                  ),
                ),
              ],
              if (actions != null && actions!.isNotEmpty) ...[
                const SizedBox(height: 32),
                Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: actions!,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
