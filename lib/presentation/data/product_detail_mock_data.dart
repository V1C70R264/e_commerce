import 'package:e_commerce/presentation/data/home_mock_data.dart';

abstract final class ProductDetailLayout {
  static const double horizontalPadding = 20;
  static const double imageHeaderHeight = 300;
  static const double imageHeaderRadius = 28;
  static const double backButtonSize = 44;
}

const String kDefaultProductTitle = 'Meat Beef Bone in ± 50 gm';
const String kDefaultProductImageUrl =
    'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?w=600&q=80';
const double kDefaultRating = 4.8;
const int kDefaultReviewCount = 185;
const String kDefaultSeller = 'Tariqul';
const String kDefaultVendor = 'Eshop';


const String kProductDetailDescription =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod '
    'tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, '
    'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo '
    'consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse '
    'cillum dolore eu fugiat nulla pariatur.';

const List<String> kProductDetailTabs = ['Details', 'Support', 'Ratings'];

List<HomeProductItem> get relatedProducts => homePopularProducts;
