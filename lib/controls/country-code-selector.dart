import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:radio_fi/services/controllers/station-controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/controllers/sync-station-controller.dart';

class CountryCodeSelector extends StatefulWidget {
  @override
  _CountryCodeSelectorState createState() => _CountryCodeSelectorState();
}

class _CountryCodeSelectorState extends State<CountryCodeSelector> {
  SyncStationsController stationsController = GetIt.I<SyncStationsController>();
  String selectedCountryCode = CountryCodes.detailsForLocale().alpha2Code;

  @override
  Widget build(BuildContext context) {
    var countryCodes = stationsController.getCountryCodes();
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
                child: Text(AppLocalizations.of(context).country), flex: 1),
            Expanded(
              flex: 1,
              child: DropdownButton(
                value: selectedCountryCode,
                items: countryCodes
                    .map((e) => DropdownMenuItem(child: Text(e), value: e))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCountryCode = value;
                    stationsController.changeCountryCode(value);
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
