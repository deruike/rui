import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
import 'package:rui/components/user/rui_login_status_panel.dart';
// import 'package:listenor/app/core/widgets/login_status_panel.dart';

class TopBarMenuItem {
  final String title;
  final IconData icon;
  final Function onTap;

  TopBarMenuItem(
      {required this.title, required this.icon, required this.onTap});
}

class WebTopNavBar extends StatefulWidget {
  final List<TopBarMenuItem> menuItems;
  String title;
  IconData? icon;
  String userName;
  String? userImage;
  final String? userEmail;
  final String? userPhone;
  final String? userAddress;
  final String? userBirthday;
  final String? userGender;
  final String? userRole;
  final String? userStatus;
  final DateTime? userCreatedAt;
  final DateTime? userUpdatedAt;
  final DateTime? userDeletedAt;
  final DateTime? userLastLogin;
  final DateTime? userLastLogout;
  Function? onTapLogout;
  Function? onColorModeChange;

  WebTopNavBar(
      {super.key,
      required this.menuItems,
      required this.title,
      this.icon,
      required this.userName,
      this.userImage,
      this.userEmail,
      this.userPhone,
      this.userAddress,
      this.userBirthday,
      this.userGender,
      this.userRole,
      this.userStatus,
      this.userCreatedAt,
      this.userUpdatedAt,
      this.userDeletedAt,
      this.userLastLogin,
      this.userLastLogout,
      this.onTapLogout,
      this.onColorModeChange});

  @override
  State<WebTopNavBar> createState() => _WebTopNavBarState();
}

class _WebTopNavBarState extends State<WebTopNavBar> {
  bool _isDarkMode = false;

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.dark_mode);
      }
      return const Icon(Icons.light_mode);
    },
  );

  @override
  void initState() {
    super.initState();
    // _isDarkMode = Get.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          _buildLeftPanel(),
          _buildMidExpandedPanel(),
          _buildRightPanel(),
        ],
      ),
    );
  }

  Widget _buildLeftPanel() {
    return Row(children: [
      IconButton(
        icon: Icon(widget.icon ?? Icons.home),
        onPressed: () {
          // Handle menu button press
        },
      ),
      Text(
        widget.title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      Container(
        width: 20,
      )
    ]);
  }

  Widget _buildMidExpandedPanel() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ...widget.menuItems.map((e) {
            return TextButton(
              onPressed: () {
                e.onTap();
              },
              child: Row(
                children: [
                  Icon(e.icon),
                  Text(
                    e.title,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            );
          }),
        ]),
      ),
    );
  }

  Widget _buildRightPanel() {
    return Row(
      children: [
        Switch(
          thumbIcon: thumbIcon,
          value: _isDarkMode,
          onChanged: (value) {
            setState(() {
              _isDarkMode = value;
            });

            // print("_isDarkMode $_isDarkMode");

            if (widget.onColorModeChange != null) {
              widget.onColorModeChange!(_isDarkMode);
            }
          },
          activeColor: Colors.grey, // 激活状态时的颜色
          activeTrackColor: Colors.blueGrey, // 激活状态时轨道的颜色
          inactiveThumbColor: Colors.grey, // 非激活状态时滑块的颜色
          inactiveTrackColor: Colors.white, // 非激活状态时轨道的颜色
        ),
        ElevatedButton(
          onPressed: () {
            // if (Get.locale != null && Get.locale!.countryCode == 'US') {
            //   Get.updateLocale(const Locale('zh', 'CN'));
            // } else {
            //   Get.updateLocale(const Locale('en', 'US'));
            // }
          },
          child: const Row(
            children: [
              const Icon(Icons.language),
              const SizedBox(
                width: 5,
              ),
              Text('En/Cn')
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        _buildUserPanel(),
      ],
    );
  }

  Widget _buildUserPanel() {
    return RuiLoginStatusPanel(
      userName: widget.userName,
      userImage: widget.userImage,
      userAddress: widget.userAddress,
      userPhone: widget.userPhone,
      userEmail: widget.userEmail,
      userBirthday: widget.userBirthday,
      userGender: widget.userGender,
      userRole: widget.userRole,
      userStatus: widget.userStatus,
      userCreatedAt: widget.userCreatedAt,
      userUpdatedAt: widget.userUpdatedAt,
      userDeletedAt: widget.userDeletedAt,
      userLastLogin: widget.userLastLogin,
    );
  }

  void _onTapSearch() {
    // Get.snackbar("search", "message");
  }
}
