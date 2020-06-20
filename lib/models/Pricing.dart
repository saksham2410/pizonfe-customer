class Pricing {
  double price;
  String storeId;
  String options;
  String storeName;

  Pricing({this.price, this.storeId, this.options});

  Pricing.fromJson(Map<dynamic, dynamic> json) {
    this.price = json["price"];
    this.storeId = json["storeId"];
    this.options = json["options"];
    this.storeName = json["storeName"];
  }
}