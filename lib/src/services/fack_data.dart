class TMTLModel{
  String id;
  String bank;
  String address;
  String time;
  TMTLStatus status;

  TMTLModel(this.id, this.bank, this.address, this.time, this.status);
}

enum TMTLStatus{In, Out}

List<TMTLModel> tmtlDataList = [
  TMTLModel('001', 'Uttara Bank, Banani, Dhaka (UB)', 'Uttara Sector 3', 'Time 10:05 am', TMTLStatus.In),
  TMTLModel('002', 'Uttara Bank, Banani, Dhaka (UB)', 'Uttara Sector 3', 'Time 10:05 am', TMTLStatus.Out),
  TMTLModel('003', 'Uttara Bank, Banani, Dhaka (UB)', 'Uttara Sector 3', 'Time 10:05 am', TMTLStatus.In),
  TMTLModel('004', 'Uttara Bank, Banani, Dhaka (UB)', 'Uttara Sector 3', 'Time 10:05 am', TMTLStatus.In),
  TMTLModel('005', 'Uttara Bank, Banani, Dhaka (UB)', 'Uttara Sector 3', 'Time 10:05 am', TMTLStatus.Out),
  TMTLModel('006', 'Uttara Bank, Banani, Dhaka (UB)', 'Uttara Sector 3', 'Time 10:05 am', TMTLStatus.In),
  TMTLModel('007', 'Uttara Bank, Banani, Dhaka (UB)', 'Uttara Sector 3', 'Time 10:05 am', TMTLStatus.Out),
  TMTLModel('008', 'Uttara Bank, Banani, Dhaka (UB)', 'Uttara Sector 3', 'Time 10:05 am', TMTLStatus.Out),
  TMTLModel('009', 'Uttara Bank, Banani, Dhaka (UB)', 'Uttara Sector 3', 'Time 10:05 am', TMTLStatus.In),
];