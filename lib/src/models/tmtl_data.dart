enum TMTLType{IN, OUT}

class TMTLData {
  int? id;
  String? clientName;
  String? shortCode;
  String? locationName;
  String? address;
  String? assignDate;
  String? type;
  String? assignTime;

  TMTLData(
      {this.id,
        this.clientName,
        this.shortCode,
        this.locationName,
        this.address,
        this.assignDate,
        this.type,
        this.assignTime});

  TMTLData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientName = json['client_name'];
    shortCode = json['short_code'];
    locationName = json['location_name'];
    address = json['address'];
    assignDate = json['assign_date'];
    type = json['type'];
    assignTime = json['assign_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_name'] = this.clientName;
    data['short_code'] = this.shortCode;
    data['location_name'] = this.locationName;
    data['address'] = this.address;
    data['assign_date'] = this.assignDate;
    data['type'] = this.type;
    data['assign_time'] = this.assignTime;
    return data;
  }
}