import 'package:email_validator/email_validator.dart';

String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "This field cannot be empty";
  } else if (value.length > 20) {
    return "Too long";
  }
  return null;
}


String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "This field cannot be empty";
  } else if (!EmailValidator.validate(value)) {
    return "Invalid Email";
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "This field cannot be empty";
  } else if (value.length < 5) {
    return "Password should be longer than 4 characters";
  }
  return null;
}

String? repasswordValidator(String? value, originalPassword){
   if (value == null || value.isEmpty) {
    return "This field cannot be empty";
  } else if (value.length < 5) {
    return "Password should be longer than 4 characters";
  } else if(value!=originalPassword){
    return "Password doesn't match";
  }
   return null;
}

String? adressValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "This field cannot be empty";
  } else if (value.length < 5) {
    return "Password should be longer than 4 characters";
  }
  return null;
}

String? phoneNumberValidator(String? value){
  if (value == null || value.isEmpty) {
    return "This field cannot be empty";
  } else if (value.length != 10) {
    return "Phonenumbers are 10 digits";
  }
  else if(!isNumeric(value)){
    return "please enter correct phone number format";
  }
  return null;
}

String? ageValidator(String? value){
  if (value == null || value.isEmpty) {
    return "This field cannot be empty";
  } else if (!isNumeric(value)) {
    return "Age is numeric";
  }else if(int.parse(value)>130||int.parse(value)<1){
    return "Invalid value for age";
  }
  return null;
}

String? budgetValidator(String? value){
 if (value == null || value.isEmpty) {
    return "This field cannot be empty";
  } else if (!isNumeric(value)) {
    return "Budget is numeric";
  }
  return null; 
}
  
bool isNumeric(value){
  try {
    int.parse(value);
    return true;
  }
  catch(e){
    return false;
  }
}