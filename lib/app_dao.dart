import 'package:floor/floor.dart';
import 'package:floor_example/app_entity.dart';

@dao
abstract class AppDao {
//get
  @Query('SELECT * FROM ProductTable')
  Stream<List<Product>> getAllProducts();

  @Query('SELECT * FROM ProductTable WHERE id = :id')
  Stream<Product?> getOneProduct(int id);

  //insert
  @insert
  Future<int> addOneProduct(Product p);

//update
  @update
  Future<int> updateOneProduct(Product p);

//delete
  @delete
  Future<int> deleteOneProduct(Product p);

  @Query('DELETE FROM ProductTable')
  Future<void> deleteAll();
}
