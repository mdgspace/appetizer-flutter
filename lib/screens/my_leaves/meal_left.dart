import 'package:flutter/material.dart';

class MealLeft extends StatelessWidget{

  final String _meal;
  final String _date;

  MealLeft(this._meal,this._date);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: const Color.fromRGBO(00, 00, 00, 0.15),
            ),
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0,8.0,0.0,2.0),
                child: Text(
                  '$_meal',
                  style: TextStyle(
                      fontSize: 19.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 8.0),
                child: Text(
                  '$_date',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: const Color.fromRGBO(0, 0, 0, 0.54),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(icon:Icon(Icons.close),
              color: const Color.fromRGBO(235, 87, 87, 1),
              iconSize: 40.0,
              onPressed:() => {},
            ),
          ),
        ],
      ),

    );
  }
}
