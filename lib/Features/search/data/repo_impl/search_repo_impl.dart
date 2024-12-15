import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import '../../../../constants.dart';
import '../../../../core/utiles/firebase_firestore_services.dart';
import '../../../home/data/models/product_model.dart';
import '../../domain/repo/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final FirestoreServices fireStoreServices;

  SearchRepoImpl({required this.fireStoreServices});

  @override
  Future<List<Product>> getSearchResult(String search) async {
    if (search.trim().isEmpty) {
      return [];
    }

    try {

      final snapshot = await fireStoreServices
          .getCollectionRef(productsCollectionKey)
          .where('name', isGreaterThanOrEqualTo: search)
          .where('name', isLessThanOrEqualTo: '$search\uf8ff')
          .get();

      final products = snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data(), doc.id))
          .toList();

      return products.map((model) => model.toEntity()).toList();
    } catch (e) {
      print("Failed to get search results: ${e.toString()}");
      return [];
    }
  }
}
