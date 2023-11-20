import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/home_page/travels_screen/travels_screen_gridview_item.dart';
import 'package:fun_adventure/features/home/presentation/view_model/travels_screen_provider/travels_screen_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'gridview_border_radius.dart';

class TravelsScreen extends StatefulWidget {
  const TravelsScreen({super.key});

  @override
  State<TravelsScreen> createState() => _TravelsScreenState();
}

class _TravelsScreenState extends State<TravelsScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TravelsScreenProvider(),
      child: Consumer<TravelsScreenProvider>(
        builder: (_, model, __) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Last Travels',
                style: GoogleFonts.akayaKanadaka().copyWith(fontSize: 25.sp),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 5.h),
              child: GridView.custom(
                gridDelegate: SliverWovenGridDelegate.count(
                  crossAxisCount: 2,
                  pattern: [
                    const WovenGridTile(.96),
                    const WovenGridTile(
                      5 / 7,
                      crossAxisRatio: .93,
                      alignment: AlignmentDirectional.centerEnd,
                    ),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate((context, index) {
                  model.putRadiusValue(index);
                  return ClipRRect(
                    borderRadius: customBorderRadius(model.radius),
                    child: GestureDetector(
                      onTap: () {
                        model.changeCurrentIndex(index);
                      },
                      child: TravelsScreenGridViewItem(
                        isSelected: index == model.currentIndex ? true : false,
                        imageUrl: model.imagesUrl[index],
                        radius: model.radius,
                      ),
                    ),
                  );
                }, childCount: 10),
              ),
            ),
          );
        },
      ),
    );
  }
}
