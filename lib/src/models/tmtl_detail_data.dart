/// if the current id of tmtl is 0 it means there are box
/// otherwise there are no box

class TmtlDetailData {
  int? id;
  String? clientName;
  String? locationName;
  String? address;
  String? assignDate;
  int? isCurrent;
  String? tmtlType;
  int? tmtlItemsCount;
  String? clientShortCode;
  String? assignTime;
  String? type;
  dynamic tmtlItems;

  TmtlDetailData(
      {this.id,
        this.clientName,
        this.locationName,
        this.address,
        this.assignDate,
        this.isCurrent,
        this.tmtlType,
        this.tmtlItemsCount,
        this.clientShortCode,
        this.assignTime,
        this.type,
        this.tmtlItems});

  TmtlDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientName = json['client_name'];
    locationName = json['location_name'];
    address = json['address'];
    assignDate = json['assign_date'];
    isCurrent = json['is_current'];
    tmtlType = json['tmtl_type'];
    tmtlItemsCount = json['tmtl_items_count'];
    clientShortCode = json['client_short_code'];
    assignTime = json['assign_time'];
    type = json['type'];
    if(json['is_current'] == 0){
      tmtlItems = json['tmtlitems'] != null
          ? TmtlItemsWithBox.fromJson(json['tmtlitems'])
          : null;
    } else{
      if (json['tmtlitems'] != null) {
        tmtlItems = <TmtlItemsWithoutBox>[];
        json['tmtlitems'].forEach((v) {
          tmtlItems!.add(TmtlItemsWithoutBox.fromJson(v));
        });
      }
    }

  }
}

class TmtlItemsWithoutBox {
  String? boxCode;
  String? batchCode;
  String? rnCode;
  String? clientFileNo;
  String? insertionCode;
  String? insertionRef;

  TmtlItemsWithoutBox(
      {this.boxCode,
        this.batchCode,
        this.rnCode,
        this.clientFileNo,
        this.insertionCode,
        this.insertionRef});

  TmtlItemsWithoutBox.fromJson(Map<String, dynamic> json) {
    boxCode = json['box_code'];
    batchCode = json['batch_code'];
    rnCode = json['rn_code'];
    clientFileNo = json['client_file_no'];
    insertionCode = json['insertion_code'];
    insertionRef = json['insertion_ref'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['box_code'] = this.boxCode;
    data['batch_code'] = this.batchCode;
    data['rn_code'] = this.rnCode;
    data['client_file_no'] = this.clientFileNo;
    data['insertion_code'] = this.insertionCode;
    data['insertion_ref'] = this.insertionRef;
    return data;
  }
}

class TmtlItemsWithBox {
  List<NBL1>? nBL1;

  TmtlItemsWithBox({this.nBL1});

  TmtlItemsWithBox.fromJson(Map<String, dynamic> json) {
    if (json['NBL-1'] != null) {
      nBL1 = <NBL1>[];
      json['NBL-1'].forEach((v) {
        nBL1!.add(new NBL1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nBL1 != null) {
      data['NBL-1'] = this.nBL1!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NBL1 {
  String? boxCode;
  String? batchCode;
  String? rnCode;
  String? clientFileNo;

  NBL1({this.boxCode, this.batchCode, this.rnCode, this.clientFileNo});

  NBL1.fromJson(Map<String, dynamic> json) {
    boxCode = json['box_code'];
    batchCode = json['batch_code'];
    rnCode = json['rn_code'];
    clientFileNo = json['client_file_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['box_code'] = this.boxCode;
    data['batch_code'] = this.batchCode;
    data['rn_code'] = this.rnCode;
    data['client_file_no'] = this.clientFileNo;
    return data;
  }
}