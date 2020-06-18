import 'package:flutter/material.dart';
import 'package:mvp_platform/providers/request/visit_ext_provider.dart';
import 'package:mvp_platform/repository/response/dto/visit_info.dart';
import 'package:provider/provider.dart';

class Comment extends StatefulWidget {
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VisitExtProvider>(
      builder: (ctx, visitExt, __) {
        if (visitExt.visitExt.ratingComment != null) {
          controller = TextEditingController(text: visitExt.visitExt.ratingComment);
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
            TextField(
              controller: controller,
              enabled: true, // visit.rating != null,
              maxLines: 2,
              onSubmitted: (_) {
                visit.ratingComment = controller.text;
                FocusScope.of(context).unfocus();
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
