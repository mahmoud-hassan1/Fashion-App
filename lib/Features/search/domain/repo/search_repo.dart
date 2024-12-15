import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';

abstract class SearchRepo {
  Future<List<Product>> getSearchResult(String search);
  Future<ScanResult> scanQRCode();
}
