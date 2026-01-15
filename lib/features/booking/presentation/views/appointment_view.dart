import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/features/booking/presentation/views/appointment_grid_view.dart';
import 'package:sportify_app/features/booking/presentation/widgets/booking_type_sheet.dart';
import 'package:sportify_app/features/booking/presentation/widgets/audience_sheet.dart';

class AppointmentView extends StatefulWidget {
  const AppointmentView({super.key});

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  int _selectedDateIndex = 2; // "Mon 10" is selected by default
  List<int> _selectedTimeSlots = [0]; // 5 AM - 6 AM is selected
  int _selectedTeamOption = 0; // "Full Team" is selected
  bool _isFindMemberMode = false; // Show form when "Find member" is selected

  // Find Member Form State
  int _playersPresent = 2;
  int _playersRequired = 3;
  String _showMatchTo = 'Friends';
  List<String> _selectedAgeGroups = ['Less than 25', '25 - 35'];
  final TextEditingController _specialNoteController = TextEditingController();

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AppointmentGridView(),
                  ),
                );
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
                    'By Week',
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar Widget
            _BookingCalendar(
              selectedIndex: _selectedDateIndex,
              onDateSelected: (index) {
                setState(() {
                  _selectedDateIndex = index;
                });
              },
            ),

            SizedBox(height: 32.h),

            // Time Slots Section
            _TimeSlotsSection(
              selectedSlots: _selectedTimeSlots,
              onSlotSelected: (index) {
                setState(() {
                  if (_selectedTimeSlots.contains(index)) {
                    _selectedTimeSlots.remove(index);
                  } else {
                    // Only allow consecutive hours
                    if (_selectedTimeSlots.isEmpty ||
                        index == _selectedTimeSlots.last + 1 ||
                        index == _selectedTimeSlots.first - 1) {
                      _selectedTimeSlots.add(index);
                      _selectedTimeSlots.sort();
                    }
                  }
                });
              },
            ),

            SizedBox(height: 32.h),

            // Team Member Selection
            _TeamSelector(
              selectedOption: _selectedTeamOption,
              onOptionSelected: (index) {
                setState(() {
                  _selectedTeamOption = index;
                  _isFindMemberMode = index == 1; // Show form when "Find member" is selected
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

            SizedBox(height: 40.h),

            // Booking Button
            SizedBox(
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

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _specialNoteController.dispose();
    super.dispose();
  }
}

// Booking Calendar Widget
class _BookingCalendar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDateSelected;

  const _BookingCalendar({
    required this.selectedIndex,
    required this.onDateSelected,
  });

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
        // Header
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

        // Days List
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 16.h,
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
                child: GestureDetector(
                  onTap: () => onDateSelected(index),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _dates[index]['day']!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: selectedIndex == index
                              ? MyColors.greenButton
                              : Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        _dates[index]['date']!,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: selectedIndex == index
                              ? MyColors.greenButton
                              : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Time Slots Section
class _TimeSlotsSection extends StatefulWidget {
  final List<int> selectedSlots;
  final ValueChanged<int> onSlotSelected;

  const _TimeSlotsSection({
    required this.selectedSlots,
    required this.onSlotSelected,
  });

  @override
  State<_TimeSlotsSection> createState() => _TimeSlotsSectionState();
}

class _TimeSlotsSectionState extends State<_TimeSlotsSection> {
  bool _showResellHours = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Text(
          'Available Time',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'you can only pick consecutive hours',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 16.h),

        // Legend and Toggle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Legend
            Row(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16.sp,
                      color: Colors.amber[700],
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Pending hours',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16.w),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.refresh,
                      size: 16.sp,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Resell hours',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Toggle Switch
            Switch(
              value: _showResellHours,
              onChanged: (value) {
                setState(() {
                  _showResellHours = value;
                });
              },
              activeColor: MyColors.greenButton,
            ),
          ],
        ),

        SizedBox(height: 16.h),

        // Time Slots Grid
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: List.generate(
            _timeSlots.length,
            (index) {
              final slot = _timeSlots[index];
              return _TimeChip(
                timeRange: slot['time'] as String,
                state: slot['state'] as TimeSlotState,
                isSelected: widget.selectedSlots.contains(index),
                onTap: () => widget.onSlotSelected(index),
              );
            },
          ),
        ),
      ],
    );
  }

  // Mock time slots data matching the image
  static const List<Map<String, dynamic>> _timeSlots = [
    {'time': '5 AM - 6 AM', 'state': TimeSlotState.resell, 'selected': true},
    {'time': '6 AM - 7 AM', 'state': TimeSlotState.disabled},
    {'time': '7 AM - 8 AM', 'state': TimeSlotState.available},
    {'time': '8 AM - 9 AM', 'state': TimeSlotState.available},
    {'time': '9 AM - 10 AM', 'state': TimeSlotState.available},
    {'time': '10 AM - 11 AM', 'state': TimeSlotState.pending},
    {'time': '11 AM - 12 PM', 'state': TimeSlotState.available},
    {'time': '12 PM - 1 PM', 'state': TimeSlotState.resell},
    {'time': '1 PM - 2 PM', 'state': TimeSlotState.pending},
    {'time': '2 PM - 3 PM', 'state': TimeSlotState.disabled},
    {'time': '3 PM - 4 PM', 'state': TimeSlotState.available},
    {'time': '4 PM - 5 PM', 'state': TimeSlotState.available},
  ];
}

// Time Slot State Enum
enum TimeSlotState {
  available,
  disabled,
  pending,
  resell,
}

// Time Chip Widget
class _TimeChip extends StatelessWidget {
  final String timeRange;
  final TimeSlotState state;
  final bool isSelected;
  final VoidCallback onTap;

  const _TimeChip({
    required this.timeRange,
    required this.state,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = state == TimeSlotState.disabled;
    final isPending = state == TimeSlotState.pending;
    final hasBadge = state == TimeSlotState.resell || state == TimeSlotState.pending;

    return SizedBox(
      width: 100.w, // Fixed width for 3 columns
      child: Stack(
        children: [
          // Main Chip
          GestureDetector(
            onTap: isDisabled ? null : onTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 12.h,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? MyColors.greenButton.withOpacity(0.1)
                    : (isDisabled
                        ? Colors.grey[100]
                        : (isPending
                            ? Colors.amber[50]
                            : Colors.white)),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: isSelected
                      ? MyColors.greenButton
                      : (isDisabled
                          ? Colors.grey[300]!
                          : (isPending
                              ? Colors.amber[700]!
                              : Colors.grey[300]!)),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  timeRange,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? MyColors.greenButton
                        : (isDisabled
                            ? Colors.grey[400]
                            : (isPending
                                ? Colors.amber[700]
                                : Colors.black87)),
                  ),
                ),
              ),
            ),
          ),

          // Badge (Top Right Corner)
          if (hasBadge && !isDisabled)
            Positioned(
              top: 4.h,
              right: 4.w,
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: state == TimeSlotState.resell
                      ? Colors.blue
                      : Colors.amber[700],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  state == TimeSlotState.resell
                      ? Icons.refresh
                      : Icons.access_time,
                  size: 10.sp,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
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
