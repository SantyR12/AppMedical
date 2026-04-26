import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/router.dart';
import 'core/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    // ProviderScope es obligatorio para Riverpod — envuelve toda la app
    const ProviderScope(
      child: SgpApp(),
    ),
  );
}

class SgpApp extends ConsumerWidget {
  const SgpApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'SGP — Sistema de Gestión de Pacientes',
      debugShowCheckedModeBanner: false,

      // Tema visual
      theme: SgpTheme.lightTheme,
      darkTheme: SgpTheme.darkTheme,
      themeMode: ThemeMode.system,

      // Localización en español (Colombia)
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'CO'),
        Locale('en'),
      ],
      locale: const Locale('es', 'CO'),

      // Navegación con go_router
      routerConfig: router,
    );
  }
}
