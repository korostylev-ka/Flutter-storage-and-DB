import 'dart:math';

class RandomValues {
  static final random = Random();
  static final firstNames = [
    'Ivan',
    'Petr',
    'Dmitry',
    'Kirill',
    'Serg',
    'Nikolay'
  ];
  static final lastNames = [
    'Ivanov',
    'Petrov',
    'Sidorov',
    'Obuhov'
  ];

  static String randomFirstName() {
    return firstNames[random.nextInt(firstNames.length - 1)];
  }

  static String randomLastName() {
    return lastNames[random.nextInt(lastNames.length - 1)];
  }

  static String randomPhone() {
    int min = 79500000000;
    int max = 79500099999;
    int phone = (min + random.nextInt(max - min));
    return '+$phone';

  }

}