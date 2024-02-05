// import 'dart:convert';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:dms_picklite/exceptions/dio_exception.dart';
// import 'package:dms_picklite/model/request_model/bank_list_request_model/bank_list_request_model.dart';
// import 'package:dms_picklite/model/request_model/cancel_attempt_request_model/cancel_attempt_delivery_request_model.dart';
// import 'package:dms_picklite/model/request_model/cancel_delatmpt_list_reason_request_model/cancel_or_delivery_attempt_reason_list_request_model.dart';
// import 'package:dms_picklite/model/request_model/complete_order_request_model/complete_order_request_model.dart';
// import 'package:dms_picklite/model/request_model/delivery_count_request_model/delivery_count_request_model.dart';
// import 'package:dms_picklite/model/request_model/delivery_history_request_model/delivery_history_request_model.dart';
// import 'package:dms_picklite/model/request_model/delivery_request_model/delivery_request_model.dart';
// import 'package:dms_picklite/model/request_model/models/auth_request_model.dart';
// import 'package:dms_picklite/model/request_model/multi_payment_request_model/multi_payment_request_model.dart';
// import 'package:dms_picklite/model/request_model/partail_delivery_collection_check_request_model/partail_delivery_collection_check_request_model.dart';
// import 'package:dms_picklite/model/request_model/pending_delivery_request_model/pending_delivery_request_model.dart';
// import 'package:dms_picklite/model/request_model/pick_list_completed_request_model/pick_list_completed_request_model.dart';
// import 'package:dms_picklite/model/request_model/popup_accept_request_model/pop_up_accept_request_model.dart';
// import 'package:dms_picklite/model/request_model/put_list_request_model/put_list_request_model.dart';
// import 'package:dms_picklite/model/request_model/put_submit_request_model/put_submit_request_model.dart';
// import 'package:dms_picklite/model/request_model/reason_list/reason_request_model.dart';
// import 'package:dms_picklite/model/request_model/request_otp_model/request_otp_request_model.dart';
// import 'package:dms_picklite/model/request_model/return_to_fc_request_model/return_to_fc_request_model.dart';
// import 'package:dms_picklite/model/request_model/should_return_to_fc_check_request_model/should_return_to_fc_check_request_model.dart';
// import 'package:dms_picklite/model/request_model/store_update_request_model/store_update_request_model.dart';
// import 'package:dms_picklite/model/request_model/unverified_reason_request_model/unverified_reason_request_model.dart';
// import 'package:dms_picklite/model/request_model/verify_otp_request_model/verify_otp_request_model.dart';

// import 'package:dms_picklite/model/response_model/bank_list_response_model/bank_list_response_model.dart';
// import 'package:dms_picklite/model/response_model/cancel_attempt_response_model/cancel_attempt_delivery_response_model.dart';
// import 'package:dms_picklite/model/response_model/cancel_delatmpt_reason_list_response_model/cancel_or_delivery_atmpt_reason_list_response_model.dart';
// import 'package:dms_picklite/model/response_model/collection_reasons_model/collection_reasons_model.dart';
// import 'package:dms_picklite/model/response_model/complete_order_response_model/complete_order_response_model.dart';
// import 'package:dms_picklite/model/response_model/delivery_count_response_model/delivery_count_response_model.dart';
// import 'package:dms_picklite/model/response_model/delivery_details_response_model/delivery_details_response_model.dart';
// import 'package:dms_picklite/model/response_model/delivery_history_response_model/delivery_collection_history_model.dart';
// import 'package:dms_picklite/model/response_model/delivery_history_response_model/delivery_history_response_model.dart';
// import 'package:dms_picklite/model/response_model/delivery_response_model/delivery_response_model.dart';
// import 'package:dms_picklite/model/response_model/multi_payment_response_model/multi_payment_response.dart';
// import 'package:dms_picklite/model/response_model/order_details_response_model/order_list_details_response_model.dart';
// import 'package:dms_picklite/model/response_model/partial_delivery_collection_check_response_model/partial_delivery_collection_check_response_model.dart';
// import 'package:dms_picklite/model/response_model/payment_type_response_model/payment_types_response_model.dart';

