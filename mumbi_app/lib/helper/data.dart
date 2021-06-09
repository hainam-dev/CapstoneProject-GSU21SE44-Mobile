
import 'dart:developer';

import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Model/category_model.dart';
import 'package:mumbi_app/Model/tile_model.dart';
import 'package:mumbi_app/Model/playlist_model.dart';

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
  playListModel.url = 'https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3';
  playListModel.title = 'Con cò bé bé';
  playListModel.singer = 'Bé xuân mai';
  playlist.add(playListModel);

  //2
  playListModel = new PlayListModel();
  playListModel.image = 'https://idol.com.vn/wp-content/uploads/2020/12/be-bao-an.png';
  playListModel.url = 'https://luan.xyz/files/audio/ambient_c_motion.mp3';
  playListModel.title = 'Con cò bé bé';
  playListModel.singer = 'Bé Bảo An';
  playlist.add(playListModel);

  //3
  playListModel = new PlayListModel();
  playListModel.image = 'https://i.ytimg.com/vi/lFxKzXW_64k/maxresdefault.jpg';
  playListModel.url = 'https://luan.xyz/files/audio/ambient_c_motion.mp3';
  playListModel.title = 'Một con vịt';
  playListModel.singer = 'Con vịt';
  playlist.add(playListModel);

  //4
  playListModel = new PlayListModel();
  playListModel.image = 'https://i.ytimg.com/vi/TRXo0LiKTyE/hqdefault.jpg';
  playListModel.url = 'https://luan.xyz/files/audio/ambient_c_motion.mp3';
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
