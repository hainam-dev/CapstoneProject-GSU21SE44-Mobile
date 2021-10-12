import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/common_message.dart';
import 'package:mumbi_app/modules/guidebook/views/guidebook_details_view.dart';
import 'package:mumbi_app/modules/news/views/news_details_view.dart';
import 'package:mumbi_app/modules/guidebook/viewmodel/saved_guidebook_viewmodel.dart';
import 'package:mumbi_app/modules/news/viewmodel/saved_news_viewmodel.dart';
import 'package:mumbi_app/widgets/customCard.dart';
import 'package:mumbi_app/widgets/customEmpty.dart';
import 'package:mumbi_app/widgets/customLoading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scoped_model/scoped_model.dart';

class Saved extends StatefulWidget {
  final num tabIndex;
  const Saved(this.tabIndex);

  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  SavedNewsViewModel _savedNewsViewModel;
  SavedGuidebookViewModel _savedGuidebookViewModel;

  num _initialIndex = 0;

  RefreshController _refreshControllerNews =
      RefreshController(initialRefresh: false);
  RefreshController _refreshControllerGuidebook =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    _initialIndex = widget.tabIndex;

    _savedNewsViewModel = SavedNewsViewModel.getInstance();
    _savedNewsViewModel.getSavedNews();

    _savedGuidebookViewModel = SavedGuidebookViewModel.getInstance();
    _savedGuidebookViewModel.getSavedGuidebook();
  }

  void _onRefreshNews() async {
    await _savedNewsViewModel.getSavedNews();
    _refreshControllerNews.refreshCompleted();
  }

  void _onLoadingNews() async {
    await _savedNewsViewModel.getMoreSavedNews();
    if (mounted) setState(() {});
    _refreshControllerNews.loadComplete();
  }

  void _onRefreshGuidebook() async {
    await _savedGuidebookViewModel.getSavedGuidebook();
    _refreshControllerGuidebook.refreshCompleted();
  }

  void _onLoadingGuidebook() async {
    await _savedGuidebookViewModel.getMoreSavedGuidebook();
    if (mounted) setState(() {});
    _refreshControllerGuidebook.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: _initialIndex,
      child: Scaffold(
        backgroundColor: WHITE_COLOR,
        appBar: AppBar(
          title: Text('Đã lưu'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                    color: PINK_COLOR,
                  ),
                  labelColor: WHITE_COLOR,
                  unselectedLabelColor: BLACK_COLOR,
                  tabs: [
                    Tab(
                      text: 'Tin Tức',
                    ),
                    Tab(
                      text: 'Cẩm Nang',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SavedNewsList(),
                  SavedGuidebookList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget SavedNewsList() {
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: MaterialClassicHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.loading) {
              body = loadingProgress();
            } else {
              body = Text(NO_MORE_NEWS_MESSAGE);
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshControllerNews,
        onRefresh: _onRefreshNews,
        onLoading: _onLoadingNews,
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate(
              [
                ScopedModel(
                    model: _savedNewsViewModel,
                    child: ScopedModelDescendant(
                      builder: (BuildContext context, Widget child,
                          SavedNewsViewModel model) {
                        return model.isLoading == true
                            ? loadingProgress()
                            : model.savedNewsListModel == null
                                ? Empty("", NO_SAVED_NEWS_MESSAGE)
                                : Column(
                                    children: [
                                      for (var item in model.savedNewsListModel)
                                        NormalCardItem(
                                            item.imageURL,
                                            item.title,
                                            item.createTime,
                                            item.estimatedFinishTime,
                                            onTap: () async {
                                          final result = await Navigator.push(
                                            context,
                                            await MaterialPageRoute(
                                              builder: (context) =>
                                                  NewsDetail(item, SAVED_ENTRY),
                                            ),
                                          );
                                          if (result == true) {
                                            _savedNewsViewModel
                                                .savedNewsListModel
                                                .remove(item);
                                            setState(() {});
                                          }
                                        })
                                    ],
                                  );
                      },
                    )),
              ],
            ))
          ],
        ));
  }

  Widget SavedGuidebookList() {
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: MaterialClassicHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.loading) {
              body = loadingProgress();
            } else {
              body = Text(NO_MORE_GUIDEBOOK_MESSAGE);
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshControllerGuidebook,
        onRefresh: _onRefreshGuidebook,
        onLoading: _onLoadingGuidebook,
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate(
              [
                ScopedModel(
                    model: _savedGuidebookViewModel,
                    child: ScopedModelDescendant(
                      builder: (BuildContext context, Widget child,
                          SavedGuidebookViewModel model) {
                        return model.isLoading == true
                            ? loadingProgress()
                            : model.savedGuidebookListModel == null
                                ? Empty("", NO_SAVED_GUIDEBOOK_MESSAGE)
                                : Column(
                                    children: [
                                      for (var item
                                          in model.savedGuidebookListModel)
                                        NormalCardItem(
                                          item.imageURL,
                                          item.title,
                                          item.createTime,
                                          item.estimatedFinishTime,
                                          onTap: () async {
                                            final result = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      GuidebookDetail(
                                                          item, SAVED_ENTRY),
                                                ));
                                            if (result == true) {
                                              _savedGuidebookViewModel
                                                  .savedGuidebookListModel
                                                  .remove(item);
                                              setState(() {});
                                            }
                                          },
                                        )
                                    ],
                                  );
                      },
                    )),
              ],
            ))
          ],
        ));
  }
}
