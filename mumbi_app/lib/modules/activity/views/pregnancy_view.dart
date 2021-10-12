import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/modules/activity/models/activity_model.dart';
import 'package:mumbi_app/modules/activity/viewmodel/activity_viewmodel.dart';
import 'package:mumbi_app/widgets/createList.dart';
import 'package:mumbi_app/widgets/customEmpty.dart';
import 'package:mumbi_app/widgets/customLoading.dart';
import 'package:mumbi_app/widgets/custom_playlist.dart';

import 'package:scoped_model/scoped_model.dart';

class Pregnancy extends StatefulWidget {
  @override
  _PregnancyState createState() => _PregnancyState();
}

class _PregnancyState extends State<Pregnancy> {
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
        title: Text("Thai giáo"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              createTitle("Các hoạt động thai giáo"),
              ListenToMusic(),
              TellTheStory(),
              ReadPoetry(),
            ],
          ),
        ),
      ),
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
          maxHeight: 7, maxWidth: SizeConfig.blockSizeHorizontal * 70),
      child: SliderTheme(
        data: SliderThemeData(
          thumbColor: BLACK_COLOR.withOpacity(0.9),
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7.0),
          overlayColor: BLACK_COLOR.withOpacity(0.9),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 10.0),
          activeTrackColor: BLACK_COLOR.withOpacity(0.5),
          inactiveTrackColor: GREY_COLOR.withOpacity(0.5),
          trackShape: RectangularSliderTrackShape(),
          trackHeight: 5.0,
        ),
        child: Slider(
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            onChanged: (double value) {
              setState(() {
                audioPlayer.seek(Duration(seconds: value.toInt()));
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
                      ? Empty("", "- Hoạt động nghe nhạc hiện đang trống -")
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
      title: "Nghe đọc thơ",
      icon: ic_poet,
      widget: ScopedModel(
          model: _activityViewModel,
          child: ScopedModelDescendant(
            builder:
                (BuildContext context, Widget child, ActivityViewModel model) {
              return model.loadingActivityPoetryListModel == true
                  ? loadingProgress()
                  : model.activityPoetryListModel == null
                      ? Empty("", "- Hoạt động đọc thơ hiện đang trống -")
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
      title: "Nghe kể chuyện",
      icon: ic_kechuyen,
      widget: ScopedModel(
          model: _activityViewModel,
          child: ScopedModelDescendant(
            builder:
                (BuildContext context, Widget child, ActivityViewModel model) {
              return model.loadingActivityStoryListModel == true
                  ? loadingProgress()
                  : model.activityStoryListModel == null
                      ? Empty("", "- Hoạt động kể chuyện hiện đang trống -")
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
}
