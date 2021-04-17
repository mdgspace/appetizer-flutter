import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserDetailsCard extends StatelessWidget {
  final String name;
  final String enrollmentNo;
  final String branch;
  final String hostel;
  final String roomNo;
  final String email;

  UserDetailsCard({
    this.name,
    this.enrollmentNo,
    this.branch,
    this.hostel,
    this.roomNo,
    this.email,
  });

  Widget _buildCardListItem(String title, String subTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: AppTheme.headline6,
          ),
          Flexible(
            child: Container(
              child: Text(
                subTitle,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.bodyText1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$name',
                      style: AppTheme.subtitle1,
                    ),
                    SizedBox(height: 4),
                    Container(
                      child: Text(
                        'INDIAN INSTITUTE OF TECHNOLOGY, ROORKEE',
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.bodyText2,
                      ),
                    )
                  ],
                ),
                SvgPicture.asset(
                  'assets/icons/red_iitr_logo.svg',
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        _buildCardListItem('Enrollment No: ', '$enrollmentNo'),
                        _buildCardListItem('Branch: ', '$branch'),
                        _buildCardListItem('Hostel: ', '$hostel'),
                        _buildCardListItem('Room No : ', '$roomNo'),
                        _buildCardListItem('Email: ', '$email'),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Icon(
                    Icons.account_circle,
                    color: AppTheme.secondary,
                    size: 100,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
