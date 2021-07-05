import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:provider/provider.dart';
import 'package:mumbi_app/Model/article_model.dart';
import 'package:mumbi_app/View/guideBook_save.dart';

final saveListProvider = StateProvider((ref)
=> ArticleList([])
);

