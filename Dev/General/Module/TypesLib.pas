unit TypesLib;

interface

Uses Classes , Dialogs , db;

type
  TGeneralProc          = procedure             of object;
  TGeneralStringProc    = Procedure (const Value:String) of Object;
  TGeneralIntProc       = Procedure (const Value:Integer) of Object;
  TGeneralBooleanProc   = Procedure (const Value:Boolean) of Object;
  TGeneralComponentProc = Procedure (Const Value:TComponent) of Object;
  TGeneralStringFunc    = Function  :String     of object;
  TGeneralBooleanFunc   = Function  :Boolean    of Object;
  TGeneralIntegerFunc   = Function  :Integer    of object;
  TGeneralconfirm       = function  (const msg :String; Buttons:TMsgDlgButtons  ; DlgType: TMsgDlgType =mtConfirmation) :Integer of Object;
  TDatasetIterateCallbackProc = procedure(Sender: TDataSet; var Abort: boolean) of object;
  TDatasetEvent = procedure(Sender: TDataSet) of object;



implementation

end.
