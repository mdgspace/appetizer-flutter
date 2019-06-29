import 'package:flutter/material.dart';

class RebateHistoryCard extends StatelessWidget{

  final int _balanceConsumed;
  final int _rebate;
  final int _additionalMeal;
  final int _year;
  final String _month;

  RebateHistoryCard(this._balanceConsumed, this._rebate, this._additionalMeal, this._month, this._year);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5.0,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: const Color.fromRGBO(224, 224, 224, 1),
                      )
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$_month $_year',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24.0,
                        color: const Color.fromRGBO(0, 0, 0, 0.87),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: const Color.fromRGBO(224, 224, 224, 1),
                      )
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Balance Consumed',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: const Color.fromRGBO(0, 0, 0, 0.54),
                          ),
                        ),
                        Text(
                          '- Rs. $_balanceConsumed',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: const Color.fromRGBO(235, 87, 87, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Rebate',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: const Color.fromRGBO(0, 0, 0, 0.54),
                          ),
                        ),
                        Text(
                          '+ Rs. $_rebate',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: const Color.fromRGBO(39, 174, 96, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Additional Meal Taken',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: const Color.fromRGBO(0, 0, 0, 0.54),
                          ),
                        ),
                        (_additionalMeal==0)?
                        Text(
                          'Rs. $_additionalMeal',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: const Color.fromRGBO(0, 0, 0, 0.54),
                          ),
                        )
                            :
                        Text(
                          '-Rs. $_additionalMeal',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: const Color.fromRGBO(235, 87, 87, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Rs. '+ (_balanceConsumed+_additionalMeal-_rebate).toString(),
                    style: TextStyle(
                      fontSize: 17.0,
                      color: const Color.fromRGBO(0, 0, 0, 0.87),
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
