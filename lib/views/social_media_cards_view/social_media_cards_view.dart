import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:soccermadeeasy/styles/colors.dart';

import '../../commands/base_command.dart';
import '../../commands/event_command.dart';
import '../../commands/event_command_impl.dart';
import '../../commands/user_command.dart';
import '../../components/custom_textfield.dart';
import '../../models/app_model.dart';

class SocialMediaCardsView extends StatefulWidget {
  const SocialMediaCardsView({
    Key? key,
  }) : super(key: key);

  @override
  State<SocialMediaCardsView> createState() => _SocialMediaCardsViewState();
}

class _SocialMediaCardsViewState extends State<SocialMediaCardsView> {
  Widget _myAnimatedWidget = Container();
  final PageController ctrl = PageController(viewportFraction: 0.85);
  int currentPage = 0;
  bool isFlip = false;
  TextEditingController controller = TextEditingController();
  List<Widget> generatedCardList = [];
  List<Widget> generatedFlippedCardList = [];

  @override
  void initState() {
    super.initState();

    ctrl.addListener(() {
      int next = ctrl.page!.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    dynamic userEventDetails = context.watch<AppModel>().userEventDetails;
    inspect(userEventDetails);

    if (userEventDetails['mainEvent'] == null) {
      return;
    }

    generatedCardList = List.generate(
        CardType.values.length,
        (index) => buildCard(
            CardType.values[index],
            checkIfAlreadyAdded(
                appList: userEventDetails['mainEvent']['SocialMediaApps']
                    ['data'],
                cardType: CardType.values[index])));

    generatedFlippedCardList = List.generate(
      CardType.values.length,
      (index) => buildCardSide(
        CardType.values[index],
        userEventDetails,
        getFilledData(
          appList: userEventDetails['mainEvent']['SocialMediaApps']['data'],
          cardType: CardType.values[index],
        ),
      ),
    );
  }

  void flipCard() {
    isFlip = !isFlip;
    setState(() {});
  }

  Future<void> onTapAddSocialMediaApp(userEventDetails) async {
    final currentUser = UserCommand().getAppModelUser();
    final selectedApp = CardType.values.toList()[currentPage];

    // final result = await EventCommandImpl().updateSocialMedia(
    //   body: AddSocialMediaAppsRequest(
    //     eventId: userEventDetails['mainEvent']['_id'],
    //     userId: currentUser['_id'],
    //     socialMediaType: selectedApp.name.toUpperCase(),
    //     socialMediaUrl: selectedApp.url + controller.text,
    //   ),
    // );

    await EventCommandImpl().updateSocialMedia(
      type: selectedApp.name.toUpperCase(),
      url: selectedApp.url + controller.text,
      eventId: userEventDetails['mainEvent']['_id'],
      userId: currentUser['_id'],
    );
  }

  Future<void> onTapDeleteSocialMediaApp(userEventDetails) async {
    final selectedApp = CardType.values.toList()[currentPage];
    final deletedSocialMediaApp = getSocialApp(
        appList: userEventDetails['mainEvent']['SocialMediaApps']['data'],
        cardType: selectedApp);

    Map<String, dynamic> eventInput = {
      "_id": deletedSocialMediaApp['_id'],
    };

    final result = await EventCommand().deleteSocialMedia(eventInput);

    if (result['data'] != null) {
      userEventDetails['mainEvent']['SocialMediaApps']['data'] =
          removeItemFromList(
              userEventDetails['mainEvent']['SocialMediaApps']['data'],
              deletedSocialMediaApp);

      // BaseCommand().updateUserEventDetailsModel(userEventDetails);
      if (isFlip) {
        controller.clear();
        flipCard();
      }
    }
  }

  dynamic removeItemFromList(dynamic itemList, dynamic itemToRemove) {
    (itemList as List).remove(itemToRemove);
    return itemList;
  }

  bool? checkIfAlreadyAdded({List? appList, required CardType cardType}) {
    if (appList?.isEmpty ?? false) {
      return false;
    }

    final value = appList?.any(
            (element) => element['type'] == cardType.name.toUpperCase()) ??
        false;

    return value;
  }

  String? getFilledData({List? appList, required CardType cardType}) {
    if (appList?.isEmpty ?? false) {
      return '';
    }

    final value = appList?.firstWhere(
      (element) => element['type'] == cardType.name.toUpperCase(),
      orElse: () => null, // Return null when no matching element is found
    );

    return value?['url'].toString().userName;
  }

  dynamic? getSocialApp({List? appList, required CardType cardType}) {
    if (appList?.isEmpty ?? false) {
      return '';
    }

    final value = appList?.firstWhere(
      (element) => element['type'] == cardType.name.toUpperCase(),
      orElse: () => null, // Return null when no matching element is found
    );

    return value;
  }

  @override
  Widget build(BuildContext context) {
    dynamic userEventDetails = context.watch<AppModel>().userEventDetails;
    // inspect(userEventDetails);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.orangeColorShade500,
        centerTitle: true,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.apps,
                color: Colors.black,
              ),
              SizedBox(width: 10),
              Text('Social Media Apps'),
            ],
          ),
        ),
      ),
      body: generatedCardList.isNotEmpty && generatedFlippedCardList.isNotEmpty
          ? GestureDetector(
              onDoubleTap: flipCard,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 0.71428571428,
                  child: PageView.builder(
                    controller: ctrl,
                    itemCount: CardType.values.length,
                    onPageChanged: (value) {
                      if (isFlip) {
                        controller.clear();
                        flipCard();
                      }
                    },
                    itemBuilder: (context, int currentIdx) {
                      bool active = currentIdx == currentPage;
                      isFlip && active
                          ? _myAnimatedWidget = _buildStoryPage(
                              generatedFlippedCardList,
                              currentIdx,
                              active,
                              true)
                          : _myAnimatedWidget = _buildStoryPage(
                              generatedCardList, currentIdx, active, false);
                      return AnimatedSwitcher(
                        transitionBuilder: _transitionBuilder,
                        duration: const Duration(milliseconds: 500),
                        child: _myAnimatedWidget,
                      );
                    },
                  ),
                ),
              ),
            )
          : const SizedBox(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.orangeColorShade500,
        onPressed: flipCard,
        child: const Icon(Icons.flip),
      ),
    );
  }

  Widget _buildStoryPage(List list, int index, bool active, bool value) {
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 50 : 125;

    return AnimatedContainer(
      key: ValueKey(value),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: blur,
            offset: Offset(offset, offset),
          ),
        ],
      ),
      child: list[index],
    );
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);

    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (const ValueKey(1) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  Widget buildCardCenter(
      {required final CardType type,
      final double? opacityValue,
      final bool? isAdded}) {
    String imageUrl;

    switch (type) {
      case CardType.instagram:
        imageUrl = 'lib/assets/icons/instagram.svg';
        break;
      case CardType.facebook:
        imageUrl = 'lib/assets/icons/facebook.svg';
        break;
      case CardType.x:
        imageUrl = 'lib/assets/icons/x.svg';
        break;
      case CardType.linkedin:
        imageUrl = 'lib/assets/icons/linkedin.svg';
        break;
      case CardType.youtube:
        imageUrl = 'lib/assets/icons/youtube.svg';
        break;
      default:
        imageUrl = '';
    }

    return ClipRRect(
      child: Opacity(
        opacity: opacityValue ?? 1,
        child: SvgPicture.asset(
          imageUrl,
          fit: BoxFit.contain,
          height: double.infinity,
          colorFilter: isAdded ?? false
              ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
              : const ColorFilter.mode(
                  AppColors.grayColor, BlendMode.saturation),
        ),
      ),
    );
  }

  Widget buildCard(CardType type, bool? isAdded) {
    return Stack(
      children: <Widget>[
        Container(
          child: buildCardCenter(type: type, isAdded: isAdded),
        ),
      ],
    );
  }

  Widget buildCardSide(CardType type, userEventDetails, String? filledData) {
    String label;
    String hint;
    switch (type) {
      case CardType.instagram:
        label = 'Instagram';
        hint = 'Username';
        break;
      case CardType.facebook:
        label = 'Facebook';
        hint = 'Username';
        break;
      case CardType.x:
        label = 'X';
        hint = 'Username';
        break;
      case CardType.linkedin:
        label = 'Linkedin';
        hint = 'Username';
        break;
      case CardType.youtube:
        label = 'Youtube';
        hint = 'Username';
        break;
      default:
        label = '';
        hint = '';
    }
    return Stack(
      children: [
        buildCardCenter(type: type, opacityValue: 0.2),
        Column(
          children: [
            CustomTextFormField(
              label: filledData ?? label,
              hintText: hint,
              controller: controller,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  onPressed: () => filledData?.isNotEmpty ?? false
                      ? onTapDeleteSocialMediaApp(userEventDetails)
                      : null,
                  child: const Text('Remove'),
                ),
                const SizedBox(width: 20),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  onPressed: () => controller.text.isNotEmpty
                      ? onTapAddSocialMediaApp(userEventDetails)
                      : null,
                  child: const Text('Save'),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

enum CardType {
  instagram,
  facebook,
  x,
  linkedin,
  youtube,
}

extension CardTypeUrl on CardType {
  String get url {
    switch (this) {
      case CardType.instagram:
        return 'https://www.instagram.com/';
      case CardType.facebook:
        return 'https://www.facebook.com/';
      case CardType.x:
        return 'https://twitter.com/';
      case CardType.linkedin:
        return 'https://www.linkedin.com/in/';
      case CardType.youtube:
        return 'https://www.youtube.com/@';
      default:
        return '';
    }
  }
}

extension UrlToUserName on String {
  String get userName {
    if (isNotEmpty) {
      final parts = split('/');
      if (parts.isNotEmpty) {
        return parts.last;
      }
    }
    return '';
  }
}
