class User {
  String? _id;
  String? _name;
  String? _email;
  String? _photo;
  String? _phone;
  List<String>? _roles;

  User(id, name, email, photo,  phone, roles){
    this._id=id;
    this._name=name;
    this._email=email;
    this._photo=photo;
    this._roles=roles;
  }
  List<String>? getRoles(){
    return this._roles;
  }
  User.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._name = json['name'];
    this._email = json['email'];
    this._photo = json['photo'];
    this._phone = json['phone'];
    this._roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['email'] = this._email;
    data['photo'] = this._photo;
    data['phone'] = this._phone;
    data['roles'] = this._roles;
    return data;
  }
}
