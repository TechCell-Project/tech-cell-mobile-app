import 'package:flutter/material.dart';
import 'package:my_app/API/api_notification.dart';
import 'package:my_app/models/notification_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class NotificationAfterLoginTab extends StatefulWidget {
  const NotificationAfterLoginTab({super.key});

  @override
  State<NotificationAfterLoginTab> createState() =>
      _NotificationAfterLoginTabState();
}

class _NotificationAfterLoginTabState extends State<NotificationAfterLoginTab> {
  NotificationUser notifications = NotificationUser(
      page: 1, pageSize: 1, totalPage: 1, totalRecord: 1, data: []);
  String _selectedReadType = 'all';
  IO.Socket socket = IO.io("wss://socket.techcell.cloud", <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });
  @override
  void initState() {
    connectToSocket();
    super.initState();
  }

  void connectToSocket() {
    socket.onConnect((_) {
      NotificationApi()
          .getNotification(context, socket, _selectedReadType)
          .then((newNotification) {
        setState(() {
          notifications = newNotification;
        });
      });
      print('Connected to socket server');
    });
    socket.onConnectError((data) => 'ket noi that bai');

    socket.on('notification', (data) {
      print('Received notification: $data');
      setState(() {
        notifications.data.insert(0, data);
      });
    });
    socket.disconnect();
    socket.connect();
  }

  void markNotificationAsRead(String notificationId) {
    socket.emit('markNotificationAsRead', notificationId);
    setState(() {
      DataNotificationUser notification = notifications.data.firstWhere(
        (element) => element.id == notificationId,
        orElse: () => DataNotificationUser(
            id: '',
            notificationType: '',
            recipientId: '',
            issuerId: '',
            content: '',
            data: {},
            readAt: null,
            canceledAt: DateTime.now(),
            updatedAt: DateTime.now(),
            createdAt: ''), // Provide a default value
      );
      if (notification.isRead() == false) {
        notification.markAsRead();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Thông báo",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: primaryColors,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: notifications.data.length,
                  itemBuilder: (context, index) {
                    DataNotificationUser notification =
                        notifications.data[index];

                    return Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: ListTile(
                            onTap: () {
                              if (!notification.isRead()) {
                                markNotificationAsRead(notification.id);
                              }
                              ;
                            },
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  AssetImage('assets/icons/profile.png'),
                            ),
                            title: Text(
                              notification.content,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: notification.isRead()
                                      ? Colors.grey
                                      : Colors.black),
                            ),
                            subtitle: Text(
                              notification.createdAt.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: notification.isRead()
                                      ? Colors.grey
                                      : Colors.black),
                            ),
                            trailing: notification.isRead()
                                ? null
                                : Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                  ),
                          ),
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        )
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }
}
