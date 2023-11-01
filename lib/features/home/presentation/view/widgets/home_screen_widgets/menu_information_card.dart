import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';

import '../../../../../../cores/utils/locator_manger.dart';

class MenuInfoCard extends StatelessWidget {
  const MenuInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .1,
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .5,
              child: ListTile(
                title: Text(
                  LocatorManager.locator<AppMainScreenCubit>()
                          .userData
                          ?.userInfoData
                          .displayName ??
                      'Nothing',
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * .025,
                      color: Colors.black.withOpacity(.8),
                      overflow: TextOverflow.ellipsis),
                ),
                subtitle: Text(
                  'Manager',
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * .02,
                      color: Colors.black.withOpacity(.5),
                      overflow: TextOverflow.ellipsis),
                ),
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                iconColor: Colors.grey,
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.arrowRightFromBracket))
          ],
        ),
      ),
    );
  }
}
