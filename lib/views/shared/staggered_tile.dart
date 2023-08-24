import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valenki/views/shared/app_style.dart';
import 'package:valenki/views/shared/reusable_text.dart';

class StaggeredTiles extends StatefulWidget {
  const StaggeredTiles({
    super.key,
    required this.imageURL,
    required this.name,
    required this.price,
  });
  final String imageURL;
  final String name;
  final String price;

  @override
  State<StaggeredTiles> createState() => _StaggeredTilesState();
}

class _StaggeredTilesState extends State<StaggeredTiles> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: widget.imageURL,
              fit: BoxFit.fill,
            ),
            Container(
              padding: EdgeInsets.only(top: 12.h),
              height: 75.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResuableText(
                    text: widget.name,
                    style: appStyleWithHt(20, Colors.black, FontWeight.w700, 1),
                  ),
                  SizedBox(height: 10.h),
                  ResuableText(
                    text: widget.price,
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
