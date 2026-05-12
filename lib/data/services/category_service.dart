import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category_model.dart';
class CategoryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<List<CategoryModel>> getAllCategories() async {
    final snapshot = await _db
        .collection('categories')
        .get();
    final list = snapshot.docs
        .map((doc) => CategoryModel.fromSnapshot(doc))
        .where((c) => c.isActive)
        .toList();
    list.sort((a, b) => a.priority.compareTo(b.priority));
    return list.take(10).toList();
  }
}