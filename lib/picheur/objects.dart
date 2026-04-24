class BatchItem {
  final String? category;
  final String fishName;
  final String? catchMethod;
  final double quantity;
  final double pricePerKg;
  final String date;
  final double total;
  final String status;
  final double? latitude;
  final double? longitude;
  final String? extraInfo;
  final List<String> pictures;

  BatchItem({
    required this.fishName,
    required this.quantity,
    required this.date,
    required this.pricePerKg,
    required this.total,
    required this.status,
    this.pictures = const ["images/grey.jpg","images/fish1.png"],
    this.category,
    this.catchMethod,
    this.latitude,
    this.longitude,
    this.extraInfo,
  });
}
