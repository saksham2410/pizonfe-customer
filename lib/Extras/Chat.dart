import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';

// void main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Example Dialogflow Flutter',
//       theme: new ThemeData(
//         primarySwatch: Colors.deepOrange,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: new HomePageDialogflow(),
//     );
//   }
// }

class HomePageDialogflow extends StatefulWidget {
  // HomePageDialogflow({Key key, this.title}) : super(key: key);

  final String title = 'Example';

  @override
  _HomePageDialogflow createState() => new _HomePageDialogflow();
}

class _HomePageDialogflow extends State<HomePageDialogflow> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();

  // Widget _buildTextComposer() {
  //   return new IconTheme(
  //     data: new IconThemeData(color: Theme.of(context).accentColor),
  //     child: new Container(
  //       margin: const EdgeInsets.symmetric(horizontal: 8.0),
  //       child: new Row(
  //         children: <Widget>[
  //           new Flexible(
  //             child: new TextField(
  //               controller: _textController,
  //               onSubmitted: _handleSubmitted,
  //               decoration:
  //                   new InputDecoration.collapsed(hintText: "Send a message"),
  //             ),
  //           ),
  //           new Container(
  //             margin: new EdgeInsets.symmetric(horizontal: 10.0),
  //             child: new IconButton(
  //                 icon: new Icon(Icons.send),
  //                 onPressed: () => _handleSubmitted(_textController.text)),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildTextComposer2() {
    return Container(
        height: 57,
        // width: MediaQuery.of(context).size.width/1.1,
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).primaryColorLight,
                  blurRadius: 10,
                  offset: Offset(0, 3))
            ]),
        child: new Row(children: <Widget>[
          new Flexible(
              child: new Padding(
            padding: EdgeInsets.only(left: 25, top: 5),
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              cursorColor: Color(0xFFFFFFFF),
              decoration: InputDecoration(
                  hintText: 'Type a message',
                  hintStyle: TextStyle(color: Color(0xFF6873a0)),
                  // suffixIcon: Icon(Icons.send, color:Color(0xFFea79ff)),
                  border: InputBorder.none),
            ),
          )),
          new Container(
            margin: new EdgeInsets.symmetric(horizontal: 10.0),
            child: new IconButton(
                icon: new Icon(Icons.send, color: Color(0xFFea79ff)),
                onPressed: () => _handleSubmitted(_textController.text)),
          ),
        ]));
  }

  void Response(query) async {
    _textController.clear();
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/test.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);
    ChatMessage message = new ChatMessage(
      text: response.getMessage() ??
          new CardDialogflow(response.getListMessage()[0]).title,
      name: "Pizon Support",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = new ChatMessage(
      text: text,
      name: "You",
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    Response(text);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Customer Support"),
      ),
      body: new Column(children: <Widget>[
        new Flexible(
            child: new ListView.builder(
          padding: new EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
        )),
        // new Divider(height: 25.0, color: Colors.black),
        new Container(
          // decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer2(),
        ),
      ]),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      new Container(
        margin: const EdgeInsets.only(right: 16.0),
        child:
            new CircleAvatar(backgroundImage: AssetImage('assets/favicon.png')),
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(this.name,
                style: new TextStyle(fontWeight: FontWeight.bold)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text(this.name, style: Theme.of(context).textTheme.subhead),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text),
            ),
          ],
        ),
      ),
      new Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: new CircleAvatar(
            // child: new Text(
            //   // this.name[0],
            //   style: new TextStyle(fontWeight: FontWeight.bold),
            // ),
            backgroundImage: AssetImage('assets/favicon.png')),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}