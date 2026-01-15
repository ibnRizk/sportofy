import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/features/booking/presentation/widgets/audience_sheet.dart';
import 'package:sportify_app/features/booking/presentation/widgets/booking_type_sheet.dart';

class AppointmentGridView extends StatefulWidget {
  const AppointmentGridView({super.key});

  @override
  State<AppointmentGridView> createState() => _AppointmentGridViewState();
}

class _AppointmentGridViewState extends State<AppointmentGridView> {
  bool _isFindMemberMode = true; // "Find member" is selected by default
  int _selectedTeamOption = 1; // "Find member" is selected

  // Find Member Form State
  int _playersPresent = 2;
  int _playersRequired = 3;
  String _showMatchTo = 'Friends';
  List<String> _selectedAgeGroups = ['Less than 25', '25 - 35'];
  final TextEditingController _specialNoteController = TextEditingController();

  @override
  void dispose() {
    _specialNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Appointment'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: MyColors.greenButton,
                  width: 1,
                ),
                foregroundColor: MyColors.greenButton,
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 6.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'By Day',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Week Header
          _WeekHeader(),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  // Schedule Grid (PM times only: 01 PM - 05 PM)
                  _ScheduleGrid(),

                  SizedBox(height: 20.h),

                  // Divider
                  Divider(height: 1, color: Colors.grey[300]),

                  SizedBox(height: 20.h),

                  // Team Member Selection
                  _TeamSelector(
                    selectedOption: _selectedTeamOption,
                    onOptionSelected: (index) {
                      setState(() {
                        _selectedTeamOption = index;
                        _isFindMemberMode = index == 1;
                      });
                    },
                  ),

                  // Find Member Form (Conditional)
                  if (_isFindMemberMode) ...[
                    SizedBox(height: 16.h),
                    _FindMemberForm(
                      playersPresent: _playersPresent,
                      playersRequired: _playersRequired,
                      showMatchTo: _showMatchTo,
                      selectedAgeGroups: _selectedAgeGroups,
                      specialNoteController: _specialNoteController,
                      onPlayersPresentChanged: (value) {
                        setState(() {
                          _playersPresent = value;
                        });
                      },
                      onPlayersRequiredChanged: (value) {
                        setState(() {
                          _playersRequired = value;
                        });
                      },
                      onShowMatchToChanged: (value) {
                        setState(() {
                          _showMatchTo = value;
                        });
                      },
                      onAgeGroupToggled: (group) {
                        setState(() {
                          if (_selectedAgeGroups.contains(group)) {
                            _selectedAgeGroups.remove(group);
                          } else {
                            _selectedAgeGroups.add(group);
                          }
                        });
                      },
                    ),
                  ],

                  SizedBox(height: 100.h), // Space for footer button
                ],
              ),
            ),
          ),

          // Footer Button (Fixed)
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.r),
                        ),
                      ),
                      builder: (context) => const BookingTypeSheet(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.greenButton,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'Booking now',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Week Header Widget
class _WeekHeader extends StatelessWidget {
  final List<Map<String, String>> _dates = const [
    {'day': 'Sat', 'date': '08'},
    {'day': 'Sun', 'date': '09'},
    {'day': 'Mon', 'date': '10'},
    {'day': 'Tue', 'date': '11'},
    {'day': 'Wed', 'date': '12'},
    {'day': 'Thu', 'date': '13'},
    {'day': 'Fri', 'date': '14'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Blue Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 16.h,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF3688A6),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12.r),
            ),
          ),
          child: Text(
            'July 2023',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),

        // Days Row
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(12.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              _dates.length,
              (index) => Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _dates[index]['day']!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: MyColors.greenButton,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _dates[index]['date']!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: MyColors.greenButton,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Schedule Grid Widget (PM times only)
class _ScheduleGrid extends StatelessWidget {
  // Time slots from 01 PM to 05 PM (matching image)
  final List<String> _timeSlots = [
    '01 PM',
    '02 PM',
    '03 PM',
    '04 PM',
    '05 PM',
  ];

  // Mock data: Wed (index 4) / 01 PM (index 0) is selected/booked (green)
  final Map<int, Map<int, CellState>> _bookedSlots = {
    4: {0: CellState.booked}, // Wed 12 / 01 PM
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Grid Cells (Left Side - Expanded)
        Expanded(
          child: Column(
            children: List.generate(
              _timeSlots.length,
              (hourIndex) => _GridRow(
                hourIndex: hourIndex,
                bookedSlots: _bookedSlots,
              ),
            ),
          ),
        ),

        // Time Labels (Right Side - Fixed Width)
        Container(
          width: 50.w,
          child: Column(
            children: _timeSlots.map((time) {
              return SizedBox(
                height: 50.h,
                child: Center(
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

// Cell State Enum
enum CellState {
  empty,
  booked,
  resell,
}

// Grid Row Widget
class _GridRow extends StatelessWidget {
  final int hourIndex;
  final Map<int, Map<int, CellState>> bookedSlots;

  const _GridRow({
    required this.hourIndex,
    required this.bookedSlots,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Row(
        children: List.generate(
          7, // 7 days
          (dayIndex) => Expanded(
            child: _GridCell(
              dayIndex: dayIndex,
              hourIndex: hourIndex,
              state: bookedSlots[dayIndex]?[hourIndex] ?? CellState.empty,
            ),
          ),
        ),
      ),
    );
  }
}

// Grid Cell Widget
class _GridCell extends StatelessWidget {
  final int dayIndex;
  final int hourIndex;
  final CellState state;

  const _GridCell({
    required this.dayIndex,
    required this.hourIndex,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: state == CellState.booked
            ? MyColors.greenButton
            : (state == CellState.resell
                ? Colors.blue[50]
                : Colors.grey[200]),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 0.5,
        ),
      ),
      child: state == CellState.resell
          ? Center(
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.refresh,
                  size: 12.sp,
                  color: Colors.white,
                ),
              ),
            )
          : null,
    );
  }
}

// Team Selector Widget
class _TeamSelector extends StatelessWidget {
  final int selectedOption;
  final ValueChanged<int> onOptionSelected;

  const _TeamSelector({
    required this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Team Member',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),

        // Full Team Option
        _TeamOption(
          icon: Icons.group,
          label: 'Full Team',
          isSelected: selectedOption == 0,
          onTap: () => onOptionSelected(0),
        ),

        SizedBox(height: 12.h),

        // Find Member Option
        _TeamOption(
          icon: Icons.person_search,
          label: 'Find member',
          isSelected: selectedOption == 1,
          hasDropdown: true,
          onTap: () => onOptionSelected(1),
        ),
      ],
    );
  }
}

// Team Option Widget
class _TeamOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final bool hasDropdown;
  final VoidCallback onTap;

  const _TeamOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    this.hasDropdown = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? MyColors.greenButton
                : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Radio Button
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? MyColors.greenButton
                      : Colors.grey[400]!,
                  width: 2,
                ),
                color: isSelected
                    ? MyColors.greenButton
                    : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 16.sp,
                      color: Colors.white,
                    )
                  : null,
            ),
            SizedBox(width: 12.w),

            // Icon
            Icon(
              icon,
              color: isSelected
                  ? MyColors.greenButton
                  : Colors.grey[600],
              size: 20.sp,
            ),
            SizedBox(width: 12.w),

            // Label
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),

            // Dropdown Arrow
            if (hasDropdown)
              Icon(
                Icons.arrow_drop_down,
                color: Colors.grey[600],
                size: 24.sp,
              ),
          ],
        ),
      ),
    );
  }
}

