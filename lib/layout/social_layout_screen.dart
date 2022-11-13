import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';

import '../modules/login/login_screen.dart';
import '../shared/components/constants.dart';
import '../shared/network/local/cache_helper.dart';

class SocialLayoutScreen extends StatelessWidget {
  const SocialLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {
        if (state is SocialNewPostState)
          {
            navigateTo(context, NewPostScreen());
          }
      },
      builder: (BuildContext context, Object? state) {

        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        'Log Out',
                      ),
                      content: const Text(
                        'Are You Sure To Logout?',
                      ),
                      actions: [
                        Row(
                          children: [
                            defaultTextButton(
                              function: () {
                                CacheHelper.removeData(
                                  key: 'uId',
                                ).then((value) {
                                  navigateAndFinish(context, LoginScreen());
                                });
                              },
                              text: 'YES',
                            ),
                            defaultTextButton(
                              function: () {
                                Navigator.pop(context);
                              },
                              text: 'NO',
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(
                  Icons.logout_outlined,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeNavBar(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(IconlyBroken.home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyBroken.chat),
                label: 'Chats'
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyBroken.paperUpload, size: 30, ),
                label: 'Posts'
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyBroken.location),
                label: 'Users'
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyBroken.setting),
                label: 'Settings'
              ),
            ],
          ),
        );
      },
    );
  }
}
