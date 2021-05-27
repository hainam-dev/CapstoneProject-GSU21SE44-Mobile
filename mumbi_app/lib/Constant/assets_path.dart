final String imageAssetsRoot = "assets/images/";

final String backgroundApp = _getImagePath('background.png');
final String logoApp = _getImagePath('logo.png');
final String logoFacebook = _getImagePath('apple_logo.jpg');
final String logoGoogle = _getImagePath('google_logo.png');
final String iconBoy = _getImagePath('icon_boy.png');
final String iconGirl = _getImagePath('icon_girl.png');
final String iconChild = _getImagePath('icon_child.png');
final String iconCalendar = _getImagePath('icon_calendar.png');
final String iconPlus = _getImagePath('icon_plus.png');
final String chooseImage = _getImagePath('Image.png');
final String remindDrink = _getImagePath('remindDrink.png');
final String remindFitness = _getImagePath('remindFitness.png');
final String remindMilk = _getImagePath('remindMilk.png');
final String remindMusic = _getImagePath('remindMusic.png');
final String remindSleep = _getImagePath('remindSleep.png');


String _getImagePath(String fileName){
  return imageAssetsRoot + fileName;
}

