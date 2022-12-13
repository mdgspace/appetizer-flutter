class DialogRequest {
  final String title;
  final String? description;
  final String? buttonTitle;
  final String? cancelTitle;
  final bool? isFailure;

  DialogRequest({
    required this.title,
    this.description,
    this.buttonTitle,
    this.cancelTitle,
    this.isFailure,
  });
}

class DialogResponse {
  final String? fieldOne;
  final String? fieldTwo;
  final bool confirmed;

  DialogResponse({
    this.fieldOne,
    this.fieldTwo,
    required this.confirmed,
  });
}
