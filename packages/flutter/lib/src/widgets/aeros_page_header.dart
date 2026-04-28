import 'package:flutter/material.dart';
import '../theme/aeros_theme_extension.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';
import 'aeros_breadcrumb.dart';

/// Compound page header used at the top of every admin screen.
/// Composes: optional breadcrumbs row, then a title row (leading +
/// title + subtitle + action buttons).
///
/// ```dart
/// AerosPageHeader(
///   breadcrumbs: [
///     AerosBreadcrumbItem('Home', onTap: ...),
///     AerosBreadcrumbItem('Masters', onTap: ...),
///     AerosBreadcrumbItem('Industries'),
///   ],
///   title: 'Industries',
///   subtitle: 'Manage the industries available to organisations',
///   actions: [
///     AerosButton(label: 'Export', onPressed: ..., variant: AerosButtonVariant.secondary),
///     AerosButton(label: 'Add', onPressed: ...),
///   ],
/// );
/// ```
class AerosPageHeader extends StatelessWidget {
  const AerosPageHeader({
    super.key,
    this.title,
    this.titleWidget,
    this.subtitle,
    this.subtitleWidget,
    this.breadcrumbs,
    this.leading,
    this.actions,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AerosSpacing.s4,
      vertical: AerosSpacing.s4,
    ),
  }) : assert(title != null || titleWidget != null,
            'Provide either title or titleWidget');

  /// Title string. If you need richer content, use [titleWidget] instead.
  final String? title;

  /// Custom title widget. Takes precedence over [title].
  final Widget? titleWidget;

  /// One-line description shown below the title.
  final String? subtitle;

  /// Custom subtitle widget. Takes precedence over [subtitle].
  final Widget? subtitleWidget;

  /// Optional breadcrumb trail rendered above the title row.
  final List<AerosBreadcrumbItem>? breadcrumbs;

  /// Optional widget shown to the left of the title (e.g. back button).
  final Widget? leading;

  /// Right-aligned action buttons.
  final List<Widget>? actions;

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final a = context.aerosColors;

    final titleNode = titleWidget ??
        Text(
          title!,
          style: AerosTypography.h2(color: a.fgPrimary),
        );

    final subtitleNode = subtitleWidget ??
        (subtitle != null
            ? Text(
                subtitle!,
                style: AerosTypography.bodyMd(color: a.fgSecondary),
              )
            : null);

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (breadcrumbs != null && breadcrumbs!.isNotEmpty) ...[
            AerosBreadcrumb(items: breadcrumbs!),
            const SizedBox(height: AerosSpacing.s2),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: AerosSpacing.s3),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    titleNode,
                    if (subtitleNode != null) ...[
                      const SizedBox(height: AerosSpacing.s1),
                      subtitleNode,
                    ],
                  ],
                ),
              ),
              if (actions != null && actions!.isNotEmpty) ...[
                const SizedBox(width: AerosSpacing.s4),
                Wrap(
                  spacing: AerosSpacing.s2,
                  runSpacing: AerosSpacing.s2,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: actions!,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
