import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_weather/domain/notifiers/weather_state_notifier.dart';
import 'package:new_weather/presentation/search_bar.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final state = ref.watch(weatherValueProvider);

    return Scaffold(
      appBar: AppBar(
        title: const SearchBar(),
      ),
      //tu raspakiravam liniju 13
      body: state.when(
        loaded: (data) => Container(
          alignment: Alignment.center,
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(data.cityName),
                  Text(data.countryName),
                  Text(
                    data.tempC.toString(),
                  ),
                  // Image.network(
                  //   '${data.current.condition.icon}',
                  // ),
                  Image.network(
                    //http dodati u mapper
                    data.icon,
                    errorBuilder: (context, error, stackTrace) =>
                        const Text('ne radi slika'),
                    width: 64,
                    height: 64,
                  ),
                  Text(data.text)
                ],
              ),
            ],
          ),
        ),
        failure: (failure) {
          return Text(failure.error.toString());
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        initial: () {
          return const Center(
              child: Text('Enter city name to start using the app!'));
        },
        empty: () => const Center(
          child: Text('Insert city name in search bar!'),
        ),
      ),
    );
  }
}
