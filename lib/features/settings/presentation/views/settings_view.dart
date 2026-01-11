import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ourdeen/features/tajweed/presentation/viewmodels/tajweed_viewmodel.dart';
import 'package:ourdeen/features/quran_reader/presentation/viewmodels/animation_viewmodel.dart';
import 'package:ourdeen/features/quran_reader/domain/entities/animation_preference.dart';
// Import other ViewModels as needed:
// import 'package:ourdeen/features/notifications/presentation/viewmodels/notification_settings_viewmodel.dart';
// import 'package:ourdeen/features/appearance/presentation/viewmodels/theme_viewmodel.dart';

/// Centralized settings page
///
/// This view composes settings from various features by consuming
/// their ViewModels. Each setting is organized by section and
/// implemented as a separate widget for maintainability.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        // Add future actions here (e.g., reset all settings)
      ),
      body: ListView(
        children: [
          // Quran Reading Section
          _buildSectionHeader('Quran Reading'),
          const _TajweedSettingTile(),
          const _AnimationSettingTile(),

          // Future sections can be added here:
          // _SectionHeader('Appearance'),
          // const _ThemeSettingTile(),
          //
          // _SectionHeader('Notifications'),
          // const _NotificationSettingTile(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}

/// Tajweed setting widget - consumes TajweedViewModel
///
/// This widget provides a toggle switch for enabling/disabling
/// Tajweed mode. It displays the current status as a subtitle.
class _TajweedSettingTile extends StatelessWidget {
  const _TajweedSettingTile();

  @override
  Widget build(BuildContext context) {
    return Consumer<TajweedViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isBusy) {
          return const SwitchListTile(
            title: Text('Tajweed Mode'),
            subtitle: Text('Loading...'),
            value: false,
            onChanged: null,
          );
        }

        return SwitchListTile(
          title: const Text('Tajweed Mode'),
          subtitle: Text(
            viewModel.isTajweedEnabled
                ? 'Tajweed is activated'
                : 'Show Tajweed coloration rules',
          ),
          value: viewModel.isTajweedEnabled,
          onChanged: (value) => viewModel.toggleTajweed(value),
        );
      },
    );
  }
}

/// Animation setting widget - consumes AnimationViewModel
///
/// This widget provides a segmented button for choosing between
/// none, smooth (easeOutCubic), and bouncy (elasticOut) animations.
class _AnimationSettingTile extends StatelessWidget {
  const _AnimationSettingTile();

  @override
  Widget build(BuildContext context) {
    return Consumer<AnimationViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isBusy) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Verse Animations', style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text('Loading...'),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verse Animations',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                _getSubtitle(viewModel.curveType),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.7),
                    ),
              ),
              const SizedBox(height: 12),
              SegmentedButton<AnimationCurveType>(
                segments: const [
                  ButtonSegment(
                    value: AnimationCurveType.none,
                    label: Text('None'),
                  ),
                  ButtonSegment(
                    value: AnimationCurveType.smooth,
                    label: Text('Smooth'),
                  ),
                  ButtonSegment(
                    value: AnimationCurveType.bouncy,
                    label: Text('Bouncy'),
                  ),
                ],
                selected: {viewModel.curveType},
                onSelectionChanged: (Set<AnimationCurveType> selected) {
                  viewModel.setAnimationCurve(selected.first);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String _getSubtitle(AnimationCurveType curveType) {
    switch (curveType) {
      case AnimationCurveType.none:
        return 'No animation effect';
      case AnimationCurveType.smooth:
        return 'Smooth cubic easing (better performance)';
      case AnimationCurveType.bouncy:
        return 'Bouncy elastic easing (more playful)';
    }
  }
}

/// Example: Future theme setting widget
// class _ThemeSettingTile extends StatelessWidget {
//   const _ThemeSettingTile();
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ThemeViewModel>(
//       builder: (context, viewModel, child) {
//         return SwitchListTile(
//           title: const Text('Dark Mode'),
//           subtitle: const Text('Use dark theme'),
//           value: viewModel.isDarkMode,
//           onChanged: (value) => viewModel.setDarkMode(value),
//         );
//       },
//     );
//   }
// }
