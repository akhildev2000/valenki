import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:valenki/controllers/favourite_provider.dart';
import 'package:valenki/views/shared/app_style.dart';
import 'package:valenki/views/shared/reusable_text.dart';
import 'package:valenki/views/ui/favorites.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.category,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
  });
  final String price;
  final String category;
  final String id;
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    var favouritesNotifier =
        Provider.of<FavoritesNotifier>(context, listen: true);
    favouritesNotifier.getFavourites();
    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 20.w),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: 325.h,
          width: 225.w,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 0.6,
                spreadRadius: 1,
                offset: Offset(1, 1),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 186.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          image,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10.w,
                    top: 10.h,
                    child: GestureDetector(
                      onTap: () {
                        if (favouritesNotifier.ids.contains(id)) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Favourites(),
                              ));
                        } else {
                          favouritesNotifier.createFav({
                            "id": id,
                            "name": name,
                            "category": category,
                            "price": price,
                            "imageUrl": image,
                          });
                        }
                      },
                      child: favouritesNotifier.ids.contains(id)
                          ? const Icon(Ionicons.heart)
                          : const Icon(Ionicons.heart_outline),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResuableText(
                      text: name,
                      style: appStyleWithHt(
                          32, Colors.black, FontWeight.bold, 1.1),
                    ),
                    ResuableText(
                      text: category,
                      style:
                          appStyleWithHt(18, Colors.grey, FontWeight.bold, 1.5),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ResuableText(
                      text: price,
                      style: appStyle(30, Colors.black, FontWeight.w600),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
