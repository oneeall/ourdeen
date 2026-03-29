import 'package:flutter/material.dart';

abstract class NotificationService {
  void send(String message);

  factory NotificationService.create(NotificationType notificationType) {
    return switch (notificationType) {
      // TODO: Handle this case.
      NotificationType.email => throw UnimplementedError(),
      // TODO: Handle this case.
      NotificationType.sms => throw UnimplementedError(),
      // TODO: Handle this case.
      NotificationType.push => PushNotificationService(),
    };
  }
}

class PushNotificationService implements NotificationService {
  @override
  void send(String message) {
    print("Push Notification Service : $message");
  }
}

enum AppButtonType { primary, secondary }
/// factory
abstract class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.onTap});

  final VoidCallback onTap;

  factory AppButton.build(AppButtonType type, {required VoidCallback onTap}) {
    return switch (type) {
      AppButtonType.primary => AppButton.red(onTap: onTap),
      AppButtonType.secondary => AppButton.blue(onTap: onTap),
    };
  }

  factory AppButton.red({required VoidCallback onTap}) {
    return ButtonRed(onTap: onTap);
  }

  factory AppButton.blue({required VoidCallback onTap}) {
    return ButtonBlue(onTap: onTap);
  }
}


// use builder
class ButtonBuilder {
  VoidCallback? _onTap;
  AppButtonType? _type;


  set onTap(VoidCallback value) {
    _onTap = value;
  }


  set type(AppButtonType value) {
    _type = value;
  }

  AppButton build() {
    return AppButton.build(_type!, onTap: _onTap!);
  }
}

class ButtonRed extends AppButton {
  const ButtonRed({super.key, required super.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      child: const Text('Red'),
    );
  }
}

class ButtonBlue extends AppButton {
  const ButtonBlue({super.key, required super.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
      child: const Text('Red'),
    );
  }
}

enum NotificationType { email, sms, push }


class ButtonBuilderCompilation {
  ButtonBuilder buttonPrimary;
  ButtonBuilder buttonSecondary;

  ButtonBuilderCompilation(this.buttonPrimary, this.buttonSecondary);
}

// command pattern
