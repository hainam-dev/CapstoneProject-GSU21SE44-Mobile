import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/activity_model.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/childHistory_view.dart';
import 'package:mumbi_app/View/childrenInfo_view.dart';
import 'package:mumbi_app/ViewModel/activity_viewmodel.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Widget/custom_playlist.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'drawer_view.dart';
import 'childOtherInfo_view.dart';

class Tracking extends StatefulWidget {
  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  MomViewModel _momViewModel;
  ChildViewModel _childViewModel;
  ActivityViewModel _activityViewModel;

  String currentImage = "";
  String currentSong = "";
  String currentTitle = "";
  IconData btnIcon = Icons.play_circle_outline;
  AudioPlayer audioPlayer = new AudioPlayer();
  AudioCache audioCache = new AudioCache();
  bool isPlaying = false;
  Duration duration = new Duration();
  Duration position = new Duration();

  @override
  void initState() {
    super.initState();
    _momViewModel = MomViewModel.getInstance();
    _momViewModel.getMomByID();

    _childViewModel = ChildViewModel.getInstance();
    if (CurrentMember.pregnancyFlag == true) {
      _childViewModel.getChildByID(CurrentMember.pregnancyID);
    } else {
      _childViewModel.getChildByID(CurrentMember.id);
    }

    _activityViewModel = ActivityViewModel.getInstance();
    _activityViewModel.getActivityByType(1);
    _activityViewModel.getActivityByType(2);
    _activityViewModel.getActivityByType(3);
  }

