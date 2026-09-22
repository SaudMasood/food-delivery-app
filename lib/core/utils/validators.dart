class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter email";
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter password";
    }

    return null;
  }
}