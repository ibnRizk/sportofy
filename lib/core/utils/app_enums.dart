enum ExpansionTypes {
  doctorTitles,
  supSpecialities,
  availableTimes,
  entryMethod,
  building,
  gender,
  status
}

enum VerifyTypes { email, phone, reset }

enum AvailableTimes { anyDay, today, tomorrow }

enum Gender { male, female }

enum Building { hospital, clinic }

enum MyError { saerch, fourZeroFour, defaultError }

enum SortingOptions {
  mostCompatible('most_compatible'),
  ratings('ratings'),
  cost('cost'),
  lessWaitingTime('waiting_time');

  final String value;
  const SortingOptions(this.value);
}

enum ReviewSorting { newest, ratings }

enum DoctorTypes {
  doctors('assets/icons/doctor_sheet.svg'),
  hospitals('assets/icons/hospital_sheet.svg');

  final String icon;
  const DoctorTypes(this.icon);
}

enum SearchType {
  autocomplete('autocomplete'),
  citySpeciality('city_speciality'),
  autocompleteClinics('autocomplete_clinics'),
  autocompleteHospitals('autocomplete_hospitals');

  final String value;
  const SearchType(this.value);
}

enum StatusLevel { natural, careful, dangerous }

enum BookingStatusEnum { canceled, completed, upcoming }

enum MedicalHistorySortingEnum { newestMedical, oldest }

enum BookingSortingEnum { newestMedical, oldest }

enum ImgPath { file, mediaPath, noKey }
