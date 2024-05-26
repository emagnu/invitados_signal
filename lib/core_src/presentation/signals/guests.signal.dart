//  //   ///
//  Import LIBRARIES
import 'package:signals_flutter/signals_flutter.dart';
import 'package:uuid/uuid.dart';
//  Import FILES
import '../../application_svcs/random_generator.dart';
import '../../domain_models/guest.dart';
//  //   ///

const uuid = Uuid();

enum GuestFilter { all, invited, pending }

final guestSignal = signal<List<Guest>>([
  Guest(
      id: uuid.v4(),
      description: RandomGenerator.getRandomName(),
      invited: false),
  Guest(
      id: uuid.v4(),
      description: RandomGenerator.getRandomName(),
      invited: true),
  Guest(
      id: uuid.v4(),
      description: RandomGenerator.getRandomName(),
      invited: false),
  Guest(
      id: uuid.v4(),
      description: RandomGenerator.getRandomName(),
      invited: true),
  Guest(
      id: uuid.v4(),
      description: RandomGenerator.getRandomName(),
      invited: false),
]);
final guestFilterSignal = signal<GuestFilter>(GuestFilter.all);

void addGuest(String description) {
  // guestSignal.value.add(Guest(id: uuid.v4(),description: description,invited: false));
  guestSignal.value = [
    ...guestSignal.value,
    Guest(id: uuid.v4(), description: description, invited: false),
  ];
}

void changeFilter(GuestFilter filter) {
  guestFilterSignal.value = filter;
}

void toggleGuestInvited(Guest guest) {
  // guestSignal.value = [...guestSignal.value.where((element) => element.id != guest.id),guest.copyWith(invited: !guest.invited)];
  // guestSignal.value = guestSignal.value.map((element) {if (element.id == guest.id) {element.invited = !element.invited;}return element;}).toList();
  guestSignal.value = guestSignal.value
      .map((gst) =>
          gst.id == guest.id ? guest.copyWith(invited: guest.invited) : gst)
      .toList();
}

Computed<List<Guest>> filteredGuestsSignal = computed(() {
  final selectedFilter = guestFilterSignal.value;
  final guests = guestSignal.value;
  switch (selectedFilter) {
    case GuestFilter.all:
      return guests;
    case GuestFilter.invited:
      return guests.where((element) => element.invited).toList();
    case GuestFilter.pending:
      return guests.where((element) => !element.invited).toList();
  }

  // if (selectedFilter == GuestFilter.all) {
  //   return guestSignal.value;
  // }
  // return guestSignal.value
  //     .where((element) =>
  //         element.invited == (selectedFilter == GuestFilter.invited))
  //     .toList();
});

// void removeGuest(Guest guest) {
//   guestSignal.value =
//       guestSignal.value.where((element) => element.id != guest.id).toList();
// }

// void filterGuests(GuestFilter filter) {
//   guestFilterSignal.value = filter;
// }
