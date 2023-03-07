class CryptoModel{
  final int id; 
  final String name;
  final String symbol;
  final double price;
  final String slug;
  final String lastUpdated;
  final double oneHourPercentChange;
  final double dayPercentChange;

  CryptoModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.price,
    required this.slug,
    required this.lastUpdated,
    required this.oneHourPercentChange,
    required this.dayPercentChange
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json){
    return CryptoModel(
      id : json['id'],
      name : json['name'],
      price : json['quote']['USD']['price'],
      symbol : json['symbol'],
      slug : json['slug'],
      lastUpdated: json['quote']['USD']['last_updated'],
      dayPercentChange: json['quote']['USD']['percent_change_24h'],
      oneHourPercentChange: json['quote']['USD']['percent_change_1h'],
    );
  }
}