import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Model/playlist_model.dart';
import 'package:mumbi_app/helper/data.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Model/tile_model.dart';
import 'package:mumbi_app/Widget/custom_playlist.dart';
import 'pregnancy_update_detail.dart';



class HomePregnancy extends StatefulWidget {
  const HomePregnancy({Key key}) : super(key: key);

  @override
  _HomePregnancyState createState() => _HomePregnancyState();
}

class _HomePregnancyState extends State<HomePregnancy> {

  CalendarFormat format = CalendarFormat.week;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();


  List<TileModel> listTile = <TileModel>[];
  List<PlayListModel> playlists = <PlayListModel>[];
  List<MutiplePlayListModel> mutiPlayList = <MutiplePlayListModel>[];
  String currentImage = "";
  String currentUrl = "";
  String currentTitle = "";
  String currentSingle = "";
  IconData btnIcon = Icons.play_arrow;
  PlayListModel curentPlaylists = new PlayListModel();

  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool isPlaying = false;
  String currentSong;

  void playMusic(String url) async{
    if(isPlaying && currentSong != url){
      audioPlayer.pause();
      int result = await audioPlayer.play(url);
      if(result ==1){
        setState(() {
          currentSong = url;
        });
      } else if(!isPlaying){
        int result = await audioPlayer.play(url);
        if(result == 1){
          setState(() {
            isPlaying= true;
          });
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listTile = listTilePregnancy();
    playlists = getListMusic();
    // mutiPlayList = getMutiplePlayList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(icon: Icon(Icons.menu)),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => {},
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      border: new Border.all(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon( Icons.assignment_ind_sharp)),
                    width: 60,
                    height: 40,
                    // color: Colors.red,
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    border: new Border.all(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                  child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon( Icons.assignment_ind_sharp)),
                  width: 50,
                  height: 40,
                  // color: Colors.green,
                ),
                Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    border: new Border.all(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                  child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon( Icons.assignment_ind_sharp)),
                  width: 40,
                  height: 40,
                  // color: Colors.blue,
                ),
              ],
            ),
          )
        ],
      ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
               children: <Widget>[
                 FlatButton(
                   onPressed: ()=>{},
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                       side: BorderSide(color: Colors.pinkAccent),
                       borderRadius: BorderRadius.all(Radius.circular(20))
                   ),
                   child:Text('Bé đã ra đời',style: TextStyle(
                     color: Colors.pinkAccent,fontSize: 14, fontWeight: FontWeight.w600,
                   ),),
                 ),

                 TableCalendar(
                   locale: 'vi',
                   firstDay: DateTime(1990),
                   lastDay: DateTime(2050),
                   focusedDay: focusedDay,
                   calendarFormat: format,
                   daysOfWeekVisible: true,
                   startingDayOfWeek: StartingDayOfWeek.monday,
                   selectedDayPredicate: (DateTime date ) {
                     return isSameDay(selectedDay, date);
                   },

                   //Style the calendar
                   calendarStyle: CalendarStyle(
                     defaultTextStyle: TextStyle(
                         color: Colors.pinkAccent
                     ),
                     weekendTextStyle: TextStyle(
                         color: Colors.pinkAccent
                     ) ,
                     selectedDecoration: BoxDecoration(
                         color: Color(0xFFFC95AE),
                         shape: BoxShape.circle
                     ),
                   ),
                   headerStyle: HeaderStyle(
                     headerPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 21),
                     leftChevronVisible: false,
                     rightChevronVisible: false,
                     formatButtonVisible: true,
                     titleTextStyle: TextStyle(
                       fontWeight: FontWeight.w600,
                       fontSize: 16,
                     ),
                     // titleTextFormatter: (date, locale) => DateFormat.yM('yMMM').format(DateTime.now())
                   ),
                 ),

                 Container(
                   height: 264, width: 264,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(150),
                     color: Color(0xFFFC95AE),
                   ),
                   child: Column(
                     children: <Widget>[
                       Container(
                         margin: EdgeInsets.only(top:52),
                         width: 60, height: 60,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(150),
                           color: Color(0xFFFB668A),
                         ),
                         child: SvgPicture.asset(img_beco),
                       ),
                       Container(
                           margin: EdgeInsets.only(top:4),
                           child: Text('Thai kì đã được', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,color: Colors.white),)
                       ),
                       Container(
                           margin: EdgeInsets.only(top:4),
                           child: Text('4 tuần 5 ngày', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.white),)
                       ),
                       Container(
                         margin: EdgeInsets.only(top:16),
                         child: FlatButton(
                           onPressed: ()=>{},
                           color: Colors.white,
                           shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.all(Radius.circular(20))
                           ),
                           child: TextButton(
                             child: Text(
                               'Cập nhật thông tin',style: TextStyle(
                               color: Color(0xFFFB668A),fontSize: 16, fontWeight: FontWeight.w700,),
                             ),
                             onPressed: () => {
                             Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => PregnancyUpdate()),
                             )
                             },
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
                 //Cac hoat dong thai giao
                 SingleChildScrollView(
                   scrollDirection: Axis.vertical,
                   child: Container(
                     margin: EdgeInsets.only(left: 12,right: 12, top: 16, bottom: 23),
                     child: Column(
                       children: <Widget>[
                         Align(
                             alignment: Alignment.topLeft,
                             child: Text('Các hoạt động thai giáo:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),)),
                         ListView.builder(
                           itemCount: listTile.length,
                             shrinkWrap: true,
                             // scrollDirection: Axis.vertical,
                             itemBuilder: (context,index){
                             return customActivityPregnancy2(
                               ontap: (){
                                 //playMusic(playlists[index].url);
                                 setState((){
                                   currentImage = playlists[index].image;
                                   //currentUrl = playlists[index].url;
                                   currentTitle = playlists[index].title;
                                   currentSingle = playlists[index].singer;
                                 });
                               },
                               title: listTile[index].title,
                               playlists: playlists,
                               icon: listTile[index].icon,
                             );
                         }),
                         Column(
                           children: <Widget>[
                             Slider.adaptive(
                                 value: 0.0, onChanged: (value){
                             }),
                             Row(
                               children: <Widget>[
                                 Expanded(
                                   child: ListTile(
                                     leading: Image.network(currentImage),
                                     subtitle: Text(currentTitle),
                                     title: Text(currentSingle),
                                   ),
                                 ),
                                 IconButton(
                                     icon: Icon(btnIcon, color: Colors.pinkAccent,),
                                     iconSize: 42,
                                     onPressed: (){
                                 })
                               ],
                             )
                           ],
                         ),
                       ],

                     ),
                   ),
                 )
               ],
            ),
          ),
        )
    );
  }
}


