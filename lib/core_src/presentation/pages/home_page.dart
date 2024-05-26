//  //   ///
//  Import LIBRARIES
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
//  Import FILES
import '../../application_svcs/random_generator.dart';
import '../signals/guests.signal.dart';
//  //   ///

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page - Signals'),
      ),
      body: const _Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addGuest(RandomGenerator.getRandomName());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    final guests = filteredGuestsSignal.watch(context);
    final currentFilter = guestFilterSignal.watch(context);
    return SafeArea(
      child: Column(
        children: <Widget>[
          const ListTile(
            title: Text('Listado de invitados'),
            subtitle: Text('Esta son la personas a invitar a la fiesta'),
          ),
          SegmentedButton(
              segments: const [
                ButtonSegment(value: GuestFilter.all, icon: Text('Todos')),
                ButtonSegment(
                    value: GuestFilter.invited, icon: Text('Invitados')),
                ButtonSegment(
                    value: GuestFilter.pending, icon: Text('Pendentes')),
              ],
              selected: <GuestFilter>{
                currentFilter
              },
              onSelectionChanged: (value) {
                changeFilter(value.first);
              }),
          const SizedBox(height: 5.0),
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: guests.length,
            itemBuilder: (context, index) {
              final guest = guests[index];
              return SwitchListTile(
                title: Text(guest.description),
                value: guest.invited,
                onChanged: (bool value) {
                  toggleGuestInvited(guest);
                },
              );
            },
          )
        ],
      ),
    );
  }
}
