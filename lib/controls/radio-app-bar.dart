import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:radio_fi/data/station-controller.dart';

class RadioAppBar extends StatefulWidget implements PreferredSizeWidget {
  final AppBar _appBar = new AppBar();

  @override
  _RadioAppBarState createState() => _RadioAppBarState();

  @override
  Size get preferredSize => new Size.fromHeight(_appBar.preferredSize.height);
}

class _RadioAppBarState extends State<RadioAppBar> {
  StationsController _stationsController = GetIt.instance<StationsController>();
  String currentText = '';

  @override
  void initState() {
    super.initState();
    _stationsController.addListener(updateStationsList);
  }

  @override
  void dispose() {
    _stationsController.removeListener(updateStationsList);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isSearching = _stationsController.isSearching();
    return AppBar(
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: !isSearching
              ? createNormalBarChildren()
              : createSearchBarChildren(context)),
    );
  }

  List<Widget> createNormalBarChildren() {
    return [
      Text('Radio App'),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          _stationsController.changeTextEditState(true);
        },
      )
    ];
  }

  List<Widget> createSearchBarChildren(BuildContext context) {
    var theme = Theme.of(context);
    return [
      Expanded(
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: lighten(theme.primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(70))),
          child: TextField(
            autofocus: true,
            onChanged: (text) {
              currentText = text;
              _stationsController.search(text);
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: IconButton(
                  color: Colors.red[900],
                  icon: Icon(Icons.close),
                  onPressed: () =>
                      _stationsController.changeTextEditState(false),
                )),
          ),
        ),
      )
    ];
  }

  void updateStationsList() {
    setState(() {});
  }

  Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
