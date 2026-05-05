import 'package:cloud_firestore/cloud_firestore.dart';

/// Chạy một lần để seed dữ liệu mẫu vào Firestore.
/// Sau khi seed xong, xóa lời gọi FirebaseSeeder.seedAll() khỏi app.
class FirebaseSeeder {
  static final _db = FirebaseFirestore.instance;

  static Future<void> seedAll() async {
    // Kiểm tra nếu đã có dữ liệu thì bỏ qua
    final check = await _db.collection('brands').limit(1).get();
    if (check.docs.isNotEmpty) {
      print('[Seeder] Dữ liệu đã tồn tại, bỏ qua seed.');
      return;
    }

    print('[Seeder] Bắt đầu seed dữ liệu vật liệu xây dựng...');
    await _seedBrands();
    await _seedCategories();
    await _seedBrandCategories();
    await _seedProducts();
    print('[Seeder] Hoàn thành!');
  }

  // ─────────────────────────────────────────
  // 1. BRANDS
  // ─────────────────────────────────────────
  static Future<void> _seedBrands() async {
    final brands = [
      {
        'id': 'scg',
        'name': 'SCG',
        'imageURL':
            'https://placehold.co/200x200/1565C0/white?text=SCG',
        'isFeatured': true,
        'isActive': true,
        'productsCount': 8,
      },
      {
        'id': 'insee',
        'name': 'INSEE',
        'imageURL':
            'https://placehold.co/200x200/0288D1/white?text=INSEE',
        'isFeatured': true,
        'isActive': true,
        'productsCount': 5,
      },
      {
        'id': 'holcim',
        'name': 'Holcim',
        'imageURL':
            'https://placehold.co/200x200/00838F/white?text=Holcim',
        'isFeatured': true,
        'isActive': true,
        'productsCount': 4,
      },
      {
        'id': 'prime',
        'name': 'Prime Group',
        'imageURL':
            'https://placehold.co/200x200/6A1B9A/white?text=Prime',
        'isFeatured': true,
        'isActive': true,
        'productsCount': 6,
      },
      {
        'id': 'dong_tam',
        'name': 'Đồng Tâm',
        'imageURL':
            'https://placehold.co/200x200/AD1457/white?text=DongTam',
        'isFeatured': true,
        'isActive': true,
        'productsCount': 5,
      },
      {
        'id': 'hoa_sen',
        'name': 'Hoa Sen',
        'imageURL':
            'https://placehold.co/200x200/C62828/white?text=HoaSen',
        'isFeatured': true,
        'isActive': true,
        'productsCount': 6,
      },
      {
        'id': 'kova',
        'name': 'Sơn Kova',
        'imageURL':
            'https://placehold.co/200x200/2E7D32/white?text=Kova',
        'isFeatured': true,
        'isActive': true,
        'productsCount': 4,
      },
      {
        'id': 'dulux',
        'name': 'Dulux',
        'imageURL':
            'https://placehold.co/200x200/E65100/white?text=Dulux',
        'isFeatured': true,
        'isActive': true,
        'productsCount': 4,
      },
    ];

    final batch = _db.batch();
    for (final b in brands) {
      final id = b['id'] as String;
      final data = Map<String, dynamic>.from(b)..remove('id');
      batch.set(_db.collection('brands').doc(id), data);
    }
    await batch.commit();
    print('[Seeder] ✓ Brands');
  }

