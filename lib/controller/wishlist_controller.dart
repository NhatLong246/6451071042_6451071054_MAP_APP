import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../controller/login_controller.dart';
import '../data/models/product_model.dart';

class WishlistController extends GetxController {
  final RxList<String> wishlistIds = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadWishlist();
  }

  Future<void> _loadWishlist() async {
    final user = Get.find<AuthController>().currentUser;
    if (user == null) return;
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .collection('wishlist')
        .get();
    wishlistIds.assignAll(snapshot.docs.map((doc) => doc.id));
  }

  bool isInWishlist(String productId) {
    return wishlistIds.contains(productId);
  }

  Future<void> toggleWishlist(ProductModel product) async {
    final user = Get.find<AuthController>().currentUser;
    if (user == null) return;

    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .collection('wishlist')
        .doc(product.id);

    if (isInWishlist(product.id)) {
      await ref.delete();
      wishlistIds.remove(product.id);
    } else {
      await ref.set({'title': product.title, 'thumbnail': product.thumbnail});
      wishlistIds.add(product.id);
    }
  }
}
