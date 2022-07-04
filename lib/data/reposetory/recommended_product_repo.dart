import 'package:deliverapp/data/Api.dart';
import 'package:deliverapp/utilities/AppConstants.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  // ignore: non_constant_identifier_names
  Future<Response> GetRecommendedtProductList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}
