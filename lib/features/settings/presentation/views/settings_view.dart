import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ourdeen/features/tajweed/presentation/viewmodels/tajweed_viewmodel.dart';
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
