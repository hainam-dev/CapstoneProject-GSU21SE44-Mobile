import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Model/playlist_model.dart';

Widget customActivityPregnancy({String icon, String title, List<PlayListModel> playlists, ontap}){
  return InkWell(
    onTap: ontap,
    child: Container(
      margin: EdgeInsets.only(top: 8),
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          ExpansionTile(
            trailing:Icon(
              Icons.keyboard_arrow_down,
            ),
            leading: IconButton(
              icon: SvgPicture.asset(icon),
            ),
            title: Text(title, style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
            children: [
              ListView.builder(
                itemCount: playlists.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context,index){
                  return customPlaylist(
                    ontap: playlists[index],
                    img: playlists[index].image,
                    title: playlists[index].title,
                    singer: playlists[index].singer,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}


Widget customPlaylist({String title, String singer, String img, ontap}){
  return InkWell(
    onTap: ontap,
    child: ListTile(
      trailing:Icon(
        Icons.play_circle_outline_rounded,
      ),
      leading: Image.network(img),
      subtitle: Text(title),
      title: Text(singer),
    ),
  );
}

Widget customActivityPregnancy2({String icon, String title, List<PlayListModel> playlists, ontap}){
  return InkWell(
    onTap: ontap,
    child: Container(
      margin: EdgeInsets.only(top: 8),
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          ExpansionTile(
            trailing:Icon(
              Icons.keyboard_arrow_down,
            ),
            leading: IconButton(
              icon: SvgPicture.asset(icon),
            ),
            title: Text(title, style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
            children: [
              ListView.builder(
                itemCount: playlists.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context,index){
                  return ListTile(
                    trailing:Icon(
                      Icons.play_circle_outline_rounded,
                    ),
                    leading: Image.network(playlists[index].image),
                    subtitle: Text(playlists[index].title),
                    title: Text(playlists[index].singer),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
