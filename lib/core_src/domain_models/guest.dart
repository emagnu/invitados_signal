//  //   ///
//  Import LIBRARIES
//  Import FILES
//  //   ///

class Guest {
  final String id;
  final String description;
  final bool invited;

  Guest({required this.id, required this.description, required this.invited});

  Guest copyWith({
    String? id,
    String? description,
    bool? invited,
    DateTime? completedAt,
  }) {
    return Guest(
      id: id ?? this.id,
      description: description ?? this.description,
      invited: invited ?? this.invited,
    );
  }
}
