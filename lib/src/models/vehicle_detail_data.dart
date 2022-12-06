class RouteData {
  int? id;
  String? locationName;
  String? assignDate;
  String? assignTime;
  int? tmtlCount;
  List<RouteTMTL>? routeTMTLs;

  RouteData(
      {this.id,
        this.locationName,
        this.assignDate,
        this.assignTime,
        this.tmtlCount,
        this.routeTMTLs});

  RouteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationName = json['location_name'];
    assignDate = json['assign_date'];
    assignTime = json['assign_time'];
    tmtlCount = json['tmtl_count'];
    if (json['tmtls'] != null) {
      routeTMTLs = <RouteTMTL>[];
      json['tmtls'].forEach((v) {
        routeTMTLs!.add(RouteTMTL.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['location_name'] = this.locationName;
    data['assign_date'] = this.assignDate;
    data['assign_time'] = this.assignTime;
    data['tmtl_count'] = this.tmtlCount;
    if (this.routeTMTLs != null) {
      data['tmtls'] = routeTMTLs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RouteTMTL {
  int? id;
  String? tmtlCode;
  String? tmtlType;
  int? tmtlItemsCount;
  String? clientShortCode;

  RouteTMTL(
      {this.id,
        this.tmtlCode,
        this.tmtlType,
        this.tmtlItemsCount,
        this.clientShortCode});

  RouteTMTL.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tmtlCode = json['tmtl_code'];
    tmtlType = json['tmtl_type'];
    tmtlItemsCount = json['tmtl_items_count'];
    clientShortCode = json['client_short_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tmtl_code'] = this.tmtlCode;
    data['tmtl_type'] = this.tmtlType;
    data['tmtl_items_count'] = this.tmtlItemsCount;
    data['client_short_code'] = this.clientShortCode;
    return data;
  }
}