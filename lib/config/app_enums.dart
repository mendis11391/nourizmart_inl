// import 'package:dms_picklite/style/app_colors.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ///enums for the delivery codes
// Map<String, String> status_enums = {
//   "OP": "Order Placed",
//   "OC": "Order Confirmed",
//   "PI": "Ready For Pickup",
//   "PU": "Picked and Put",
//   "VA": "Pending Delivery",
//   "OD": "Out for Delivery",
//   "CA": "Cancelled",
//   "DA": "Delivery Attempted",
//   "PD": "Partial Delivery",
//   "DL": "Delivered",
//   "RD": "Redeliver in Future",
//   "NBB": "No Bill Back",
//   "BB": "Bill Back",
//   "VOU": "Voucher"
// };

// ///enums for the app bar title
// Map<String, String> appBarTitleEnums = {
//   "OP": "Order Placed",
//   "OC": "Order Confirmed",
//   "PI": "Ready For Pickup",
//   "PU": "Picked and Put",
//   "VA": "Pending Delivery",
//   "OD": "Out for Delivery",
//   "CA": Strings.titleCancelled,
//   "DA": Strings.titleDeliveryAttempted,
//   "PD": Strings.titlePartiallyDelivered,
//   "DL": Strings.titleDelivered,
//   "RD": "Redeliver in Future",
//   "NBB": "No Bill Back",
//   "BB": "Bill Back",
//   "VOU": "Voucher"
// };

// /// enums for the delivery colors
// Map<String, dynamic> color_enums = {
//   "CA": AppColors.red,
//   "DL": AppColors.green,
//   "VA": AppColors.red_orange,
//   "PD": AppColors.ilghtgreen,
//   "OD": AppColors.red_orange,
//   "DA": AppColors.iconColor,
//   "RD": AppColors.red_orange,
//   "COD": AppColors.teals
// };

// //// enums for the payment icons
// Map<String, dynamic> iconsEnums = {
//   "CASH": FontAwesomeIcons.euroSign,
//   "UPI": FontAwesomeIcons.googleWallet,
//   "NEFT": FontAwesomeIcons.university,
//   "CHEQUE": FontAwesomeIcons.moneyCheck,
// };

//* Toast Type
enum ToastType { normal, error }

//* normal = 1, error = 2,
extension ToastTypeId on ToastType {
  int get value {
    switch (this) {
      case ToastType.normal:
        return 1;
      case ToastType.error:
        return 2;
    }
  }
}