  @override
  void dispose() async {
    super.dispose();
    await audioPlayer.pause();
    await audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Theo dõi"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChildHistory(),
                    ));
              },
              icon: CircleAvatar(
                  backgroundColor: WHITE_COLOR,
                  child: Icon(
                    Icons.history,
                    size: 20,
                    color: BLACK_COLOR,
                  )),
            ),
          )
        ],
      ),
      drawer: getDrawer(context),
      body: ScopedModel(
          model: _childViewModel,
          child: ScopedModelDescendant(
            builder:
                (BuildContext context, Widget child, ChildViewModel model) {
              return model.childModel == null
                  ? loadingProgress()
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(13, 0, 13, 10),
                            child: Column(
                              children: <Widget>[
                                CalendarHeader(model.childModel),
                                CalendarBody(),
                                CircleThing(model.childModel),
                                SizedBox(
                                  height: 12,
                                ),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Các hoạt động cho bé:',
                                      style: BOLD_20,
                                    )),
                                SizedBox(
                                  height: 8,
                                ),
                                ListenToMusic(),
                                TellTheStory(),
                                ReadPoetry(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
            },
          )),
      bottomNavigationBar: currentSong != "" ? MusicPlaying() : null,
    );
  }

  Widget MusicPlaying() {
    return Container(
        decoration: BoxDecoration(
          color: WHITE_COLOR,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(23), topLeft: Radius.circular(23)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 5),
          ],
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: SvgPicture.asset(currentImage),
                  onPressed: null,
                ),
                Expanded(
                    child: Text(
                  currentTitle,
                )),
                PLayAndPause(),
              ],
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Flexible(child: CurrentDuration()),
                Flexible(
                  child: slider(),
                  flex: 4,
                ),
                Flexible(child: SongDuration()),
              ],
            ),
          ),
        ));
  }

  Widget slider() {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: 5, maxWidth: SizeConfig.blockSizeHorizontal * 70),
      child: SliderTheme(
        data: SliderThemeData(
          thumbColor: BLACK_COLOR.withOpacity(0.9),
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7.0),
          overlayColor: BLACK_COLOR.withOpacity(0.9),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 10.0),
          activeTrackColor: BLACK_COLOR.withOpacity(0.5),
          inactiveTrackColor: GREY_COLOR.withOpacity(0.5),
          trackShape: RectangularSliderTrackShape(),
          trackHeight: 4.0,
        ),
        child: Slider(
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            onChanged: (double value) {
              setState(() {
                Duration newDuration = Duration(seconds: value.toInt());
                audioPlayer.seek(newDuration);
                value = value;
              });
            }),
      ),
    );
  }

  Widget PLayAndPause() {
    return IconButton(
        icon: Icon(
          btnIcon,
          color: BLACK_COLOR,
        ),
        iconSize: 33,
        onPressed: () {
          if (isPlaying) {
            audioPlayer.pause();
            setState(() {
              btnIcon = Icons.play_circle_outline;
              isPlaying = false;
            });
          } else {
            audioPlayer.resume();
            setState(() {
              btnIcon = Icons.pause_circle_outline;
              isPlaying = true;
            });
          }
        });
  }

  Widget CurrentDuration() {
    return Text(
      position.toString().split(".")[0],
    );
  }

  Widget SongDuration() {
    return Text(
      duration.toString().split(".")[0],
    );
  }

  void playMusic(String url) async {
    if (isPlaying && currentSong != url) {
      audioPlayer.pause();
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          currentSong = url;
        });
      }
    } else if (!isPlaying) {
      audioPlayer.pause();
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          isPlaying = false;
          btnIcon = Icons.pause_circle_outline;
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
        position = event;
      });
    });
  }

  Widget CalendarHeader(ChildModel childModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CurrentMember.pregnancyFlag == true
              ? createFlatButton(context, 'Bé đã ra đời',
                  ChildrenInfo(childModel, UPDATE_STATE, CHILD_ENTRY))
              : Container(),
          Row(
            children: [
              Text(
                "Tháng ${DateTimeConvert.getCurrentMonth()}",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              SizedBox(
                width: 4,
              ),
              Icon(
                Icons.calendar_today_outlined,
                color: BLACK_COLOR,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget CalendarBody() {
    return TableCalendar(
      locale: 'vi',
      firstDay: DateTime.now().subtract(new Duration(days: 30)),
      lastDay: DateTime.now().add(new Duration(days: 30)),
      focusedDay: DateTime.now(),
      calendarFormat: CalendarFormat.week,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        defaultTextStyle: TextStyle(color: PINK_COLOR),
      ),
      headerVisible: false,
      availableGestures: AvailableGestures.none,
      calendarBuilders: CalendarBuilders(
        todayBuilder: (context, date, events) => Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: PINK_COLOR, borderRadius: BorderRadius.circular(30.0)),
            child: Text(
              date.day.toString(),
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }

  Widget CircleThing(ChildModel childModel) {
    return Container(
      height: 250,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(150),
        color: Color(0xFFFC95AE),
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 45),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(150),
              color: Color(0xFFFB668A),
            ),
            child: SvgPicture.asset(CurrentMember.pregnancyFlag == true
                ? img_beco
                : getGenderImage(childModel.gender)),
          ),
          Container(
              margin: EdgeInsets.only(top: 4),
              child: Text(
                CurrentMember.pregnancyFlag == true
                    ? "Thai kì đã được"
                    : "Bé đã được",
                style: SEMIBOLDWHITE_13,
              )),
          Container(
              margin: EdgeInsets.only(top: 4),
              child: Text(
                CurrentMember.pregnancyFlag == true
                    ? DateTimeConvert.pregnancyWeekAndDay(
                        childModel.estimatedBornDate)
                    : DateTimeConvert.calculateChildAge(childModel.birthday),
                style: BOLDWHITE_20,
              )),
          SizedBox(
            height: 10.0,
          ),
          createButtonWhite(
              context, 'Cập nhật thông tin', 180, ChildInfoUpdate()),
        ],
      ),
    );
  }

  String getGenderImage(num gender) {
    switch (gender) {
      case 1:
        return img_betrai;
        break;
      case 2:
        return img_begai;
        break;
      default:
        return img_beco;
        break;
    }
  }

  Widget ListenToMusic() {
    return customActivity(
      title: "Nghe nhạc",
      icon: ic_playlist,
      widget: ScopedModel(
          model: _activityViewModel,
          child: ScopedModelDescendant(
            builder:
                (BuildContext context, Widget child, ActivityViewModel model) {
              return model.loadingActivityMusicListModel == true
                  ? loadingProgress()
                  : model.activityMusicListModel == null
                      ? Empty("- Hoạt động nghe nhạc hiện đang trống -")
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: model.activityMusicListModel.length,
                          itemBuilder: (context, index) {
                            ActivityModel activityModel =
                                model.activityMusicListModel[index];
                            return customListTilePlaylist(
                              activityModel.activityName,
                              ic_playlist,
                              onClick: () {
                                playMusic(activityModel.mediaFileURL);
                                setState(() {
                                  currentImage = ic_playlist;
                                  currentTitle = activityModel.activityName;
                                  currentSong = activityModel.mediaFileURL;
                                });
                              },
                            );
                          },
                        );
            },
          )),
    );
  }

  Widget ReadPoetry() {
    return customActivity(
      title: "Đọc thơ",
      icon: ic_poet,
      widget: ScopedModel(
          model: _activityViewModel,
          child: ScopedModelDescendant(
            builder:
                (BuildContext context, Widget child, ActivityViewModel model) {
              return model.loadingActivityPoetryListModel == true
                  ? loadingProgress()
                  : model.activityPoetryListModel == null
                      ? Empty("- Hoạt động đọc thơ hiện đang trống -")
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: model.activityPoetryListModel.length,
                          itemBuilder: (context, index) {
                            ActivityModel activityModel =
                                model.activityPoetryListModel[index];
                            return customListTilePlaylist(
                              activityModel.activityName,
                              ic_poet,
                              onClick: () {
                                playMusic(activityModel.mediaFileURL);
                                setState(() {
                                  currentImage = ic_poet;
                                  currentTitle = activityModel.activityName;
                                  currentSong = activityModel.mediaFileURL;
                                });
                              },
                            );
                          },
                        );
            },
          )),
    );
  }

  Widget TellTheStory() {
    return customActivity(
      title: "Kể Chuyện",
      icon: ic_kechuyen,
      widget: ScopedModel(
          model: _activityViewModel,
          child: ScopedModelDescendant(
            builder:
                (BuildContext context, Widget child, ActivityViewModel model) {
              return model.loadingActivityStoryListModel == true
                  ? loadingProgress()
                  : model.activityStoryListModel == null
                      ? Empty("- Hoạt động kể chuyện hiện đang trống -")
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: model.activityStoryListModel.length,
                          itemBuilder: (context, index) {
                            ActivityModel activityModel =
                                model.activityStoryListModel[index];
                            return customListTilePlaylist(
                              activityModel.activityName,
                              ic_kechuyen,
                              onClick: () {
                                playMusic(activityModel.mediaFileURL);
                                setState(() {
                                  currentImage = ic_kechuyen;
                                  currentTitle = activityModel.activityName;
                                  currentSong = activityModel.mediaFileURL;
                                });
                              },
                            );
                          },
                        );
            },
          )),
    );
  }

  Widget Empty(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Center(
          child: Text(
        title,
        style: TextStyle(color: GREY_COLOR),
      )),
    );
  }
}
