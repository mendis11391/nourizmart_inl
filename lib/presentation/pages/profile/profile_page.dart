import '../../../../../app/utils/app_export.dart';
import 'profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    context.theme;
    return Obx(() => buildScreen());
  }

  Widget buildScreen() => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => hideKeyBoardFocus(),
        child: Scaffold(
          appBar: buildAppBar(),
          body: buildBody(),
          // bottomNavigationBar: buildBottomNavigation(),
        ),
      );

  AppToolBar buildAppBar() => AppToolBar(
        title: controller.title.value,
        isNeedShadow: false,
        onToolBackPressed: () => controller.backValidationAction(),
        appBarActions: [
          IconButton(
              onPressed: () => controller.logoutAction(),
              icon: AppImage(
                assetName: AppResource.icLogout,
                width: getSize(25),
                height: getSize(25),
              )),
          const SpaceWidth(mWidth: 10)
        ],
      );

  Widget buildBody() => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildSemiCircle(),
            Expanded(
              child: SingleChildScrollView(
                controller: controller.scrollController,
                padding: getPadding(left: 12, right: 12, top: 3, bottom: 10),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildContactInfo(),
                    buildContactCard(),
                    buildYourInfo(),
                    buildYourCard(),
                    buildOtherInfo(),
                    buildOtherCard(),
                    buildPoweredBy()
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildSemiCircle() => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: getVerticalSize(80),
                decoration: BoxDecoration(
                  color: getPrimaryColor(),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                      getDeviceWidth(),
                      getVerticalSize(80),
                    ),
                  ),
                ),
              ),
              const SpaceHeight(mHeight: 35),
            ],
          ),
          Positioned(
              bottom: 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: getPrimaryColor(),
                    radius: getSize(50),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: getSize(48.5),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(getSize(100))),
                      child: AppImage(
                        assetName: AppResource.icAvatar,
                        width: getSize(100),
                        height: getSize(100),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      );

  Widget buildContactInfo() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: AppText(
              text: 'Contact Info',
              size: 15,
              color: Colors.grey.shade800,
            ),
          ),
          const SpaceWidth(mWidth: 10),
          AppButton(
              buttonText: 'Edit',
              buttonHeight: getVerticalSize(22),
              buttonWidth: getHorizontalSize(50),
              borderRadius: getSize(5),
              weight: FontWeight.normal,
              textSize: getFontSize(13),
              onTap: () => controller.editAction()),
        ],
      );

  Widget buildContactCard() => SizedBox(
        width: double.infinity,
        child: Padding(
          padding: getPadding(top: 10),
          child: Card(
            elevation: 0,
            color: Colors.grey.shade300,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getSize(12)),
            ),
            child: Padding(
              padding: getPadding(all: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  personCard(Icons.person, controller.firstName.value),
                  const SpaceHeight(mHeight: 8),
                  personCard(Icons.person, controller.lastName.value),
                  const SpaceHeight(mHeight: 8),
                  personCard(
                      Icons.phone_iphone_outlined, controller.mobile.value),
                ],
              ),
            ),
          ),
        ),
      );

  Widget personCard(IconData icon, String name) => Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getSize(8)),
        ),
        child: Padding(
          padding: getPadding(all: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon),
              const SpaceWidth(mWidth: 10),
              AppText(text: name, size: 14),
            ],
          ),
        ),
      );

  Widget buildYourInfo() => Padding(
        padding: getPadding(top: 15),
        child: AppText(
          text: 'Your Info',
          size: 15,
          color: Colors.grey.shade800,
        ),
      );

  Widget buildYourCard() => SizedBox(
        width: double.infinity,
        child: Padding(
          padding: getPadding(top: 10),
          child: Card(
            elevation: 0,
            color: Colors.grey.shade300,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getSize(12)),
            ),
            child: Padding(
              padding: getPadding(all: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  clickableCard(1, AppResource.icOrderHistory, 'Order History'),
                  const SpaceHeight(mHeight: 8),
                  clickableCard(2, AppResource.icAddressBook, 'Address Book'),
                ],
              ),
            ),
          ),
        ),
      );

  Widget clickableCard(int id, String icon, String name) => ListTile(
        tileColor: Colors.white,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(getSize(8)),
        ),
        title: AppText(text: name, size: 14),
        minLeadingWidth: getSize(20),
        leading: AppImage(
          assetName: icon,
          height: getSize(18),
          width: getSize(name == 'Order History' ? 14 : 16),
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
        ),
        onTap: () => controller.yourInfoAction(id),
      );

  Widget buildOtherInfo() => Padding(
        padding: getPadding(top: 15),
        child: AppText(
          text: 'Other Info',
          size: 15,
          color: Colors.grey.shade800,
        ),
      );

  Widget buildOtherCard() => Padding(
        padding: getPadding(left: 10, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildOtherText(1, 'Terms & Condition'),
            buildOtherText(2, 'Privacy Policy'),
            buildOtherText(3, 'About us'),
          ],
        ),
      );

  Widget buildOtherText(int id, String name) => InkWell(
        onTap: () => controller.otherInfoAction(id),
        child: Padding(
          padding: getPadding(all: 5),
          child: AppText(text: name, size: 12),
        ),
      );

  Widget buildPoweredBy() => SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SpaceHeight(mHeight: 5),
            const AppText(
              text: 'Power by Nourish',
              size: 15,
              color: Colors.blueGrey,
              weight: FontWeight.bold,
            ),
            AppText(
              text: controller.version.value,
              size: 13,
              color: Colors.blueGrey,
            ),
          ],
        ),
      );
}
