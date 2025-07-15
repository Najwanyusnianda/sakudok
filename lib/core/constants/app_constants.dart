class AppConstants {
  // App Info
  static const String appName = 'SakuDok';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Brankas digital 100% offline untuk KTP, SIM, Ijazah';
  
  // Database
  static const String databaseName = 'sakudok.db';
  static const int databaseVersion = 1;
  
  // Security
  static const String encryptionKey = 'sakudok_encryption_key';
  static const String biometricKey = 'sakudok_biometric_key';
  static const String pinKey = 'sakudok_pin_key';
  
  // Storage
  static const String documentsFolder = 'documents';
  static const String backupsFolder = 'backups';
  static const String tempFolder = 'temp';
  
  // Document Types
  static const String ktp = 'KTP';
  static const String sim = 'SIM';
  static const String ijazah = 'Ijazah';
  static const String paspor = 'Paspor';
  static const String stnk = 'STNK';
  static const String bpjs = 'BPJS';
  static const String npwp = 'NPWP';
  static const String ielts = 'IELTS/TOEFL';
  static const String kk = 'Kartu Keluarga';
  static const String aktaLahir = 'Akta Lahir';
  static const String cv = 'CV';
  static const String transkrip = 'Transkrip';
  static const String sertifikat = 'Sertifikat';
  static const String custom = 'Custom';
  
  // Document Type Icons
  static const Map<String, String> documentTypeIcons = {
    ktp: 'assets/icons/ktp.svg',
    sim: 'assets/icons/sim.svg',
    ijazah: 'assets/icons/ijazah.svg',
    paspor: 'assets/icons/paspor.svg',
    stnk: 'assets/icons/stnk.svg',
    bpjs: 'assets/icons/bpjs.svg',
    npwp: 'assets/icons/npwp.svg',
    ielts: 'assets/icons/ielts.svg',
    kk: 'assets/icons/kk.svg',
    aktaLahir: 'assets/icons/akta_lahir.svg',
    cv: 'assets/icons/cv.svg',
    transkrip: 'assets/icons/transkrip.svg',
    sertifikat: 'assets/icons/sertifikat.svg',
    custom: 'assets/icons/custom.svg',
  };
  
  // Bundle Templates
  static const Map<String, List<String>> bundleTemplates = {
    'Lamaran Kerja': [ktp, ijazah, cv, transkrip],
    'Pendaftaran Beasiswa': [kk, transkrip, sertifikat],
    'Administrasi Pernikahan': [ktp, aktaLahir, kk],
    'Perpanjangan SIM': [sim, ktp],
    'Pembuatan Paspor': [ktp, kk],
    'Pendaftaran BPJS': [ktp, kk],
  };
  
  // Reminder Intervals (in days)
  static const Map<String, List<int>> reminderIntervals = {
    sim: [30, 14, 7],
    paspor: [180, 90, 30],
    stnk: [30, 14, 7],
    ielts: [730, 365, 180],
    bpjs: [7, 3, 1],
  };
  
  // Validation Rules
  static const Map<String, Map<String, dynamic>> validationRules = {
    ktp: {
      'nik': r'^\d{16}$',
      'nik_length': 16,
    },
    sim: {
      'nomor_sim': r'^[A-Z]\d{12}$',
      'nomor_sim_length': 13,
    },
    npwp: {
      'nomor_npwp': r'^\d{2}\.\d{3}\.\d{3}\.\d{1}-\d{3}\.\d{3}$',
    },
  };
  
  // File Extensions
  static const List<String> supportedImageExtensions = ['jpg', 'jpeg', 'png', 'heic'];
  static const List<String> supportedDocumentExtensions = ['pdf', 'doc', 'docx'];
  
  // Image Quality
  static const int imageQuality = 85;
  static const int maxImageWidth = 1920;
  static const int maxImageHeight = 1080;
  
  // Backup
  static const String backupFileExtension = '.sakudok';
  static const int maxBackupFiles = 5;
  
  // Notifications
  static const String notificationChannelId = 'sakudok_reminders';
  static const String notificationChannelName = 'SakuDok Reminders';
  static const String notificationChannelDescription = 'Pengingat dokumen SakuDok';
  
  // Routes
  static const String homeRoute = '/';
  static const String documentsRoute = '/documents';
  static const String addDocumentRoute = '/documents/add';
  static const String editDocumentRoute = '/documents/edit';
  static const String documentDetailRoute = '/documents/detail';
  static const String bundlesRoute = '/bundles';
  static const String addBundleRoute = '/bundles/add';
  static const String settingsRoute = '/settings';
  static const String securityRoute = '/security';
  static const String backupRoute = '/backup';
  static const String aboutRoute = '/about';
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Debounce Delay
  static const Duration searchDebounce = Duration(milliseconds: 300);
  
  // Pagination
  static const int documentsPerPage = 20;
  
  // Cache
  static const Duration imageCacheDuration = Duration(days: 7);
  static const int maxCachedImages = 100;
}
