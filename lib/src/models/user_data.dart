class UserData {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic twoFactorConfirmedAt;
  dynamic currentTeamId;
  dynamic profilePhotoPath;
  String? createdAt;
  String? updatedAt;
  int? status;
  int? createdBy;
  dynamic clientId;
  int? driverId;
  dynamic deletedAt;
  String? profilePhotoUrl;
  Info? info;

  UserData(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.twoFactorConfirmedAt,
        this.currentTeamId,
        this.profilePhotoPath,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.createdBy,
        this.clientId,
        this.driverId,
        this.deletedAt,
        this.profilePhotoUrl,
        this.info});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    currentTeamId = json['current_team_id'];
    profilePhotoPath = json['profile_photo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    createdBy = json['created_by'];
    clientId = json['client_id'];
    driverId = json['driver_id'];
    deletedAt = json['deleted_at'];
    profilePhotoUrl = json['profile_photo_url'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['two_factor_confirmed_at'] = this.twoFactorConfirmedAt;
    data['current_team_id'] = this.currentTeamId;
    data['profile_photo_path'] = this.profilePhotoPath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['client_id'] = this.clientId;
    data['driver_id'] = this.driverId;
    data['deleted_at'] = this.deletedAt;
    data['profile_photo_url'] = this.profilePhotoUrl;
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    return data;
  }
}

class Info {
  int? id;
  String? address;
  String? phone;
  String? identificationId;
  int? status;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Info(
      {this.id,
        this.address,
        this.phone,
        this.identificationId,
        this.status,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Info.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    phone = json['phone'];
    identificationId = json['identification_id'];
    status = json['status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['identification_id'] = this.identificationId;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}