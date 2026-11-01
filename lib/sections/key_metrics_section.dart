import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../core/data/portfolio_data.dart';
import '../../core/models/portfolio_models.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/icon_helper.dart';

class KeyMetricsSection extends StatelessWidget {
  const KeyMetricsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    final stats = PortfolioData.stats;

    if (stats.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
        vertical: isMobile ? 24 : 40,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final count = stats.length;
              double cardWidth;
              if (isMobile) {
                cardWidth = (constraints.maxWidth - 16) / 2;
              } else if (isTablet) {
                cardWidth = (constraints.maxWidth - 20) / 2;
              } else {
                final desktopCols = count.clamp(1, 5);
                cardWidth =
                    (constraints.maxWidth - (20 * (desktopCols - 1))) /
                        desktopCols;
              }

              return Wrap(
                spacing: isMobile ? 16 : 20,
                runSpacing: isMobile ? 16 : 20,
                alignment: WrapAlignment.center,
                children: stats.asMap().entries.map((entry) {
                  final index = entry.key;
                  final stat = entry.value;

                  final isLastOnMobileOdd = isMobile &&
                      stats.length.isOdd &&
                      index == stats.length - 1;

                  return SizedBox(
                    width: isLastOnMobileOdd ? constraints.maxWidth : cardWidth,
                    child: _MetricCard(
                      stat: stat,
                      isWide: isLastOnMobileOdd,
                    )
                        .animate(delay: (100 * index).ms)
                        .fadeIn(duration: 500.ms)
                        .slideY(begin: 0.25, end: 0)
                        .scale(begin: const Offset(0.9, 0.9)),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MetricCard extends StatefulWidget {
  final StatModel stat;
  final bool isWide;

  const _MetricCard({
    required this.stat,
    this.isWide = false,
  });

  @override
  State<_MetricCard> createState() => _MetricCardState();
}

class _MetricCardState extends State<_MetricCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -6.0 : 0.0),
        padding: EdgeInsets.symmetric(
          horizontal: widget.isWide ? 24 : 16,
          vertical: isMobile ? 20 : 24,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDark
              ? (_isHovered
                  ? const Color(0xFF1E293B).withValues(alpha: 0.95)
                  : const Color(0xFF0F172A).withValues(alpha: 0.75))
              : (_isHovered ? Colors.white : Colors.white.withValues(alpha: 0.85)),
          border: Border.all(
            color: _isHovered
                ? AppColors.secondary.withValues(alpha: 0.8)
                : AppColors.primary.withValues(alpha: 0.2),
            width: _isHovered ? 1.8 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.35)
                  : AppColors.primary.withValues(alpha: 0.08),
              blurRadius: _isHovered ? 24 : 12,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon Pill
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: _isHovered
                      ? [
                          AppColors.secondary.withValues(alpha: 0.3),
                          AppColors.primary.withValues(alpha: 0.3),
                        ]
                      : [
                          AppColors.primary.withValues(alpha: 0.15),
                          AppColors.secondary.withValues(alpha: 0.08),
                        ],
                ),
              ),
              child: FaIcon(
                IconHelper.getIcon(widget.stat.icon),
                size: isMobile ? 22 : 26,
                color: _isHovered ? AppColors.secondary : AppColors.primary,
              ),
            ),
            const SizedBox(height: 14),

            // Number Stat
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: _isHovered
                    ? [Colors.white, AppColors.secondary]
                    : [AppColors.secondary, AppColors.primary],
              ).createShader(bounds),
              child: Text(
                widget.stat.title,
                style: TextStyle(
                  fontSize: isMobile ? 28 : 34,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -0.5,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 6),

            // Subtitle
            Text(
              widget.stat.subtitle,
              style: TextStyle(
                fontSize: isMobile ? 12 : 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

