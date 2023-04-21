import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_weather/domain/notifiers/weather/weather_state_notifier.dart';

class SearchBarWidget extends ConsumerWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      autofocus: true,
      style: const TextStyle(color: Colors.white),
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      cursorColor: Colors.white,
      onChanged: (query) {
        if (query.length > 3) {
          ref.read(weatherValueProvider.notifier).getWeather(query: query);
        } else if (query.isEmpty) {
          ref.read(weatherValueProvider.notifier).getWeather();
        }
      },
      enableSuggestions: true,
      decoration: InputDecoration(
        hintText: 'Search City',
        hintStyle: TextStyle(
          color: Colors.blue.shade100,
        ),
        icon: const Icon(
          Icons.search,
          color: Colors.white,
        ),
        border: InputBorder.none,
      ),
    );
  }
  //debounce metoda koja ceka dok korisnik nije prestao upisivat da se api zove samo jednom
}
