import 'package:chat_app/screens/welcom_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _fireStore = FirebaseFirestore.instance;
late User signedUser;

class ChatScreen extends StatefulWidget {
  static String TAG = 'chat_screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? testMessage ;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser(){
    try {
      final user = _auth.currentUser;
      if(user != null){
        signedUser = user;
        print(signedUser.email);
      }
    }catch (e){
      print(e);
    }
  }

  // void getMessage() async{
  //   final messages = await _fireStore.collection('messages').get();
  //   for(var message in messages.docs){
  //     print(message.data());
  //   }
  // }


  void messagesStreams() async {
    await for(var snapshot in _fireStore.collection('messages').snapshots()){
      for(var message in snapshot.docs){
        print(message);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[900],
          title: Row(
            children: [
              Image.asset('images/logo.png' , height: 30,color: Colors.white,),
              SizedBox(width: 10,),
              Text('MessageMe'),
            ],
          ),
          actions: [
            IconButton(
                onPressed: (){
                  _auth.signOut();
                  Navigator.pushNamed(context, WelcomScreen.TAG);
                },
                icon: Icon(Icons.close)),
          ],
        ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageBuilder(),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  )
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      onChanged: (value) {
                        testMessage = value;
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        hintText: 'Write your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: (){
                        messageController.clear();
                        _fireStore.collection('messages').add({
                          'sender' : signedUser.email,
                          'text' : testMessage,
                          'time' : FieldValue.serverTimestamp(),
                        });
                      },
                      child: Text(
                        'send',
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBuilder extends StatelessWidget {
  const MessageBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').orderBy('time').snapshots(),
      builder: (context , snapShot){
        List<MessageLine> messageWidgets = [];

        if(!snapShot.hasData){
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.orange,
            ),
          );
        }

        final messages = snapShot.data!.docs.reversed;
        for(var message in messages){
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          final currentUser = signedUser.email;

          // if(currentUser == messageSender){
          //
          // }

          final messageWidget = MessageLine(
            sender: '$messageSender',
            text: '$messageText',
            isMe: currentUser == messageSender,);
          messageWidgets.add(messageWidget);
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 20),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}




class MessageLine extends StatelessWidget {
  const MessageLine({Key? key,
    this.sender,
    this.text,
    required this.isMe
  }) : super(key: key);

  final String? sender;
  final String? text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text('$sender' ,
          style: TextStyle(
            fontSize: 12,
            color: Colors.yellow[900],
          ),),
          Material(
            elevation: 5,
            borderRadius: isMe ? BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)
            ) : BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)
            ),
            color: isMe ? Colors.blue[800] : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
              child: Text(
                '$text' ,
                style: TextStyle(
                    fontSize: 15,
                  color: isMe ? Colors.white : Colors.black45,
                ),),
            ),
          ),
        ],
      ),
    );
  }
}

