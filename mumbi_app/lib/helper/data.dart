
import 'dart:developer';

import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Model/category_model.dart';
import 'package:mumbi_app/Model/tile_model.dart';
import 'package:mumbi_app/Model/playlist_model.dart';
import 'package:mumbi_app/Utils/utilsDay.dart';
import 'package:mumbi_app/Model/tooth_model.dart';

List<CategoryModel> getCategories(){
  List<CategoryModel> category = <CategoryModel>[];
  CategoryModel categoryModel;

  //1
  categoryModel = new CategoryModel();
  categoryModel.cateforyName = "Chuyển dạ sinh con và 101 thắc mắc của mẹ bầu.";
  categoryModel.imgeUrl = "https://i.pinimg.com/originals/05/44/2c/05442ce313dba17776639cfadef49cfc.jpg";
  categoryModel.dateTime = "03/05/2021";
  category.add(categoryModel);

  //2
  categoryModel = new CategoryModel();
  categoryModel.cateforyName = "Chuyển dạ sinh con và 101 thắc mắc của mẹ bầu.";
  categoryModel.imgeUrl = "https://dct.azureedge.net/assets/uploads/file/7f7f7ba3-d114-43a7-86d8-74f2a6eda480.jpg";
  categoryModel.dateTime = "03/05/2021";
  category.add(categoryModel);

  //3
  categoryModel = new CategoryModel();
  categoryModel.cateforyName = "Chuyển dạ sinh con và 101 thắc mắc của mẹ bầu.";
  categoryModel.imgeUrl = "https://www.healthychildren.org/SiteCollectionImagesArticleImages/baby_hood_towel.jpg?RenditionID=6";
  categoryModel.dateTime = "03/05/2021";
  category.add(categoryModel);

  //4
  categoryModel = new CategoryModel();
  categoryModel.cateforyName = "Chuyển dạ sinh con và 101 thắc mắc của mẹ bầu.";
  categoryModel.imgeUrl = "https://www.healthychildren.org/SiteCollectionImagesArticleImages/baby_hood_towel.jpg?RenditionID=6";
  categoryModel.dateTime = "03/05/2021";
  category.add(categoryModel);

  //5
  categoryModel = new CategoryModel();
  categoryModel.cateforyName = "Science";
  categoryModel.imgeUrl = "https://www.healthychildren.org/SiteCollectionImagesArticleImages/baby_hood_towel.jpg?RenditionID=6";
  categoryModel.dateTime = "03/05/2021";
  category.add(categoryModel);

  //6
  categoryModel = new CategoryModel();
  categoryModel.cateforyName = "Technology";
  categoryModel.imgeUrl = "https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
  categoryModel.dateTime = "03/05/2021";
  category.add(categoryModel);

  print("List Catefory:" + category.length.toString());
  return category;

}
List<TileModel> listTilePregnancy(){
  List<TileModel> tiles = <TileModel>[];
  TileModel tileModel;

  //1
  tileModel = new TileModel();
  tileModel.icon = ic_playlist;
  tileModel.title = 'Nghe nhạc';
  tiles.add(tileModel);

  //2
  tileModel = new TileModel();
  tileModel.icon = ic_poet;
  tileModel.title = 'Đọc thơ';
  tiles.add(tileModel);

  //3
  tileModel = new TileModel();
  tileModel.icon = ic_kechuyen;
  tileModel.title = 'Kể chuyện';
  tiles.add(tileModel);

  return tiles;
}

