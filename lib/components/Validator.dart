
class Validators {
  static String? validateRequired(String value, String type) {
    if (value.isEmpty) {
      return "$type is required";
    }
    return null;
  }

  static String? validateName(String? value, String type) {
    String pattern = r'^[a-zA-Z ]{2,50}$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.length < 3) {
      return "$type must be more than 2 charter";
    } else if (!regExp.hasMatch(value)) {
      return "Enter valid $type";
    } else {
      return null;
    }
  }

  static String? validateNotEmptyText({String? value, String? text}) {
    if (value.toString().isEmpty) {
      return "$text is required";
    }
    return null;
  }

  String? validatedate(String value) {
    String patttern = r'([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return "Date is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Please enter valid date";
    }
    return null;
  }

}
