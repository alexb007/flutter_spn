import 'package:floor/floor.dart';
import 'package:spn_flutter/data/db/database.dart';
import 'package:spn_flutter/data/db/models/category.dart';
import 'package:spn_flutter/data/db/models/matrix.dart';
import 'package:spn_flutter/data/db/models/walk_type.dart';

var assetsBaseDir = 'assets/category/';

var categories = [
  Category(null, 'Parks & Green Areas', 'green_areas', null, ''),
  Category(null, 'Parks & Gardens', 'green_areas', 1,
      'leisure:park,leisure:garden,leisure:nature_reserve,tourism:zoo'),
  Category(null, 'Ponds and other water places', 'green_areas', 1,
      'natural:water,leisure:beach_resort,leisure:swimming_area'),
  Category(
      null, 'Grave yard', 'green_areas', 1, 'amenity:grave_yard,building:ruins'),
  Category(null, 'Nature', 'green_areas', 1, ''),

  Category(null, 'Playgrounds', 'playgrounds', null, ''),
  Category(null, 'For children', 'playgrounds', 6,
      'leisure:playground,tourism:theme_park'),
  Category(null, 'For dogs', 'playgrounds', 6, 'leisure:dog_park'),
  Category(null, 'For sport', 'playgrounds', 6,
      'sport:climbing_adventure,sport:skateboard,leisure:sports_centre'),

  Category(null, 'Objects for walking', 'street_furnitures', null, ''),
  Category(null, 'Benches', 'street_furnitures', 10, 'amenity:bench'),
  Category(null, 'Picnic tables', 'street_furnitures', 10,
      'leisure:picnic_table,tourism:picnic_site'),
  Category(null, 'Drinking water', 'street_furnitures', 10,
      'amenity:drinking_water,amenity:water_point,man_made:water_tap'),
  Category(null, 'Footways', 'street_furnitures', 10,
      'highway:footway,highway:pedestrian'),
  Category(null, 'Viewpoints', 'street_furnitures', 10, 'tourism:viewpoint'),
  Category(null, 'Monuments', 'street_furnitures', 10,
      'historic:monument,historic:pillory,historic:wayside_shrine,historic:memorial,historic:milestone,historic:cannon,historic:ruins,historic:yes'),
  Category(null, 'Street furniture', 'street_furnitures', 10, 'amenity:public_bookcase,amenity:clock'),
  Category(null, 'Fountains', 'street_furnitures', 10, 'amenity:fountain'),
  Category(null, 'Picnic sites', 'street_furnitures', 10, 'tourism:picnic_site,amenity:bbq'),
  Category(null, 'Murals', 'street_furnitures', 10, 'tourism:artwork'),

  Category(null, 'SOS', 'sos', null, ''),
  Category(null, 'Toilets', 'sos', 21, 'amenity:toilets,toilets:wheelchair,building:toilets'),
  Category(null, 'Pharmacy', 'sos', 21, 'amenity:pharmacy'),
  Category(null, 'Hospital', 'sos', 21, 'amenity:hospital'),
  Category(null, 'Police', 'sos', 21, 'amenity:police'),
  Category(null, 'I’m lost', 'sos', 21, ''),

  Category(null, 'ART & Culture, Entertainment', 'culture_events', null, ''),
  Category(null, 'Dance club', 'culture_events', 27, 'amenity:nightclub'),
  Category(null, 'Cinema', 'culture_events', 27, 'amenity:cinema'),
  Category(null, 'Theater', 'culture_events', 27, 'amenity:theatre'),
  Category(null, 'Library', 'culture_events', 27, ''),
  Category(null, 'Monument', 'culture_events', 27, ''),
  Category(null, 'Historic Building', 'culture_events', 27, 'historic:building,historic:castle,historic:church'),
  Category(null, 'Museum', 'culture_events', 27, 'tourism:museum,tourism:gallery'),
  Category(null, 'Events', 'culture_events', 27, ''),

  Category(null, 'Eat and Drink', 'where_to_eat', null, ''),
  Category(null, 'Café', 'where_to_eat', 36, 'amenity:cafe'),
  Category(null, 'Restaurants', 'where_to_eat', 36, 'amenity:restaurant'),
  Category(null, 'Food court', 'where_to_eat', 36, 'amenity:fast_food,amenity:food_court'),
  Category(null, 'Bars', 'where_to_eat', 36, 'amenity:bar,amenity:biergarten,amenity:pub'),

  Category(null, 'Store and Shops', 'where_to_eat', null, ''),
  Category(null, 'Shopping center', 'where_to_eat', 41, 'shop:department_store,shop:general,shop:mall'),
  Category(null, 'Supermarket', 'where_to_eat', 41, 'shop:supermarket'),
  Category(null, 'Grocery store', 'where_to_eat', 41, 'shop:bakery,shop:cheese,shop:chocolate,shop:convenience,shop:butcher'),
  Category(null, 'DIY', 'where_to_eat', 41, 'shop:doityourself,shop:electrical,shop:energy,shop:garden_centre,shop:houseware,shop:hardware'),
  Category(null, 'Sport', 'where_to_eat', 41, 'shop:sports'),
  Category(null, 'Books', 'where_to_eat', 41, 'shop:books'),

  Category(null, 'Business and finance', 'atm', null, ''),
  Category(null, 'Exchange', 'atm', 48, 'amenity:bureau_de_change'),
  Category(null, 'ATM', 'atm', 48, 'amenity:atm'),
  Category(null, 'Bank', 'atm', 48, 'amenity:bank'),

  Category(null, 'WiFi', 'wifi', null, 'internet_access:yes,amenity:internet_cafe'),

  Category(null, 'Post', 'post', null, 'amenity:post_box,amenity:post_office'),

  Category(null, 'Public Transport', 'transport', null, ''),
  Category(null, 'Bus station', 'transport', 54, 'highway:bus_stop,public_transport:stop_position,public_transport:platform'),
  Category(null, 'Public transportation', 'transport', 54, 'public_transport:station,public_transport:stop_area'),
  Category(null, 'Railway station', 'transport', 54, 'railway:light_rail,railway:subway,railway:tram,railway:halt,public_transport:stop_position,railway:platform,public_transport:station,railway:subway_entrance,railway:tram_stop'),
  Category(null, 'Bicycle parking', 'transport', 54, ''),
  Category(null, 'Airport', 'transport', 54, ''),
  Category(null, 'Port', 'transport', 54, ''),

  Category(null, 'Services', 'services', null, ''),
  Category(null, 'Hairdresser', 'services', 61, ''),
  Category(null, 'Beauty salon', 'services', 61, ''),
  Category(null, 'Sauna', 'services', 61, ''),
  Category(null, 'Recycling', 'services', 61, ''),

//  Category(null, 'For city visitors', 'For city visitors', null, ''),
//  Category(null, 'Information for tourists', 'Information for tourists', null, ''),
//  Category(null, 'Toilets', 'Toilets', null, ''),
//  Category(null, 'Events', 'Events', null, ''),
//  Category(null, 'Sport', 'Sport', null, ''),
//  Category(null, 'Arena', 'Arena', null, ''),
//  Category(null, 'Ice rink', 'Ice rink', null, ''),
//  Category(null, 'Gym', 'Gym', null, ''),
//  Category(null, 'Tennis court', 'Tennis court', null, ''),
//  Category(null, 'Football field', 'Football field', null, ''),
//  Category(null, 'Swimming pool', 'Swimming pool', null, ''),
//  Category(null, 'Basketball court', 'Basketball court', null, ''),
//  Category(null, 'Volleyball court', 'Volleyball court', null, ''),
//  Category(null, 'Religion', 'Religion', null, ''),
//  Category(null, 'Temple', 'Temple', null, ''),
//  Category(null, 'Mosque', 'Mosque', null, ''),
//  Category(null, 'Church', 'Church', null, ''),
//  Category(null, 'Synagogue', 'Synagogue', null, ''),
//  Category(null, 'Accommodation', 'Accommodation', null, ''),
//  Category(null, 'Education', 'Education', null, ''),
//  Category(null, 'Kindergarten', 'Kindergarten', null, ''),
//  Category(null, 'University', 'University', null, ''),
//  Category(null, 'School', 'School', null, ''),
//  Category(null, 'Government institutions', 'Government institutions', null, ''),
//  Category(null, 'Town Hall', 'Town Hall', null, ''),
//  Category(null, 'Police station', 'Police station', null, ''),
//  Category(null, 'Court', 'Court', null, ''),
//  Category(null, 'Prosecutor etc.', 'Prosecutor etc.', null, ''),
//  Category(null, 'Notary', 'Notary', null, ''),
//  Category(null, 'Lawyer', 'Lawyer', null, ''),
];

var walkTypes = [
  WalkType(1, 'Go through'),
  WalkType(2, 'Walk with children'),
  WalkType(3, 'Walk with friends'),
  WalkType(4, 'Walk with the disabled person'),
  WalkType(5, 'Walk the dog'),
  WalkType(6, 'SOS'),
  WalkType(7, '10,000 steps'),
];

var matrix = [
  Matrix(null, 1, '1,2,3,4,5,7'),
  Matrix(null, 6, '1,2,7'),
  Matrix(null, 10, '1,2,3,4,5,7'),
  Matrix(null, 21, '6'),
  Matrix(null, 27, '1,2,3,4'),
  Matrix(null, 36, '1,3,4'),
];

@transaction
Future<void> initializeData() async {
  var db = await Floor.instance.database;
  db.categoryDao.insertCategories(categories);
  db.walkTypeDao.insertWalkTypes(walkTypes);
  db.matrixDao.insertMatrixes(matrix);
}
