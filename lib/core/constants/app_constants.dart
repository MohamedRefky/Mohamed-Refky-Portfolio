import '../data/portfolio_data.dart';

class AppConstants {
  static String get devName => PortfolioData.personalInfo.name;
  static String get devTitle => PortfolioData.personalInfo.title;
  static String get devDescription =>
      PortfolioData.personalInfo.description.isNotEmpty
          ? PortfolioData.personalInfo.description
          : 'I am a passionate Flutter developer building production-ready mobile and web applications with Clean Architecture.';

  static String get devImagePath => PortfolioData.personalInfo.image;
  static String get devCvPath =>
      PortfolioData.personalInfo.cv.isNotEmpty
          ? PortfolioData.personalInfo.cv
          : 'https://drive.google.com/file/d/1DhmkxmSVydc2uxzJtuN9VmY5KluUZ2UG/view?usp=drive_link';

  // Social Links
  static String get githubUrl =>
      PortfolioData.personalInfo.github.isNotEmpty
          ? PortfolioData.personalInfo.github
          : 'https://github.com/MohamedRefky';
  static String get linkedinUrl =>
      PortfolioData.personalInfo.linkedin.isNotEmpty
          ? PortfolioData.personalInfo.linkedin
          : 'https://www.linkedin.com/in/mohamedrefky/';
  static String get email => 'mailto:${PortfolioData.personalInfo.email}';
  static String get whatsappNumber => PortfolioData.personalInfo.whatsappNumber;
  static String get whatsappUrl =>
      'https://wa.me/${whatsappNumber.replaceAll('+', '')}';
  static String get phoneCallUrl => 'tel:${PortfolioData.personalInfo.phone}';
}
