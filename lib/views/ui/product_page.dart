import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:valenki/controllers/cart_provider.dart';
import 'package:valenki/controllers/favourite_provider.dart';
import 'package:valenki/controllers/product_provider.dart';
import 'package:valenki/views/shared/app_style.dart';
import 'package:valenki/views/shared/check_out_button.dart';
import 'package:valenki/views/shared/reusable_text.dart';
import 'package:valenki/views/ui/favorites.dart';
import '../../models/sneakers_model.dart';

class ProductPage extends StatelessWidget {
  ProductPage({
    super.key,
    required this.id,
    required this.category,
  });

  final String id;
  final String category;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    productNotifier.getShoes(category, id);
    var favouritesNotifier =
        Provider.of<FavoritesNotifier>(context, listen: true);
    favouritesNotifier.getFavourites();
    var cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: FutureBuilder<Sneakers>(
        future: productNotifier.sneaker,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          } else {
            final sneaker = snapshot.data;
            return Consumer<ProductNotifier>(
              builder: (context, productNotifier, child) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leadingWidth: 0,
                      title: Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                productNotifier.shoeSizes.clear();
                              },
                              child: const Icon(
                                Ionicons.close,
                                color: Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Ionicons.ellipsis_horizontal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      pinned: true,
                      snap: false,
                      floating: true,
                      backgroundColor: Colors.transparent,
                      expandedHeight: MediaQuery.of(context).size.height,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SizedBox(
                              height: 401.h,
                              width: 375.w,
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sneaker!.imageUrl.length,
                                controller: pageController,
                                onPageChanged: (page) {
                                  productNotifier.activePage = page;
                                },
                                itemBuilder: (context, int index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        height: 316.h,
                                        width: 375.w,
                                        color: Colors.grey.shade300,
                                        child: CachedNetworkImage(
                                          imageUrl: sneaker.imageUrl[index],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        right: 20,
                                        child: Consumer<FavoritesNotifier>(
                                            builder: (
                                          context,
                                          favouriteNotifier,
                                          child,
                                        ) {
                                          return GestureDetector(
                                            onTap: () async {
                                              if (favouriteNotifier.ids
                                                  .contains(id)) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Favourites(),
                                                    ));
                                              } else {
                                                favouritesNotifier.createFav({
                                                  "id": sneaker.id,
                                                  "name": sneaker.name,
                                                  "category": sneaker.category,
                                                  "price": sneaker.price,
                                                  "imageUrl":
                                                      sneaker.imageUrl[0],
                                                });
                                              }
                                            },
                                            child: favouriteNotifier.ids
                                                    .contains(id)
                                                ? const Icon(Ionicons.heart)
                                                : const Icon(
                                                    Ionicons.heart_outline),
                                          );
                                        }),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List<Widget>.generate(
                                            sneaker.imageUrl.length,
                                            (index) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: CircleAvatar(
                                                radius: 5,
                                                backgroundColor: productNotifier
                                                            .activepage !=
                                                        index
                                                    ? Colors.grey
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.645,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ResuableText(
                                          text: sneaker.name,
                                          style: appStyle(
                                            40,
                                            Colors.black,
                                            FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              sneaker.category,
                                              style: appStyle(
                                                20,
                                                Colors.grey,
                                                FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            RatingBar.builder(
                                                initialRating: 4,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 22,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 1),
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                      Ionicons.star,
                                                      size: 18,
                                                      color: Colors.black,
                                                    ),
                                                onRatingUpdate: (rating) {})
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$${sneaker.price}",
                                              style: appStyle(26, Colors.black,
                                                  FontWeight.w600),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Colors",
                                                  style: appStyle(
                                                      18,
                                                      Colors.black,
                                                      FontWeight.w500),
                                                ),
                                                const SizedBox(width: 5),
                                                const CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.black,
                                                ),
                                                const SizedBox(width: 5),
                                                const CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.red,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Select Sizes",
                                                  style: appStyle(
                                                      20,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                ),
                                                const SizedBox(width: 20),
                                                Text(
                                                  "View size guides",
                                                  style: appStyle(
                                                      20,
                                                      Colors.grey,
                                                      FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                              height: 40,
                                              child: ListView.builder(
                                                itemCount: productNotifier
                                                    .shoeSizes.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                padding: EdgeInsets.zero,
                                                itemBuilder: (context, index) {
                                                  final sizes = productNotifier
                                                      .shoeSizes[index];
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8),
                                                    child: ChoiceChip(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(90),
                                                        side: const BorderSide(
                                                          color: Colors.black,
                                                          width: 1,
                                                          style:
                                                              BorderStyle.solid,
                                                        ),
                                                      ),
                                                      disabledColor:
                                                          Colors.white,
                                                      label: Text(
                                                        sizes['size'],
                                                        style: appStyle(
                                                          18,
                                                          sizes['isSelected']
                                                              ? Colors.white
                                                              : Colors.black,
                                                          FontWeight.w500,
                                                        ),
                                                      ),
                                                      selected: productNotifier
                                                              .shoeSizes[index]
                                                          ['isSelected'],
                                                      onSelected: (newState) {
                                                        if (productNotifier
                                                            .sizes
                                                            .contains(sizes[
                                                                'size'])) {
                                                          productNotifier.sizes
                                                              .remove(sizes[
                                                                  'size']);
                                                        } else {
                                                          productNotifier.sizes
                                                              .add(sizes[
                                                                  'size']);
                                                        }

                                                        productNotifier
                                                            .toggleChechk(
                                                                index);
                                                      },
                                                      pressElevation: 1,
                                                      selectedColor:
                                                          sizes['isSelected']
                                                              ? Colors.black
                                                              : Colors.white,
                                                      shadowColor:
                                                          Colors.black38,
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        const Divider(
                                          indent: 10,
                                          endIndent: 10,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: ResuableText(
                                            text: sneaker.title,
                                            style: appStyle(
                                              24,
                                              Colors.black,
                                              FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 7),
                                        Text(
                                          sneaker.description,
                                          textAlign: TextAlign.justify,
                                          overflow: TextOverflow.fade,
                                          maxLines: 3,
                                          style: appStyle(
                                            14,
                                            Colors.black,
                                            FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(height: 7.h),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 9.h),
                                            child: CheckOutButton(
                                              label: "Add to Cart",
                                              onTap: () async {
                                                cartProvider.createCart({
                                                  "id": sneaker.id,
                                                  "name": sneaker.name,
                                                  "category": sneaker.category,
                                                  "sizes":
                                                      productNotifier.sizes[0],
                                                  "imageUrl":
                                                      sneaker.imageUrl[0],
                                                  "price": sneaker.price,
                                                  "qty": 1,
                                                });
                                                productNotifier.sizes.clear();
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
