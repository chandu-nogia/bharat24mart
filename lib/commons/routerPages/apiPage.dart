// ignore_for_file: file_names

class ApiUser {
  static String baseUrl = "https://bharatmart.akshayanidhi.digital/api/";
  static String forgotPassword = "${baseUrl}user/forgot-password/otp";
  static String createVerify = "${baseUrl}user/otp/verify";
  static String passwordUpdate = "${baseUrl}user/password_update";
  static String profile = "${baseUrl}user/profile";
  static String products = "${baseUrl}products";
  static String logInApi = "${baseUrl}user/login";
  static String signUpApi = "${baseUrl}user/create";
  static String singleProduct = "${baseUrl}product/details";
  static String getCart = "${baseUrl}cart/get";
  static String addcart = "${baseUrl}cart/add";
  static String editCart = "${baseUrl}cart/edit";
  static String deleteCart = "${baseUrl}cart/delete";
  static String editProfile = "${baseUrl}user/profile-update";
  static String category = "${baseUrl}category";
  static String states = "${baseUrl}user/states";
  static String city = "${baseUrl}user/cities";
  static String getOrder = "${baseUrl}orders";
  static String createOreder = "${baseUrl}orders/create";
  static String cancelOrder = "${baseUrl}orders/cancel";
  static String getAddress = "${baseUrl}address";
  static String addAddress = "${baseUrl}address/add";
  static String editAdress = "${baseUrl}address/edit";
  static String deleteAdress = "${baseUrl}address/delete";
  static String updatePassword = "${baseUrl}user/password/update";
  static String wallet = "${baseUrl}user/wallet";
  static String netUrl =
      "https://bharatmart.akshayanidhi.digital/images/products/";
}