// Find Member Form Widget
class _FindMemberForm extends StatelessWidget {
  final int playersPresent;
  final int playersRequired;
  final String showMatchTo;
  final List<String> selectedAgeGroups;
  final TextEditingController specialNoteController;
  final ValueChanged<int> onPlayersPresentChanged;
  final ValueChanged<int> onPlayersRequiredChanged;
  final ValueChanged<String> onShowMatchToChanged;
  final ValueChanged<String> onAgeGroupToggled;

  const _FindMemberForm({
    required this.playersPresent,
    required this.playersRequired,
    required this.showMatchTo,
    required this.selectedAgeGroups,
    required this.specialNoteController,
    required this.onPlayersPresentChanged,
    required this.onPlayersRequiredChanged,
    required this.onShowMatchToChanged,
    required this.onAgeGroupToggled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Player Counters
          _CounterRow(
            label: 'The number of players present',
            value: playersPresent,
            onDecrement: () {
              if (playersPresent > 0) {
                onPlayersPresentChanged(playersPresent - 1);
              }
            },
            onIncrement: () {
              onPlayersPresentChanged(playersPresent + 1);
            },
          ),

          SizedBox(height: 16.h),

          _CounterRow(
            label: 'The number of players required',
            value: playersRequired,
            onDecrement: () {
              if (playersRequired > 0) {
                onPlayersRequiredChanged(playersRequired - 1);
              }
            },
            onIncrement: () {
              onPlayersRequiredChanged(playersRequired + 1);
            },
          ),

          SizedBox(height: 24.h),

          // Show match to Button (Opens Audience Sheet)
          Row(
            children: [
              Text(
                'Show match to',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () async {
                  final result = await showModalBottomSheet<String>(
                    context: context,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),
                    ),
                    builder: (context) => AudienceSheet(
                      selected: showMatchTo,
                    ),
                  );

                  if (result != null) {
                    onShowMatchToChanged(result);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: MyColors.greenButton,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.person,
                        size: 16.sp,
                        color: MyColors.greenButton,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        showMatchTo,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: MyColors.greenButton,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.arrow_drop_down,
                        color: MyColors.greenButton,
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          // Group Age Section
          Text(
            'Group Age',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12.h),

          // Age Groups Checkboxes (2-column grid)
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: [
              'Less than 25',
              '25 - 35',
              'More than 35',
              'All',
            ].map((group) {
              final isSelected = selectedAgeGroups.contains(group);
              return SizedBox(
                width: (MediaQuery.of(context).size.width - 72.w) / 2,
                child: CheckboxListTile(
                  title: Text(
                    group,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                  value: isSelected,
                  onChanged: (value) {
                    onAgeGroupToggled(group);
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  activeColor: MyColors.greenButton,
                  dense: true,
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 24.h),

          // Special Note Field
          Text(
            'Special Note',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: specialNoteController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText:
                  'EX: This game is for training only for age players between...',
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[500],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: MyColors.greenButton,
                ),
              ),
              contentPadding: EdgeInsets.all(12.w),
            ),
          ),
        ],
      ),
    );
  }
}

// Counter Row Widget
class _CounterRow extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const _CounterRow({
    required this.label,
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Decrement Button
            IconButton(
              icon: Icon(
                Icons.remove_circle_outline,
                color: MyColors.greenButton,
                size: 24.sp,
              ),
              onPressed: onDecrement,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            SizedBox(width: 12.w),
            // Value
            Text(
              value.toString(),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(width: 12.w),
            // Increment Button
            IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                color: MyColors.greenButton,
                size: 24.sp,
              ),
              onPressed: onIncrement,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ],
    );
  }
}
