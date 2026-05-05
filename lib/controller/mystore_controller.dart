import 'package:get/get.dart';
import '../data/models/brand_model.dart';
import '../data/models/category_model.dart';
import '../data/models/product_model.dart';
import '../data/services/mystore_service.dart';

class MyStoreController extends GetxController {
  final MyStoreService _service = MyStoreService();
  var isLoading = false.obs;
  var featuredBrands = <BrandModel>[].obs;
  var categories = <CategoryModel>[].obs;
  var categoryBrands = <BrandModel>[].obs;
  var products = <ProductModel>[].obs;
  var selectedCategoryIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    isLoading.value = true;
    featuredBrands.value = await _service.getFeaturedBrands();
    categories.value = await _service.getCategories();
    if (categories.isNotEmpty) {
      await selectCategory(0);
    }
    isLoading.value = false;
  }

  Future<void> selectCategory(int index) async {
    selectedCategoryIndex.value = index;
    final categoryId = categories[index].id;
    final brandIds = await _service.getBrandIdsByCategory(categoryId);
    categoryBrands.value = featuredBrands
        .where((brand) => brandIds.contains(brand.id))
        .toList();
    products.value = await _service.getProductsByCategoryAndBrands(
      categoryId,
      brandIds,
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  final String id;
  final String name;
  final String imageUrl;
  final bool isFeatured;
  final bool isActive;
  final int productsCount;

  BrandModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.isFeatured,
    required this.isActive,
    required this.productsCount,
  });

  factory BrandModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BrandModel(
      id: doc.id,
      name: data['name'] ?? '',
      imageUrl: data['imageURL'] ?? '',
      isFeatured: data['isFeatured'] ?? false,
      isActive: data['isActive'] ?? false,
      productsCount: data['productsCount'] ?? 0,
    );
  }

  BrandModel copyWith({int? productsCount}) {
    return BrandModel(
      id: id,
      name: name,
      imageUrl: imageUrl,
      isFeatured: isFeatured,
      isActive: isActive,
      productsCount: productsCount ?? this.productsCount,);
  }
}