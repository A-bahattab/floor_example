import 'package:floor/floor.dart';

@Entity(tableName: 'ProductTable', foreignKeys: [
  ForeignKey(
      childColumns: ['categoryId'], parentColumns: ['id'], entity: Category)
])
class Product {
  @primaryKey
  int? id;
  @ColumnInfo(name: 'pname')
  String? name;
  int? categoryId;
  double price;

  Product({this.id, this.name, this.price = 0.0, this.categoryId});
}

@entity
class Category {
  @primaryKey
  int? id;
  String? name;

  Category({this.id, this.name});
}
