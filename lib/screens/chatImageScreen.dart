import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uni_dating/models/businessLayer/global.dart' as g;


class ChatImage extends StatefulWidget {
  final String? imageUrl;
  final String? currentUserId;

  ChatImage({this.imageUrl,this.currentUserId});
  @override
  _ChatImageState createState() => _ChatImageState();
}

class _ChatImageState extends State<ChatImage> {

  PreferredSizeWidget _appBarWidget() {
    return PreferredSize(
      preferredSize: Size.fromHeight(65),
      child: Stack(
        children: [

          Container(
            padding: EdgeInsets.only(left: 8),
            alignment: g.isRTL ? Alignment.centerRight : Alignment.centerLeft,
            color: Color(0xFFDC3664),
            width: MediaQuery.of(context).size.width / 2 - 35,
            height: 65,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.longArrowAltLeft),
              color: Colors.white,
              onPressed: () {
                   Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: _appBarWidget(),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: g.gradientColors,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            image: DecorationImage(
              fit: BoxFit.contain,
              image: CachedNetworkImageProvider(widget.imageUrl!),
            )
          ),

        ),
      ),
    );
  }
}
