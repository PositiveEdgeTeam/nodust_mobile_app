import 'package:nodustmobileapp/Models/channel.dart';

class ChannelResponse{
  String state;
  String code;
  String message;
  List<Channel> data;


  ChannelResponse(this.state, this.code,this.message, [this.data]);

  factory ChannelResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      var tagObjsJson = json['data'] as List;
      List<Channel> _channels = tagObjsJson.map((tagJson) => Channel.fromJson(tagJson))
          .toList();

      return ChannelResponse(
          json['state'] as String,
          json['code'] as String,
          json['message'] as String,
          _channels
      );
    }
    else{
      return ChannelResponse(
          json['state'] as String,
          json['code'] as String,
          json['message'] as String);
    }

  }

  @override
  String toString() {
    return '{ ${this.state}, ${this.code},${this.message}, ${this.data} }';
  }
}