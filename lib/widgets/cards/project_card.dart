import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/theme/app_colors.dart';
import '../buttons/primary_button.dart';
import '../buttons/outline_button.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? githubUrl;
  final String? liveDemoUrl;
  final bool isFeatured;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    this.playStoreUrl,
    this.appStoreUrl,
    this.githubUrl,
    this.liveDemoUrl,
    this.isFeatured = false,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  Future<void> _launchUrl(String? urlString) async {
    if (urlString == null) return;
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _buildMobileChip({
    required Widget icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.appStoreUrl != null) {
          _launchUrl(widget.appStoreUrl);
        } else if (widget.playStoreUrl != null) {
          _launchUrl(widget.playStoreUrl);
        } else if (widget.liveDemoUrl != null) {
          _launchUrl(widget.liveDemoUrl);
        } else if (widget.githubUrl != null) {
          _launchUrl(widget.githubUrl);
        }
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [
                  BoxShadow(
                    color: ResponsiveBreakpoints.of(context).isMobile
                        ? AppColors.primary.withValues(alpha: 0.15)
                        : Colors.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
          border: Border.all(
            color: isHovered
                ? AppColors.primary.withValues(alpha: 0.5)
                : Colors.transparent,
            width: 1,
          ),
        ),
        transform: isHovered
            ? Matrix4.translationValues(0.0, -8.0, 0.0)
            : Matrix4.identity(),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image Section — fixed height
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // The actual project image — vivid, no darkening
                  AnimatedScale(
                    duration: const Duration(milliseconds: 500),
                    scale: isHovered ? 1.08 : 1.0,
                    child: widget.imageUrl.startsWith('http')
                        ? Image.network(widget.imageUrl, fit: BoxFit.cover)
                        : Image.asset(widget.imageUrl, fit: BoxFit.cover),
                  ),
                  // Subtle bottom gradient — doesn't wash out image
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.55),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Featured Project Badge
                  if (widget.isFeatured)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.5),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: 14,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Featured',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  // Action buttons — appears on hover (desktop)
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isHovered ? 1.0 : 0.0,
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.5),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Center(
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.center,
                          children: [
                            if (widget.playStoreUrl != null)
                              PrimaryButton(
                                text: 'Google Play',
                                icon: const FaIcon(
                                  FontAwesomeIcons.googlePlay,
                                  size: 15,
                                ),
                                onPressed: () =>
                                    _launchUrl(widget.playStoreUrl),
                              ),
                            if (widget.appStoreUrl != null)
                              PrimaryButton(
                                text: 'App Store',
                                icon: const FaIcon(
                                  FontAwesomeIcons.appStore,
                                  size: 15,
                                ),
                                onPressed: () =>
                                    _launchUrl(widget.appStoreUrl),
                              ),
                            if (widget.liveDemoUrl != null)
                              PrimaryButton(
                                text: 'Live Demo',
                                icon: const Icon(Icons.open_in_new, size: 15),
                                onPressed: () =>
                                    _launchUrl(widget.liveDemoUrl),
                              ),
                            if (widget.githubUrl != null)
                              OutlineButton(
                                text: 'GitHub',
                                icon: const FaIcon(
                                  FontAwesomeIcons.github,
                                  size: 15,
                                ),
                                onPressed: () => _launchUrl(widget.githubUrl),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Mobile: Action chips at bottom right (always visible on mobile)
                  Positioned(
                    bottom: 10,
                    right: 12,
                    left: 12,
                    child: Builder(
                      builder: (context) {
                        final isMobile =
                            ResponsiveBreakpoints.of(context).isMobile;
                        if (!isMobile) return const SizedBox.shrink();
                        return Align(
                          alignment: Alignment.bottomRight,
                          child: Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            alignment: WrapAlignment.end,
                            children: [
                              if (widget.playStoreUrl != null)
                                _buildMobileChip(
                                  icon: const FaIcon(
                                    FontAwesomeIcons.googlePlay,
                                    size: 11,
                                    color: Colors.white,
                                  ),
                                  label: 'Google Play',
                                  onTap: () =>
                                      _launchUrl(widget.playStoreUrl),
                                ),
                              if (widget.appStoreUrl != null)
                                _buildMobileChip(
                                  icon: const FaIcon(
                                    FontAwesomeIcons.appStore,
                                    size: 11,
                                    color: Colors.white,
                                  ),
                                  label: 'App Store',
                                  onTap: () =>
                                      _launchUrl(widget.appStoreUrl),
                                ),
                              if (widget.liveDemoUrl != null)
                                _buildMobileChip(
                                  icon: const Icon(
                                    Icons.open_in_new,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                  label: 'Demo',
                                  onTap: () =>
                                      _launchUrl(widget.liveDemoUrl),
                                ),
                              if (widget.githubUrl != null)
                                _buildMobileChip(
                                  icon: const FaIcon(
                                    FontAwesomeIcons.github,
                                    size: 11,
                                    color: Colors.white,
                                  ),
                                  label: 'GitHub',
                                  onTap: () =>
                                      _launchUrl(widget.githubUrl),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Info Section — natural height
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.technologies
                        .map(
                          (tech) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              tech,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
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
