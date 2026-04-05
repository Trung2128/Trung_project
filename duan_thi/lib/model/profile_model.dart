class Profile {
  final int id;
  final String firstName;
  final String lastName;
  final String maidenName;
  final int age;
  final String gender;
  final String email;
  final String phone;
  final String username;
  final String password;
  final String birthDate;
  final String image;
  final String bloodGroup;
  final double height;
  final double weight;
  final String eyeColor;

  // Các biến chứa dữ liệu lồng nhau
  final String hair; // Gộp color + type
  final String ip;
  final String address; // Gộp address, city, state
  final String macAddress;
  final String university;

  final String bank; // Gộp card info
  final String company; // Gộp Title + Name

  final String ein;
  final String ssn;
  final String userAgent;
  final String crypto; // Gộp Coin + Wallet
  final String role;
  final String accessToken;

  Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.maidenName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
    required this.birthDate,
    required this.image,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hair,
    required this.ip,
    required this.address,
    required this.macAddress,
    required this.university,
    required this.bank,
    required this.company,
    required this.ein,
    required this.ssn,
    required this.userAgent,
    required this.crypto,
    required this.role,
    required this.accessToken,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    String fullAddress = "Không có địa chỉ";
    if (json['address'] != null) {
      final a = json['address'];
      fullAddress =
          "${a['address'] ?? ''}, ${a['city'] ?? ''}, ${a['state'] ?? ''} (${a['country'] ?? ''})";
    }

    String fullCompany = "Không có công ty";
    if (json['company'] != null) {
      final c = json['company'];
      fullCompany = "${c['title'] ?? ''} at ${c['name'] ?? ''}";
    }

    String fullHair = "";
    if (json['hair'] != null) {
      fullHair =
          "${json['hair']['color'] ?? ''}, ${json['hair']['type'] ?? ''}";
    }

    String fullBank = "";
    if (json['bank'] != null) {
      fullBank =
          "${json['bank']['cardType'] ?? ''}: ${json['bank']['cardNumber'] ?? ''} (Exp: ${json['bank']['cardExpire'] ?? ''})";
    }

    String fullCrypto = "";
    if (json['crypto'] != null) {
      fullCrypto =
          "${json['crypto']['coin'] ?? ''}: ${json['crypto']['wallet'] ?? ''}";
    }

    return Profile(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      maidenName: json['maidenName'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      birthDate: json['birthDate'] ?? '',
      image: json['image'] ?? 'https://via.placeholder.com/150',
      bloodGroup: json['bloodGroup'] ?? '',
      // Xử lý số thực (double) an toàn hơn
      height: (json['height'] is num)
          ? (json['height'] as num).toDouble()
          : 0.0,
      weight: (json['weight'] is num)
          ? (json['weight'] as num).toDouble()
          : 0.0,
      eyeColor: json['eyeColor'] ?? '',

      // Gán các biến đã xử lý ở trên
      hair: fullHair,
      ip: json['ip'] ?? '',
      address: fullAddress,
      macAddress: json['macAddress'] ?? '',
      university: json['university'] ?? '',
      bank: fullBank,
      company: fullCompany,
      ein: json['ein'] ?? '',
      ssn: json['ssn'] ?? '',
      userAgent: json['userAgent'] ?? '',
      crypto: fullCrypto,
      role: json['role'] ?? '',

      accessToken: json['accessToken'] ?? json['token'] ?? '',
    );
  }
}
