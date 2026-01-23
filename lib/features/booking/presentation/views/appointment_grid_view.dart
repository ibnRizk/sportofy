import 'package:flutter/material.dart';
import 'package:sportify_app/core/utils/app_colors.dart';
import 'package:sportify_app/core/utils/app_dimens.dart';
import 'package:sportify_app/core/utils/app_padding.dart';
import 'package:sportify_app/core/utils/app_radius.dart';
import 'package:sportify_app/core/utils/values/text_styles.dart';
import 'package:sportify_app/features/booking/presentation/widgets/audience_sheet.dart';
import 'package:sportify_app/features/booking/presentation/widgets/booking_type_sheet.dart';

class AppointmentGridView extends StatefulWidget {
  const AppointmentGridView({super.key});

  @override
  State<AppointmentGridView> createState() =>
      _AppointmentGridViewState();
}

class _AppointmentGridViewState
    extends State<AppointmentGridView> {
  bool _isFindMemberMode =
      true; // "Find member" is selected by default
  int _selectedTeamOption = 1; // "Find member" is selected

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
  void dispose() {
    _specialNoteController.dispose();
    super.dispose();
  }

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
                Navigator.pop(context);
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
                    'By Day',
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
      body: Column(
        children: [
          // Week Header
          _WeekHeader(),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: AppPadding.h20,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppDimens.h20),

                  // Schedule Grid (PM times only: 01 PM - 05 PM)
                  _ScheduleGrid(),

                  SizedBox(height: AppDimens.h20),

                  // Divider
                  Divider(
                    height: AppDimens.dividerThickness1,
                    color: MyColors.grey300,
                  ),

                  SizedBox(height: AppDimens.h20),

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
                            _selectedAgeGroups.remove(
                              group,
                            );
                          } else {
                            _selectedAgeGroups.add(group);
                          }
                        });
                      },
                    ),
                  ],

                  SizedBox(
                    height: AppDimens.h100,
                  ), // Space for footer button
                ],
              ),
            ),
          ),

          // Footer Button (Fixed)
          Container(
            padding: AppPadding.p20,
            decoration: BoxDecoration(
              color: MyColors.white,
              boxShadow: [
                BoxShadow(
                  color: MyColors.black.withValues(
                    alpha: AppDimens.opacity05,
                  ),
                  blurRadius: AppDimens.elevation10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: AppDimens.buttonHeight50,
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: MyColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.top30,
                      ),
                      builder: (context) =>
                          const BookingTypeSheet(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.greenButton,
                    foregroundColor: MyColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.r10,
                    ),
                  ),
                  child: Text(
                    'Booking now',
                    style: TextStyles.semiBold16(color: MyColors.white),
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

        // Days Row
        Container(
          padding: AppPadding.h12v12,
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _dates[index]['day']!,
                      style: TextStyles.medium12(color: MyColors.greenButton),
                    ),
                    SizedBox(height: AppDimens.h4),
                    Text(
                      _dates[index]['date']!,
                      style: TextStyles.semiBold14(color: MyColors.greenButton),
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
          width: AppDimens.w50,
          child: Column(
            children: _timeSlots.map((time) {
              return SizedBox(
                height: AppDimens.h50,
                child: Center(
                  child: Text(
                    time,
                    style: TextStyles.medium12(color: MyColors.darkGrayColor),
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
enum CellState { empty, booked, resell }

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
      height: AppDimens.h50,
      child: Row(
        children: List.generate(
          7, // 7 days
          (dayIndex) => Expanded(
            child: _GridCell(
              dayIndex: dayIndex,
              hourIndex: hourIndex,
              state:
                  bookedSlots[dayIndex]?[hourIndex] ??
                  CellState.empty,
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
                  ? MyColors.blue50
                  : MyColors.grey200),
        border: Border.all(
          color: MyColors.grey300,
          width: AppDimens.borderWidth0_5,
        ),
      ),
      child: state == CellState.resell
          ? Center(
              child: Container(
                padding: AppPadding.p6,
                decoration: BoxDecoration(
                  color: MyColors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.refresh,
                  size: AppDimens.iconSize12,
                  color: MyColors.white,
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
