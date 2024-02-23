class AppResource {
  AppResource._privateConstructor();
  static final AppResource _instance = AppResource._privateConstructor();
  factory AppResource() {
    return _instance;
  }

  //* Asset Gif path *//
  static const String gifLoader = 'assets/gifs/gif_tomato.json.zip';
  static const String gifSplash = 'assets/gifs/gif_splash.json.zip';
  static const String gifPlaceHolder = 'assets/gifs/gif_img_ring.gif';
  static const String gifNoData = 'assets/gifs/gif_no_data.zip';

  //* Asset Image path *//
  static const String bgNoImage = 'assets/images/ic_no_image.png';
  // static const String bgLogin = 'assets/images/bg_login.svg';

  //* Asset Icon path *//
  // static const String icNoData = 'assets/icons/ic_empty.svg';
  static const String icAvatar = 'assets/icons/ic_avatar.jpeg';
  static const String icLoginUser = 'assets/icons/ic_login_user.png';
  static const String icArea = 'assets/icons/ic_area.svg';
  static const String icDistrict = 'assets/icons/ic_district.svg';
  static const String icHouse = 'assets/icons/ic_house.svg';
  static const String icLand = 'assets/icons/ic_land.svg';
  static const String icMobile = 'assets/icons/ic_mobile.svg';
  static const String icPincode = 'assets/icons/ic_pincode.svg';
  static const String icState = 'assets/icons/ic_state.svg';
  static const String icStreet = 'assets/icons/ic_street.svg';
  static const String icUser = 'assets/icons/ic_user.svg';
  static const String icNotification = 'assets/icons/ic_notification.svg';
  static const String icCart = 'assets/icons/ic_cart.svg';
  static const String icFilter = 'assets/icons/ic_filter.svg';
  static const String icFilterProduct = 'assets/icons/ic_filter_product.svg';
  static const String icDelete = 'assets/icons/ic_delete.svg';
  static const String icEdit = 'assets/icons/ic_edit.svg';
}
