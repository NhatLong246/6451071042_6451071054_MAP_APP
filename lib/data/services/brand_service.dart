import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/brand_model.dart';

class BrandService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<BrandModel>> getAllFeaturedBrands() async {
    final snapshot = await _db
        .collection('brands')
        .where('isActive', isEqualTo: true)
        .where('isFeatured', isEqualTo: true)
        .get();
    return snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
  }

  Future<List<BrandModel>> getAllBrands() async {
    final snapshot = await _db
        .collection('brands')
        .where('isActive', isEqualTo: true)
        .get();
    return snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
  }
}