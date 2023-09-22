import 'package:flutter/material.dart';

import '../widgets/text_widget.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) {
        // List msg = data.docs[index]['messages'];
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: ListTile(
            onTap: () {
              showchat(context);
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => ChatPage(
              //           userData: data.docs[index]['freelancerId'],
              //         )));
            },
            leading: const CircleAvatar(
              maxRadius: 40,
              minRadius: 40,
              backgroundImage: AssetImage('assets/images/profile.png'),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.circle,
                  color: Colors.green,
                ),
              ),
            ),
            title: TextWidget(
              text: 'Name here',
              fontSize: 24,
              color: Colors.black,
              fontFamily: 'Bold',
            ),
            subtitle: TextWidget(
              text: 'Message here',
              fontSize: 14,
              color: Colors.grey,
              fontFamily: 'Regular',
            ),
          ),
        );
      },
    );
  }

  final msgController = TextEditingController();

  showchat(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 300,
                  width: 300,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: TextWidget(
                          text: 'Message here',
                          fontSize: 14,
                          fontFamily: 'Medium',
                          color: Colors.black,
                        ),
                        subtitle: TextWidget(
                          text: 'Name here',
                          fontSize: 12,
                          fontFamily: 'Regular',
                          color: Colors.grey,
                        ),
                        trailing: TextWidget(
                          text: '01/20/2023',
                          fontSize: 8,
                          fontFamily: 'Regular',
                          color: Colors.black,
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.send,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: TextWidget(
                text: 'Close',
                fontSize: 14,
                fontFamily: 'Bold',
              ),
            ),
          ],
        );
      },
    );
  }
}
