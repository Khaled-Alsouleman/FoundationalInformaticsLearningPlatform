import 'package:flutter/foundation.dart';
import 'package:foundational_learning_platform/core/utils/abstract/PdfService.dart';

import 'TMPdfServiceMobile.dart';
import 'TMPdfServiceWeb.dart';


class PdfServiceFactory {
  static PdfService createPdfService() {
    if (kIsWeb) {
      return TMPdfServiceWeb(); // Web-Implementierung
    } else {
      return TMPdfServiceMobile(); // Mobile-Implementierung
    }
  }
}
