import 'package:flutter/material.dart';

import 'package:study_flutter/product/component/pagination_list_view.dart';
import 'package:study_flutter/restaurant/component/restuarant_card.dart';
import 'package:study_flutter/restaurant/provider/reataurant_provider.dart';
import 'package:study_flutter/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      provider: restaurantProvider,
      itemBuilder: <RestaurantModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => RestaurantDetailScreen(
                  id: model.id,
                ),
              ),
            );
          },
          child: RestuarantCard.fromModel(
            model: model,
          ),
        );
      },
    );
  }
}