List<PlayListModel> getListMusic(){
  List<PlayListModel> playlist = <PlayListModel>[];
  PlayListModel playListModel;

  //1
  playListModel = new PlayListModel();
  playListModel.image = 'https://image-us.eva.vn/upload/4-2019/images/2019-11-08/d5725539e07809265069-1573176800-91-width800height550.jpg';
  playListModel.url = 'https://nhacchuong123.com/nhac-chuong/amthanh/Nhac-Chuong-Chi-La-Khong-Cung-Nhau-Tang-Phuc-Tr%C6%B0%C6%A1ng-Thao-Nhi.mp3';
  playListModel.title = 'Con cò bé bé';
  playListModel.singer = 'Bé xuân mai';
  playlist.add(playListModel);

  //2
  playListModel = new PlayListModel();
  playListModel.image = 'https://idol.com.vn/wp-content/uploads/2020/12/be-bao-an.png';
  playListModel.url = 'https://nhacchuong123.com/nhac-chuong/nhac-tik-tok/Nhac%20Chuong%20Co%20Doc%20Vuong%20(Diep%20Khuc)%20-%20Thien%20Tu.mp3';
  playListModel.title = 'Chú cún con';
  playListModel.singer = 'Bé Bảo An';
  playlist.add(playListModel);

  //3
  playListModel = new PlayListModel();
  playListModel.image = 'https://i.ytimg.com/vi/lFxKzXW_64k/maxresdefault.jpg';
  playListModel.url = 'https://nhacchuong123.com/nhac-chuong/am-thanh/Nhac Chuong Duong Toi Cho Em Ve - buitruonglinh.mp3';
  playListModel.title = 'Một con vịt';
  playListModel.singer = 'Con vịt';
  playlist.add(playListModel);

  //4
  playListModel = new PlayListModel();
  playListModel.image = 'https://i.ytimg.com/vi/TRXo0LiKTyE/hqdefault.jpg';
  playListModel.url = 'https://nhacchuong123.com/nhac-chuong/nhac-tre/HOAI LAM  - Buon Lam Chi Em Oi - nhacchuong123.com.mp3';
  playListModel.title = 'Chú mèo con';
  playListModel.singer = 'Con mèo';
  playlist.add(playListModel);

  return playlist;
}
List<PlayListModel> getListPoet(){
  List<PlayListModel> playlist = <PlayListModel>[];
  PlayListModel playListModel;

  //1
  playListModel = new PlayListModel();
  playListModel.url = '...';
  playListModel.title = 'Con cò bé bé';
  playListModel.singer = 'Bé xuân mai';
  playlist.add(playListModel);

  //2
  playListModel = new PlayListModel();
  playListModel.url = '...';
  playListModel.title = 'Con cò bé bé';
  playListModel.singer = 'Bé xuân mai';
  playlist.add(playListModel);

  //3
  playListModel = new PlayListModel();
  playListModel.url = '...';
  playListModel.title = 'Con cò bé bé';
  playListModel.singer = 'Bé xuân mai';
  playlist.add(playListModel);

  return playlist;
}
List<PlayListModel> getListStory(){
  List<PlayListModel> playlist = <PlayListModel>[];
  PlayListModel playListModel;

  //1
  playListModel = new PlayListModel();
  playListModel.url = 'https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3';
  playListModel.title = 'Con cò bé bé';
  playListModel.singer = 'Bé xuân mai';
  playlist.add(playListModel);

  //2
  playListModel = new PlayListModel();
  playListModel.url = 'https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3';
  playListModel.title = 'Con cò bé bé';
  playListModel.singer = 'Bé xuân mai';
  playlist.add(playListModel);

  //3
  playListModel = new PlayListModel();
  playListModel.url = 'https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3';
  playListModel.title = 'Con cò bé bé';
  playListModel.singer = 'Bé xuân mai';
  playlist.add(playListModel);

  //3
  playListModel = new PlayListModel();
  playListModel.url = 'https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3';
  playListModel.title = 'Con cò bé bé';
  playListModel.singer = 'Bé xuân mai';
  playlist.add(playListModel);


  print("Play List Model:" + playlist.length.toString());
  return playlist;
}

List<MutiplePlayListModel> getMutiplePlayList(){
  List<TileModel> listTiles = listTilePregnancy();
  List<PlayListModel> playList = <PlayListModel>[];

  List<MutiplePlayListModel> listPlayList = <MutiplePlayListModel>[] ;
  for (int i= 0; i < listTiles.length; i++){
      listPlayList[i].tileModel = listTiles[i];
     // listPlayList[i].playlistModel = playList;
  }
  print("List Play List" + listPlayList.toString());
  return listPlayList;
}

List music = [
  {
    'coverImage': "https://image-us.eva.vn/upload/4-2019/images/2019-11-08/d5725539e07809265069-1573176800-91-width800height550.jpg",
    'subtitle': "Con cò bé bé",
    'single': "Bé Xuân Mai",
    'url': "https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3",
  },
  {
    'coverImage': "https://image-us.eva.vn/upload/4-2019/images/2019-11-08/d5725539e07809265069-1573176800-91-width800height550.jpg",
    'subtitle': "Con cò bé bé",
    'single': "Bé Xuân Mai",
    'url': "https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3",
  },
  {
    'coverImage': "https://image-us.eva.vn/upload/4-2019/images/2019-11-08/d5725539e07809265069-1573176800-91-width800height550.jpg",
    'subtitle': "Con cò bé bé",
    'single': "Bé Xuân Mai",
    'url': "https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3",
  },
  {
    'coverImage': "https://image-us.eva.vn/upload/4-2019/images/2019-11-08/d5725539e07809265069-1573176800-91-width800height550.jpg",
    'subtitle': "Con cò bé bé",
    'single': "Bé Xuân Mai",
    'url': "https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3",
  },
];

