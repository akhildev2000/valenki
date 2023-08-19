import 'package:flutter/material.dart';
import 'package:valenki/views/shared/app_style.dart';

class StaggeredTile extends StatefulWidget {
  const StaggeredTile({
    super.key,
    required this.imageURL,
    required this.name,
    required this.price,
  });
  final String imageURL;
  final String name;
  final String price;

  @override
  State<StaggeredTile> createState() => _StaggeredTileState();
}

class _StaggeredTileState extends State<StaggeredTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage(
                widget.imageURL,
              ),
              fit: BoxFit.fill,
            ),
            Container(
              padding: const EdgeInsets.only(top: 12),
              height: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: appStyleWithHt(20, Colors.black, FontWeight.w700, 1),
                  ),
                  Text(
                    widget.price,
                    style: appStyleWithHt(20, Colors.black, FontWeight.w500, 1),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