  // ─────────────────────────────────────────
  // 2. CATEGORIES
  // ─────────────────────────────────────────
  static Future<void> _seedCategories() async {
    final now = Timestamp.now();
    final categories = [
      {
        'id': 'xi_mang',
        'name': 'Xi măng',
        'imageURL':
            'https://placehold.co/300x200/546E7A/white?text=Xi+mang',
        'isActive': true,
        'isFeatured': true,
        'priority': 1,
        'numberOfProducts': 17,
        'viewCount': 0,
        'createdBy': 'admin',
        'updatedBy': 'admin',
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'id': 'gach_ngoi',
        'name': 'Gạch & Ngói',
        'imageURL':
            'https://placehold.co/300x200/8D6E63/white?text=Gach+Ngoi',
        'isActive': true,
        'isFeatured': true,
        'priority': 2,
        'numberOfProducts': 11,
        'viewCount': 0,
        'createdBy': 'admin',
        'updatedBy': 'admin',
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'id': 'son',
        'name': 'Sơn',
        'imageURL':
            'https://placehold.co/300x200/F57F17/white?text=Son',
        'isActive': true,
        'isFeatured': true,
        'priority': 3,
        'numberOfProducts': 8,
        'viewCount': 0,
        'createdBy': 'admin',
        'updatedBy': 'admin',
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'id': 'thep_sat',
        'name': 'Thép & Sắt',
        'imageURL':
            'https://placehold.co/300x200/37474F/white?text=Thep+Sat',
        'isActive': true,
        'isFeatured': true,
        'priority': 4,
        'numberOfProducts': 10,
        'viewCount': 0,
        'createdBy': 'admin',
        'updatedBy': 'admin',
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'id': 'tam_lop',
        'name': 'Tấm lợp',
        'imageURL':
            'https://placehold.co/300x200/4E342E/white?text=Tam+Lop',
        'isActive': true,
        'isFeatured': false,
        'priority': 5,
        'numberOfProducts': 6,
        'viewCount': 0,
        'createdBy': 'admin',
        'updatedBy': 'admin',
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'id': 'ong_nuoc',
        'name': 'Ống nước',
        'imageURL':
            'https://placehold.co/300x200/1B5E20/white?text=Ong+Nuoc',
        'isActive': true,
        'isFeatured': false,
        'priority': 6,
        'numberOfProducts': 5,
        'viewCount': 0,
        'createdBy': 'admin',
        'updatedBy': 'admin',
        'createdAt': now,
        'updatedAt': now,
      },
    ];

    final batch = _db.batch();
    for (final c in categories) {
      final id = c['id'] as String;
      final data = Map<String, dynamic>.from(c)..remove('id');
      batch.set(_db.collection('categories').doc(id), data);
    }
    await batch.commit();
    print('[Seeder] ✓ Categories');
  }

  // ─────────────────────────────────────────
  // 3. BRAND_CATEGORIES (N-N)
  // ─────────────────────────────────────────
  static Future<void> _seedBrandCategories() async {
    final links = [
      // Xi măng
      {'brandId': 'scg', 'categoryId': 'xi_mang'},
      {'brandId': 'insee', 'categoryId': 'xi_mang'},
      {'brandId': 'holcim', 'categoryId': 'xi_mang'},
      // Gạch & Ngói
      {'brandId': 'prime', 'categoryId': 'gach_ngoi'},
      {'brandId': 'dong_tam', 'categoryId': 'gach_ngoi'},
      // Sơn
      {'brandId': 'kova', 'categoryId': 'son'},
      {'brandId': 'dulux', 'categoryId': 'son'},
      // Thép & Sắt
      {'brandId': 'hoa_sen', 'categoryId': 'thep_sat'},
      {'brandId': 'scg', 'categoryId': 'thep_sat'},
      // Tấm lợp
      {'brandId': 'hoa_sen', 'categoryId': 'tam_lop'},
      // Ống nước
      {'brandId': 'scg', 'categoryId': 'ong_nuoc'},
    ];

    final batch = _db.batch();
    for (final link in links) {
      final docId = '${link['brandId']}_${link['categoryId']}';
      batch.set(_db.collection('brand_categories').doc(docId), link);
    }
    await batch.commit();
    print('[Seeder] ✓ Brand-Categories');
  }

