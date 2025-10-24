import 'package:flutter_storage/state/random_values.dart';
import 'package:uuid/uuid.dart';

class PersonEntity {
  String id;
  String firstName;
  String lastName;
  String phone;

  static const dbFileName = 'person_database.db';
  static const table = 'persons';
  static const createDB = 'CREATE TABLE persons('
      'id TEXT PRIMARY KEY,'
      'firstName TEXT,'
      'lastName TEXT,'
      'phone TEXT'
      ')';

  PersonEntity()
    : id = const Uuid().v4(),
      firstName = '',
      lastName = '',
      phone = '';

  PersonEntity.of({ required this.id, required this.firstName, required this.lastName, required this.phone });

  PersonEntity.copy({ required PersonEntity personEntity })
      : id = personEntity.id,
        firstName = personEntity.firstName,
        lastName = personEntity.lastName,
        phone = personEntity.phone;

  @override
  String toString() {
    return 'PersonEntity{id: $id, firstName: $firstName, lastName: $lastName, phone: $phone}';
  }

  String? validateFirstName() {
    if (firstName.isEmpty) {
      return 'Please enter First name';
    }
    return null;
  }

  String? validateLastName() {
    if (lastName.isEmpty) {
      return 'Please enter Last name';
    }
    return null;
  }

  String? validatePhone() {
    if (phone.isEmpty) {
      return 'Please enter Phone';
    }
    return null;
  }

  bool validate() {
    if (validateFirstName() != null) return false;
    if (validateLastName() != null) return false;
    if (validatePhone() != null) return false;
    return true;
  }

  static PersonEntity random() {
    const uuid = Uuid();
    PersonEntity personEntity = PersonEntity();
    personEntity.id = uuid.v4();
    personEntity.firstName = RandomValues.randomFirstName();
    personEntity.lastName = RandomValues.randomLastName();
    personEntity.phone = RandomValues.randomPhone();
    return personEntity;
  }

  //Маппер
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone
    };
  }


}