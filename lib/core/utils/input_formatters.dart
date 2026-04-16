import 'package:flutter/services.dart';

class AppInputFormatters {
  /// Always converts text to uppercase
  static final TextInputFormatter uppercase = _UpperCaseTextFormatter();

  /// Limits input to 10 digits (for Mobile)
  static final TextInputFormatter phone = LengthLimitingTextInputFormatter(10);

  /// Limits input to 12 digits (for Aadhar)
  static final TextInputFormatter aadhar = LengthLimitingTextInputFormatter(12);

  /// Allows only numbers
  static final TextInputFormatter digitsOnly = FilteringTextInputFormatter.digitsOnly;

  /// Custom formatter to auto uppercase after space (if TextCapitalization doesn't suffice)
  static final TextInputFormatter autoCapitalizeAfterSpace = _AutoCapitalizeAfterSpaceFormatter();
}

class _UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}

class _AutoCapitalizeAfterSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;

    String text = newValue.text;
    List<String> words = text.split(' ');
    
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }

    String result = words.join(' ');
    
    // Ensure the cursor stays in the correct position
    return newValue.copyWith(
      text: result,
      selection: newValue.selection,
    );
  }
}

class AppValidators {
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Mobile number is required';
    if (value.length != 10) return 'Mobile number must be 10 digits';
    return null;
  }

  static String? validateAadhar(String? value) {
    if (value == null || value.isEmpty) return 'Aadhar number is required';
    if (value.length != 12) return 'Aadhar number must be 12 digits';
    return null;
  }
}
