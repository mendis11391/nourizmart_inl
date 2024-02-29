enum ToastType { normal, error, success }

enum LogType { normal, request, response, error, json }

enum ApiCallLoadingTypeEnum {
  none,
  circularProgress,
  customLoading,
  pullToRefresh,
  loadMore,
  search
}

//* Delivery Type
enum DeliveryType { instant, discount }

//* Instant = 1, Discount = 2
extension DeliveryTypeId on DeliveryType {
  int get value {
    return [1, 2][index];
  }
}

//* Register DropDown Type
enum DropDownType { state, district, pincode, area }
