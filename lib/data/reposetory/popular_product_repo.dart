import 'package:deliverapp/data/Api.dart';
import 'package:deliverapp/data/test.dart';
import 'package:deliverapp/utilities/AppConstants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  // ignore: non_constant_identifier_names
  Future<Response> GetPopularProductList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}
