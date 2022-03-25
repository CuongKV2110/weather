import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:weather/presentation/bloc/cubit/weather_cubit.dart';
import 'package:weather/presentation/pages/home_screen.dart';

import 'generated/l10n.dart';
import 'injection.dart';

void main() async {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WeatherCubit weatherCubit = getIt();
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BlocProvider(
            create: (context) => weatherCubit,
            child: const HomeScreen(),
          ),
          locale: const Locale('en'),
          localizationsDelegates: const [
            S.delegate,
            FallbackCupertinoLocalisationsDelegate(),
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: S.delegate.supportedLocales,
        );
      },
    );
  }
}

class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return true;
  }

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    return DefaultMaterialLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<MaterialLocalizations> old) {
    return false;
  }
}
