import 'package:deliverapp/data/reposetory/popular_product_repo.dart';
import 'package:deliverapp/data/reposetory/recommended_product_repo.dart';
import 'package:deliverapp/model/popuar_product_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  late final RecommendedProductRepo recommendedProductRepo;
  List<ProductModel> _recommendedproductlist = [];
  List<ProductModel> get recommendedproductlist => _recommendedproductlist;
  bool isLoaded = false;

  RecommendedProductController({required this.recommendedProductRepo});

  // ignore: non_constant_identifier_names
  Future<void> GetRecommendedProductlist() async {
    Response response =
        await recommendedProductRepo.GetRecommendedtProductList();
    if (response.statusCode == 200) {
      print("got Recommended");
      _recommendedproductlist.clear();
      _recommendedproductlist = [];
      _recommendedproductlist.addAll(Product.fromJson(response.body).products!);
      isLoaded = true;
      update();
    } else {
      print("could not got Recommended ");
    }
  }
}
