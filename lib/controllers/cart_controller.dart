import 'package:app_food/data/repository/cart_repo.dart';
import 'package:app_food/models/food_model.dart';
import 'package:get/get.dart';
import '../models/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<String, CartModel> _items = {};
  Map<String, CartModel> get items => _items;
  List<CartModel> storageItems=[];
  String? topping;
  void addItem(FoodTopping food, int quantity, List<ListTopping> topping) {

    var totalQuantity = 0;
    if (_items.containsKey(food.foodId!)) {
      _items.update(food.foodId!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          foodId: value.foodId,
          foodName: value.foodName,
          price: value.price,
          imageUrl: value.imageUrl,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          listFoodTopping: topping,
          food: food,
        );
      });
      if (totalQuantity <= 0) {
        _items.remove(food.foodId);
      }
    } else {
      _items.putIfAbsent(food.foodId!, () {
        return CartModel(
          foodId: food.foodId,
          foodName: food.name,
          price: food.price,
          imageUrl: food.urlImage,
          quantity: quantity,
          isExist: true,
          time: DateTime.now().toString(),
          listFoodTopping: topping,
          food: food,
        );
      });
    }
    // _items.values.forEach((element) {
    //   element.listFoodTopping.forEach((element) {
    //     print(element.name);
    //   });
    // });

    cartRepo.addToCartList(getItems);
    update();
  }

  existInCart(FoodTopping food) {
    if (_items.containsKey(food.foodId)) {
      return true;
    }
    return false;
  }
  getListTopping(FoodTopping food){
     List<dynamic> toppingID=[];
     if(_items.containsKey(food.foodId)){
       _items.forEach((key, value) {
         if(key==food.foodId){
           value.listFoodTopping.forEach((element) {
             toppingID.add(element.iD);
           });
         }
       });
     }
     return toppingID;

  }
  getQuantity(FoodTopping food) {
    var quantity = 0;
    if (_items.containsKey(food.foodId)) {
      print("co ne");
      _items.forEach((key, value) {
        if (key == food.foodId) {
          print("getquantity"+value.quantity.toString());
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      print("totalItems"+value.quantity.toString());
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }
  List<CartModel> get getItems{
   return  _items.entries.map((e){
     print("getItems${e.value.quantity}");
       return e.value;
    }).toList();
  }
  int getTotalMoneyItems(foodID){
    var totalMoney=0;
    topping="";
    _items.values.forEach((element) {
      if(element.foodId==foodID){
         totalMoney=element.price!*element.quantity!;
        element.listFoodTopping.forEach((element) {
          totalMoney+=element.price!;
          topping="${topping!},${element.name!}";
        });
      }

    });
    return totalMoney;
  }
  int get totalAmount{
    var total=0;
    _items.forEach((key, value) {
      total+=getTotalMoneyItems(value.foodId)!;
    });
    return total;
  }
  List<CartModel> getCartData(){
    setCart=cartRepo.getCartList();
    return storageItems;
  }
  set setCart(List<CartModel> items){
    storageItems=items;
    print("Length i  cart"+storageItems.length.toString());
    for(int i=0;i<storageItems.length;i++){
      _items.putIfAbsent(storageItems[i].food!.foodId!, () => storageItems[i]);
    }
    print(_items.toString());
  }


}
