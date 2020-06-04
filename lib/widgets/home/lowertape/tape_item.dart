import 'package:flutter/material.dart';
import 'package:mvp_platform/models/home/lowertape_item.dart';
import 'package:mvp_platform/screens/smo/smo_info_screen.dart';

class TapeItem extends StatelessWidget {
  final LowerTapeItem item;

  TapeItem(this.item);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, SmoInfoScreen.routeName),
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      bottomLeft: Radius.circular(4.0),
                    ),
                    child: Container(
                      color: item.color,
                      height: double.infinity,
                      child: Icon(
                        item.icon,
                        size: 72,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 280,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 220,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                item.description,
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.close),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
