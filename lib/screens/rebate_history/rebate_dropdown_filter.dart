import 'package:flutter/material.dart';

class RebateDropdownFilter extends StatefulWidget{

  @override
  _RebateDropdownFilterState createState() => _RebateDropdownFilterState();
}

class _RebateDropdownFilterState extends State<RebateDropdownFilter> {

  final _yearList = [
    DateTime.now().year,
    DateTime.now().year-1,
    DateTime.now().year-2,
    DateTime.now().year-3,
    DateTime.now().year-4,
  ];

  int _currentItemSelected = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(121, 85, 72, 1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
                child: Text(
                  'Filter by',
                  style: TextStyle(
                    fontSize: 16.5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 2.0),
                child: Text(
                  'Year',
                  style: TextStyle(
                      color: const Color.fromRGBO(0, 0, 0, 0.54),
                      fontSize: 16.5
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: const Color.fromRGBO(0, 0, 0, 0.15)
                                )
                            )
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: _currentItemSelected,
                            items: _yearList.map((int dropDownItem){
                              return DropdownMenuItem<int>(
                                value: dropDownItem,
                                child: Text(
                                  '$dropDownItem',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (int newValueSelected){
                              _onDropDownItemSelected(newValueSelected);
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onDropDownItemSelected(int newValueSelected){
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

}
