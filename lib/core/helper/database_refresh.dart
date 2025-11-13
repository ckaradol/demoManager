List data = [
  {
    "id": "PRD-001",
    "name": "Dermacare Cilt Serumu",
    "category": "Medikal Kozmetik",
    "description": "Cilt yenileyici profesyonel medikal serum. Dermatologlar tarafından reçete edilen premium ürün.",
    "price": 890,
    "images": [
      "https://firebasestorage.googleapis.com/v0/b/fir-778de.firebasestorage.app/o/products%2FChatGPT%20Image%2013%20Kas%202025%2014_58_41.png?alt=media&token=5daba56d-5c1c-4c25-9162-892d949338c2",
    ],
    "currency": "TRY",
    "unit": "adet",
    "stock": {"total": 1200, "criticalLevel": 100, "skt": "2026-04-15"},
    "regionDistribution": {"Ege": 350, "Marmara": 480, "Akdeniz": 220, "Doğu": 150},
    "commission": {"type": "sale_based", "rate": 0.05, "description": "Bu ürün satıldığında ilgili bölge temsilcisine %5 prim eklenir."},
    "attributes": {
      "volume": "50ml",
      "usage": "Günde 1 kez doktor önerisi ile kullanılır.",
      "suitableFor": ["Dermatoloji", "Cilt tedavisi"],
    },
    "status": "active",
  },
  {
    "id": "PRD-002",
    "name": "BioMax Vitamin Enjeksiyonu",
    "category": "Medikal Enjeksiyon",
    "description": "Bağışıklık güçlendirici yüksek etkili vitamin enjeksiyonu.",
    "price": 450,
    "images": [],
    "currency": "TRY",
    "unit": "ampul",
    "stock": {"total": 980, "criticalLevel": 80, "skt": "2025-12-01"},
    "regionDistribution": {"Ege": 240, "Marmara": 390, "Akdeniz": 210, "Doğu": 140},
    "commission": {"rate": 0.04, "description": "Her satışta temsilciye %4 prim eklenir."},
    "attributes": {
      "volume": "5ml",
      "usage": "Doktor tarafından reçete edilerek uygulanır.",
      "suitableFor": ["Enjeksiyon tedavisi", "Vitamin takviyesi"],
    },
    "status": "active",
  },

  {
    "id": "PRD-003",
    "name": "Aqualift Hyaluronik Dolgu",
    "category": "Dolgu Ürünü",
    "description": "Profesyonel yüz estetiği uygulamalarında kullanılan premium hyaluronik dolgu.",
    "price": 1750,
    "currency": "TRY",
    "images": [],
    "unit": "şırınga",
    "stock": {"total": 430, "criticalLevel": 30, "skt": "2027-02-10"},
    "regionDistribution": {"Ege": 110, "Marmara": 150, "Akdeniz": 95, "Doğu": 75},
    "commission": {"rate": 0.07, "description": "Her satışta temsilciye %7 prim eklenir."},
    "attributes": {
      "volume": "1ml",
      "usage": "Yalnızca uzman doktor tarafından uygulanır.",
      "suitableFor": ["Estetik", "Cilt dolgu"],
    },
    "status": "active",
  },

  {
    "id": "PRD-004",
    "name": "Dermapad Lazer Sonrası Onarım Kremi",
    "category": "Dermokozmetik",
    "description": "Lazer ve peeling sonrası cilt bariyerini güçlendiren profesyonel bakım kremi.",
    "price": 320,
    "currency": "TRY",
    "images": [],
    "unit": "tüp",
    "stock": {"total": 1600, "criticalLevel": 150, "skt": "2026-11-20"},
    "regionDistribution": {"Ege": 420, "Marmara": 550, "Akdeniz": 360, "Doğu": 270},
    "commission": {"rate": 0.03, "description": "Her satışta temsilciye %3 prim eklenir."},
    "attributes": {
      "volume": "75ml",
      "usage": "Günde 2 kez uygulanır.",
      "suitableFor": ["Lazer sonrası bakım", "Yoğun nemlendirme"],
    },
    "status": "active",
  },

  {
    "id": "PRD-005",
    "name": "Ultrason Jel 5L",
    "category": "Tıbbi Sarf",
    "description": "Ultrason cihazları için yüksek iletkenlik veren tıbbi jel.",
    "price": 210,
    "images": [],
    "currency": "TRY",
    "unit": "kova",
    "stock": {"total": 2400, "criticalLevel": 200, "skt": "2028-03-01"},
    "regionDistribution": {"Ege": 600, "Marmara": 800, "Akdeniz": 500, "Doğu": 500},
    "commission": {"rate": 0.02, "description": "Her satışta temsilciye %2 prim eklenir."},
    "attributes": {
      "volume": "5000ml",
      "usage": "Ultrason cihazlarında kullanılır.",
      "suitableFor": ["Hastane", "Muayenehane"],
    },
    "status": "active",
  },

  {
    "id": "PRD-006",
    "name": "Medisoft Dikiş Seti",
    "category": "Cerrahi Set",
    "description": "Cerrahi operasyonlarda kullanılan steril tek kullanımlık dikiş seti.",
    "price": 680,
    "currency": "TRY",
    "images": [],
    "unit": "set",
    "stock": {"total": 720, "criticalLevel": 60, "skt": "2027-06-15"},
    "regionDistribution": {"Ege": 180, "Marmara": 260, "Akdeniz": 150, "Doğu": 130},
    "commission": {"rate": 0.05, "description": "Her satışta temsilciye %5 prim eklenir."},
    "attributes": {
      "contents": ["1 adet bistüri", "1 adet pens", "Sütür ipliği", "Steril örtü", "Eldiven"],
      "usage": "Tek kullanımlıktır.",
      "suitableFor": ["Cerrahi işlemler", "Acil müdahale"],
    },
    "status": "active",
  },
];

List<String> generateSearchKeywords(String text) {
  final cleaned = text
      .toLowerCase()
      .replaceAll(RegExp(r'[^\w\sğüşöçı]'), '') // noktalama temizleme
      .split(RegExp(r'\s+')); // kelimelere böl

  final Set<String> keywords = {};

  for (var word in cleaned) {
    if (word.trim().isEmpty) continue;

    // Kelimenin kendisi
    keywords.add(word);

    // Prefix (1–2–3 harf)
    for (int i = 1; i <= word.length; i++) {
      keywords.add(word.substring(0, i)); // d, de, der, derm, derma...
    }
  }

  return keywords.toList();
}

Map<String, dynamic> productToFirestore(Map product) {
  final combinedText = "${product['name']} ${product['description']}";

  final searchKeywords = generateSearchKeywords(combinedText);

  return {...product, "searchKeywords": searchKeywords};
}
