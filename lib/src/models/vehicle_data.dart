class VehicleData {
  int? id;
  String? vehicleName;
  String? vehicleDescription;
  List<String>? locationName;
  String? assignDate;
  String? startTime;
  String? endTime;

  VehicleData(
      {this.id,
        this.vehicleName,
        this.vehicleDescription,
        this.locationName,
        this.assignDate,
        this.startTime,
        this.endTime});

  VehicleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleName = json['vehicle_name'];
    vehicleDescription = json['vehicle_description'];
    locationName = json['location_name'].cast<String>();
    assignDate = json['assign_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicle_name'] = this.vehicleName;
    data['vehicle_description'] = this.vehicleDescription;
    data['location_name'] = this.locationName;
    data['assign_date'] = this.assignDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}