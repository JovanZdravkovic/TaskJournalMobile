class TaskFormValidators {

  static String? taskName(String? taskName) {
    if(taskName != null && taskName.isNotEmpty) {
      if(taskName.length <= 50) {
        return null;
      } else {
        return 'Name must be shorter than 50 characters';
      }
    }
    return 'Name cannot be empty';
  } 

  static String? taskDesc(String? taskDesc) {
    if(taskDesc != null && taskDesc.isNotEmpty) {
      if(taskDesc.length <= 500) {
        return null;
      } else {
        return 'Description must be shorter than 500 characters';
      }
    }
    return 'Description cannot be empty';
  } 

}