import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/controllers/geo-station-controller.dart';

class CountryCodeSelector extends StatefulWidget {
  @override
  _CountryCodeSelectorState createState() => _CountryCodeSelectorState();
}

class _CountryCodeSelectorState extends State<CountryCodeSelector> {
  GeoStationsController stationsController = GetIt.I<GeoStationsController>();
  String? selectedCountryCode = CountryCodes.detailsForLocale().alpha2Code;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
                child: Text(AppLocalizations.of(context)!.country), flex: 1),
            Expanded(
              flex: 1,
              child: DropdownButton(
                value: selectedCountryCode,
                items: stationsController.countryCodes
                    .map((e) => DropdownMenuItem(child: Text(e), value: e))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCountryCode = value?.toString();
                    stationsController.changeCountryCode(value.toString());
                  });
                },
              ),
            ),
            Expanded(child: SizedBox(), flex: 2)
          ],
        ),
      ),
    );
  }
}
