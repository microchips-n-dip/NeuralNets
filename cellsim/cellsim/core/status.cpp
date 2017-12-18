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
  if (ok()) {
    continue;
  }
  else {
    delete error;
  }
}

// Return bind failure
Status Status::BindFailure()
{ return Status(BIND_FAIL); }

// Return unbind failure
// This is redundant; unbind never fails
Status Status::UnbindFailure()
{ return Status(UNBIND_FAIL); }

// Check for okay status
bool Status::ok()
{ return (error == nullptr) ? true : false; }

// Check for bind failure
bool Status::BindFailed()
{ return (*error == BIND_FAIL) ? true : false; }

// Check for unbind failure
// This is also redundant; since we know unbind never fails there is no need
//  to check for a failure... it is nice to have though
bool Status::UnbindFailed()
{ return (*error == UNBIND_FAIL) ? true : false; }

}