  // ─────────────────────────────────────────
  // 4. PRODUCTS
  // ─────────────────────────────────────────
  static Future<void> _seedProducts() async {
    final now = Timestamp.now();
    final products = <Map<String, dynamic>>[
      // ── XI MĂNG SCG ──────────────────────
      {
        'title': 'Xi măng SCG Low Carbon PCB 40',
        'lowerTitle': 'xi mang scg low carbon pcb 40',
        'description':
            'Xi măng Portland hỗn hợp PCB 40, giảm phát thải CO₂, độ bền cao, phù hợp xây dựng dân dụng và công nghiệp.',
        'price': 95000.0,
        'salePrice': 88000.0,
        'thumbnail':
            'https://placehold.co/400x400/1565C0/white?text=SCG+PCB40',
        'images': [
          'https://placehold.co/800x600/1565C0/white?text=SCG+PCB40+1',
          'https://placehold.co/800x600/1565C0/white?text=SCG+PCB40+2',
        ],
        'brandId': 'scg',
        'categoryIds': ['xi_mang'],
        'tags': ['xi mang', 'scg', 'pcb40', 'low carbon'],
        'attributes': [],
        'stock': 500,
        'sku': 'SCG-XM-001',
        'productType': 'simple',
        'isFeatured': true,
        'isActive': true,
        'isDraft': false,
        'isDeleted': false,
        'isRecommended': true,
        'onSale': true,
        'isOutOfStock': false,
        'rating': 4.8,
        'ratingCount': 120,
        'reviewsCount': 85,
        'oneStarCount': 2,
        'twoStarCount': 3,
        'threeStarCount': 5,
        'fourStarCount': 20,
        'fiveStarCount': 90,
        'soldQuantity': 1200,
        'views': 3500,
        'likes': 450,
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'title': 'Xi măng SCG Super XI Maso',
        'lowerTitle': 'xi mang scg super xi maso',
        'description':
            'Xi măng chịu sulfate cao, chuyên dùng cho móng, hầm, công trình tiếp xúc nước ngầm và môi trường ăn mòn.',
        'price': 110000.0,
        'salePrice': null,
        'thumbnail':
            'https://placehold.co/400x400/0D47A1/white?text=SCG+Maso',
        'images': [
          'https://placehold.co/800x600/0D47A1/white?text=SCG+Maso+1',
        ],
        'brandId': 'scg',
        'categoryIds': ['xi_mang'],
        'tags': ['xi mang', 'scg', 'chiu sulfate', 'mong'],
        'attributes': [],
        'stock': 300,
        'sku': 'SCG-XM-002',
        'productType': 'simple',
        'isFeatured': true,
        'isActive': true,
        'isDraft': false,
        'isDeleted': false,
        'isRecommended': false,
        'onSale': false,
        'isOutOfStock': false,
        'rating': 4.6,
        'ratingCount': 80,
        'reviewsCount': 60,
        'oneStarCount': 1,
        'twoStarCount': 2,
        'threeStarCount': 7,
        'fourStarCount': 18,
        'fiveStarCount': 52,
        'soldQuantity': 800,
        'views': 2100,
        'likes': 280,
        'createdAt': now,
        'updatedAt': now,
      },
      // ── XI MĂNG INSEE ────────────────────
      {
        'title': 'Xi măng INSEE PCB 40 (50kg)',
        'lowerTitle': 'xi mang insee pcb 40 50kg',
        'description':
            'Xi măng Portland hỗn hợp INSEE PCB 40, bao 50kg, chất lượng cao, thích hợp đổ sàn, cột, dầm bê tông.',
        'price': 93000.0,
        'salePrice': 87000.0,
        'thumbnail':
            'https://placehold.co/400x400/0288D1/white?text=INSEE+PCB40',
        'images': [
          'https://placehold.co/800x600/0288D1/white?text=INSEE+PCB40',
        ],
        'brandId': 'insee',
        'categoryIds': ['xi_mang'],
        'tags': ['xi mang', 'insee', 'pcb40'],
        'attributes': [],
        'stock': 400,
        'sku': 'INS-XM-001',
        'productType': 'simple',
        'isFeatured': true,
        'isActive': true,
        'isDraft': false,
        'isDeleted': false,
        'isRecommended': true,
        'onSale': true,
        'isOutOfStock': false,
        'rating': 4.7,
        'ratingCount': 95,
        'reviewsCount': 70,
        'oneStarCount': 1,
        'twoStarCount': 2,
        'threeStarCount': 6,
        'fourStarCount': 22,
        'fiveStarCount': 64,
        'soldQuantity': 950,
        'views': 2800,
        'likes': 310,
        'createdAt': now,
        'updatedAt': now,
      },
      // ── XI MĂNG HOLCIM ───────────────────
      {
        'title': 'Xi măng Holcim PCB 40 Xanh',
        'lowerTitle': 'xi mang holcim pcb 40 xanh',
        'description':
            'Xi măng Holcim PCB 40, sản phẩm thân thiện môi trường, đạt tiêu chuẩn TCVN 6260:2009, phù hợp mọi công trình.',
        'price': 92000.0,
        'salePrice': null,
        'thumbnail':
            'https://placehold.co/400x400/00838F/white?text=Holcim+PCB40',
        'images': [
          'https://placehold.co/800x600/00838F/white?text=Holcim+PCB40',
        ],
        'brandId': 'holcim',
        'categoryIds': ['xi_mang'],
        'tags': ['xi mang', 'holcim', 'pcb40', 'xanh'],
        'attributes': [],
        'stock': 350,
        'sku': 'HOL-XM-001',
        'productType': 'simple',
        'isFeatured': true,
        'isActive': true,
        'isDraft': false,
        'isDeleted': false,
        'isRecommended': false,
        'onSale': false,
        'isOutOfStock': false,
        'rating': 4.5,
        'ratingCount': 70,
        'reviewsCount': 50,
        'oneStarCount': 2,
        'twoStarCount': 3,
        'threeStarCount': 5,
        'fourStarCount': 15,
        'fiveStarCount': 45,
        'soldQuantity': 700,
        'views': 1900,
        'likes': 220,
        'createdAt': now,
        'updatedAt': now,
      },
      // ── GẠCH PRIME ───────────────────────
      {
        'title': 'Gạch granite Prime 60x60 vân đá',
        'lowerTitle': 'gach granite prime 60x60 van da',
        'description':
            'Gạch granite cao cấp kích thước 60x60cm, vân đá tự nhiên, độ cứng cao, chống trầy xước, phù hợp phòng khách, hành lang.',
        'price': 320000.0,
        'salePrice': 280000.0,
        'thumbnail':
            'https://placehold.co/400x400/6A1B9A/white?text=Prime+60x60',
        'images': [
          'https://placehold.co/800x600/6A1B9A/white?text=Prime+60x60+1',
          'https://placehold.co/800x600/6A1B9A/white?text=Prime+60x60+2',
        ],
        'brandId': 'prime',
        'categoryIds': ['gach_ngoi'],
        'tags': ['gach', 'granite', 'prime', '60x60', 'van da'],
        'attributes': [
          {'attributeId': 'size', 'name': 'Kích thước', 'values': ['60x60']},
          {
            'attributeId': 'finish',
            'name': 'Bề mặt',
            'values': ['Bóng', 'Mờ'],
          },
        ],
        'stock': 800,
        'sku': 'PRM-GCH-001',
        'productType': 'variable',
        'isFeatured': true,
        'isActive': true,
        'isDraft': false,
        'isDeleted': false,
        'isRecommended': true,
        'onSale': true,
        'isOutOfStock': false,
        'rating': 4.9,
        'ratingCount': 150,
        'reviewsCount': 110,
        'oneStarCount': 1,
        'twoStarCount': 1,
        'threeStarCount': 8,
        'fourStarCount': 25,
        'fiveStarCount': 115,
        'soldQuantity': 2000,
        'views': 5500,
        'likes': 780,
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'title': 'Gạch ốp tường Prime 30x60 trắng ngà',
        'lowerTitle': 'gach op tuong prime 30x60 trang nga',
        'description':
            'Gạch ốp tường Prime 30x60cm màu trắng ngà, bề mặt semi-gloss, phù hợp nhà vệ sinh, bếp, phòng ngủ.',
        'price': 185000.0,
        'salePrice': null,
        'thumbnail':
            'https://placehold.co/400x400/7B1FA2/white?text=Prime+30x60',
        'images': [
          'https://placehold.co/800x600/7B1FA2/white?text=Prime+30x60',
        ],
        'brandId': 'prime',
        'categoryIds': ['gach_ngoi'],
        'tags': ['gach', 'op tuong', 'prime', '30x60'],
        'attributes': [
          {
            'attributeId': 'size',
            'name': 'Kích thước',
            'values': ['30x60'],
          },
        ],
        'stock': 600,
        'sku': 'PRM-GCH-002',
        'productType': 'simple',
        'isFeatured': true,
        'isActive': true,
        'isDraft': false,
        'isDeleted': false,
        'isRecommended': false,
        'onSale': false,
        'isOutOfStock': false,
        'rating': 4.6,
        'ratingCount': 90,
        'reviewsCount': 65,
        'oneStarCount': 2,
        'twoStarCount': 3,
        'threeStarCount': 5,
        'fourStarCount': 20,
        'fiveStarCount': 60,
        'soldQuantity': 1100,
        'views': 3100,
        'likes': 380,
        'createdAt': now,
        'updatedAt': now,
      },
      // ── GẠCH ĐỒNG TÂM ────────────────────
      {
        'title': 'Gạch Đồng Tâm 60x60 ceramic bóng',
        'lowerTitle': 'gach dong tam 60x60 ceramic bong',
        'description':
            'Gạch ceramic Đồng Tâm 60x60cm bề mặt bóng, vân gỗ tự nhiên, độ bền cao, dễ vệ sinh.',
        'price': 290000.0,
        'salePrice': 265000.0,
        'thumbnail':
            'https://placehold.co/400x400/AD1457/white?text=DT+60x60',
        'images': [
          'https://placehold.co/800x600/AD1457/white?text=DT+60x60',
        ],
        'brandId': 'dong_tam',
        'categoryIds': ['gach_ngoi'],
        'tags': ['gach', 'ceramic', 'dong tam', '60x60', 'van go'],
        'attributes': [
          {'attributeId': 'size', 'name': 'Kích thước', 'values': ['60x60']},
        ],
        'stock': 700,
        'sku': 'DT-GCH-001',
        'productType': 'simple',
        'isFeatured': true,
        'isActive': true,
        'isDraft': false,
        'isDeleted': false,
        'isRecommended': true,
        'onSale': true,
        'isOutOfStock': false,
        'rating': 4.7,
        'ratingCount': 110,
        'reviewsCount': 80,
        'oneStarCount': 2,
        'twoStarCount': 2,
        'threeStarCount': 6,
        'fourStarCount': 25,
        'fiveStarCount': 75,
        'soldQuantity': 1500,
        'views': 4200,
        'likes': 550,
        'createdAt': now,
        'updatedAt': now,
      },
      // ── SƠN KOVA ─────────────────────────
      {
        'title': 'Sơn nội thất Kova K-5500 18L',
        'lowerTitle': 'son noi that kova k-5500 18l',
        'description':
            'Sơn nội thất Kova K-5500 bóng mờ, kháng khuẩn, dễ lau chùi, phủ được 80-100m² cho 1 lớp sơn. Đóng thùng 18 lít.',
        'price': 850000.0,
        'salePrice': 780000.0,
        'thumbnail':
            'https://placehold.co/400x400/2E7D32/white?text=Kova+K5500',
        'images': [
          'https://placehold.co/800x600/2E7D32/white?text=Kova+K5500+1',
          'https://placehold.co/800x600/2E7D32/white?text=Kova+K5500+2',
        ],
        'brandId': 'kova',
        'categoryIds': ['son'],
        'tags': ['son', 'kova', 'noi that', 'k5500', 'khang khuan'],
        'attributes': [
          {
            'attributeId': 'volume',
            'name': 'Dung tích',
            'values': ['5L', '18L'],
          },
          {
            'attributeId': 'finish',
            'name': 'Độ bóng',
            'values': ['Mờ', 'Bóng nhẹ'],
          },
        ],
        'stock': 200,
        'sku': 'KVA-SON-001',
        'productType': 'variable',
        'isFeatured': true,
        'isActive': true,
        'isDraft': false,
        'isDeleted': false,
        'isRecommended': true,
        'onSale': true,
        'isOutOfStock': false,
        'rating': 4.8,
        'ratingCount': 140,
        'reviewsCount': 100,
        'oneStarCount': 1,
        'twoStarCount': 2,
        'threeStarCount': 7,
        'fourStarCount': 28,
        'fiveStarCount': 102,
        'soldQuantity': 650,
        'views': 4800,
        'likes': 620,
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'title': 'Sơn ngoại thất Kova K-8200 18L',
        'lowerTitle': 'son ngoai that kova k-8200 18l',
        'description':
            'Sơn ngoại thất Kova K-8200, chịu thời tiết, chống thấm, chống rêu mốc, bảo vệ tường lâu dài. Bao 18 lít.',
        'price': 980000.0,
        'salePrice': null,
        'thumbnail':
            'https://placehold.co/400x400/1B5E20/white?text=Kova+K8200',
        'images': [
          'https://placehold.co/800x600/1B5E20/white?text=Kova+K8200',
        ],
        'brandId': 'kova',
        'categoryIds': ['son'],
        'tags': ['son', 'kova', 'ngoai that', 'k8200', 'chong tham'],
        'attributes': [
          {
            'attributeId': 'volume',
            'name': 'Dung tích',
            'values': ['5L', '18L'],
          },
        ],
        'stock': 150,
        'sku': 'KVA-SON-002',
        'productType': 'variable',
        'isFeatured': true,
        'isActive': true,
        'isDraft': false,
        'isDeleted': false,
        'isRecommended': false,
        'onSale': false,
        'isOutOfStock': false,
        'rating': 4.7,
        'ratingCount': 95,
        'reviewsCount': 70,
        'oneStarCount': 1,
        'twoStarCount': 2,
        'threeStarCount': 6,
        'fourStarCount': 20,
        'fiveStarCount': 66,
        'soldQuantity': 420,
        'views': 3200,
        'likes': 410,
        'createdAt': now,
        'updatedAt': now,
      },
      // ── SƠN DULUX ─────────────────────────
      {
        'title': 'Sơn Dulux Inspire Interior 18L',
        'lowerTitle': 'son dulux inspire interior 18l',
        'description':
            'Sơn nội thất Dulux Inspire Interior bóng cao cấp, màu sắc bền đẹp, kháng khuẩn, phủ 90-110m²/lớp.',
        'price': 1150000.0,
        'salePrice': 1050000.0,
        'thumbnail':
            'https://placehold.co/400x400/E65100/white?text=Dulux+Inspire',
        'images': [
          'https://placehold.co/800x600/E65100/white?text=Dulux+Inspire+1',
          'https://placehold.co/800x600/E65100/white?text=Dulux+Inspire+2',
        ],
        'brandId': 'dulux',
        'categoryIds': ['son'],
        'tags': ['son', 'dulux', 'noi that', 'cao cap', 'khang khuan'],
        'attributes': [
          {
            'attributeId': 'volume',
            'name': 'Dung tích',
            'values': ['5L', '18L'],
          },
        ],
        'stock': 180,
        'sku': 'DLX-SON-001',
        'productType': 'variable',
        'isFeatured': true,
        'isActive': true,
        'isDraft': false,
        'isDeleted': false,
        'isRecommended': true,
        'onSale': true,
        'isOutOfStock': false,
        'rating': 4.9,
        'ratingCount': 165,
        'reviewsCount': 120,
        'oneStarCount': 1,
        'twoStarCount': 1,
        'threeStarCount': 5,
        'fourStarCount': 30,
        'fiveStarCount': 128,
        'soldQuantity': 580,
        'views': 6200,
        'likes': 820,
        'createdAt': now,
        'updatedAt': now,
      },
      // ── THÉP HOA SEN ─────────────────────
      {
        'title': 'Tôn mạ kẽm Hoa Sen 0.45mm',
        'lowerTitle': 'ton ma kem hoa sen 0.45mm',
        'description':
            'Tôn mạ kẽm Hoa Sen dày 0.45mm, độ bền cao, chống gỉ tốt, phù hợp làm mái nhà xưởng, nhà ở. Chiều dài tấm theo yêu cầu.',
        'price': 145000.0,
        'salePrice': 130000.0,
        'thumbnail':
            'https://placehold.co/400x400/C62828/white?text=HoaSen+Ton',
        'images': [
          'https://placehold.co/800x600/C62828/white?text=HoaSen+Ton+1',
          'https://placehold.co/800x600/C62828/white?text=HoaSen+Ton+2',
        ],
        'brandId': 'hoa_sen',
        'categoryIds': ['thep_sat', 'tam_lop'],
        'tags': ['ton', 'ma kem', 'hoa sen', 'mai nha', 'thep'],
        'attributes': [
          {
            'attributeId': 'thickness',
            'name': 'Độ dày',
            'values': ['0.35mm', '0.45mm', '0.55mm'],
          },
        ],
        'stock': 1000,
        'sku': 'HS-TON-001',
        'productType': 'variable',
        'isFeatured': true,
        'isActive': true,
        'isDraft': false,
        'isDeleted': false,
        'isRecommended': true,
        'onSale': true,
        'isOutOfStock': false,
        'rating': 4.7,
        'ratingCount': 130,
        'reviewsCount': 95,
        'oneStarCount': 2,
        'twoStarCount': 3,
        'threeStarCount': 5,
        'fourStarCount': 28,
        'fiveStarCount': 92,
        'soldQuantity': 3200,
        'views': 7800,
        'likes': 950,
        'createdAt': now,
        'updatedAt': now,
      },
      {
        'title': 'Thép thanh vằn Hoa Sen D10 (12m)',
        'lowerTitle': 'thep thanh van hoa sen d10 12m',
        'description':
            'Thép thanh vằn Hoa Sen phi 10, dài 12m, tiêu chuẩn TCVN 1651-2:2008, dùng cho kết cấu bê tông cốt thép.',
        'price': 210000.0,
        'salePrice': null,
        'thumbnail':
            'https://placehold.co/400x400/B71C1C/white?text=HoaSen+D10',
        'images': [
          'https://placehold.co/800x600/B71C1C/white?text=HoaSen+D10',
        ],
        'brandId': 'hoa_sen',
        'categoryIds': ['thep_sat'],
        'tags': ['thep', 'thanh van', 'hoa sen', 'd10', 'be tong'],
        'attributes': [
          {
            'attributeId': 'diameter',
            'name': 'Đường kính',
            'values': ['D8', 'D10', 'D12', 'D14'],
          },
        ],
        'stock': 500,
        'sku': 'HS-THEP-001',
        'productType': 'variable',
        'isFeatured': true,
        'isActive': true,
        'isDraft': false,
        'isDeleted': false,
        'isRecommended': false,
        'onSale': false,
        'isOutOfStock': false,
        'rating': 4.6,
        'ratingCount': 85,
        'reviewsCount': 60,
        'oneStarCount': 2,
        'twoStarCount': 2,
        'threeStarCount': 6,
        'fourStarCount': 18,
        'fiveStarCount': 57,
        'soldQuantity': 2400,
        'views': 5100,
        'likes': 640,
        'createdAt': now,
        'updatedAt': now,
      },
      // ── ỐNG NƯỚC SCG ─────────────────────
      {
        'title': 'Ống nước SCG PVC Ø27 (4m)',
        'lowerTitle': 'ong nuoc scg pvc 27 4m',
        'description':
            'Ống nhựa PVC SCG đường kính 27mm, dài 4m, áp lực 10 bar, phù hợp hệ thống cấp nước dân dụng và tưới tiêu.',
        'price': 48000.0,
        'salePrice': 42000.0,
        'thumbnail':
            'https://placehold.co/400x400/1565C0/white?text=SCG+PVC+27',
        'images': [
          'https://placehold.co/800x600/1565C0/white?text=SCG+PVC+27',
        ],
        'brandId': 'scg',
        'categoryIds': ['ong_nuoc'],
        'tags': ['ong nuoc', 'pvc', 'scg', 'cap nuoc'],
        'attributes': [
          {
            'attributeId': 'diameter',
            'name': 'Đường kính',
            'values': ['Ø21', 'Ø27', 'Ø34', 'Ø42'],
          },
        ],
        'stock': 400,
        'sku': 'SCG-ONG-001',
        'productType': 'variable',
        'isFeatured': true,
        'isActive': true,
        'isDraft': false,
        'isDeleted': false,
        'isRecommended': true,
        'onSale': true,
        'isOutOfStock': false,
        'rating': 4.5,
        'ratingCount': 75,
        'reviewsCount': 55,
        'oneStarCount': 2,
        'twoStarCount': 3,
        'threeStarCount': 5,
        'fourStarCount': 15,
        'fiveStarCount': 50,
        'soldQuantity': 1800,
        'views': 3400,
        'likes': 420,
        'createdAt': now,
        'updatedAt': now,
      },
      // ── TẤM LỢP HOA SEN ──────────────────
      {
        'title': 'Tấm lợp fibro xi măng Hoa Sen 2.3mm',
        'lowerTitle': 'tam lop fibro xi mang hoa sen 2.3mm',
        'description':
            'Tấm lợp fibro xi măng Hoa Sen dày 2.3mm, chịu nhiệt, cách âm, chống thấm, nhẹ hơn tôn. Kích thước 1830x920mm.',
        'price': 75000.0,
        'salePrice': null,
        'thumbnail':
            'https://placehold.co/400x400/4E342E/white?text=HoaSen+Fibro',
        'images': [
          'https://placehold.co/800x600/4E342E/white?text=HoaSen+Fibro',
        ],
        'brandId': 'hoa_sen',
        'categoryIds': ['tam_lop'],
        'tags': ['tam lop', 'fibro', 'xi mang', 'hoa sen', 'chong tham'],
        'attributes': [
          {
            'attributeId': 'thickness',
            'name': 'Độ dày',
            'values': ['2.0mm', '2.3mm', '3.0mm'],
          },
        ],
        'stock': 600,
        'sku': 'HS-TL-001',
        'productType': 'variable',
        'isFeatured': false,
        'isActive': true,
        'isDraft': false,
        'isDeleted': false,
        'isRecommended': false,
        'onSale': false,
        'isOutOfStock': false,
        'rating': 4.4,
        'ratingCount': 60,
        'reviewsCount': 40,
        'oneStarCount': 2,
        'twoStarCount': 3,
        'threeStarCount': 5,
        'fourStarCount': 12,
        'fiveStarCount': 38,
        'soldQuantity': 950,
        'views': 2600,
        'likes': 310,
        'createdAt': now,
        'updatedAt': now,
      },
    ];

    // Batch write (Firestore tối đa 500 ops / batch)
    var batch = _db.batch();
    int count = 0;
    for (final p in products) {
      final docRef = _db.collection('products').doc();
      batch.set(docRef, p);
      count++;
      if (count == 400) {
        await batch.commit();
        batch = _db.batch();
        count = 0;
      }
    }
    if (count > 0) await batch.commit();
    print('[Seeder] ✓ Products (${products.length} sản phẩm)');
  }
}
