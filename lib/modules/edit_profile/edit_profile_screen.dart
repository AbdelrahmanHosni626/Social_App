import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 57),
            child: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                defaultTextButton(
                  function: () {
                    SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                    );
                  },
                  text: 'Update',
                ),
                const SizedBox(
                  width: 15.0,
                )
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is SocialUpdateUserLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialUpdateUserLoadingState)
                    const SizedBox(
                      height: 10.0,
                    ),
                  SizedBox(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 140.0,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: coverImage == null
                                        ? NetworkImage(
                                            '${userModel.cover}',
                                          )
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 16.0,
                                  child: Icon(
                                    IconlyBroken.camera,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 54,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: profileImage == null
                                    ? NetworkImage(
                                        '${userModel.image}',
                                      )
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: const CircleAvatar(
                                child: Icon(
                                  IconlyBroken.camera,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if ((SocialCubit.get(context).profileImage != null) ||
                      (SocialCubit.get(context).coverImage != null))
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  text: 'Update Profile',
                                ),
                                if(state is SocialUpdateUserLoadingState)
                                  const SizedBox(height: 5,),
                                if(state is SocialUpdateUserLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        if (SocialCubit.get(context).profileImage != null)
                          const SizedBox(
                            width: 10,
                          ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: ()
                                  {
                                    SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  text: 'Update Cover',
                                ),
                                if(state is SocialUpdateUserLoadingState)
                                  const SizedBox(height: 5,),
                                if(state is SocialUpdateUserLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      prefix: IconlyBroken.user2,
                      label: 'Name',
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Name Must not be empty';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      prefix: IconlyBroken.infoCircle,
                      label: 'Bio',
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Bio Must not be empty';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      prefix: IconlyBroken.calling,
                      label: 'Phone',
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Phone Must not be empty';
                        }
                        return null;
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
