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
              : createSearchBarChildren()),
    );
  }

  List<Widget> createNormalBarChildren() {
    return [
      Text('Radiofi'),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          _stationsController.changeTextEditState(true);
        },
      )
    ];
  }

  List<Widget> createSearchBarChildren() {
    return [
      Expanded(
        child: TextField(
          autofocus: true,
          onChanged: (text) {
            currentText = text;
            _stationsController.search(text);
          },
          decoration: InputDecoration(
              border: UnderlineInputBorder(),
              prefixIcon: IconButton(
                color: Colors.redAccent,
                icon: Icon(Icons.close),
                onPressed: () => _stationsController.changeTextEditState(false),
              ),
              suffixIcon: IconButton(
                  icon: Icon(Icons.check),
                  color: Colors.greenAccent,
                  onPressed: currentText.length > 0
                      ? () {                        
                        if(_stationsController.stations.isNotEmpty){
                          _stationsController.play(_stationsController.stations.first);
                        }
                        _stationsController.changeTextEditState(false);
                      }
                      : null)),
        ),
      )
    ];
  }

  void updateStationsList() {
    setState(() {});
  }
}
