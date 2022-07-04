import 'package:deliverapp/utilities/AppConstants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GET;

class Api {
  static final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.BASE_URL,
      receiveDataWhenStatusError: true,
    ),
  );

  static void initializeInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request, handler) async {
        var token = "";
        // await GetStorage().read('login_token')

        var headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}',
        };

        request.headers.addAll(headers);
        print('${request.method} ${request.path}');
        print('${request.headers}');
        return handler.next(request); //continue
      },
      onResponse: (response, handler) {
        print('${response.data}');
        if (response.data['error'] == 1) throw response.data['message'];

        return handler.next(response); // continue
      },
      onError: (error, handler) {
        if (GET.Get.isDialogOpen == true) {
          GET.Get.back();
        }

        GET.Get.snackbar(
          'error'.tr,
          '${error.message}',
          snackPosition: GET.SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        return handler.next(error); //continue
      },
    ));
  } // end of initializeInterceptor

  static Future<Response> getPopularProducts() async {
    return dio.get(AppConstants.POPULAR_PRODUCT_URI);
  } //end of getGenres

} //end of api
