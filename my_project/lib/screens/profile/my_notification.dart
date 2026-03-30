import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final Color primaryColor = const Color(0xFF0CB39F);
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedData = prefs.getString('my_notifications');

    setState(() {
      if (savedData != null) {
        notifications = List<Map<String, dynamic>>.from(json.decode(savedData));
      } else {
        notifications = _getMockData();
        _saveNotifications();
      }
    });
  }

  List<Map<String, dynamic>> _getMockData() => [
    {
      'id': 1,
      'title': '📚 Sách mới lên kệ!',
      'content': 'Cuốn "Muôn kiếp nhân sinh 3" đã có mặt.',
      'time': '2 phút trước',
      'isRead': false,
      'color': Colors.blue.value,
      'icon': Icons.book_online.codePoint,
    },
    {
      'id': 2,
      'title': '⏰ Nhắc nhở đọc sách',
      'content': 'Đã đến giờ đọc sách rồi, thư giãn nhé!',
      'time': '1 giờ trước',
      'isRead': false,
      'color': Colors.orange.value,
      'icon': Icons.alarm.codePoint,
    },
    {
      'id': 3,
      'title': '✅ Trả sách thành công',
      'content': 'Hệ thống xác nhận bạn đã trả sách.',
      'time': '3 giờ trước',
      'isRead': true,
      'color': Colors.green.value,
      'icon': Icons.check_circle_outline.codePoint,
    },
  ];

  Future<void> _saveNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('my_notifications', json.encode(notifications));
  }

  void _markAllAsRead() {
    setState(() {
      for (var item in notifications) {
        item['isRead'] = true;
      }
    });
    _saveNotifications();
  }

  void _deleteAll() {
    setState(() => notifications.clear());
    _saveNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: Text(
          'Thông báo (${notifications.length})',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: _markAllAsRead,
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _deleteAll,
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                "Không có thông báo nào",
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];
                return Dismissible(
                  key: Key(item['id'].toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    setState(() => notifications.removeAt(index));
                    _saveNotifications();
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: item['isRead']
                        ? Colors.white
                        : const Color(0xFFE0F2F1),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(item['color']).withOpacity(0.1),
                        child: Icon(
                          IconData(item['icon'], fontFamily: 'MaterialIcons'),
                          color: Color(item['color']),
                          size: 20,
                        ),
                      ),
                      title: Text(
                        item['title'],
                        style: TextStyle(
                          fontWeight: item['isRead']
                              ? FontWeight.normal
                              : FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        "${item['content']}\n${item['time']}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      isThreeLine: true,
                      onTap: () {
                        setState(() => item['isRead'] = true);
                        _saveNotifications();
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
