import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/features/booking/presentation/views/appointment_grid_view.dart';
import 'package:sportify_app/features/booking/presentation/widgets/booking_type_sheet.dart';
import 'package:sportify_app/features/booking/presentation/widgets/audience_sheet.dart';

class AppointmentView extends StatefulWidget {
  const AppointmentView({super.key});

  @override
  State<AppointmentView> createState() =>
      _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  int _selectedDateIndex =
      2; // "Mon 10" is selected by default
  List<int> _selectedTimeSlots = [
    0,
  ]; // 5 AM - 6 AM is selected
  int _selectedTeamOption = 0; // "Full Team" is selected
  bool _isFindMemberMode =
      false; // Show form when "Find member" is selected

  // Find Member Form State
  int _playersPresent = 2;
  int _playersRequired = 3;
  String _showMatchTo = 'Friends';
  List<String> _selectedAgeGroups = [
    'Less than 25',
    '25 - 35',
  ];
  final TextEditingController _specialNoteController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text('Appointment'),
        backgroundColor: MyColors.white,
        elevation: AppDimens.elevation0,
        iconTheme: const IconThemeData(
          color: MyColors.black87,
        ),
        actions: [
          Padding(
            padding: AppPadding.right20,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const AppointmentGridView(),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: MyColors.greenButton,
                  width: AppDimens.borderWidth1,
                ),
                foregroundColor: MyColors.greenButton,
                padding: AppPadding.h12v6,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.r8,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'By Week',
                    style: TextStyles.medium12(),
                  ),
                  SizedBox(width: AppDimens.w4),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: AppDimens.iconSize12,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppPadding.p20,
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

            SizedBox(height: AppDimens.h32),

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
                        index ==
                            _selectedTimeSlots.last + 1 ||
                        index ==
                            _selectedTimeSlots.first - 1) {
                      _selectedTimeSlots.add(index);
                      _selectedTimeSlots.sort();
                    }
                  }
                });
              },
            ),

            SizedBox(height: AppDimens.h32),

            // Team Member Selection
            _TeamSelector(
              selectedOption: _selectedTeamOption,
              onOptionSelected: (index) {
                setState(() {
                  _selectedTeamOption = index;
                  _isFindMemberMode =
                      index ==
                      1; // Show form when "Find member" is selected
                });
              },
            ),

            // Find Member Form (Conditional)
            if (_isFindMemberMode) ...[
              SizedBox(height: AppDimens.h16),
              _FindMemberForm(
                playersPresent: _playersPresent,
                playersRequired: _playersRequired,
                showMatchTo: _showMatchTo,
                selectedAgeGroups: _selectedAgeGroups,
                specialNoteController:
                    _specialNoteController,
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
                    if (_selectedAgeGroups.contains(
                      group,
                    )) {
                      _selectedAgeGroups.remove(group);
                    } else {
                      _selectedAgeGroups.add(group);
                    }
                  });
                },
              ),
            ],

            SizedBox(height: AppDimens.h40),

            // Booking Button
            SizedBox(
              width: double.infinity,
              height: AppDimens.buttonHeight50,
              child: ElevatedButton(
                onPressed: _selectedTimeSlots.isNotEmpty
                    ? () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: MyColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppRadius.top30,
                          ),
                          builder: (context) =>
                              const BookingTypeSheet(),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedTimeSlots.isNotEmpty
                      ? MyColors.greenButton
                      : MyColors.grey300,
                  foregroundColor: MyColors.white,
                  disabledBackgroundColor: MyColors.grey300,
                  disabledForegroundColor: MyColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.r10,
                  ),
                ),
                child: Text(
                  'Booking now',
                  style: TextStyles.semiBold16(),
                ),
              ),
            ),

            SizedBox(height: AppDimens.h20),
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
          padding: AppPadding.h20v16,
          decoration: BoxDecoration(
            color: MyColors.main,
            borderRadius: AppRadius.top12,
          ),
          child: Text(
            'July 2023',
            style: TextStyles.semiBold16(color: MyColors.white),
          ),
        ),

        // Days List
        Container(
          padding: AppPadding.h12v16,
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: AppRadius.bottom12,
            boxShadow: [
              BoxShadow(
                color: MyColors.black.withValues(alpha: AppDimens.opacity05),
                blurRadius: AppDimens.elevation8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
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
                        style: TextStyles.medium12(
                          color: selectedIndex == index
                              ? MyColors.greenButton
                              : MyColors.grey700,
                        ),
                      ),
                      SizedBox(height: AppDimens.h4),
                      Text(
                        _dates[index]['date']!,
                        style: TextStyles.semiBold16(
                          color: selectedIndex == index
                              ? MyColors.greenButton
                              : MyColors.black87,
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
  State<_TimeSlotsSection> createState() =>
      _TimeSlotsSectionState();
}

class _TimeSlotsSectionState
    extends State<_TimeSlotsSection> {
  bool _showResellHours = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Text(
          'Available Time',
          style: TextStyles.semiBold18(color: MyColors.black87),
        ),
        SizedBox(height: AppDimens.h4),
        Text(
          'you can only pick consecutive hours',
          style: TextStyles.regular12(color: MyColors.darkGrayColor),
        ),
        SizedBox(height: AppDimens.h16),

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
                      size: AppDimens.iconSize16,
                      color: MyColors.amber700,
                    ),
                    SizedBox(width: AppDimens.w4),
                    Text(
                      'Pending hours',
                      style: TextStyles.regular12(color: MyColors.darkGrayColor),
                    ),
                  ],
                ),
                SizedBox(width: AppDimens.w16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.refresh,
                      size: AppDimens.iconSize16,
                      color: MyColors.blue,
                    ),
                    SizedBox(width: AppDimens.w4),
                    Text(
                      'Resell hours',
                      style: TextStyles.regular12(color: MyColors.darkGrayColor),
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

        SizedBox(height: AppDimens.h16),

        // Time Slots Grid
        Wrap(
          spacing: AppDimens.w12,
          runSpacing: AppDimens.h12,
          children: List.generate(_timeSlots.length, (
            index,
          ) {
            final slot = _timeSlots[index];
            return _TimeChip(
              timeRange: slot['time'] as String,
              state: slot['state'] as TimeSlotState,
              isSelected: widget.selectedSlots.contains(
                index,
              ),
              onTap: () => widget.onSlotSelected(index),
            );
          }),
        ),
      ],
    );
  }

  // Mock time slots data matching the image
  static const List<Map<String, dynamic>> _timeSlots = [
    {
      'time': '5 AM - 6 AM',
      'state': TimeSlotState.resell,
      'selected': true,
    },
    {
      'time': '6 AM - 7 AM',
      'state': TimeSlotState.disabled,
    },
    {
      'time': '7 AM - 8 AM',
      'state': TimeSlotState.available,
    },
    {
      'time': '8 AM - 9 AM',
      'state': TimeSlotState.available,
    },
    {
      'time': '9 AM - 10 AM',
      'state': TimeSlotState.available,
    },
    {
      'time': '10 AM - 11 AM',
      'state': TimeSlotState.pending,
    },
    {
      'time': '11 AM - 12 PM',
      'state': TimeSlotState.available,
    },
    {'time': '12 PM - 1 PM', 'state': TimeSlotState.resell},
    {'time': '1 PM - 2 PM', 'state': TimeSlotState.pending},
    {
      'time': '2 PM - 3 PM',
      'state': TimeSlotState.disabled,
    },
    {
      'time': '3 PM - 4 PM',
      'state': TimeSlotState.available,
    },
    {
      'time': '4 PM - 5 PM',
      'state': TimeSlotState.available,
    },
  ];
}

