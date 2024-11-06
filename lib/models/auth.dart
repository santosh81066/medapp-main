class AuthState {
  AuthState({
    required this.statusCode,
    required this.success,
    required this.messages,
    required this.data,
  });

  late final int statusCode;
  late final bool success;
  late final List<String> messages;
  late final Data data;

  AuthState.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    messages = List.castFrom<dynamic, String>(json['messages']);
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['success'] = success;
    _data['messages'] = messages;
    _data['data'] = data.toJson();
    return _data;
  }

  AuthState copyWith({
    int? statusCode,
    bool? success,
    List<String>? messages,
    Data? data,
  }) {
    return AuthState(
      statusCode: statusCode ?? this.statusCode,
      success: success ?? this.success,
      messages: messages ?? this.messages,
      data: data ?? this.data,
    );
  }

  // Initial method for creating an initial state
  static AuthState initial() {
    return AuthState(
      statusCode: 0,
      success: false,
      messages: [],
      data: Data.initial(),
    );
  }
}

class Data {
  Data({
    required this.userId,
    required this.username,
    this.countryname,
    this.state,
    this.city,
    this.address,
    this.profilePic,
    this.useRole,
    this.idFront,
    this.idBack,
    this.idCard,
    this.bankaccountno,
    this.bankname,
    this.ifsccode,
    this.latitude,
    this.longitude,
    this.radius,
    required this.accessToken,
    this.accessTokenExpiresAt,
    required this.refreshToken,
    this.refreshTokenExpiresAt,
  });

  late final int userId;
  late final String username;
  late final String? countryname;
  late final String? state;
  late final String? city;
  late final String? address;
  late final String? profilePic;
  late final String? useRole;
  late final String? idFront;
  late final String? idBack;
  late final String? idCard;
  late final String? bankaccountno;
  late final String? bankname;
  late final String? ifsccode;
  late final double? latitude;
  late final double? longitude;
  late final double? radius;
  late final String accessToken;
  late final int? accessTokenExpiresAt; // Made nullable
  late final String refreshToken;
  late final int? refreshTokenExpiresAt; // Made nullable

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    countryname = json['countryname'];
    state = json['state'];
    city = json['city'];
    address = json['address'];
    profilePic = json['profile_pic'];
    useRole = json['use_role'];
    idFront = json['id_front'];
    idBack = json['id_back'];
    idCard = json['id_card'];
    bankaccountno = json['bankaccountno'];
    bankname = json['bankname'];
    ifsccode = json['ifsccode'];
    latitude = json['latitude'] != null
        ? double.tryParse(json['latitude'].toString())
        : null;
    longitude = json['longitude'] != null
        ? double.tryParse(json['longitude'].toString())
        : null;
    radius = json['radius'] != null
        ? double.tryParse(json['radius'].toString())
        : null;
    accessToken = json['access_token'];
    accessTokenExpiresAt = json['access_token_expires_at'];
    refreshToken = json['refresh_token'];
    refreshTokenExpiresAt = json['refresh_token_expires_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = userId;
    _data['username'] = username;
    _data['countryname'] = countryname;
    _data['state'] = state;
    _data['city'] = city;
    _data['address'] = address;
    _data['profile_pic'] = profilePic;
    _data['use_role'] = useRole;
    _data['id_front'] = idFront;
    _data['id_back'] = idBack;
    _data['id_card'] = idCard;
    _data['bankaccountno'] = bankaccountno;
    _data['bankname'] = bankname;
    _data['ifsccode'] = ifsccode;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['radius'] = radius;
    _data['access_token'] = accessToken;
    _data['access_token_expires_at'] = accessTokenExpiresAt;
    _data['refresh_token'] = refreshToken;
    _data['refresh_token_expires_at'] = refreshTokenExpiresAt;
    return _data;
  }

  Data copyWith({
    int? userId,
    String? username,
    String? countryname,
    String? state,
    String? city,
    String? address,
    String? profilePic,
    String? useRole,
    String? idFront,
    String? idBack,
    String? idCard,
    String? bankaccountno,
    String? bankname,
    String? ifsccode,
    double? latitude,
    double? longitude,
    double? radius,
    String? accessToken,
    int? accessTokenExpiresAt,
    String? refreshToken,
    int? refreshTokenExpiresAt,
  }) {
    return Data(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      countryname: countryname ?? this.countryname,
      state: state ?? this.state,
      city: city ?? this.city,
      address: address ?? this.address,
      profilePic: profilePic ?? this.profilePic,
      useRole: useRole ?? this.useRole,
      idFront: idFront ?? this.idFront,
      idBack: idBack ?? this.idBack,
      idCard: idCard ?? this.idCard,
      bankaccountno: bankaccountno ?? this.bankaccountno,
      bankname: bankname ?? this.bankname,
      ifsccode: ifsccode ?? this.ifsccode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      radius: radius ?? this.radius,
      accessToken: accessToken ?? this.accessToken,
      accessTokenExpiresAt: accessTokenExpiresAt ?? this.accessTokenExpiresAt,
      refreshToken: refreshToken ?? this.refreshToken,
      refreshTokenExpiresAt:
          refreshTokenExpiresAt ?? this.refreshTokenExpiresAt,
    );
  }

  // Initial method for creating an initial data state
  static Data initial() {
    return Data(
      userId: 0,
      username: '',
      countryname: null,
      state: null,
      city: null,
      address: null,
      profilePic: null,
      useRole: null,
      idFront: null,
      idBack: null,
      idCard: null,
      bankaccountno: null,
      bankname: null,
      ifsccode: null,
      latitude: null,
      longitude: null,
      radius: null,
      accessToken: '',
      accessTokenExpiresAt: null,
      refreshToken: '',
      refreshTokenExpiresAt: null,
    );
  }
}
