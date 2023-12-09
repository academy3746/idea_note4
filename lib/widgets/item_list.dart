import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:idea_note4/constants/sizes.dart';
import 'package:idea_note4/data/idea_info.dart';
import 'package:intl/intl.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    required this.index,
    required this.lstIdeaInfo,
  });

  final int index;

  final List<IdeaInfo> lstIdeaInfo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Container(
        height: Sizes.size80,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.grey.shade400,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(Sizes.size10),
          ),
        ),
        margin: const EdgeInsets.only(top: Sizes.size20),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            /// 아이디어 제목
            Container(
              margin: const EdgeInsets.only(
                left: Sizes.size12,
                bottom: Sizes.size16,
              ),
              child: Text(
                "# ${lstIdeaInfo[index].title}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: Sizes.size16,
                ),
              ),
            ),

            /// 아이디어 작성 일자
            Container(
              margin: const EdgeInsets.only(
                right: Sizes.size12,
                bottom: Sizes.size8,
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  DateFormat("yyyy.MM.dd HH:mm").format(
                      DateTime.fromMillisecondsSinceEpoch(
                          lstIdeaInfo[index].createDatetime)),
                  style: TextStyle(
                    fontSize: Sizes.size10,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),

            /// 아이디어 중요도 점수
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: const EdgeInsets.only(
                  left: Sizes.size12,
                  bottom: Sizes.size8,
                ),
                child: RatingBar.builder(
                  initialRating: lstIdeaInfo[index].importance.toDouble(),
                  itemCount: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemSize: Sizes.size16,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                  ignoreGestures: true,
                  updateOnDrag: false,
                  itemBuilder: (context, index) {
                    return const FaIcon(
                      FontAwesomeIcons.star,
                      color: Colors.amberAccent,
                    );
                  },
                  onRatingUpdate: (value) {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
