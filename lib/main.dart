import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_weather/presentation/weather_screen.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
// }

// class _MyAppState extends ConsumerState<MyApp> {
//   @override
//   void initState() {
// ignore: todo
//     // TODO: implement initState
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       final value = await ref.read(apiClientProvider).getWeather('Zagreb');
//       print(value);
//     });
//   }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: WeatherScreen(),
    );
  }
}
