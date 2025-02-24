var this_year = DateTime.now().year.toString();

class AppConfig {
  static String copyright_text =
      "@ EmeraldLightAuto " + this_year; //this shows in the splash screen
  static String app_name = "Emerald Light Auto"; //this shows in the splash screen

  static String purchase_code =
      "bkash"; //enter your purchase code for the app from codecanyon
  static String system_key = "bkash"; //enter your purchase code for the app from codecanyon

  //Default language config
  static String default_language = "en";
  static String mobile_app_code = "en";
  static bool app_language_rtl = false;

  //configure this
  static const bool HTTPS = true;

  static const DOMAIN_PATH = "emeraldlightauto.uk";
  static const DOMAIN_OTHER_USELESS = "emeraldlightauto.uk";
  //airsoftauctions.co.uk  emeraldlightauto.uk

  //do not configure these below
  static const String API_ENDPATH = "api/v2";
 
  static const String PROTOCOL = HTTPS ? "https://" : "http://";
  static const String RAW_BASE_URL = "${PROTOCOL}${DOMAIN_PATH}";
  
  static const String RAW_BASE_URL_OTHER = "${PROTOCOL}${DOMAIN_OTHER_USELESS}";
  static const String BASE_URL = "${RAW_BASE_URL}/${API_ENDPATH}";
 // static const String BASE_URL = "${RAW_BASE_URL}";

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
