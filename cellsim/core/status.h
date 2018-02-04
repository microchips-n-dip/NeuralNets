#ifndef CELLSIM_STATUS_H
#define CELLSIM_STATUS_H

namespace cellsim {

struct Status
{
  enum ErrorType {
    BIND_FAIL,     // Failure on protein binding
    UNBIND_FAIL,   // Failure on protein unbinding
    FETCH_NEXT,
    TRANSCRIPT_FAIL,
    TRANSLATE_FAIL
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
  static Status OK();
  // Return protein binding failure status
  static Status BindFailure();
  // Return protein unbinding failure status
  static Status UnbindFailure();
  // Return fetch next status
  static Status PlzFetchNext();
  // Return transcription failure status
  static Status TranscriptionFailure();
  // Return translation failure status
  static Status TranslationFailure();
  
  // Check for OK status
  bool ok();
  // Check for binding failure
  bool BindFailed();
  // Check for unbinding failure
  bool UnbindFailed();
  // Check for fetch next
  bool FetchNext();
  // Check for transcription failure
  bool TranscriptionFailed();
  // Check for translation failure
  bool TranslationFailed();
  
  ErrorType* error;
};

}

#endif
