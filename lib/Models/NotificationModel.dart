class NotificationModel {
  String? notificationId, name, body, senderId;
  DateTime? date;

  NotificationModel(
      this.name, this.body, this.notificationId, this.date, this.senderId);

  NotificationModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    name = map['name'];
    body = map['body'];
    senderId = map['senderId'];
    notificationId = map['notificationId'];
    date =
        DateTime.fromMicrosecondsSinceEpoch(map['date'].microsecondsSinceEpoch);
  }

  toJson() {
    return {
      'name': name,
      'body': body,
      'senderId': senderId,
      'notificationId': notificationId,
      'date': date,
    };
  }
}
