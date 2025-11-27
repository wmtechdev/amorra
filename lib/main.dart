import 'package:flutter/material.dart';
import 'core/config/app_initializer.dart';
import 'presentation/widgets/app/app_material.dart';

void main() async {
  await AppInitializer.initialize();

  runApp(const AmorraApp());
}

class AmorraApp extends StatelessWidget {
  const AmorraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppMaterial();
  }
}
