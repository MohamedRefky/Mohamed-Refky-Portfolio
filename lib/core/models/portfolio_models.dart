class PersonalInfoModel {
  final String name;
  final String title;
  final String description;
  final String about;
  final String image;
  final String cv;
  final String github;
  final String linkedin;
  final String email;
  final String whatsappNumber;
  final String phone;
  final String? location;
  final String? yearsOfExperience;
  final String? availability;
  final String? militaryService;

  const PersonalInfoModel({
    required this.name,
    required this.title,
    required this.description,
    required this.about,
    required this.image,
    required this.cv,
    required this.github,
    required this.linkedin,
    required this.email,
    required this.whatsappNumber,
    required this.phone,
    this.location,
    this.yearsOfExperience,
    this.availability,
    this.militaryService,
  });

  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) {
    return PersonalInfoModel(
      name: json['name'] as String? ?? 'Mohamed Refky',
      title: json['title'] as String? ?? 'Flutter Developer',
      description: json['description'] as String? ?? '',
      about: json['about'] as String? ?? '',
      image: json['image'] as String? ?? 'assets/images/my_image.jpg',
      cv: json['cv'] as String? ?? '',
      github: json['github'] as String? ?? '',
      linkedin: json['linkedin'] as String? ?? '',
      email: json['email'] as String? ?? 'mohamedrefky9765@gmail.com',
      whatsappNumber: json['whatsappNumber'] as String? ?? '+201019964918',
      phone: json['phone'] as String? ?? '+201019964918',
      location: json['location'] as String?,
      yearsOfExperience: json['yearsOfExperience'] as String?,
      availability: json['availability'] as String?,
      militaryService: json['military_service'] as String?,
    );
  }
}

class StatModel {
  final String title;
  final String subtitle;
  final String icon;

