class AppConfig {
  static String baseUrl = '';

  static const String defaultLocale = 'en';

  static void configDev() {
    baseUrl = 'https://api-retail.connectpos.com';
  }

  static void configTest() {
    // TODO(boilerplate): flavoring
  }

  static void configProduction() {
    // TODO(boilerplate): flavoring
  }
}
