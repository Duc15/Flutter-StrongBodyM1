import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    print("MessagePage is built");
    return Center(child: Text('Message Page'));
  }
}
