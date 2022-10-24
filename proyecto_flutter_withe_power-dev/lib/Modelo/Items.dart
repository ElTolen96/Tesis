class ItemModel {
  ItemModel({
    required this.title,
    required this.quantity,
    required this.unitPrice,
  });

  String title;
  int quantity;
  int unitPrice;

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
    title: json["title"],
    quantity: json["quantity"],
    unitPrice: json["unitPrice"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "quantity": quantity,
    "unitPrice": unitPrice,
  };
}
