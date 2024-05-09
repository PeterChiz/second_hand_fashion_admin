
class SHFValidator{

  ///Empty Text Validation
  static String? validationEmptyText(String? fieldName, String? value){
    if(value == null || value.isEmpty){
      return 'Vui lòng nhập $fieldName';
    }

    return null;
  }

  static String? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return 'Vui lòng nhập Email';
    }

    //Biểu thức chính quy để kiểm tra định dạng email theo chuẩn RFC 5322
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if(!emailRegExp.hasMatch(value)){
      return 'Địa chỉ email không hợp lệ.';
    }

    return null;
  }

}