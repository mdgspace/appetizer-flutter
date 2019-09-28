import 'package:appetizer/models/user/me.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.35,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 30.0),
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
                            fontSize: 25.0,
                            color: appiLightGreyText,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 1.0, 1.0, 4.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Text(
                            "INDIAN INSTITUTE OF TECHNOLOGY, ROORKEE",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: appiDarkGreyText,
                              fontSize: 13.0,
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
                      height: 55.0,
                      width: 55.0,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 16.0, 6.0, 4.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Enrollment No: ",
                                style: Theme.of(context).accentTextTheme.title,
                              ),
                              Flexible(
                                child: Text(
                                  "$_enrollmentNo",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color:
                                          const Color.fromRGBO(79, 79, 79, 1),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 4.0, 6.0, 4.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Branch: ",
                                style: Theme.of(context).accentTextTheme.title,
                              ),
                              Flexible(
                                child: Text(
                                  "$_branch",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .accentTextTheme
                                      .subtitle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 4.0, 6.0, 4.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Hostel: ",
                                style: Theme.of(context).accentTextTheme.title,
                              ),
                              Flexible(
                                child: Text(
                                  "$_hostel",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .accentTextTheme
                                      .subtitle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 4.0, 6.0, 4.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Room No.: ",
                                style: Theme.of(context).accentTextTheme.title,
                              ),
                              Flexible(
                                child: Text(
                                  "$_roomNo",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .accentTextTheme
                                      .subtitle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 4.0, 6.0, 14.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "E-Mail: ",
                                style: Theme.of(context).accentTextTheme.title,
                              ),
                              Flexible(
                                child: Text(
                                  "$_email",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .accentTextTheme
                                      .subtitle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),
                    child: Container(
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/accountIcon.svg',
                        height: 90.0,
                        width: 90.0,
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
}