Map<DateTime, List<Event>> getEvents() {
  return {
    DateTime(2021, 6, 14): [Event(dateTime: "5 ngày 5 giờ")],
    DateTime(2021, 6, 15): [Event(dateTime: "6 ngày 5 giờ")],
    DateTime(2021, 6, 16): [Event(dateTime: "7 ngày 5 giờ")],
    DateTime(2021, 6, 17): [Event(dateTime: "8 ngày 5 giờ")],
    DateTime(2021, 6, 18): [Event(dateTime: "9 ngày 5 giờ")],
  };
}

List<ToothInfoModel> getListTeeth(){
  List<ToothInfoModel> listTeeth = <ToothInfoModel>[];
  ToothInfoModel teethModel;

  teethModel = new ToothInfoModel();
  teethModel.icon = ic_teeth1_ht;
  teethModel.iconChoose = ic_teeth1_ht_choose;
  teethModel.height = 65;
  teethModel.width = 65;
  teethModel.top = 112;
  teethModel.left = 6;
  teethModel.name ='Răng 19';
  listTeeth.add(teethModel);

  teethModel = new ToothInfoModel();
  teethModel.icon = ic_teeth2_ht;
  teethModel.iconChoose = ic_teeth2_ht_choose;
  teethModel.height = 63;
  teethModel.width = 63;
  teethModel.top = 68;
  teethModel.left = 22;
  teethModel.name ='Răng 10';
  listTeeth.add(teethModel);

  teethModel = new ToothInfoModel();
  teethModel.icon = ic_teeth3_ht;
  teethModel.iconChoose = ic_teeth3_ht_choose;
  teethModel.height = 55;
  teethModel.width = 55;
  teethModel.top = 38;
  teethModel.left = 48;
  teethModel.name ='Răng 13';
  listTeeth.add(teethModel);

  teethModel = new ToothInfoModel();
  teethModel.icon = ic_teeth4_ht;
  teethModel.iconChoose = ic_teeth4_ht_choose;
  teethModel.height = 50;
  teethModel.width = 50;
  teethModel.top = 15;
  teethModel.left = 70;
  teethModel.name ='Răng 5';
  listTeeth.add(teethModel);

  teethModel = new ToothInfoModel();
  teethModel.icon = ic_teeth5_ht;
  teethModel.iconChoose = ic_teeth5_ht_choose;
  teethModel.height = 50;
  teethModel.width = 50;
  teethModel.top = 5;
  teethModel.left = 105;
  teethModel.name ='Răng 3';
  listTeeth.add(teethModel);

  teethModel = new ToothInfoModel();
  teethModel.icon = ic_teeth6_ht;
  teethModel.iconChoose = ic_teeth6_ht_choose;
  teethModel.height = 53;
  teethModel.width = 53;
  teethModel.top = 5;
  teethModel.left = 143;
  teethModel.name ='Răng 4';
  listTeeth.add(teethModel);

  teethModel = new ToothInfoModel();
  teethModel.icon = ic_teeth7_ht;
  teethModel.iconChoose = ic_teeth7_ht_choose;
  teethModel.height = 53;
  teethModel.width = 53;
  teethModel.top = 15;
  teethModel.left = 178;
  teethModel.name ='Răng ';
  teethModel.growTime ='Răng 1';
  listTeeth.add(teethModel);

  teethModel = new ToothInfoModel();
  teethModel.icon = ic_teeth8_ht;
  teethModel.iconChoose = ic_teeth8_ht_choose;
  teethModel.height = 46;
  teethModel.width = 50;
  teethModel.top = 45;
  teethModel.left = 200;
  teethModel.name ='Răng 1';
  teethModel.growTime ='Răng 1';
  listTeeth.add(teethModel);

  teethModel = new ToothInfoModel();
  teethModel.icon = ic_teeth9_ht;
  teethModel.iconChoose = ic_teeth9_ht_choose;
  teethModel.height = 60;
  teethModel.width = 63;
  teethModel.top = 70;
  teethModel.left = 215;
  teethModel.name ='Răng 1';
  teethModel.growTime ='Răng 1';
  listTeeth.add(teethModel);

  teethModel = new ToothInfoModel();
  teethModel.icon = ic_teeth10_ht;
  teethModel.iconChoose = ic_teeth10_ht_choose;
  teethModel.height = 65;
  teethModel.width = 65;
  teethModel.top = 112;
  teethModel.left = 229;
  teethModel.name ='Răng 1';
  teethModel.growTime ='Răng 1';
  listTeeth.add(teethModel);

  teethModel = new ToothInfoModel();
  teethModel.icon = ic_teeth1_hd;
  teethModel.iconChoose = ic_teeth1_hd_choose;
  teethModel.height = 65;
  teethModel.width = 65;
  teethModel.top = 5;
  teethModel.left = 2;
  teethModel.name ='Răng 1';
  teethModel.growTime ='Răng 1';
  listTeeth.add(teethModel);

  teethModel = new ToothInfoModel();
  teethModel.icon = ic_teeth2_hd;
  teethModel.iconChoose = ic_teeth2_hd_choose;
  teethModel.height = 60;
  teethModel.width = 55;
  teethModel.top = 55;
  teethModel.left = 23;
  teethModel.name ='Răng 1';
  teethModel.growTime ='Răng 1';
  listTeeth.add(teethModel);

  teethModel = new ToothInfoModel();
  teethModel.icon = ic_teeth3_hd;
  teethModel.iconChoose = ic_teeth3_hd_choose;
  teethModel.height = 52;
  teethModel.width = 52;
  teethModel.top = 95;
  teethModel.left = 46;
  teethModel.name ='Răng 1';
  teethModel.growTime ='Răng 1';
  listTeeth.add(teethModel);

  teethModel = new ToothInfoModel();
  teethModel.icon = ic_teeth4_hd;
  teethModel.iconChoose = ic_teeth4_hd_choose;
  teethModel.height = 50;
  teethModel.width = 50;
  teethModel.top = 125;
  teethModel.left = 68;
  teethModel.name ='Răng 1';
  teethModel.growTime ='Răng 1';
  listTeeth.add(teethModel);

  teethModel = new ToothInfoModel();
  teethModel.icon = ic_teeth5_hd;
  teethModel.iconChoose = ic_teeth5_hd_choose;
  teethModel.height = 45;
  teethModel.width = 45;
  teethModel.top = 140;
  teethModel.left = 108;
  teethModel.name ='Răng 1';
  teethModel.growTime ='Răng 1';
  listTeeth.add(teethModel);

  teethModel = new ToothInfoModel();
  teethModel.icon = ic_teeth6_hd;
  teethModel.iconChoose = ic_teeth6_hd_choose;
  teethModel.height = 45;
  teethModel.width = 45;
  teethModel.top = 140;
  teethModel.left = 149;
  teethModel.name ='Răng 1';
  teethModel.growTime ='Răng 1';
  listTeeth.add(teethModel);

  teethModel = new ToothInfoModel();
  teethModel.icon = ic_teeth7_hd;
  teethModel.iconChoose = ic_teeth7_hd_choose;
  teethModel.height = 50;
  teethModel.width = 50;
  teethModel.top = 125;
  teethModel.left = 183;
  teethModel.name ='Răng 1';
  teethModel.growTime ='Răng 1';
  listTeeth.add(teethModel);

  teethModel = new ToothInfoModel();
  teethModel.icon = ic_teeth8_hd;
  teethModel.iconChoose = ic_teeth8_hd_choose;
  teethModel.height = 50;
  teethModel.width = 50;
  teethModel.top = 95;
  teethModel.left = 205;
  teethModel.name ='Răng 1';
  teethModel.growTime ='Răng 1';
  listTeeth.add(teethModel);

  teethModel = new ToothInfoModel();
  teethModel.icon = ic_teeth9_hd;
  teethModel.iconChoose = ic_teeth9_hd_choose;
  teethModel.height = 63;
  teethModel.width = 63;
  teethModel.top = 53;
  teethModel.left = 220;
  teethModel.name ='Răng 1';
  teethModel.growTime ='Răng 1';
  listTeeth.add(teethModel);

  teethModel = new ToothInfoModel();
  teethModel.icon = ic_teeth10_hd;
  teethModel.iconChoose = ic_teeth10_hd_choose;
  teethModel.height = 65;
  teethModel.width = 65;
  teethModel.top = 5;
  teethModel.left = 233;
  teethModel.name ='Răng 1';
  teethModel.growTime ='Răng 1';
  listTeeth.add(teethModel);

  return listTeeth;
}