// Time Slot State Enum
enum TimeSlotState { available, disabled, pending, resell }

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
    final hasBadge =
        state == TimeSlotState.resell ||
        state == TimeSlotState.pending;

    return SizedBox(
      width: AppDimens.w100, // Fixed width for 3 columns
      child: Stack(
        children: [
          // Main Chip
          GestureDetector(
            onTap: isDisabled ? null : onTap,
            child: Container(
              padding: AppPadding.h12v12,
              decoration: BoxDecoration(
                color: isSelected
                    ? MyColors.greenButton.withValues(
                        alpha: AppDimens.opacity1,
                      )
                    : (isDisabled
                          ? MyColors.grey100
                          : (isPending
                                ? MyColors.amber50
                                : MyColors.white)),
                borderRadius: AppRadius.r8,
                border: Border.all(
                  color: isSelected
                      ? MyColors.greenButton
                      : (isDisabled
                            ? MyColors.grey300
                            : (isPending
                                  ? MyColors.amber700
                                  : MyColors.grey300)),
                  width: AppDimens.borderWidth1,
                ),
              ),
              child: Center(
                child: Text(
                  timeRange,
                  style: TextStyles.medium12(
                    color: isSelected
                        ? MyColors.greenButton
                        : (isDisabled
                              ? MyColors.grey400
                              : (isPending
                                    ? MyColors.amber700
                                    : MyColors.black87)),
                  ),
                ),
              ),
            ),
          ),

          // Badge (Top Right Corner)
          if (hasBadge && !isDisabled)
            Positioned(
              top: AppDimens.h4,
              right: AppDimens.w4,
              child: Container(
                padding: AppPadding.p4,
                decoration: BoxDecoration(
                  color: state == TimeSlotState.resell
                      ? MyColors.blue
                      : MyColors.amber700,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  state == TimeSlotState.resell
                      ? Icons.refresh
                      : Icons.access_time,
                  size: AppDimens.iconSize10,
                  color: MyColors.white,
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
          style: TextStyles.semiBold18(color: MyColors.black87),
        ),
        SizedBox(height: AppDimens.h16),

        // Full Team Option
        _TeamOption(
          icon: Icons.group,
          label: 'Full Team',
          isSelected: selectedOption == 0,
          onTap: () => onOptionSelected(0),
        ),

        SizedBox(height: AppDimens.h12),

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
        padding: AppPadding.p16,
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: AppRadius.r12,
          border: Border.all(
            color: isSelected
                ? MyColors.greenButton
                : MyColors.grey300,
            width: AppDimens.borderWidth1,
          ),
        ),
        child: Row(
          children: [
            // Radio Button
            Container(
              width: AppDimens.w24,
              height: AppDimens.w24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? MyColors.greenButton
                      : MyColors.grey400,
                  width: AppDimens.borderWidth2,
                ),
                color: isSelected
                    ? MyColors.greenButton
                    : MyColors.transparent,
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: AppDimens.iconSize16,
                      color: MyColors.white,
                    )
                  : null,
            ),
            SizedBox(width: AppDimens.w12),

            // Icon
            Icon(
              icon,
              color: isSelected
                  ? MyColors.greenButton
                  : MyColors.grey600,
              size: AppDimens.iconSize20,
            ),
            SizedBox(width: AppDimens.w12),

            // Label
            Expanded(
              child: Text(
                label,
                style: TextStyles.medium16(color: MyColors.black87),
              ),
            ),

            // Dropdown Arrow
            if (hasDropdown)
              Icon(
                Icons.arrow_drop_down,
                color: MyColors.grey600,
                size: AppDimens.iconSize24,
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
      padding: AppPadding.p16,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: AppRadius.r12,
        border: Border.all(
          color: MyColors.grey300,
          width: AppDimens.borderWidth1,
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

          SizedBox(height: AppDimens.h16),

          _CounterRow(
            label: 'The number of players required',
            value: playersRequired,
            onDecrement: () {
              if (playersRequired > 0) {
                onPlayersRequiredChanged(
                  playersRequired - 1,
                );
              }
            },
            onIncrement: () {
              onPlayersRequiredChanged(playersRequired + 1);
            },
          ),

          SizedBox(height: AppDimens.h24),

          // Show match to Button (Opens Audience Sheet)
          Row(
            children: [
              Text(
                'Show match to',
                style: TextStyles.medium14(color: MyColors.black87),
              ),
              const Spacer(),
              InkWell(
                onTap: () async {
                  final result =
                      await showModalBottomSheet<String>(
                        context: context,
                        backgroundColor: MyColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.top30,
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
                  padding: AppPadding.h12v8,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: MyColors.greenButton,
                      width: AppDimens.borderWidth1,
                    ),
                    borderRadius: AppRadius.r8,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.person,
                        size: AppDimens.iconSize16,
                        color: MyColors.greenButton,
                      ),
                      SizedBox(width: AppDimens.w6),
                      Text(
                        showMatchTo,
                        style: TextStyles.medium14(color: MyColors.greenButton),
                      ),
                      SizedBox(width: AppDimens.w4),
                      Icon(
                        Icons.arrow_drop_down,
                        color: MyColors.greenButton,
                        size: AppDimens.iconSize20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: AppDimens.h24),

          // Group Age Section
          Text(
            'Group Age',
            style: TextStyles.semiBold14(color: MyColors.black87),
          ),
          SizedBox(height: AppDimens.h12),

          // Age Groups Checkboxes (2-column grid)
          Wrap(
            spacing: AppDimens.w12,
            runSpacing: AppDimens.h12,
            children:
                [
                  'Less than 25',
                  '25 - 35',
                  'More than 35',
                  'All',
                ].map((group) {
                  final isSelected = selectedAgeGroups
                      .contains(group);
                  return SizedBox(
                    width:
                        (MediaQuery.of(context).size.width -
                            AppDimens.w72) /
                        AppDimens.w2,
                    child: CheckboxListTile(
                      title: Text(
                        group,
                        style: TextStyles.regular14(color: MyColors.black87),
                      ),
                      value: isSelected,
                      onChanged: (value) {
                        onAgeGroupToggled(group);
                      },
                      controlAffinity:
                          ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      activeColor: MyColors.greenButton,
                      dense: true,
                    ),
                  );
                }).toList(),
          ),

          SizedBox(height: AppDimens.h24),

          // Special Note Field
          Text(
            'Special Note',
            style: TextStyles.semiBold14(color: MyColors.black87),
          ),
          SizedBox(height: AppDimens.h8),
          TextFormField(
            controller: specialNoteController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText:
                  'EX: This game is for training only for age players between...',
              hintStyle: TextStyles.regular14(color: MyColors.darkGrayColor),
              border: OutlineInputBorder(
                borderRadius: AppRadius.r8,
                borderSide: BorderSide(
                  color: MyColors.grey300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: AppRadius.r8,
                borderSide: BorderSide(
                  color: MyColors.grey300,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: AppRadius.r8,
                borderSide: BorderSide(
                  color: MyColors.greenButton,
                ),
              ),
              contentPadding: AppPadding.p12,
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
            style: TextStyles.medium14(color: MyColors.black87),
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
                size: AppDimens.iconSize24,
              ),
              onPressed: onDecrement,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            SizedBox(width: AppDimens.w12),
            // Value
            Text(
              value.toString(),
              style: TextStyles.semiBold16(color: MyColors.black87),
            ),
            SizedBox(width: AppDimens.w12),
            // Increment Button
            IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                color: MyColors.greenButton,
                size: AppDimens.iconSize24,
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
