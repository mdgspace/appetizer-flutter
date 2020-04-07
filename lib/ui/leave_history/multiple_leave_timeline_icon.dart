import 'package:flutter/material.dart';

class MultipleLeaveTimelineIcon extends StatelessWidget {
  final int _noOfLeaves;

  MultipleLeaveTimelineIcon(this._noOfLeaves);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 113.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 14.0,
            child: Container(
              height: 12.0,
              width: 12.0,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 193, 7, 1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 2.0,
            left: 16.0,
            child: Container(
              height: 8.0,
              width: 8.0,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 10.0,
            left: 19.0,
            child: Container(
              height: 93,
              width: 2,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 193, 7, 1),
              ),
            ),
          ),
          Positioned(
            top: 35.0,
            left: 0.0,
            child: Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 193, 7, 1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 37.0,
            left: 2.0,
            child: Container(
              height: 36.0,
              width: 36.0,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          //Display no of meals left
          (_noOfLeaves > 9)
              ? Positioned(
                  top: 46.0,
                  left: 11.0,
                  child: Text(
                    '$_noOfLeaves',
                    style: TextStyle(
                      color: const Color.fromRGBO(255, 193, 7, 1),
                      fontSize: 16.0,
                    ),
                  ),
                )
              : Positioned(
                  top: 46.0,
                  left: 16.0,
                  child: Text(
                    '$_noOfLeaves',
                    style: TextStyle(
                      color: const Color.fromRGBO(255, 193, 7, 1),
                      fontSize: 16.0,
                    ),
                  ),
                ),
          // End of display
          Positioned(
            top: 101.0,
            left: 14.0,
            child: Container(
              height: 12.0,
              width: 12.0,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 193, 7, 1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 103.0,
            left: 16.0,
            child: Container(
              height: 8.0,
              width: 8.0,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
