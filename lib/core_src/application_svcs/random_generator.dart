//  //   ///
//  Import LIBRARIES
import 'package:random_name_generator/random_name_generator.dart';
//  Import FILES
//  //   ///

class RandomGenerator {
  static String getRandomName() {
    final randomNames = RandomNames(Zone.spain);

    return randomNames.fullName();
  }

  static Stream<String> randomStream() {
    return Stream.periodic(const Duration(seconds: 2), (i) {
      return getRandomName();
    });
  }
}
