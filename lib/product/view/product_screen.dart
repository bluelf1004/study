import 'package:flutter/material.dart';
import 'package:study_flutter/product/component/pagination_list_view.dart';
import 'package:study_flutter/product/component/product_card.dart';
import 'package:study_flutter/product/provider/product_provider.dart';
import 'package:study_flutter/restaurant/view/restaurant_detail_screen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      provider: productProvider,
      itemBuilder: <ProductModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => RestaurantDetailScreen(
                id: model.restaurant.id,
              ),
            ));
          },
          child: ProductCard.fromProductModel(
            model: model,
          ),
        );
      },
    );
  }
}
