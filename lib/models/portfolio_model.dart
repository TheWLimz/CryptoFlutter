class PortfolioModel {
  final String id;
  final String name;
  final int lots;
  final double totalPrice; 
  final double change;

  PortfolioModel({required this.id ,required this.name, required this.lots, required this.totalPrice, required this.change});
   
  factory PortfolioModel.fromJson(Map<String, dynamic> json){
      return PortfolioModel(
        id : json["id"],
        name : json["name"],
        lots : json['lots'],
        totalPrice: json['total'],
        change : json['change']
      );
  }

  Map<String, dynamic> toMap() => {
    "id" : id,
     "name" : name,
     "lots" : lots,
     "total" : totalPrice,
     "change" : change
  };

}