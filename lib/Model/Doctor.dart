

class Doctor {

  String name;
  String speciality;
  String grade;
  int yearOfExperience;

  Doctor(
      {
      required this.name,
      required this.speciality,
      required this.grade,
      required this.yearOfExperience
      });

 factory Doctor.fromJson(Map<String, dynamic> json) {

  return Doctor(
    name: json['name'],
    speciality: json['Speciality'],
    grade: json['grade'],
    yearOfExperience: json['yearOfExperience'],
  );
 }
   
 
   
  }

  Map<String, dynamic> toJson(dynamic name, dynamic speciality, dynamic grade, dynamic yearOfExperience) {
    final Map<String, dynamic> data = <String, dynamic>{
    };
    data['name'] = name;
    data['Speciality'] = speciality;
    data['grade'] = grade;
    data['yearOfExperience'] = yearOfExperience;
    return data;
  }

