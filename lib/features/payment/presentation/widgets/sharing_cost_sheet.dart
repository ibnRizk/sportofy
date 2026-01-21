import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';

// Simple User Model
class _User {
  final String id;
  final String name;
  final String userId;
  final String phone;
  final String avatar;

  _User({
    required this.id,
    required this.name,
    required this.userId,
    required this.phone,
    required this.avatar,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _User &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class SharingCostSheet extends StatefulWidget {
  const SharingCostSheet({super.key});

  @override
  State<SharingCostSheet> createState() =>
      _SharingCostSheetState();
}

class _SharingCostSheetState
    extends State<SharingCostSheet> {
  final TextEditingController _searchController =
      TextEditingController();
  final List<_User> _allUsers = [];
  final List<_User> _selectedUsers = [];

  @override
  void initState() {
    super.initState();
    // Initialize mock data matching the image
    _allUsers.addAll([
      _User(
        id: '1',
        name: 'Mohamed Ameen',
        userId: '123kj',
        phone: '01001001010',
        avatar: 'assets/images/mohamed_ahmed.png',
      ),
      _User(
        id: '2',
        name: 'Hany Adel',
        userId: '123kj',
        phone: '01001001010',
        avatar: 'assets/images/salah_mostafa.png',
      ),
      _User(
        id: '3',
        name: 'Hany Adel',
        userId: '123kj',
        phone: '01001001010',
        avatar: 'assets/images/team2.png',
      ),
      _User(
        id: '4',
        name: 'Hany Adel',
        userId: '123kj',
        phone: '01001001010',
        avatar: 'assets/images/team3.png',
      ),
    ]);

    // Start with no users selected - Share button will be disabled
    // Users must be selected manually to activate the Share button
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleUserSelection(_User user) {
    setState(() {
      if (_selectedUsers.contains(user)) {
        _selectedUsers.remove(user);
      } else {
        _selectedUsers.add(user);
      }
    });
  }

  void _removeSelectedUser(_User user) {
    setState(() {
      _selectedUsers.remove(user);
    });
  }

  List<_User> get _filteredUsers {
    if (_searchController.text.isEmpty) {
      return _allUsers;
    }
    final query = _searchController.text.toLowerCase();
    return _allUsers.where((user) {
      return user.name.toLowerCase().contains(query) ||
          user.phone.contains(query) ||
          user.userId.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight:
              MediaQuery.of(context).size.height * 0.9,
        ),
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: AppRadius.top25,
        ),
        child: Column(
          children: [
            // Drag Handle
            SizedBox(height: AppDimens.h12),
            Container(
              width: AppDimens.w40,
              height: AppDimens.h4,
              decoration: BoxDecoration(
                color: MyColors.grey300,
                borderRadius: AppRadius.r2,
              ),
            ),

            // Header
            Padding(
              padding: EdgeInsets.only(
                top: AppDimens.h16,
                left: AppDimens.w20,
                right: AppDimens.w20,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: MyColors.black,
                      size: AppDimens.iconSize24,
                    ),
                    padding: AppPadding.zero,
                    constraints: const BoxConstraints(),
                  ),
                  SizedBox(width: AppDimens.w12),
                  Expanded(
                    child: Text(
                      'Sharing the cost',
                      style: TextStyles.bold18(color: MyColors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppDimens.h16),

            // Search Bar
            Padding(
              padding: AppPadding.h20,
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyles.regular14(color: MyColors.grey500),
                  prefixIcon: Icon(
                    Icons.search,
                    color: MyColors.grey500,
                    size: AppDimens.iconSize22,
                  ),
                  contentPadding: AppPadding.h16v12,
                  border: OutlineInputBorder(
                    borderRadius: AppRadius.r8,
                    borderSide: BorderSide(
                      color: MyColors.grey300,
                      width: AppDimens.borderWidth1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: AppRadius.r8,
                    borderSide: BorderSide(
                      color: MyColors.grey300,
                      width: AppDimens.borderWidth1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: AppRadius.r8,
                    borderSide: BorderSide(
                      color: MyColors.greenButton,
                      width: AppDimens.borderWidth2,
                    ),
                  ),
                ),
              ),
            ),

            // Selected Users Section (Horizontal List)
            if (_selectedUsers.isNotEmpty) ...[
              SizedBox(height: AppDimens.h12),
              SizedBox(
                height: AppDimens.containerHeight82,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: AppPadding.h20,
                  itemCount: _selectedUsers.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: AppDimens.w12),
                  itemBuilder: (context, index) {
                    final user = _selectedUsers[index];
                    return SizedBox(
                      width: AppDimens.w70,
                      child: _SelectedUserItem(
                        user: user,
                        onRemove: () =>
                            _removeSelectedUser(user),
                      ),
                    );
                  },
                ),
              ),
            ],

            SizedBox(height: AppDimens.h12),

            // Main User List
            Expanded(
              child: ListView.separated(
                padding: AppPadding.h20,
                itemCount: _filteredUsers.length,
                separatorBuilder: (context, index) =>
                    Divider(
                      height: AppDimens.dividerThickness1,
                      color: MyColors.grey300,
                    ),
                itemBuilder: (context, index) {
                  final user = _filteredUsers[index];
                  final bool isSelected = _selectedUsers
                      .contains(user);

                  return InkWell(
                    onTap: () => _toggleUserSelection(user),
                    child: Padding(
                      padding: AppPadding.v12,
                      child: Row(
                        children: [
                          // Avatar
                          CircleAvatar(
                            radius: AppDimens.avatarSize25,
                            backgroundImage: AssetImage(
                              user.avatar,
                            ),
                            onBackgroundImageError:
                                (exception, stackTrace) {
                                  // Handle error silently
                                },
                          ),

                          SizedBox(width: AppDimens.w12),

                          // User Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              mainAxisSize:
                                  MainAxisSize.min,
                              children: [
                                Text(
                                  '${user.name} ( ID:${user.userId} )',
                                  style: TextStyles.semiBold15(color: MyColors.black87),
                                  maxLines: 1,
                                  overflow:
                                      TextOverflow.ellipsis,
                                ),
                                SizedBox(height: AppDimens.h4),
                                Text(
                                  user.phone,
                                  style: TextStyles.regular12(color: MyColors.grey600),
                                  maxLines: 1,
                                  overflow:
                                      TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),

                          // Selection Indicator
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: MyColors.greenButton,
                              size: AppDimens.iconSize22,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Share Button (Footer)
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppDimens.w20,
                AppDimens.h16,
                AppDimens.w20,
                AppDimens.h16,
              ),
              child: SizedBox(
                width: double.infinity,
                height: AppDimens.buttonHeight50,
                child: ElevatedButton(
                  onPressed: _selectedUsers.isNotEmpty
                      ? () {
                          // TODO: Implement share logic
                          Navigator.pop(context);
                          // Show success message
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Subscription cost sharing request sent!',
                                style: TextStyles.regular14(),
                              ),
                              backgroundColor:
                                  MyColors.greenButton,
                              duration: const Duration(
                                seconds: 2,
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.greenButton,
                    disabledBackgroundColor:
                        MyColors.grey300,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.r10,
                    ),
                    elevation: AppDimens.elevation0,
                  ),
                  child: Text(
                    'Share',
                    style: TextStyles.bold16(color: MyColors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Selected User Item Widget (Horizontal List Item)
class _SelectedUserItem extends StatelessWidget {
  final _User user;
  final VoidCallback onRemove;

  const _SelectedUserItem({
    required this.user,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Avatar with Remove Button
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: AppDimens.avatarSize30,
              backgroundImage: AssetImage(user.avatar),
              onBackgroundImageError:
                  (exception, stackTrace) {
                    // Handle error silently
                  },
            ),
            // Remove Button (X icon)
            Positioned(
              top: -AppDimens.h4,
              right: -AppDimens.h4,
              child: InkWell(
                onTap: onRemove,
                borderRadius: AppRadius.r12,
                child: Container(
                  width: AppDimens.iconSize24,
                  height: AppDimens.iconSize24,
                  decoration: BoxDecoration(
                    color: MyColors.red,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: MyColors.white,
                      width: AppDimens.borderWidth2,
                    ),
                  ),
                  child: Icon(
                    Icons.close,
                    size: AppDimens.iconSize14,
                    color: MyColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppDimens.h6),
        // User Name
        Text(
          user.name
              .split(' ')
              .first, // Show only first name
          style: TextStyles.medium12(color: MyColors.black87),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
