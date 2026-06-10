import 'package:flutter_test/flutter_test.dart';

import 'package:waste_bank/models/offer_model.dart';
import 'package:waste_bank/models/user_model.dart';

void main() {
  group('UserModel', () {
    test('fromJson creates a valid UserModel', () {
      final json = {
        'id': '1',
        'name': 'أحمد',
        'phone': '0123456789',
        'role': 'farmer',
      };
      final user = UserModel.fromJson(json);
      expect(user.id, '1');
      expect(user.name, 'أحمد');
      expect(user.phone, '0123456789');
      expect(user.role, 'farmer');
    });

    test('toJson returns correct map', () {
      final user = UserModel(
        id: '1',
        name: 'أحمد',
        phone: '0123456789',
        role: 'farmer',
      );
      final json = user.toJson();
      expect(json['id'], '1');
      expect(json['name'], 'أحمد');
    });
  });

  group('OfferModel', () {
    test('fromJson creates a valid OfferModel', () {
      final json = {
        'data': {
          'id': 1,
          'title': 'قش أرز',
          'category': 'مخلفات زراعية',
          'description': 'قش أرز طازج',
          'quantity': 500,
          'unit': 'كجم',
          'price': 150,
          'location': 'الدقهلية',
          'status': 'available',
          'user_id': 1,
          'user_name': 'أحمد',
          'created_at': '2024-01-01',
        },
      };
      final offer = OfferModel.fromJson(json);
      expect(offer.id, '1');
      expect(offer.title, 'قش أرز');
      expect(offer.category, 'مخلفات زراعية');
      expect(offer.quantity, 500);
      expect(offer.price, 150);
      expect(offer.unit, 'كجم');
    });

    test('toJson returns correct map', () {
      final offer = OfferModel(
        id: '1',
        title: 'قش أرز',
        category: 'مخلفات زراعية',
        description: 'قش أرز طازج',
        quantity: 500,
        unit: 'كجم',
        price: 150,
        location: 'الدقهلية',
        userId: '1',
        userName: 'أحمد',
        createdAt: '2024-01-01',
      );
      final json = offer.toJson();
      expect(json['title'], 'قش أرز');
      expect(json['category'], 'مخلفات زراعية');
      expect(json['quantity'], 500);
      expect(json['price'], 150);
    });
  });
}
