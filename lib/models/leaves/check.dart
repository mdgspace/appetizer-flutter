// To parse this JSON data, do
//
//     final check = checkFromJson(jsonString);

import 'dart:convert';

Check checkFromJson(String str) => Check.fromJson(json.decode(str));

String checkToJson(Check data) => json.encode(data.toJson());

class Check {
    int checkoutTime;
    int checkinTime;
    int user;
    bool isCheckedOut;

    Check({
        this.checkoutTime,
        this.checkinTime,
        this.user,
        this.isCheckedOut,
    });

    factory Check.fromJson(Map<String, dynamic> json) => new Check(
        checkoutTime: json["checkout_time"],
        checkinTime: json["checkin_time"],
        user: json["user"],
        isCheckedOut: json["is_checked_out"],
    );

    Map<String, dynamic> toJson() => {
        "checkout_time": checkoutTime,
        "checkin_time": checkinTime,
        "user": user,
        "is_checked_out": isCheckedOut,
    };
}
