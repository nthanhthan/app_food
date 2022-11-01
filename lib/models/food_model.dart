class Food {
  String? foodId;
  String? name;
  String? description;
  String? urlImage;
  int? price;
  String? category;
  Null? listTopping;
  String? state;

  Food(
      {this.foodId,
        this.name,
        this.description,
        this.urlImage,
        this.price,
        this.category,
        this.listTopping,
        this.state});

  Food.fromJson(Map<String, dynamic> json) {
    foodId = json['FoodId'];
    name = json['Name'];
    description = json['Dscription'];
    urlImage = json['UrlImage'];
    price = json['Price'];
    category = json['Category'];
    listTopping = json['ListTopping'];
    state = json['State'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FoodId'] = this.foodId;
    data['Name'] = this.name;
    data['Dscription'] = this.description;
    data['UrlImage'] = this.urlImage;
    data['Price'] = this.price;
    data['Category'] = this.category;
    data['ListTopping'] = this.listTopping;
    data['State'] = this.state;
    return data;
  }
}