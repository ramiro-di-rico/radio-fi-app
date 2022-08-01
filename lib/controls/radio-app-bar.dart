import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../info-scree.dart';
import '../services/station-manager.dart';

class RadioAppBar extends StatefulWidget implements PreferredSizeWidget {
  final AppBar _appBar = new AppBar();

  @override
  _RadioAppBarState createState() => _RadioAppBarState();

  @override
  Size get preferredSize => new Size.fromHeight(_appBar.preferredSize.height);
}

class _RadioAppBarState extends State<RadioAppBar> {
  StationManager _stationsController = GetIt.instance<StationManager>();
  String currentText = '';
  Widget searchBarIconButton;
  FocusNode searchBarFocusNode;
  TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    _stationsController.addListener(updateStationsList);
    searchBarFocusNode = FocusNode();
    searchController = TextEditingController();
    searchBarIconButton = IconButton(
      splashColor: Colors.transparent,
      icon: Icon(Icons.search),
      color: Colors.blueAccent,
      onPressed: () {
        _stationsController.changeTextEditState(true);
        searchBarFocusNode.requestFocus();
      },
    );
  }

  @override
  void dispose() {
    _stationsController.removeListener(updateStationsList);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: createSearchBarChildren(context)),
    );
  }

  List<Widget> createSearchBarChildren(BuildContext context) {
    var isSearching = _stationsController.isSearching();
    var theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    return [
      Row(
        children: [
          Text(AppLocalizations.of(context).appTitle),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, InfoScreen.id);
              },
              icon: Icon(Icons.info_outlined))
        ],
      ),
      AnimatedContainer(
        width: isSearching ? (width / 2) : 50,
        padding: EdgeInsets.symmetric(horizontal: isSearching ? 20 : 5),
        height: 50,
        decoration: BoxDecoration(
            color: lighten(theme.primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(70))),
        duration: Duration(seconds: 2),
        curve: Curves.fastLinearToSlowEaseIn,
        child: TextField(
          controller: searchController,
          focusNode: searchBarFocusNode,
          onChanged: (text) {
            currentText = text;
            _stationsController.search(text);
          },
          decoration: InputDecoration(
              border: InputBorder.none, prefixIcon: searchBarIconButton),
        ),
      )
    ];
  }

  void updateStationsList() {
    setState(() {
      if (_stationsController.isSearching()) {
        searchBarIconButton = IconButton(
          splashColor: Colors.transparent,
          color: Colors.red[900],
          icon: Icon(Icons.close),
          onPressed: () {
            _stationsController.changeTextEditState(false);
            searchBarFocusNode.unfocus();
            searchController.clear();
          },
        );
      } else {
        searchBarIconButton = IconButton(
          splashColor: Colors.transparent,
          icon: Icon(Icons.search),
          color: Colors.blueAccent,
          onPressed: () {
            _stationsController.changeTextEditState(true);
            searchBarFocusNode.requestFocus();
          },
        );
      }
    });
  }

  Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
