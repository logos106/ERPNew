unit DNMExceptions;

interface

uses
  Classes, SysUtils;

type
  ESingleton          = class(Exception);
  ENoAccess           = class(Exception);
  ESQLError           = class(Exception);
  EMultisiteError     = class(Exception);
  ERequiredFieldEmpty = class(Exception);
  ECoPreferenceViolation = class(Exception);
  ETranConvertError   = class(Exception);
  EReportNotFoundError = class(Exception);
  EBaseCashError      = class(Exception);

implementation

end.
