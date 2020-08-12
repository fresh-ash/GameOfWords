class Message {
  final String mess;

  Message({this.mess});

  factory Message.fromJson(Map<String, dynamic> json){
    return Message(mess: json['message']);
  }

  List<String> getStrings(){
    return mess.split("\n");
  }

}