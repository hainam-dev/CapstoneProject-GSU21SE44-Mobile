import 'package:cached_network_image/cached_network_image.dart';
import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Model/comment_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/View/editComment.dart';
import 'package:mumbi_app/ViewModel/comment_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/ViewModel/reaction_viewmodel.dart';
import 'package:mumbi_app/Widget/customConfirmDialog.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:mumbi_app/Widget/customProgressDialog.dart';
import 'package:readmore/readmore.dart';
import 'package:scoped_model/scoped_model.dart';

class PostComment extends StatefulWidget {
  final postModel;

  const PostComment(this.postModel);

  @override
  _PostCommentState createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> {

  bool commentFlag = false;
  String replyUser = "";
  num replyCommentId;
  MomViewModel _momViewModel;
  CommentViewModel commentViewModel;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _momViewModel = MomViewModel.getInstance();
    commentViewModel = new CommentViewModel();
    commentViewModel.getPostComment(widget.postModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: Text(
            "Bình luận",
          ),
        ),
        body: ScopedModel(
          model: commentViewModel,
          child: ScopedModelDescendant(builder: (BuildContext context, Widget child, CommentViewModel model) {
            return model.isLoading == true
                ? loadingProgress()
                : model.commentListModel.length == 0
                ? Empty()
                : SingleChildScrollView(
                child: Column(
                  children: [
                    for(var comment in model.commentListModel)
                      postComment(comment),
                  ],
                ));
          },),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: WHITE_COLOR,
              border: Border(top: BorderSide(color: GREY_COLOR))),
          child:
          Card(margin: EdgeInsets.zero, child: CommentSection()),
        ),
      ),
    );
  }

  Widget postComment(CommentModel commentModel) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 4),
      child: CommentTreeWidget<Comment, Comment>(
        Comment(
          avatar: commentModel.avatar,
          userName: commentModel.fullName,
          content: commentModel.commentContent,),
        [
        ],
        treeThemeData: TreeThemeData(lineColor: TRANSPARENT_COLOR, lineWidth: 3),
        avatarRoot: (context, data) => PreferredSize(
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey,
            backgroundImage: CachedNetworkImageProvider(data.avatar),
          ),
          preferredSize: Size.fromRadius(18),
        ),
        avatarChild: (context, data) => PreferredSize(
          child: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.grey,
            backgroundImage: CachedNetworkImageProvider(data.avatar),
          ),
          preferredSize: Size.fromRadius(12),
        ),
        contentRoot: (context, data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(19)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.userName}',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.black,fontSize: 16),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    data.content.length < 300
                        ? Text(
                        '${data.content}',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                            fontWeight: FontWeight.w300, color: Colors.black,fontSize: 16))
                        : CommentContent(data.content),
                  ],
                ),
              ),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.caption?.copyWith(
                    color: LIGHT_DARK_GREY_COLOR, fontWeight: FontWeight.bold),
                child: Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 7,
                      ),
                      Text("${DateTimeConvert.timeAgoInShort(commentModel.createdTime)}"),
                      SizedBox(
                        width: 15,
                      ),
                      Text(commentModel.totalReaction == 0 ? "" : commentModel.totalReaction.toString(),
                        style: TextStyle(color: commentModel.idReaction != 0 ? PINK_COLOR : LIGHT_DARK_GREY_COLOR),),
                      SizedBox(
                        width: 2,
                      ),
                      GestureDetector(
                        onTap: () async {
                          showProgressDialogue(context);
                          if(commentModel.idReaction != 0){
                            await ReactionViewModel().deleteReaction(commentModel.idReaction);
                            await ReactionViewModel().checkCommentReaction(commentModel);
                            commentModel.totalReaction--;
                          }else{
                            await ReactionViewModel().addCommentReaction(commentModel.id);
                            await ReactionViewModel().checkCommentReaction(commentModel);
                            commentModel.totalReaction++;
                          }
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: Text("Thích",
                          style: TextStyle(color: commentModel.idReaction != 0 ? PINK_COLOR : LIGHT_DARK_GREY_COLOR),),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(commentModel.totalReply == 0 ? "" : commentModel.totalReply.toString()),
                      SizedBox(
                        width: 2,
                      ),
                      GestureDetector(
                        onTap: () async {
                          replyUser = commentModel.fullName;
                          replyCommentId = commentModel.id;
                          setState(() {});
                        },
                        child: Text("Trả lời"),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      if(commentModel.userId == _momViewModel.momModel.id)
                        GestureDetector(
                          onTap: (){
                            showConfirmDialog(context, "Xoá", "Bạn có muốn xóa bình luận này?",ContinueFunction: () async{
                              Navigator.pop(context);
                              showProgressDialogue(context);
                              bool result = await CommentViewModel().deleteComment(commentModel.id);
                              if(result){
                                commentViewModel.commentListModel.remove(commentModel);
                                widget.postModel.totalComment--;
                              }
                              Navigator.pop(context);
                              setState(() {});
                            });
                          },
                          child: Text("Xóa"),
                        ),
                      SizedBox(
                        width: 15,
                      ),
                      if(commentModel.userId == _momViewModel.momModel.id)
                        GestureDetector(
                          onTap: () async{
                            await Navigator.push(context, MaterialPageRoute(builder: (context) => EditComment(commentModel),));
                            setState(() {});
                          },
                          child: Text("Sửa"),
                        ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
        contentChild: (context, data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.userName}',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.black,fontSize: 14),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${data.content}',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          fontWeight: FontWeight.w300, color: Colors.black,fontSize: 14),
                    ),
                  ],
                ),
              ),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.caption?.copyWith(
                    color: LIGHT_DARK_GREY_COLOR.withOpacity(0.7), fontWeight: FontWeight.bold),
                child: Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 7,
                      ),
                      Text("${DateTimeConvert.timeAgoInShort(commentModel.createdTime)}"),
                      SizedBox(
                        width: 15,
                      ),
                      Text('0 Thích'),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget CommentContent(String content) {
    return Align(
      alignment: Alignment.topLeft,
      child: ReadMoreText(
        content,
        trimLength: 300,
        colorClickableText: BLACK_COLOR,
        delimiter: "",
        trimCollapsedText: '... Xem thêm',
        trimExpandedText: ' Thu gọn',
        moreStyle: TextStyle(fontWeight: FontWeight.w600),
        lessStyle: TextStyle(fontWeight: FontWeight.w600),
        style: Theme.of(context).textTheme.caption?.copyWith(
            fontWeight: FontWeight.w300, color: Colors.black,fontSize: 15),
      ),
    );
  }

  Widget CommentSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5,top: 5),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            if(replyUser != "")
            GestureDetector(
              onTap: (){
                replyUser = "";
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 10),
                child: Text("Hủy",style: TextStyle(color: LIGHT_DARK_GREY_COLOR
                ),),
              ),
            ),
            TextFormField(
              minLines: 1,
              maxLines: 4,
              controller: _controller,
              decoration: InputDecoration(
                hintText: replyUser != "" ? "Phản hồi ${replyUser}" : 'Viết bình luận...',
                fillColor: LIGHT_GREY_COLOR,
                filled: true,
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: TRANSPARENT_COLOR),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: TRANSPARENT_COLOR),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                /*prefixIcon: _momViewModel.momModel == null
                  ? CircleAvatar(radius: 20, backgroundColor: LIGHT_GREY_COLOR)
                      : CircleAvatar(
                  radius: 20,
                  backgroundColor: LIGHT_GREY_COLOR,
                  backgroundImage:
                  CachedNetworkImageProvider(_momViewModel.momModel.imageURL),),*/
                suffixIcon: IconButton(
                    icon: Icon(Icons.send_rounded,color: commentFlag == true ? PINK_COLOR : GREY_COLOR,size: 28,),
                    onPressed: () async{
                      commentFlag == true ? handleComment() : null;
                    }
                ),
              ),
              onChanged: (value) {
                setState(() {
                  if (value != "") {
                    commentFlag = true;
                  } else {
                    commentFlag = false;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void handleComment() async {
    showProgressDialogue(context);
    CommentModel commentModel = new CommentModel();
    commentModel.postId = widget.postModel.id;
    commentModel.fullName = _momViewModel.momModel.fullName;
    commentModel.avatar = _momViewModel.momModel.imageURL;
    commentModel.commentContent = _controller.text;
    _controller.clear();
    commentModel.imageURL = null;
    commentFlag = false;
    if(replyUser == ""){
      bool result = await CommentViewModel().addPostComment(commentModel);
      if(result){
        commentViewModel.getPostComment(widget.postModel);
        widget.postModel.totalComment++;
      }
    }else{
      commentModel.replyCommentId = replyCommentId;
      bool result = await CommentViewModel().addReplyPostComment(commentModel);
      if(result){
        commentViewModel.getPostComment(widget.postModel);
      }
    }
    Navigator.pop(context);
    replyUser = "";
    setState(() {});
  }

  Widget Empty(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(comment,height: 120,),
            SizedBox(height: 10,),
            Text("Bài viết hiện chưa có bình luận",style: TextStyle(fontSize: 19),),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }

}
