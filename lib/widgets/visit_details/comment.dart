import 'package:flutter/material.dart';
import 'package:mvp_platform/models/enums/request_status.dart';
import 'package:mvp_platform/providers/request/visit_ext_provider.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';
import 'package:mvp_platform/widgets/common/gos_cupertino_loading_indicator.dart';
import 'package:provider/provider.dart';

class Comment extends StatefulWidget {
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VisitExtProvider>(
      builder: (ctx, visitExt, __) {
        if (visitExt.requestStatus == RequestStatus.processing) {
          return Center(child: const GosCupertinoLoadingIndicator());
        }
        if (visitExt.requestStatus == RequestStatus.error) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Scaffold.of(ctx).showSnackBar(SnackBar(
                content: Text(
              'Ошибка: ${visitExt.errorMessage}',
            )));
          });
          visitExt.requestStatus = RequestStatus.ready;
        }
        return _buildCommentTextField(visitExt.visitExt);
      },
    );
  }

  Widget _buildCommentTextField(VisitExt visit) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: const Text(
                'Ваш комментарий:',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Builder(
              builder: (_) {
                if (visit.ratingComment != null &&
                    visit.ratingComment.isNotEmpty) {
                  controller.text = visit.ratingComment;
                }
                return TextField(
                  controller: controller,
                  enabled: visit.rating == null,
                  maxLines: 2,
                  onSubmitted: (_) {
                    visit.ratingComment = controller.text;
                    FocusScope.of(context).unfocus();
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
