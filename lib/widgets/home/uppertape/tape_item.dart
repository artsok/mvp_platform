import 'package:flutter/material.dart';
import 'package:mvp_platform/models/home/uppertape_item.dart';
import 'package:mvp_platform/screens/smo/smo_birth_screen.dart';
import 'package:mvp_platform/utils/scale_factor.dart';

class TapeItem extends StatelessWidget {
  final UpperTapeItem item;

  TapeItem(this.item);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, SmoBirthInfoScreen.routeName),
      child: SizedBox(
        width: 180.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
            elevation: 5.0,
            color: item.color,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 8, top: 4),
                        width: MediaQuery.of(context).size.width / 3.8,
                        child: Text(
                          item.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                ScaleFactor.scalingHeight(context, 48, 58),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          item.icon,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4, left: 8),
                    child: Text(
                      item.tags,
                      style: TextStyle(
                        color: item.fading ? Colors.white60 : Colors.white,
                        fontSize: ScaleFactor.scalingHeight(context, 48, 58),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