  const StatModel({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  factory StatModel.fromJson(Map<String, dynamic> json) {
    return StatModel(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      icon: json['icon'] as String? ?? 'circle',
    );
  }
}

class ServiceModel {
  final String title;
  final String description;
  final String icon;

  const ServiceModel({
    required this.title,
    required this.description,
    required this.icon,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      icon: json['icon'] as String? ?? 'server',
    );
  }
}

class ExperienceModel {
  final String title;
  final String company;
  final String period;
  final String description;
  final List<String> points;
  final List<String> technologies;
  final String? location;
  final String? type;

  const ExperienceModel({
    required this.title,
    required this.company,
    required this.period,
    required this.description,
    this.points = const [],
    this.technologies = const [],
    this.location,
    this.type,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    List<String> parsedPoints = [];
    if (json['points'] is List) {
      parsedPoints = (json['points'] as List).map((e) => e.toString()).toList();
    }
    List<String> parsedTech = [];
    if (json['technologies'] is List) {
      parsedTech = (json['technologies'] as List).map((e) => e.toString()).toList();
    }

    return ExperienceModel(
      title: json['title'] as String? ?? json['role'] as String? ?? '',
      company: json['company'] as String? ?? '',
      period: json['period'] as String? ?? json['date'] as String? ?? '',
      description: json['description'] is String
          ? json['description'] as String
          : parsedPoints.join(' '),
      points: parsedPoints,
      technologies: parsedTech,
      location: json['location'] as String?,
      type: json['type'] as String?,
    );
  }
}

class ProjectModel {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? githubUrl;
  final String? liveDemoUrl;
  final bool isFeatured;
  final List<String> points;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    this.playStoreUrl,
    this.appStoreUrl,
    this.githubUrl,
    this.liveDemoUrl,
    this.isFeatured = false,
    this.points = const [],
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    List<String> parsedTech = [];
    if (json['technologies'] is List) {
      parsedTech = (json['technologies'] as List).map((e) => e.toString()).toList();
    }
    List<String> parsedPoints = [];
    if (json['points'] is List) {
      parsedPoints = (json['points'] as List).map((e) => e.toString()).toList();
    }

    final playStore = json['playStoreUrl'] as String?;
    final appStore = json['appStoreUrl'] as String?;
    final live = json['liveDemoUrl'] as String?;
    final github = json['githubUrl'] as String?;

    return ProjectModel(
      title: json['title'] as String? ?? json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? json['image'] as String? ?? '',
      technologies: parsedTech,
      playStoreUrl: (playStore != null && playStore.isNotEmpty) ? playStore : null,
      appStoreUrl: (appStore != null && appStore.isNotEmpty) ? appStore : null,
      liveDemoUrl: (live != null && live.isNotEmpty) ? live : null,
      githubUrl: (github != null && github.isNotEmpty) ? github : null,
      isFeatured: json['is_featured'] as bool? ?? false,
      points: parsedPoints,
    );
  }
}

class EducationModel {
  final String degree;
  final String university;
  final String period;
  final String grade;
  final String icon;

  const EducationModel({
    required this.degree,
    required this.university,
    required this.period,
    required this.grade,
    required this.icon,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      degree: json['degree'] as String? ?? '',
      university: json['university'] as String? ?? json['institution'] as String? ?? '',
      period: json['period'] as String? ?? json['date'] as String? ?? '',
      grade: json['grade'] as String? ?? '',
      icon: json['icon'] as String? ?? 'graduationCap',
    );
  }
}

class CertificateModel {
  final String title;
  final String platform;
  final String date;
  final String icon;

  const CertificateModel({
    required this.title,
    required this.platform,
    required this.date,
    required this.icon,
  });

  factory CertificateModel.fromJson(Map<String, dynamic> json) {
    return CertificateModel(
      title: json['title'] as String? ?? json['name'] as String? ?? '',
      platform: json['platform'] as String? ?? json['issuer'] as String? ?? '',
      date: json['date'] as String? ?? json['year'] as String? ?? '',
      icon: json['icon'] as String? ?? 'laptopCode',
    );
  }
}

class ExpertiseModel {
  final String name;
  final String icon;

  const ExpertiseModel({required this.name, required this.icon});

  factory ExpertiseModel.fromJson(Map<String, dynamic> json) {
    return ExpertiseModel(
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String? ?? 'circle',
    );
  }
}

class ExpertiseDetailModel {
  final String title;
  final String desc;
  final String icon;

  const ExpertiseDetailModel({
    required this.title,
    required this.desc,
    required this.icon,
  });

  factory ExpertiseDetailModel.fromJson(Map<String, dynamic> json) {
    return ExpertiseDetailModel(
      title: json['title'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
      icon: json['icon'] as String? ?? 'circle',
    );
  }
}

class TechCategoryModel {
  final String title;
  final String icon;
  final List<String> skills;

  const TechCategoryModel({
    required this.title,
    required this.icon,
    required this.skills,
  });

  factory TechCategoryModel.fromJson(Map<String, dynamic> json) {
    List<String> parsedSkills = [];
    if (json['skills'] is List) {
      parsedSkills = (json['skills'] as List).map((e) => e.toString()).toList();
    }
    return TechCategoryModel(
      title: json['title'] as String? ?? '',
      icon: json['icon'] as String? ?? 'code',
      skills: parsedSkills,
    );
  }
}

class SocialLinkModel {
  final String platform;
  final String url;
  final String icon;

  const SocialLinkModel({
    required this.platform,
    required this.url,
    required this.icon,
  });

  factory SocialLinkModel.fromJson(Map<String, dynamic> json) {
    return SocialLinkModel(
      platform: json['platform'] as String? ?? '',
      url: json['url'] as String? ?? '',
      icon: json['icon'] as String? ?? 'link',
    );
  }
}

class PortfolioModel {
  final PersonalInfoModel personalInfo;
  final List<StatModel> stats;
  final List<ServiceModel> services;
  final List<ExperienceModel> experience;
  final List<ProjectModel> projects;
  final List<EducationModel> education;
  final List<CertificateModel> certificates;
  final List<ExpertiseModel> expertise;
  final List<ExpertiseDetailModel> expertiseDetails;
  final List<TechCategoryModel> techStack;
  final List<SocialLinkModel> socialLinks;

  const PortfolioModel({
    required this.personalInfo,
    this.stats = const [],
    this.services = const [],
    this.experience = const [],
    this.projects = const [],
    this.education = const [],
    this.certificates = const [],
    this.expertise = const [],
    this.expertiseDetails = const [],
    this.techStack = const [],
    this.socialLinks = const [],
  });

  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    List<T> parseList<T>(String key, T Function(Map<String, dynamic>) fromJson) {
      if (json[key] is List) {
        return (json[key] as List)
            .whereType<Map<String, dynamic>>()
            .map(fromJson)
            .toList();
      }
      return [];
    }

    return PortfolioModel(
      personalInfo: PersonalInfoModel.fromJson(
        json['personalInfo'] as Map<String, dynamic>? ?? {},
      ),
      stats: parseList('stats', StatModel.fromJson),
      services: parseList('services', ServiceModel.fromJson),
      experience: parseList('experience', ExperienceModel.fromJson),
      projects: parseList('projects', ProjectModel.fromJson),
      education: parseList('education', EducationModel.fromJson),
      certificates: parseList('certificates', CertificateModel.fromJson),
      expertise: parseList('expertise', ExpertiseModel.fromJson),
      expertiseDetails: parseList('expertiseDetails', ExpertiseDetailModel.fromJson),
      techStack: parseList('techStack', TechCategoryModel.fromJson),
      socialLinks: parseList('socialLinks', SocialLinkModel.fromJson),
    );
  }
}

