unit DelayLib;

interface
  type

  TObjectProcedure = procedure () of object;

  TDelayProcedureRec = class
  public
    ExecTime: TDateTime;
    Proc: TObjectProcedure;
    Description :String;
  end;


implementation

end.

