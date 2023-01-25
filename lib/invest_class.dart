class Invest {
  final int id;
  final String ingestedDate;
  final String investmentGoal;
  final String stockName;
  final String buyDate;
  final double buyPrice;
  final double quantity;
  final String sellDate;
  final double sellPrice;

  const Invest({
    required this.id,
    required this.ingestedDate,
    required this.investmentGoal,
    required this.stockName,
    required this.buyDate,
    required this.buyPrice,
    required this.quantity,
    required this.sellDate,
    required this.sellPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ingestedDate': ingestedDate,
      'investmentGoal': investmentGoal,
      'stockName': stockName,
      'buyDate': buyDate,
      'buyPrice': buyPrice,
      'quantity': quantity,
      'sellDate': sellDate,
      'sellPrice': sellPrice,
    };
  }

  @override
  String toString() {
    return 'Invest{id: $id, ingestedDate: $ingestedDate, investmentGoal: $investmentGoal, stockName: $stockName, buyDate: $buyDate, buyPrice: $buyPrice, quantity: $quantity, sellDate: $sellDate, sellPrice: $sellPrice}';
  }
}
