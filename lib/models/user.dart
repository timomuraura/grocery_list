  
class User {
   int id;
   String firstName;
   String lastName;
  User({this.id, this.firstName, this.lastName});

  Map<String, dynamic> toMap() {
    return {
      'id': id,     
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}