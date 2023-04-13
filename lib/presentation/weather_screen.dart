import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_weather/domain/notifiers/weather_state_notifier.dart';
import 'package:new_weather/presentation/empty_state_screen.dart';
import 'package:new_weather/presentation/search_bar.dart';

class WeatherScreen extends ConsumerWidget {
  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final state = ref.watch(weatherValueProvider);

    return Scaffold(
      appBar: AppBar(
        title: SearchBar(),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text('${data.location.name}' + ','),
                      // Text(data.location.country.toString()),
                      Text(data.cityName),
                      Text(data.countryName),
                    ],
                  ),
                  Text(
                    data.tempC.toString(),
                  ),
                  // Image.network(
                  //   '${data.current.condition.icon}',
                  // ),
                  Image(
                    //http dodati u mapper
                    image: NetworkImage('http:${data.icon}'),
                    width: 64,
                    height: 64,
                  ),
                  Text(data.text.toString()),
                ],
              ),
            ],
          ),
        ),
        failure: (failure) {
          log(failure.trace.toString());
          return Text(failure.error.toString());
        },
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
        initial: () {
          return EmptyStateWidget();
        },
        empty: () => EmptyStateWidget(),
      ),
    );
  }
}
