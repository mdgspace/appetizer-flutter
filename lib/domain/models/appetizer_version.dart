class AppetizerVersion {
  String number;
  String platform;
  dynamic expiryDate;
  bool isExpired;
  bool isLatest;
  int dateCreated;

  AppetizerVersion({
    required this.number,
    required this.platform,
    required this.expiryDate,
    required this.isExpired,
    required this.isLatest,
    required this.dateCreated,
  });

  factory AppetizerVersion.fromJson(Map<String, dynamic> json) =>
      AppetizerVersion(
        number: json['number'],
        platform: json['platform'],
        expiryDate: json['expiry_date'],
        isExpired: json['is_expired'],
        isLatest: json['is_latest'],
        dateCreated: json['date_created'],
      );

  Map<String, dynamic> toJson() => {
        'number': number,
        'platform': platform,
        'expiry_date': expiryDate,
        'is_expired': isExpired,
        'is_latest': isLatest,
        'date_created': dateCreated,
      };
}
