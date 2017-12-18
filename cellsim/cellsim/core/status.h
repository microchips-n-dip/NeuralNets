namespace cellsim {

struct Status
{
  enum ErrorType {
    BIND_FAIL,     // Failure on protein binding
    UNBIND_FAIL    // Failure on protein unbinding
  };
  
  // Construct a status with a null pointer error field
  // Null pointers represent an OK status
  Status();
  // Construct a status with a defined pointer error field
  // This error is constructed in the `error = new ErrorType(e);`
  Status(ErrorType e);
  // Destroy status
  ~Status();
  
  // Return OK status
  Status OK();
  // Return protein binding failure status
  Status BindFailure();
  // Return protein unbinding failure status
  Status UnbindFailure();
  // Check for OK status
  bool ok();
  // Check for binding failure
  bool BindFailed();
  // Check for unbinding failure
  bool UnbindFailed();
  
  ErrorType* error;
};

}
