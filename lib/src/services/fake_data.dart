class TMTLModel{
  String id;
  String bank;
  String address;
  String time;
  String quantity;
  TMTLStatus status;

  TMTLModel(this.id, this.bank, this.address, this.time, this.quantity, this.status);
}

enum TMTLStatus{In, Out}

List<TMTLModel> tmtlDataList = [
  TMTLModel('001', 'Uttara Bank, Banani, Dhaka (UB)', 'Uttara Sector 3', 'Time 10:05 am', '04 Box', TMTLStatus.In),
  TMTLModel('002', 'Uttara Bank, Banani, Dhaka (UB)', 'Uttara Sector 3', 'Time 10:05 am', '03 Box', TMTLStatus.Out),
  TMTLModel('003', 'Uttara Bank, Banani, Dhaka (UB)', 'Uttara Sector 3', 'Time 10:05 am', '04 Box', TMTLStatus.In),
  TMTLModel('004', 'Uttara Bank, Banani, Dhaka (UB)', 'Uttara Sector 3', 'Time 10:05 am', '05 Box', TMTLStatus.In),
  TMTLModel('005', 'Uttara Bank, Banani, Dhaka (UB)', 'Uttara Sector 3', 'Time 10:05 am', '08 Box', TMTLStatus.Out),
  TMTLModel('006', 'Uttara Bank, Banani, Dhaka (UB)', 'Uttara Sector 3', 'Time 10:05 am', '01 Box', TMTLStatus.In),
  TMTLModel('007', 'Uttara Bank, Banani, Dhaka (UB)', 'Uttara Sector 3', 'Time 10:05 am', '04 Box', TMTLStatus.Out),
  TMTLModel('008', 'Uttara Bank, Banani, Dhaka (UB)', 'Uttara Sector 3', 'Time 10:05 am', '03 Box', TMTLStatus.Out),
  TMTLModel('009', 'Uttara Bank, Banani, Dhaka (UB)', 'Uttara Sector 3', 'Time 10:05 am', '08 Box', TMTLStatus.In),
];

class NotificationModel{
  final String date;
  final String time;
  final String body;

  NotificationModel({required this.date, required this.time, required this.body});
}

List<NotificationModel> notificationList = [
  NotificationModel(date: '08 Oct 2021', time: '12:25 PM', body: 'You Oder #B0011223344556677 is approved as you requested. Thank you for trusting us. Welcome shopping again with us.'),
  NotificationModel(date: '03 Oct 2021', time: '12:25 PM', body: 'You Oder #B0011223344556677 is approved as you requested. Thank you for trusting us. Welcome shopping again with us.'),
  NotificationModel(date: '08 Oct 2021', time: '12:25 PM', body: 'You Oder #B0011223344556677 is approved as you requested. Thank you for trusting us. Welcome shopping again with us.'),
  NotificationModel(date: '23 Oct 2021', time: '12:25 PM', body: 'You Oder #B0011223344556677 is approved as you requested. Thank you for trusting us. Welcome shopping again with us.'),
  NotificationModel(date: '01 Oct 2021', time: '12:25 PM', body: 'You Oder #B0011223344556677 is approved as you requested. Thank you for trusting us. Welcome shopping again with us.'),
  NotificationModel(date: '25 Oct 2021', time: '12:25 PM', body: 'You Oder #B0011223344556677 is approved as you requested. Thank you for trusting us. Welcome shopping again with us.'),
  NotificationModel(date: '26 Oct 2021', time: '12:25 PM', body: 'You Oder #B0011223344556677 is approved as you requested. Thank you for trusting us. Welcome shopping again with us.'),
  NotificationModel(date: '15 Oct 2021', time: '12:25 PM', body: 'You Oder #B0011223344556677 is approved as you requested. Thank you for trusting us. Welcome shopping again with us.'),
  NotificationModel(date: '14 Oct 2021', time: '12:25 PM', body: 'You Oder #B0011223344556677 is approved as you requested. Thank you for trusting us. Welcome shopping again with us.'),
  NotificationModel(date: '17 Oct 2021', time: '12:25 PM', body: 'You Oder #B0011223344556677 is approved as you requested. Thank you for trusting us. Welcome shopping again with us.'),
];