import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/portfolio_models.dart';

class PortfolioData {
  static bool _isLoaded = false;
  static Map<String, dynamic> _data = {};
  static PortfolioModel _portfolio = PortfolioModel.fromJson({});

  static Map<String, dynamic> get data => _data;
  static PortfolioModel get portfolio => _portfolio;

  // Strongly-typed accessors
  static PersonalInfoModel get personalInfo => _portfolio.personalInfo;
  static List<StatModel> get stats => _portfolio.stats;
  static List<ServiceModel> get services => _portfolio.services;
  static List<ExperienceModel> get experience => _portfolio.experience;
  static List<ProjectModel> get projects => _portfolio.projects;
  static List<EducationModel> get education => _portfolio.education;
  static List<CertificateModel> get certificates => _portfolio.certificates;
  static List<ExpertiseModel> get expertise => _portfolio.expertise;
  static List<ExpertiseDetailModel> get expertiseDetails => _portfolio.expertiseDetails;
  static List<TechCategoryModel> get techStack => _portfolio.techStack;
  static List<SocialLinkModel> get socialLinks => _portfolio.socialLinks;

  static Future<void> load() async {
    if (_isLoaded) return;
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/portfolio_data.json',
      );
      _data = jsonDecode(jsonString) as Map<String, dynamic>;
      _portfolio = PortfolioModel.fromJson(_data);
      _isLoaded = true;
    } catch (e) {
      _data = {};
      _portfolio = PortfolioModel.fromJson({});
      debugPrint('Error loading portfolio data: $e');
    }
  }
}
