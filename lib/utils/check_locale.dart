import 'package:SMLingg/config/application.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';

Locale checkLocale() {
  if (Application.sharePreference.getString("locale") == null) {
    print("------");
    print(I18n.localeStr);
    print("system: ${I18n.systemLocale}");
    return I18n.localeStr == "en_us" ? Locale('en', "US") : Locale('vi', "VN");
  } else if (Application.sharePreference.getString("locale") == "vi_vn") {
    return Locale('vi', "VN");
  } else {
    return Locale('en', "US");
  }
}
