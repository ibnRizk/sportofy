import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';

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
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.r),
          ),
        ),
        child: Column(
          children: [
            // Drag Handle
            SizedBox(height: 12.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            // Header
            Padding(
              padding: EdgeInsets.only(
                top: 16.h,
                left: 20.w,
                right: 20.w,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 24.sp,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Sharing the cost',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[500],
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[500],
                    size: 22.sp,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      8.r,
                    ),
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      8.r,
                    ),
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      8.r,
                    ),
                    borderSide: BorderSide(
                      color: MyColors.greenButton,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),

            // Selected Users Section (Horizontal List)
            if (_selectedUsers.isNotEmpty) ...[
              SizedBox(height: 12.h),
              SizedBox(
                height: 82.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  itemCount: _selectedUsers.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: 12.w),
                  itemBuilder: (context, index) {
                    final user = _selectedUsers[index];
                    return SizedBox(
                      width: 70.w,
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

            SizedBox(height: 12.h),

            // Main User List
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                itemCount: _filteredUsers.length,
                separatorBuilder: (context, index) =>
                    Divider(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                itemBuilder: (context, index) {
                  final user = _filteredUsers[index];
                  final bool isSelected = _selectedUsers
                      .contains(user);

                  return InkWell(
                    onTap: () => _toggleUserSelection(user),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                      ),
                      child: Row(
                        children: [
                          // Avatar
                          CircleAvatar(
                            radius: 25.r,
                            backgroundImage: AssetImage(
                              user.avatar,
                            ),
                            onBackgroundImageError:
                                (exception, stackTrace) {
                                  // Handle error silently
                                },
                          ),

                          SizedBox(width: 12.w),

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
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight:
                                        FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 1,
                                  overflow:
                                      TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  user.phone,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight:
                                        FontWeight.w400,
                                    color: Colors.grey[600],
                                  ),
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
                              size: 22.sp,
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
                20.w,
                16.h,
                20.w,
                16.h,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50.h,
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
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
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
                        Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10.r,
                      ),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Share',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
              radius: 30.r,
              backgroundImage: AssetImage(user.avatar),
              onBackgroundImageError:
                  (exception, stackTrace) {
                    // Handle error silently
                  },
            ),
            // Remove Button (X icon)
            Positioned(
              top: -4,
              right: -4,
              child: InkWell(
                onTap: onRemove,
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.close,
                    size: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        // User Name
        Text(
          user.name
              .split(' ')
              .first, // Show only first name
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
