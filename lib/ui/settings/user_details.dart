import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../colors.dart';

class UserDetails extends StatelessWidget {
  final String _name;
  final String _enrollmentNo;
  final String _branch;
  final String _hostel;
  final String _roomNo;
  final String _email;

  UserDetails(this._name, this._enrollmentNo, this._branch, this._hostel,
      this._roomNo, this._email);

  Widget cardListItem(String title, String subTitle, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,5,0,5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).accentTextTheme.title,
          ),
          Text(
            subTitle,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).accentTextTheme.subtitle,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.32,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 30.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 6.0, 8.0, 1.0),
                        child: Text(
                          "$_name",
                          style: TextStyle(
                            fontSize: 18,
                            color: appiLightGreyText,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 1.0, 1.0, 4.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: Text(
                            "INDIAN INSTITUTE OF TECHNOLOGY, ROORKEE",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: appiDarkGreyText,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 4.0, 10.0, 4.0),
                    child: SvgPicture.asset(
                      'assets/icons/redIITRLogo.svg',
                      height: 40.0,
                      width: 40.0,
                      color: const Color.fromRGBO(234, 87, 87, 1),
                    ),
                  ),
                ],
              ),
              Container(
                color: const Color.fromRGBO(121, 85, 72, 1),
                height: 1.0,
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: EdgeInsets.only(top: 7,bottom: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          cardListItem("Enrollment No: ", "$_enrollmentNo", context),
                          cardListItem("Branch: ", "$_branch", context),
                          cardListItem("Hostel: ", "$_hostel", context),
                          cardListItem("Room No : ", "$_roomNo", context),
                          cardListItem("Email: ", "$_email", context),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.account_circle,
                          size: 110,
                          color: appiBrown,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