// import 'package:dms_picklite/model/response_model/pending_delivery_response_model/pending_delivery_response_model.dart';
// import 'package:dms_picklite/model/response_model/pick_id_send_response_model/data.dart';
// import 'package:dms_picklite/model/response_model/pick_id_send_response_model/pick_id_sendresponse_model.dart';
// import 'package:dms_picklite/model/response_model/pick_list_completed_response_model/pick_list_completed_response_model.dart';
// import 'package:dms_picklite/model/response_model/popup_accept_response_model/pop_up_accept_response_model.dart';
// import 'package:dms_picklite/model/response_model/popup_id_response_model/pop_up_id_response_model.dart';
// import 'package:dms_picklite/model/response_model/profile_response_model/profile_response_model.dart';
// import 'package:dms_picklite/model/response_model/put_list_response_model/put_list_response_model.dart';
// import 'package:dms_picklite/model/response_model/put_submit_response_model/put_submit_response_model.dart';
// import 'package:dms_picklite/model/response_model/reason_response_model/reason_response_model.dart';
// import 'package:dms_picklite/model/response_model/request_otp_response_model/request_otp_response_model.dart';
// import 'package:dms_picklite/model/response_model/return_to_fc_response_model/return_to_fc_response_model.dart';
// import 'package:dms_picklite/model/response_model/should_return_to_fc_check_response_model/should_return_to_fc_response_model.dart';
// import 'package:dms_picklite/model/response_model/store_update_response_model/store_update_response_model.dart';
// import 'package:dms_picklite/model/response_model/unverified_reason_response_model/unverified_reason_response_model.dart';
// import 'package:dms_picklite/model/response_model/upi_ref_no_list_response_model/upi_ref_no_list_response_model.dart';
// import 'package:dms_picklite/model/response_model/verify_otp_response_model/verify_otp_response_model.dart';

// import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:nourish_mart/model/user_register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import 'api_constants.dart';
import 'api_provider.dart';

class Repository {
  ApiProvider apiProvider = new ApiProvider();
  SharedPreferences? sharedPreferences;

