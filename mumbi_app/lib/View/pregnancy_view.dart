import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Model/playlist_model.dart';
import 'package:mumbi_app/Utils/utilsDay.dart';
import 'package:mumbi_app/helper/data.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Model/tile_model.dart';
import 'package:mumbi_app/Widget/custom_playlist.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'drawer_view.dart';
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

  Map<DateTime, List<Event>> selectedEvents;

  List<TileModel> listTile = <TileModel>[];
  List<PlayListModel> playlists = <PlayListModel>[];
  List<MutiplePlayListModel> mutiPlayList = <MutiplePlayListModel>[];
  String currentImage = "";
  String currentSong = "";
  String currentTitle = "";
  String currentSingle = "";
  IconData btnIcon = Icons.play_arrow;
  PlayListModel currentPlaylists = new PlayListModel();

  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool isPlaying = false;
  Duration duration = new Duration();
  Duration positon = new Duration();

  void playMusic(String url) async{
    if(isPlaying && currentSong != url) {
      audioPlayer.pause();
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          currentSong = url;
        });
      }
    }else if(!isPlaying){
        audioPlayer.pause();
        int result = await audioPlayer.play(url);
        if(result == 1){
          setState(() {
            isPlaying= true;
            btnIcon = Icons.pause;
          });
        }
    }
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        positon = event;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    selectedEvents = getEvents();
    super.initState();
    listTile = listTilePregnancy();
    playlists = getListMusic();
    // mutiPlayList = getMutiplePlayList();
  }

  List<Event> _getEventsFromDay(DateTime date){
    return selectedEvents[DateTime(date.year, date.month, date.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin thai kì'),
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
        drawer: getDrawer(context),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
               children: <Widget>[
                 createFlatButton(context,'Bé đã ra đời',null),
                 TableCalendar(
                   locale: 'vi',
                   firstDay: DateTime(1990),
                   lastDay: DateTime(2050),
                   focusedDay: focusedDay,
                   calendarFormat: format,
                   daysOfWeekVisible: true,
                   startingDayOfWeek: StartingDayOfWeek.monday,

                   //Style the calendar
                   calendarStyle: CalendarStyle(
                     defaultTextStyle: TextStyle(
                         color: Colors.pinkAccent
                     ),
                     weekendTextStyle: TextStyle(
                         color: Colors.pinkAccent
                     ) ,
                   ),
                   headerStyle: HeaderStyle(
                     //Week or Month
                     formatButtonShowsNext: false,
                     formatButtonDecoration: new BoxDecoration(
                       color: PINK_COLOR,
                       borderRadius: BorderRadius.circular(10)
                     ),
                     // headerPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 21),
                     leftChevronVisible: true,
                     rightChevronVisible: true,
                     formatButtonVisible: true,
                     titleTextStyle: BOLD_16,
                     titleTextFormatter: (date, locale) => DateFormat.MMMM(locale).format(DateTime.now()),
                     leftChevronIcon: Icon(Icons.navigate_before_sharp, color: PINK_COLOR,),
                     rightChevronIcon: Icon(Icons.navigate_next_sharp, color: PINK_COLOR,)
                   ),
                   calendarBuilders: CalendarBuilders(
                     selectedBuilder: (context, date, events) => Container(
                         margin: const EdgeInsets.all(4.0),
                         alignment: Alignment.center,
                         decoration: BoxDecoration(
                             color: Theme.of(context).primaryColor,
                             borderRadius: BorderRadius.circular(30.0)),
                         child: Text(
                           date.day.toString(),
                           style: TextStyle(color: Colors.white),
                         )),
                     todayBuilder: (context, date, events) => Container(
                         margin: const EdgeInsets.all(4.0),
                         alignment: Alignment.center,
                         decoration: BoxDecoration(
                             color: Colors.blue,
                             borderRadius: BorderRadius.circular(30.0)),
                         child: Text(
                           date.day.toString(),
                           style: TextStyle(color: Colors.white),
                         )),
                   ),
                   eventLoader: _getEventsFromDay,

                   onDaySelected: (DateTime selectDay, DateTime focusDay) {
                     setState(() {
                       selectedDay = selectDay;
                       focusedDay = focusDay;
                     });
                     print(focusedDay);
                   },
                   selectedDayPredicate: (DateTime date) {
                     return isSameDay(selectedDay, date);
                   },
                 ),
                 ..._getEventsFromDay(selectedDay).map(
                       (Event event) => UpdateInformation(event.dateTime),
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
                             child: Text('Các hoạt động thai giáo:', style: BOLD_20,)),
                         customActivityPregnancy(
                           title: "Nghe Nhạc",
                           icon: ic_playlist,
                           playlists: playlists,
                           widget: ListView.builder(
                             itemCount: playlists.length,
                             shrinkWrap: true,
                             scrollDirection: Axis.vertical,
                             itemBuilder: (context,index){
                               return customListTilePlaylist(
                                 ontap: (){
                                   playMusic(playlists[index].url);
                                   setState(() {
                                     currentImage = playlists[index].image;
                                     currentTitle = playlists[index].title;
                                     currentSingle = playlists[index].singer;
                                   });
                                 },
                                 index: index,
                                 playlists: playlists,
                               );
                             },),),
                         customActivityPregnancy(
                           title: "Đọc thơ",
                           icon: ic_poet,
                           playlists: playlists,
                           widget: ListView.builder(
                             itemCount: playlists.length,
                             shrinkWrap: true,
                             scrollDirection: Axis.vertical,
                             itemBuilder: (context,index){
                               return customListTilePlaylist(
                                 ontap: (){
                                   playMusic(playlists[index].url);
                                   setState(() {
                                     currentImage = playlists[index].image;
                                     currentTitle = playlists[index].title;
                                     currentSingle = playlists[index].singer;
                                   });
                                 },
                                 index: index,
                                 playlists: playlists,
                               );
                             },),),
                         customActivityPregnancy(
                           title: "Kể chuyện",
                           icon: ic_kechuyen,
                           playlists: playlists,
                           widget: ListView.builder(
                             itemCount: playlists.length,
                             shrinkWrap: true,
                             scrollDirection: Axis.vertical,
                             itemBuilder: (context,index){
                               return customListTilePlaylist(
                                 ontap: (){
                                   playMusic(playlists[index].url);
                                   setState(() {
                                     currentImage = playlists[index].image;
                                     currentTitle = playlists[index].title;
                                     currentSingle = playlists[index].singer;
                                   });
                                 },
                                 index: index,
                                 playlists: playlists,
                               );
                             },),),
                         Column(
                           children: <Widget>[
                             Slider.adaptive(
                                 value: positon.inSeconds.toDouble(),
                                 min: 0.0,
                                 max: duration.inSeconds.toDouble(),
                                 onChanged: (value){
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
                                       if (isPlaying){
                                         audioPlayer.pause();
                                         setState(() {
                                           btnIcon = Icons.play_arrow;
                                           isPlaying = false;
                                         });
                                       } else {
                                         audioPlayer.resume();
                                         setState(() {
                                           btnIcon = Icons.pause;
                                           isPlaying = true;
                                         });
                                       }
                                 })
                               ],
                             )
                           ],
                         ),
                       ],
                     ),
                   ),
                 ),
               ],
            ),
          ),
        ),
    );
  }
}
class UpdateInformation extends StatelessWidget {
  String dateTime;
  UpdateInformation(this.dateTime);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Text('Thai kì đã được', style: SEMIBOLDWHITE_13,)
          ),
          Container(
              margin: EdgeInsets.only(top:4),
              child: Text(dateTime, style: BOLDWHITE_20,)
          ),
          createButtonWhite(context, 'Cập nhật hông tin', 200, PregnancyUpdate()),
        ],
      ),
    );
  }
}


