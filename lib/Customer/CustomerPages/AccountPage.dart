import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class AppColors {
  //One instance, needs factory
  static AppColors? _instance;
  factory AppColors() => _instance ??= AppColors._();

  AppColors._();

  static const primaryColor = Color(0xffbb6649);
  static const darkGrey = Color(0xff7C7C7C);
}

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading:
                SizedBox(width: 65, height: 65, child: getImageHeader()),
                title: AppText(
                  text: "Joyna Joy",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: AppText(
                  text: "github.com/Joyna-Joy",
                  color: Color(0xff7C7C7C),
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              Column(
                children: getChildrenWithSeperator(
                  widgets: accountItems.map((e) {
                    return getAccountItemWidget(e);
                  }).toList(),
                  seperator: Divider(
                    thickness: 1,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              logoutButton(),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget logoutButton() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          elevation: 0,
          backgroundColor: Color(0xffF2F3F2),
          textStyle: TextStyle(
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 25),
          minimumSize: const Size.fromHeight(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                "assets/icons/account_icons/logout_icon.svg",
              ),
            ),
            Text(
              "Log Out",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor),
            ),
            Container()
          ],
        ),
        onPressed: () {},
      ),
    );
  }

  Widget getImageHeader() {
    String imagePath = "assets/images/account_image.jpg";
    return CircleAvatar(
      radius: 5.0,
      backgroundImage: AssetImage(imagePath),
      backgroundColor: AppColors.primaryColor.withOpacity(0.7),
    );
  }

  Widget getAccountItemWidget(AccountItem accountItem) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset(
              accountItem.iconPath,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            accountItem.label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}


class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign? textAlign;

  const AppText({
    Key? key,
    required this.text,
    this.fontSize = 18,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign == null ? null : TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}

class AccountItem {
  final String label;
  final String iconPath;

  AccountItem(this.label, this.iconPath);
}

List<AccountItem> accountItems = [
  AccountItem("Orders", "assets/icons/account_icons/orders_icon.svg"),
  AccountItem("My Details", "assets/icons/account_icons/details_icon.svg"),
  AccountItem(
      "Delivery Access", "assets/icons/account_icons/delivery_icon.svg"),
  AccountItem("Payment Methods", "assets/icons/account_icons/payment_icon.svg"),
  AccountItem("Promo Card", "assets/icons/account_icons/promo_icon.svg"),
  AccountItem(
      "Notifications", "assets/icons/account_icons/notification_icon.svg"),
  AccountItem("Help", "assets/icons/account_icons/help_icon.svg"),
  AccountItem("About", "assets/icons/account_icons/about_icon.svg"),
];

List<Widget> getChildrenWithSeperator(
    {required List<Widget> widgets,
      required Widget seperator,
      bool addToLastChild = true}) {
  List<Widget> children = [];
  if (widgets.length > 0) {
    children.add(seperator);

    for (int i = 0; i < widgets.length; i++) {
      children.add(widgets[i]);

      if (widgets.length - i == 1) {
        if (addToLastChild) {
          children.add(seperator);
        }
      } else {
        children.add(seperator);
      }
    }
  }
  return children;
}