  Future<Map?> checkIfUserExists(String userId) async {
    var response;
    try {
      response = await apiProvider.get(
          ApiConstants.checkIfUserExistsURL + userId, 'nm');
      return response as Map;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> registerUser(UserRegisterModel userRegisterModel) async {
    var response;
    // UserRegisterModel userRegisterModel =
    //     userRegisterModelFromJson(jsonEncode(userModel.toMap()));
    // log(json.decode(jsonEncode(userModel.toMap())));
    try {
      response = await apiProvider.post(
        ApiConstants.registerUserURL,
        'nm',
        userRegisterModel.toJson(),
        // json.decode(jsonEncode(userModel.toMap()))
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

//   Future<ProfileResponseModel?> champLogin(
//       AuthRequestModel authRequestModel) async {
//     var response;
//     try {
//       response = await apiProvider.post(
//           ApiConstants.champLoginUrl, 'cdms', authRequestModel.toJson());
//       return ProfileResponseModel.fromJson(response);
//     } on DioError catch (dioError) {
//       if (dioError.type == DioExceptionType.badResponse &&
//           (dioError.response?.statusCode! == 400 ||
//               dioError.response?.statusCode! == 500)) {
//         return ProfileResponseModel.fromJson(dioError.response?.data);
//       } else {
//         return ProfileResponseModel.fromJson(dioError.response?.data);
//       }
//     } on Error catch (e) {
//       ProfileResponseModel pfm = e as ProfileResponseModel;
//       return ProfileResponseModel.fromJson(pfm.toJson());
//     } catch (e) {
//       ProfileResponseModel pfm = e as ProfileResponseModel;
//       return ProfileResponseModel.fromJson(pfm.toJson());
//     }
//   }

//   Future<DeliveryResponseModel?> getDeliveryList(
//       DeliveryRequestModel deliveryRequestModel) async {
//     var response;
//     try {
//       response = await apiProvider.post(
//         ApiConstants.orderListURL,
//         'cdms',
//         deliveryRequestModel.toJson(),
//       );
//       return DeliveryResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<ProfileResponseModel?> getProfile() async {
//     var response;
//     try {
//       response = await apiProvider.get(ApiConstants.profileURL, 'cdms');
//       return ProfileResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<PendingDeliveryResponseModel?> getPendingDeliverylist(
//       PendingDeliveryRequestModel pendingDeliveryRequestModel) async {
//     var response;
//     try {
//       response = await apiProvider.post(
//         ApiConstants.orderListURL,
//         'cdms',
//         pendingDeliveryRequestModel.toJson(),
//       );
//       return PendingDeliveryResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<ReasonResponseModel?> getReasonList(
//       ReasonRequestModel reasonRequestModel) async {
//     var response;
//     try {
//       response = await apiProvider.post(
//           ApiConstants.reasonDetailsURL, 'cdms', reasonRequestModel.toJson());
//       return ReasonResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<DeliveryDetailsResponseModel?> getDeliveryDetails(
//       String? orderId) async {
//     var response;
//     try {
//       response = await apiProvider.get(
//           ApiConstants.orderDetailsURL + orderId!, 'cdms');
//       return DeliveryDetailsResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<PaymentTypesResponseModel?> getPaymentTypes() async {
//     var response;
//     try {
//       response = await apiProvider.get(ApiConstants.paymentTypesURL, 'cdms');
//       return PaymentTypesResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<BankListResponseModel?> getBankList(
//       BankListRequestModel bankListRequestModel) async {
//     var response;
//     try {
//       response = await apiProvider.post(
//           ApiConstants.bankListURL, 'cdms', bankListRequestModel.toJson());
//       return BankListResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<CancelOrDeliveryAtmptReasonListResponseModel?>
//       getReasonCancelOrDelAtmptList(
//           CancelOrDeliveryAttemptReasonListRequestModel
//               cancelOrDeliveryAttemptReasonListRequestModel) async {
//     var response;
//     try {
//       response = await apiProvider.post(ApiConstants.reasonDetailsURL, 'cdms',
//           cancelOrDeliveryAttemptReasonListRequestModel.toJson());
//       return CancelOrDeliveryAtmptReasonListResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<CancelAttemptDeliveryResponseModel?> submitCancelOrder(
//       CancelAttemptDeliveryRequestModel cancelAttemptDeliveryRequestModel,
//       String orderID) async {
//     var response;
//     try {
//       response = await apiProvider.post(
//           ApiConstants.orderURL + orderID + "/cancel",
//           'cdms',
//           cancelAttemptDeliveryRequestModel.toJson());
//       return CancelAttemptDeliveryResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<CancelAttemptDeliveryResponseModel?> submitDeliveryAttemptedOrder(
//       CancelAttemptDeliveryRequestModel cancelAttemptDeliveryRequestModel,
//       String orderID) async {
//     var response;
//     try {
//       response = await apiProvider.post(
//           ApiConstants.orderURL + orderID + "/attempt",
//           'cdms',
//           cancelAttemptDeliveryRequestModel.toJson());
//       return CancelAttemptDeliveryResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<PickListCompletedResponseModel?> getCompletedPickingLlist(
//       PickListCompletedRequestModel pickListCompletedRequestModel) async {
//     var response;
//     try {
//       response = await apiProvider.post(ApiConstants.pickCompletedList, 'cdms',
//           pickListCompletedRequestModel.toJson());
//       return PickListCompletedResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<PickIdSendresponseModel?> sendPickId(String orderID) async {
//     var response;
//     try {
//       response = await apiProvider.post(
//           ApiConstants.pickIdSend + orderID + "/pick", 'cdms', "");
//       return PickIdSendresponseModel.fromJson(response);
//     } catch (e) {
//       if (e is DioException) {
//         if (e.error is SocketException) {
//           throw e;
//         } else {
//           Map valueMap = jsonDecode(e.response.toString());
//           return PickIdSendresponseModel(
//               success: valueMap["success"],
//               data: Data(count: 0, message: valueMap["error"]["message"]));
//         }
//       } else {
//         throw e;
//       }
//     }
//   }

//   Future<PutListResponseModel?> getPutList(
//       PutListRequestModel putListRequestModel, String orderID) async {
//     var response;

//     try {
//       response = await apiProvider.post(
//           ApiConstants.pickIdSend + orderID + "/picklist",
//           'cdms',
//           putListRequestModel.toJson());

//       return PutListResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<PutSubmitResponseModel?> submitPutList(
//       PutSubmitRequestModel putSubmitRequestModel, String orderID) async {
//     var response;

//     try {
//       response = await apiProvider.post(
//           ApiConstants.pickIdSend + orderID + "/put",
//           'cdms',
//           putSubmitRequestModel.toJson());
//       return PutSubmitResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<CompleteOrderResponseModel?> submitCompleteOrder(
//       CompleteOrderRequestModel completeOrderRequestModel,
//       String orderID,
//       String urlID) async {
//     var response;

//     try {
//       response = await apiProvider.post(ApiConstants.orderURL + orderID + urlID,
//           'cdms', completeOrderRequestModel.toJson());
//       return CompleteOrderResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<DeliveryCountResponseModel?> getCountOrder(
//       DeliveryCountRequestModel deliveryCountRequestModel) async {
//     var response;
//     try {
//       response = await apiProvider.post(ApiConstants.countDeliveryDetails,
//           'cdms', deliveryCountRequestModel.toJson());
//       return DeliveryCountResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<ProfileResponseModel?> getNewAccessToken() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     var response;
//     try {
//       Map<String, String> headers = {
//         "Content-Type": "application/json",
//         'Authorization':
//             'Bearer ${sharedPreferences!.getString("refresh_token")}',
//       };
//       response = await apiProvider.post(
//           ApiConstants.profileURL, 'cdms', {"is_mobile": "true"},
//           headers: headers);
//       return ProfileResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<OrderListDetailsResponseModel?> getOrderDetails(String orderID) async {
//     var response;
//     try {
//       response = await apiProvider.get(ApiConstants.orderURL + orderID, 'cdms');
//       return OrderListDetailsResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<PopUpIdResponseModel?> getPopUp() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     var response;
//     try {
//       Map<String, String> headers = {
//         "Content-Type": "application/json",
//         'Authorization':
//             'Bearer ${sharedPreferences!.getString("access_token")}',
//         "date": "${DateTime.now()}"
//       };
//       response = await apiProvider.get(ApiConstants.getPopup, 'cdms',
//           headers: headers);
//       return PopUpIdResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<PopUpAcceptResponseModel?> submitPopUp(
//       PopUpAcceptRequestModel popUpAcceptRequestModel) async {
//     var response;
//     try {
//       response = await apiProvider.post(
//           ApiConstants.acceptPopup, 'cdms', popUpAcceptRequestModel.toJson());
//       return PopUpAcceptResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<ShouldReturnToFcResponseModel?> shouldReturnToFCCheck(
//       ShouldReturnToFcCheckRequestModel
//           shouldRetuenToFcCheckRequestModel) async {
//     var response;
//     try {
//       response = await apiProvider.post(ApiConstants.shouldRetunToFC, 'cdms',
//           shouldRetuenToFcCheckRequestModel.toJson());
//       return ShouldReturnToFcResponseModel.fromJson(response);
//     } catch (e) {
//       return response;
//     }
//   }

//   Future<ReturnToFcResponseModel?> returnToFC(
//       ReturnToFcRequestModel returnToFcRequestModel) async {
//     var response;
//     try {
//       response = await apiProvider.post(
//           ApiConstants.returnToFc, 'cdms', returnToFcRequestModel.toJson());
//       return ReturnToFcResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<PartialDeliveryCollectionCheckResponseModel?> checkPartialCollection(
//       PartailDeliveryCollectionCheckRequestModel
//           partailDeliveryCollectionCheckRequestModel,
//       String orderID) async {
//     var response;
//     try {
//       response = await apiProvider.post(
//           ApiConstants.orderURL + orderID + "/partial/to_collect",
//           'cdms',
//           partailDeliveryCollectionCheckRequestModel.toJson());
//       return PartialDeliveryCollectionCheckResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<RequestOtpResponseModel?> requestOTP(
//       RequestOtpRequestModel requestOtpRequestModel) async {
//     var response;
//     try {
//       response = await apiProvider.post(
//           ApiConstants.requestOTP, 'cdms', requestOtpRequestModel.toJson());
//       return RequestOtpResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<VerifyOtpResponseModel?> verifyOTP(
//       VerifyOtpRequestModel verifyOtpRequestModel) async {
//     var response;
//     try {
//       response = await apiProvider.post(
//           ApiConstants.verifyOTP, 'cdms', verifyOtpRequestModel.toJson());
//       return VerifyOtpResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<StoreUpdateResponseModel?> storeUpdate(
//       StoreUpdateRequestModel storeUpdateRequestModel) async {
//     var response;
//     try {
//       response = await apiProvider.put(
//           ApiConstants.storeUpdate, 'cdms', storeUpdateRequestModel.toJson());
//       return StoreUpdateResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<UpiRefNoListResponse?> getUpiRefNoList(
//       int storeId, String amount, String query) async {
//     var response;
//     try {
//       response = await apiProvider.get(
//           ApiConstants.upiReferenceNumberList +
//               "?type=UPI&store_id=$storeId&amount=$amount&query=$query",
//           'collection');
//       return UpiRefNoListResponse.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<MultiPaymentResponse> submitMultiPaymentCollection(
//       MultiPaymentRequest multiPaymentRequest, String orderID) async {
//     var response;

//     try {
//       response = await apiProvider.post(
//           ApiConstants.collectionSubmit + orderID + "/complete",
//           'collection',
//           multiPaymentRequest.toJson());
//       print(response);
//       return MultiPaymentResponse.fromJson(response);
//     } on CDMSDioException catch (dioError) {
//       return MultiPaymentResponse.fromJson({"error": dioError.message});
//     } on Error catch (e) {
//       return MultiPaymentResponse.fromJson({"error": e.toString()});
//     } catch (e) {
//       return MultiPaymentResponse.fromJson({"error": e.toString()});
//     }
//   }

//   Future<UnverifiedReasonsResponseModel?> getRetailerUnverifiedReasons() async {
//     var response;
//     try {
//       response =
//           await apiProvider.get(ApiConstants.retailerUnverifiedReasons, 'oms');
//       return UnverifiedReasonsResponseModel.fromJson(response);
//     } on DioException catch (dioError) {
//       return UnverifiedReasonsResponseModel.fromJson(dioError.response?.data);
//     } on Error catch (e) {
//       return UnverifiedReasonsResponseModel.fromJson({"error": e.toString()});
//     } catch (e) {
//       return UnverifiedReasonsResponseModel.fromJson({"error": e.toString()});
//     }
//   }

//   Future<CollectionReasonsModel?> getCollectionsReasons() async {
//     var response;
//     try {
//       response =
//           await apiProvider.get(ApiConstants.collectionReasons, 'collection');
//       return CollectionReasonsModel.fromJson(response);
//     } on DioException catch (dioError) {
//       return CollectionReasonsModel.fromJson(dioError.response?.data);
//     } on Error catch (e) {
//       return CollectionReasonsModel.fromJson({"error": e.toString()});
//     } catch (e) {
//       return CollectionReasonsModel.fromJson({"error": e.toString()});
//     }
//   }

//   Future<UnverifiedReasonsResponseModel?> setRetailerUnverifiedReasons(
//       UnverifiedReasonsRequestModel unverifiedReasonsRequestModel) async {
//     var response;
//     try {
//       response = await apiProvider.post(ApiConstants.retailerUnverifiedReasons,
//           'oms', unverifiedReasonsRequestModel.toJson());
//       return UnverifiedReasonsResponseModel.fromJson(response);
//     } on DioException catch (dioError) {
//       return UnverifiedReasonsResponseModel.fromJson(dioError.response?.data);
//     } on Error catch (e) {
//       return UnverifiedReasonsResponseModel.fromJson({"error": e.toString()});
//     } catch (e) {
//       return UnverifiedReasonsResponseModel.fromJson({"error": e.toString()});
//     }
//   }

//   Future<DeliveryHistoryResponseModel?> deliveryHistory(
//       Map deliveryHistoryRequestModel) async {
//     var response;
//     try {
//       response = await apiProvider.post(ApiConstants.deliveryHistory, 'oms',
//           jsonEncode(deliveryHistoryRequestModel));
//       return DeliveryHistoryResponseModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<DeliveryCollectionHistoryModel?> deliveryCollectionHistory(
//       Map deliveryCollectionRequestModel) async {
//     var response;
//     try {
//       response = await apiProvider.post(ApiConstants.deliveryHistory, 'oms',
//           jsonEncode(deliveryCollectionRequestModel));
//       return DeliveryCollectionHistoryModel.fromJson(response);
//     } catch (e) {
//       throw e;
//     }
//   }
}
