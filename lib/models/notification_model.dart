// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotificationUser {
  int page;
  int pageSize;
  int totalPage;
  int totalRecord;
  List<DataNotificationUser> data;
  NotificationUser({
    required this.page,
    required this.pageSize,
    required this.totalPage,
    required this.totalRecord,
    required this.data,
  });
  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'pageSize': pageSize,
      'totalPage': totalPage,
      'totalRecord': totalRecord,
      'data': data.map((e) => e.toMap()).toList(),
    };
  }

  factory NotificationUser.fromMap(Map<String, dynamic> json) {
    return NotificationUser(
      page: json['page'],
      pageSize: json['pageSize'],
      totalPage: json['totalPage'],
      totalRecord: json['totalRecord'],
      data: (json['data'] as List<dynamic>?)
              ?.map((x) => DataNotificationUser.fromMap(x))
              .toList() ??
          [],
    );
  }
  String toJson() => json.encode(toMap());
  factory NotificationUser.fromJson(String source) =>
      NotificationUser.fromMap(json.decode(source));
}

class DataNotificationUser {
  String id;
  String notificationType;
  String recipientId;
  String issuerId;
  String content;
  Map<String, dynamic> data;
  DateTime? readAt;
  DateTime canceledAt;
  DateTime updatedAt;
  String createdAt;

  DataNotificationUser({
    required this.id,
    required this.notificationType,
    required this.recipientId,
    required this.issuerId,
    required this.content,
    required this.data,
    required this.readAt,
    required this.canceledAt,
    required this.updatedAt,
    required this.createdAt,
  });
  bool isRead() {
    return readAt != null;
  }

  void markAsRead() {
    readAt = DateTime.now();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'notificationType': notificationType,
      'recipientId': recipientId,
      'issuerId': issuerId,
      'content': content,
      'data': data,
      'readAt': readAt,
      'canceledAt': canceledAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'createdAt': createdAt,
    };
  }

  factory DataNotificationUser.fromMap(Map<String, dynamic> map) {
    return DataNotificationUser(
      id: map['_id'],
      notificationType: map['notificationType'],
      recipientId: map['recipientId'],
      issuerId: map['issuerId'],
      content: map['content'],
      data: map['data'],
      updatedAt: _parseDateTime(map['updatedAt']),
      createdAt: map['createdAt'],
      readAt: map['readAt'] != null ? DateTime.parse(map['readAt']) : null,
      canceledAt: _parseDateTime(map['canceledAt']),
    );
  }
  static DateTime _parseDateTime(dynamic value) {
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    } else if (value is String) {
      return DateTime.timestamp();
    }
    return DateTime.now();
  }

  String toJson() => json.encode(toMap());

  factory DataNotificationUser.fromJson(String source) =>
      DataNotificationUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
