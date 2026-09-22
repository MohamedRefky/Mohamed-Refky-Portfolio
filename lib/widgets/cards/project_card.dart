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

  Widget _buildActionBtn({
    required String text,
    required Widget icon,
    required VoidCallback onTap,
    bool isPrimary = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          gradient: isPrimary ? AppColors.primaryGradient : null,
          color: isPrimary ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isPrimary
              ? null
              : Border.all(color: AppColors.primary, width: 1.5),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(
                color: isPrimary ? Colors.white : AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
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
        constraints: BoxConstraints(
          minHeight: ResponsiveBreakpoints.of(context).isMobile ? 0 : 470,
        ),
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
            // Image Section — responsive 16:9 ratio, complete and uncropped
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: const Color(0xFF0F172A),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // The actual project image — vivid, complete without cropping
                    AnimatedScale(
                      duration: const Duration(milliseconds: 500),
                      scale: isHovered ? 1.04 : 1.0,
                      child: widget.imageUrl.startsWith('http')
                          ? Image.network(
                              widget.imageUrl,
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                            )
                          : Image.asset(
                              widget.imageUrl,
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                            ),
                    ),
                    // Subtle bottom gradient for mobile chip readability
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.4),
                              Colors.transparent,
                            ],
                          ),
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
                ],
              ),
            ),
          ),

            // Info Section — natural height
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Builder(
                builder: (context) {
                  final isMobile =
                      ResponsiveBreakpoints.of(context).isMobile;
                  final isTablet =
                      ResponsiveBreakpoints.of(context).isTablet;
                  final isTouchDevice = isMobile || isTablet;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: isMobile ? 0 : 54,
                        ),
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: isMobile ? 0 : 68,
                        ),
                        child: Text(
                          widget.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
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
                      if (isTouchDevice) ...[
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            if (widget.playStoreUrl != null)
                              _buildActionBtn(
                                text: 'Google Play',
                                icon: const FaIcon(
                                  FontAwesomeIcons.googlePlay,
                                  size: 13,
                                  color: Colors.white,
                                ),
                                isPrimary: true,
                                onTap: () => _launchUrl(widget.playStoreUrl),
                              ),
                            if (widget.appStoreUrl != null)
                              _buildActionBtn(
                                text: 'App Store',
                                icon: const FaIcon(
                                  FontAwesomeIcons.appStore,
                                  size: 13,
                                  color: Colors.white,
                                ),
                                isPrimary: true,
                                onTap: () => _launchUrl(widget.appStoreUrl),
                              ),
                            if (widget.liveDemoUrl != null)
                              _buildActionBtn(
                                text: 'Live Demo',
                                icon: const Icon(
                                  Icons.open_in_new,
                                  size: 14,
                                  color: Colors.white,
                                ),
                                isPrimary: true,
                                onTap: () => _launchUrl(widget.liveDemoUrl),
                              ),
                            if (widget.githubUrl != null)
                              _buildActionBtn(
                                text: 'GitHub',
                                icon: const FaIcon(
                                  FontAwesomeIcons.github,
                                  size: 13,
                                  color: AppColors.primary,
                                ),
                                isPrimary: false,
                                onTap: () => _launchUrl(widget.githubUrl),
                              ),
                          ],
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
