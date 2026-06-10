class OfferModel {
  final String id;
  final String title;
  final String category;
  final String description;
  final double quantity;
  final String unit;
  final double price;
  final String location;
  final String? availableDate;
  final String? imageUrl;
  final String status;
  final String userId;
  final String userName;
  final String createdAt;

  OfferModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.quantity,
    required this.unit,
    required this.price,
    required this.location,
    this.availableDate,
    this.imageUrl,
    this.status = 'available',
    required this.userId,
    required this.userName,
    required this.createdAt,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    return OfferModel(
      id: (data['id'] ?? '').toString(),
      title: data['title'] as String? ?? data['name'] as String? ?? '',
      category: data['category'] as String? ?? '',
      description: data['description'] as String? ?? '',
      quantity: (data['quantity'] as num?)?.toDouble() ?? 0,
      unit: data['unit'] as String? ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0,
      location: data['location'] as String? ?? data['address_village'] as String? ?? '',
      availableDate: data['available_date'] as String?,
      imageUrl: data['image_url'] as String? ?? data['image'] as String?,
      status: data['status'] as String? ?? 'available',
      userId: (data['user_id'] ?? data['userId'] ?? '').toString(),
      userName: data['user_name'] as String? ?? data['userName'] as String? ?? '',
      createdAt: data['created_at'] as String? ?? data['createdAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'description': description,
      'quantity': quantity,
      'unit': unit,
      'price': price,
      'location': location,
      'available_date': availableDate,
      'image_url': imageUrl,
    };
  }
}
