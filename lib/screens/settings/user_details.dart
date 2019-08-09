import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserDetails extends StatelessWidget{

  final String _name;
  final int _enrollmentNo;
  final String _branch;
  final String _hostel;
  final String _roomNo;
  final String _email;

  UserDetails(this._name, this._enrollmentNo, this._branch, this._hostel, this._roomNo, this._email);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 30.0),
        child: Card(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0,6.0,8.0,1.0),
                        child: Text(
                          "$_name",
                          style: TextStyle(
                            fontSize: 25.0,
                            color: const Color.fromRGBO(79, 79, 79, 1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0,1.0,1.0,4.0),
                        child: Text(
                          "INDIAN INSTITUTE OF TECHNOLOGY, ROORKEE",
                          style: TextStyle(
                            color: const Color.fromRGBO(130, 130, 130, 1),
                            fontSize: 13.0,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,4.0,10.0,4.0),
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
                width: 362.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0,16.0,6.0,4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Enrollment No.: ",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: const Color.fromRGBO(130, 130, 130, 1),
                              ),
                            ),
                            Text(
                              "$_enrollmentNo",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: const Color.fromRGBO(79, 79, 79, 1),
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0,4.0,6.0,4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Branch: ",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: const Color.fromRGBO(130, 130, 130, 1),
                              ),
                            ),
                            Text(
                              "$_branch",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: const Color.fromRGBO(79, 79, 79, 1),
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0,4.0,6.0,4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Hostel: ",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: const Color.fromRGBO(130, 130, 130, 1),
                              ),
                            ),
                            Text(
                              "$_hostel",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: const Color.fromRGBO(79, 79, 79, 1),
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0,4.0,6.0,4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Room No.: ",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: const Color.fromRGBO(130, 130, 130, 1),
                              ),
                            ),
                            Text(
                              "$_roomNo",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: const Color.fromRGBO(79, 79, 79, 1),
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0,4.0,6.0,14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "E-Mail: ",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: const Color.fromRGBO(130, 130, 130, 1),
                              ),
                            ),
                            Text(
                              "$_email",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: const Color.fromRGBO(79, 79, 79, 1),
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(2.0,18.0,8.0,18.0),
                    child: Container(
                      width: 122.0,
                      height: 122.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
//                          image: new DecorationImage(
//                              fit: BoxFit.fill,
//                              image: new NetworkImage("")
//                          )
                        //TODO: add image
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/accountIcon.svg',
                        height: 60.0,
                        width: 60.0,
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
