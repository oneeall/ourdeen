import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasources/alquran_cloud_api.dart';
import 'data/repositories/alquran_cloud_repository_impl.dart';
import 'domain/repositories/alquran_cloud_repository.dart';
import 'alquran_cloud_service.dart';

/// Provider setup for AlquranCloud service.
///
/// Wraps the app with providers for API client, repository, and service.
/// Must be placed at the root of the widget tree.
class AlquranCloudProvider extends StatelessWidget {
  final Widget child;

  const AlquranCloudProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        final prefs = snapshot.data!;

        return MultiProvider(
          providers: [
            Provider<AlquranCloudApi>(
              create: (_) => AlquranCloudApi(),
            ),

            Provider<AlquranCloudRepository>(
              create: (context) => AlquranCloudRepositoryImpl(
                api: context.read<AlquranCloudApi>(),
                prefs: prefs,
              ),
            ),

            Provider<AlquranCloudService>(
              create: (context) => AlquranCloudService(
                context.read<AlquranCloudRepository>(),
              ),
            ),
          ],
          child: child,
        );
      },
    );
  }
}
