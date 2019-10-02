import 'package:spn_flutter/models/category.dart';
import 'package:spn_flutter/models/route.dart';

class Constants {
  static const GO_THROUGH = 1;
  static const WALK_WITH_CHILDREN = 2;
  static const WALK_WITH_FRIENDS = 3;
  static const WALK_WITH_THE_DISABLED_PERSON = 4;
  static const WALK_THE_DOG = 5;
  static const SOS = 6;
  static const TT_STEPS = 7; // 10,000 Steps

  static final List<RouteModel> templateWalks = [
    RouteModel(
      title: 'Walk the dog',
      walkTypeId: WALK_THE_DOG,
      description:
          'Описание прогулки и ограничения, которые входят в эту прогулку Описание прогулки и ограничения',
    ),
    RouteModel(
      title: 'Walk with the disabled person',
      walkTypeId: WALK_WITH_THE_DISABLED_PERSON,
      description:
      'Описание прогулки и ограничения, которые входят в эту прогулку Описание прогулки и ограничения',
    ),
    RouteModel(
      title: 'Walk with children',
      walkTypeId: WALK_WITH_CHILDREN,
      description:
      'Описание прогулки и ограничения, которые входят в эту прогулку Описание прогулки и ограничения',
    ),
    RouteModel(
      title: 'Walk with friends',
      walkTypeId: WALK_WITH_FRIENDS,
      description:
      'Описание прогулки и ограничения, которые входят в эту прогулку Описание прогулки и ограничения',
    )
  ];

  static const DB_VERSION = 1;
  static const DB_NAME = 'spn_database.db';

  static final walkTemplates = [];

  static final List<Category> categories = [
    Category(title: 'Green areas', code: 'green_zone', symbol: 'shop-11'),
    Category(
        title: 'Playgrounds',
        code: 'playground',
        symbol: 'shop-11',
        children: [
          Category(title: 'For kids', code: 'playground', symbol: 'shop-11'),
          Category(title: 'For dogs', code: 'playground', symbol: 'shop-11'),
          Category(
              title: 'Sport grounds', code: 'playground', symbol: 'shop-11')
        ]),
    Category(
        title: 'Street furniture', code: 'street_furniture', symbol: 'shop-11'),
    Category(title: 'Transport', code: 'transport', symbol: 'shop-11'),
    Category(
        title: 'Culture events', code: 'culture_events', symbol: 'shop-11'),
  ];
}
