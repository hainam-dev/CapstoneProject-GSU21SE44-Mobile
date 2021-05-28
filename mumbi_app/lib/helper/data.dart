
import 'package:mumbi_app/Model/category_model.dart';

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

  print(category.toString());
  return category;

}