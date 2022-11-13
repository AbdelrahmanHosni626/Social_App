import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/shared/styles/colors.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5.0,
            margin: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                const Image(
                  image: NetworkImage(
                    'https://img.freepik.com/free-photo/happy-man-rides-scooter-shows-direction-away-points-thumb-right-blank-space-yellow-background-dressed-casual-wear-helmet-uses-headphones-has-cheerful-face-expression_273609-32476.jpg?size=626&ext=jpg&ga=GA1.2.263807918.1667467436&semt=sph',
                  ),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Communicate With your friends',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => buildCardItem(context),
            separatorBuilder: (context, index) => const SizedBox(height: 10.0,),
            itemCount: 5,
          ),
          const SizedBox(
            height: 8.0,
          )
        ],
      ),
    );
  }

  Widget buildCardItem(context) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/sign-affection-admiration-pretty-curly-woman-presses-palms-heart-being-grateful-gift-wears-yellow-t-shirt-poses-rosy-wall-says-you-are-always-my-heart-smiles-gently_273609-42551.jpg?t=st=1668102528~exp=1668103128~hmac=45306a3f573783d3a3bb4b7c414241efc8216306688c718dac844da73f5a676a',
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text(
                              'Abdelrahman Hosni',
                              style: TextStyle(
                                height: 1.4,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.check_circle,
                              size: 16,
                              color: defaultColor,
                            ),
                          ],
                        ),
                        Text(
                          'November 10, 2022 at 08:21 pm',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                height: 1.4,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 16,
                    ),
                  ),
                ],
              ), // **Circle Avatar And Name**
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ), // **Divider**
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                style: Theme.of(context).textTheme.subtitle1,
              ), // **Post content**
              Padding(
                padding: const EdgeInsets.only(
                  top: 5.0,
                  bottom: 10.0,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 6.0),
                        child: SizedBox(
                          height: 25.0,
                          child: MaterialButton(
                            minWidth: 1.0,
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: const Text(
                              '#Software',
                              style: TextStyle(
                                color: defaultColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 6.0),
                        child: SizedBox(
                          height: 25.0,
                          child: MaterialButton(
                            minWidth: 1.0,
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: const Text(
                              '#Flutter',
                              style: TextStyle(
                                color: defaultColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ), //  **Tags
              Container(
                width: double.infinity,
                height: 140.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://img.freepik.com/premium-photo/emotional-cheerful-curly-haired-woman-has-online-conversation-stares-impressed-smartphone-front-camera-applies-beauty-patches-wears-bathhat-sunglasses-t-shirt-isolated-pink-background_273609-62723.jpg?size=626&ext=jpg&ga=GA1.2.263807918.1667467436&semt=sph',
                    ),
                  ),
                ),
              ), //  **Post Image
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              const Icon(
                                IconlyBroken.heart,
                                size: 16,
                                color: defaultColor,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '12345',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                IconlyBroken.moreSquare,
                                size: 16,
                                color: defaultColor,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '123 comment',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 20.0,
                          backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/sign-affection-admiration-pretty-curly-woman-presses-palms-heart-being-grateful-gift-wears-yellow-t-shirt-poses-rosy-wall-says-you-are-always-my-heart-smiles-gently_273609-42551.jpg?t=st=1668102528~exp=1668103128~hmac=45306a3f573783d3a3bb4b7c414241efc8216306688c718dac844da73f5a676a',
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          'Write a comment ...',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                height: 1.4,
                              ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: const [
                          Icon(
                            IconlyBroken.heart,
                            size: 16,
                            color: defaultColor,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Like',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
