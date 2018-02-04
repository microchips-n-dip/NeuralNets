#include "status.h"

namespace cellsim {

// Note: Use multiple forms of constructors to easily construct statuses
//  which handle various error cases
// Constructor with no errors
Status::Status()
{ error = nullptr; }

// Constructor with errors
Status::Status(ErrorType e)
{ error = new ErrorType(e); }

// Return OK status
// OK status exists when the error field is a null pointer
Status Status::OK()
{ return Status(); }

Status::~Status()
{
  if (!ok()) {
		error = nullptr;
	}
}

// Return bind failure
Status Status::BindFailure()
{ return Status(BIND_FAIL); }

// Return unbind failure
// This is redundant; unbind never fails
Status Status::UnbindFailure()
{ return Status(UNBIND_FAIL); }

// Return fetch next
Status Status::PlzFetchNext()
{ return Status(FETCH_NEXT); }

// Return transcription failure
Status Status::TranscriptionFailure()
{ return Status(TRANSCRIPT_FAIL); }

// Return translation failure
Status Status::TranslationFailure()
{ return Status(TRANSLATE_FAIL); }

// Check for okay status
bool Status::ok()
{ return error == nullptr; }

// Check for bind failure
bool Status::BindFailed() {
  if (!ok()) {
    return (*error) == BIND_FAIL;
  }
  else {
    return false;
  }
}

// Check for unbind failure
// This is also redundant; since we know unbind never fails there is no need
//  to check for a failure... it is nice to have though
bool Status::UnbindFailed() {
  if (!ok()) {
    return (*error) == UNBIND_FAIL;
  }
  else {
    return false;
  }
}

// Check for fetch next
bool Status::FetchNext() {
  if (!ok()) {
    return (*error) == FETCH_NEXT;
  }
  else {
    return false;
  }
}

// Check for transcription error
bool Status::TranscriptionFailed() {
  if (!ok()) {
    return (*error) == TRANSCRIPT_FAIL;
  }
  else {
    return false;
  }
}

// Check for translation error
bool Status::TranslationFailed() {
  if (!ok()) {
    return (*error) == TRANSLATE_FAIL;
  }
  else {
    return false;
  }
}

}
