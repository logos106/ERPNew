unit ExcelfileObj;

interface

Uses
  Windows, Messages, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DNMSpeedButton , Excel2000, OleServer, ExcelXP;

Type
  TExcelObj = Class;

  TExcelCellAddress = record
    Rowno:Integer;
    columnno :Integer;
  end;

  TExcelObjEventtype = (teoetNone =0,
                        teoetDblclick       =1,
                        teoetbeforeDestory  =2,
                        teoetAfterDestroy   =3 ,
                        teoetWbDeactivate   =4 ,
                        teoetWbBeforeSave   =5,
                        teoetSheetDeactivate=6,
                        teoetWindowDeactivate=7,
                        teoetShowSelectionMsg=8);
  TExcelObjEvent = Function (sender :TExcelObj ; Eventtype :TExcelObjEventtype):boolean of Object;

  TExcelObjDblclick           = Procedure (ASender: TObject; const Sh: IDispatch; const Target: ExcelRange; var Cancel: WordBool) of Object;

  TExcelObj = Class(TComponent)
  Private
    ExcelApp: TExcelApplication;
    fsExcelfilename: string;
    fiLCID:Integer;
    ExcelWb: _WorkBook;
    ExcelSt: _WorkSheet;
    fonDblclick: TExcelObjDblclick;
    fOnExcelObjEvent: TExcelObjEvent;

    Procedure DoExecute(DoShow:Boolean);
    procedure doOnSheetBeforeDoubleClick(ASender: TObject;const Sh: IDispatch; const Target: ExcelRange; var Cancel: WordBool);
    procedure doOnSheetDeactivate(ASender: TObject; const Sh: IDispatch);
    procedure doOnWindowDeactivate(ASender: TObject; const Wb: _Workbook;      const Wn: Window);
    procedure doOnWorkbookBeforeSave(ASender: TObject; const Wb: _Workbook;SaveAsUI: WordBool; var Cancel: WordBool);
    procedure doOnWorkbookDeactivate(ASender: TObject; const Wb: _Workbook);
    function getActiveCellRow: Integer;
    function getActiveCellColumn: Integer;
    function getExcelCellAddress: TExcelCellAddress;
    procedure SetExcelCellAddress(const Value: TExcelCellAddress);
    procedure setActiveCellColumn(const Value: Integer);
    procedure SetActiveCellRow(const Value: Integer);
    procedure SetfocustoCell(irow, icol: Integer);

  Protected
  Public
      Constructor Create(AOwner:TComponent);override;
      destructor Destroy;override;

      Property Excelfilename :string read fsExcelfilename write fsExcelfilename;
      Property onDblclick : TExcelObjDblclick read fonDblclick write fonDblclick;
      Property OnExcelObjEvent : TExcelObjEvent read fOnExcelObjEvent write fOnExcelObjEvent;

      Class Function OpenExcel(AOwner:TComponent;aExcelfilename:String; aonDblclick : TExcelObjDblclick):TExcelObj;Overload;
      Procedure OpenExcel(aExcelfilename:String; aonDblclick : TExcelObjDblclick);Overload;

      Class Function OpenExcelSheet(AOwner:TComponent;aExcelfilename:String; aOnExcelObjEvent : TExcelObjEvent):TExcelObj;Overload;
      Procedure OpenExcelSheet(aExcelfilename:String; aOnExcelObjEvent : TExcelObjEvent);Overload;

      Property ActiveCellRow :Integer read getActiveCellRow write SetActiveCellRow;
      Property ActiveCellColumn :Integer read getActiveCellColumn write setActiveCellColumn;
      Property ExcelCellAddress :TExcelCellAddress read getExcelCellAddress write SetExcelCellAddress;
      procedure SendEscape;
      class function calcpartsforexcelprice(AOwner: TComponent;const fiProductId: Integer;var fbpartsforexcelpriceOverrides: Boolean;var fbHaspartsforexcelprice: Boolean; var fdpartsforexcelpriceDefaultQty:Double; ShowMsgifExcelPricenotExists :Boolean): Double;Overload;
      function calcpartsforexcelprice(const fiProductId: Integer;var fbpartsforexcelpriceOverrides: Boolean;var fbHaspartsforexcelprice: Boolean; var fdpartsforexcelpriceDefaultQty:Double; ShowMsgifExcelPricenotExists :Boolean;OpenExcelsheet:Boolean; aOnExcelObjEvent : TExcelObjEvent): Double;Overload;
      Function SelectedValue :String;
      Function CellValue(arow,acol:Integer):String;

  End;
function EventtoDec (Const Value :TExcelObjEventtype):String;

implementation

uses sysutils , OleAuto, CommonLib, LogLib , sndkey32, tcDataUtils,
  Busobjpartsforexcelprice;

{ TExcelObj }
function EventtoDec (Const Value :TExcelObjEventtype):String;
begin
         if Value = teoetNone  then result := ''
   else  if Value = teoetDblclick        then result := 'None'
   else  if Value = teoetbeforeDestory    then result := 'Destroying'
   else  if Value = teoetAfterDestroy     then result := 'Destroyed'
   else  if Value = teoetWbDeactivate     then result := 'WorkBook Deactivated'
   else  if Value = teoetWbBeforeSave     then result := 'Saving Workbook'
   else  if Value = teoetSheetDeactivate  then result := 'Sheet Deactivated'
   else  if Value = teoetWindowDeactivate then result := 'Window Deactivated'
   else  if Value = teoetShowSelectionMsg then result := 'Source Field Status'
   else result := 'None';
end;
constructor TExcelObj.Create(AOwner: TComponent);
begin
  inherited;
  try
    try
      ExcelApp:= TExcelApplication.Create(self);
    Except
        on E:Exception do begin

        end;
    end;
    fonDblclick := nil;
    fOnExcelObjEvent := nil;
    ExcelApp.OnSheetBeforeDoubleClick := doOnSheetBeforeDoubleClick;
    ExcelApp.OnWorkbookDeactivate := doOnWorkbookDeactivate;
    ExcelApp.OnWorkbookBeforeSave := doOnWorkbookBeforeSave;
    ExcelApp.OnSheetDeactivate := doOnSheetDeactivate;
    ExcelApp.OnWindowDeactivate := doOnWindowDeactivate;
  Except
    on E:Exception do begin
      Logtext(E.Message);
    end;
  end;
end;
procedure TExcelObj.doOnWorkbookDeactivate(ASender: TObject; const Wb: _Workbook);
begin
  Logtext('TExcelObj.doOnWorkbookDeactivate');
  if Assigned(fOnExcelObjEvent) then fOnExcelObjEvent(Self, teoetWbDeactivate);
end;

procedure TExcelObj.doOnWorkbookBeforeSave(ASender: TObject; const Wb: _Workbook;SaveAsUI: WordBool; var Cancel: WordBool);
begin
  Logtext('TExcelObj.doOnWorkbookBeforeSave');
  if Assigned(fOnExcelObjEvent) then fOnExcelObjEvent(Self, teoetWbBeforeSave);
end;
procedure TExcelObj.doOnSheetDeactivate(ASender: TObject; const Sh: IDispatch);
begin
  Logtext('TExcelObj.doOnSheetDeactivate');
  if Assigned(fOnExcelObjEvent) then fOnExcelObjEvent(Self, teoetSheetDeactivate);
end;
procedure TExcelObj.doOnWindowDeactivate(ASender: TObject; const Wb: _Workbook;      const Wn: Window);
begin
  Logtext('TExcelObj.doOnWindowDeactivate');
  if Assigned(fOnExcelObjEvent) then fOnExcelObjEvent(Self, teoetWindowDeactivate);
end;

procedure TExcelObj.doOnSheetBeforeDoubleClick(ASender: TObject;const Sh: IDispatch; const Target: ExcelRange; var Cancel: WordBool);
begin
  ExcelWb.Save(filcid);
  if Assigned(fonDblclick) then begin
    fonDblclick(ASender, sh, TArget,Cancel);
  end;
  if Assigned(fOnExcelObjEvent) then begin
    if fOnExcelObjEvent(Self, teoetDblclick) then
      (*SetfocustoCell(ExcelApp.ActiveCell.Row+1 ,ExcelApp.ActiveCell.column+1)*);
  end;
end;



destructor TExcelObj.Destroy;
begin
  logtext('===================================================================');
  if Assigned(fOnExcelObjEvent) then fOnExcelObjEvent(Self, teoetShowSelectionMsg); // to hide the msg
  if Assigned(fOnExcelObjEvent) then fOnExcelObjEvent(Self, teoetbeforeDestory);
  try
    try Logtext('ExcelWb.Save'        ); ExcelWb.Save(fiLCID);                            Except on  E:Exception do begin if devmode then Logtext('Exception ExcelWb.Save :'        + E.message); end; End;
    try Logtext('FreeAndNil(ExcelSt)' ); FreeAndNil(ExcelSt);                             Except on  E:Exception do begin if devmode then Logtext('Exception FreeAndNil(ExcelSt) :' + E.message); end; End;
(*    try Logtext('ExcelWb.Close'       ); ExcelWb.Close(true, Excelfilename, '' , filcid); Except on  E:Exception do begin if devmode then Logtext('Exception ExcelWb.Close :'       + E.message); end; End;
    try Logtext('FreeAndNil(ExcelWb)' ); FreeAndNil(ExcelWb);                             Except on  E:Exception do begin if devmode then Logtext('Exception FreeAndNil(ExcelWb):'  + E.message); end; End;*)
    try Logtext('freeandnil(ExcelApp)'); freeandnil(ExcelApp);                            Except on  E:Exception do begin if devmode then Logtext('Exception freeandnil(ExcelApp):' + E.message); end; End;
    inherited;
  finally
    if Assigned(fOnExcelObjEvent) then fOnExcelObjEvent(Self, teoetAfterDestroy);
  end;
  logtext('===================================================================');
end;

procedure TExcelObj.DoExecute(DoShow:Boolean);

Procedure HandleOleError(aE:Exception);
var
  hWnd :THandle;
begin
  try
    (*if (pos('OLE error' , aE.message)>0) and assigned(ExcelApp) and ExcelApp.Application.Visible[0] then begin
      ExcelApp.UserControl := TRUE;*)
    if (pos('OLE error' , aE.message)>0) then begin
      hWnd := FindWindow('XLMAIN', nil);
      if hWnd <> 0 then begin
        SetActiveWindow(hWnd);
        MessageDlgXP_Vista('Excel is already Open. Please Close This before Accessing Excel again', mtWarning, [mbOK], 0);
        Exit;
      end;
    end;
    MessageDlgXP_Vista('Error Opening Excel :' + aE.message, mtWarning, [mbOK], 0);
  Except
    on E:Exception do begin
      MessageDlgXP_Vista(E.message, mtWarning, [mbOK], 0);
    end;
  end;
  MessageDlgXP_Vista(aE.message, mtWarning, [mbOK], 0);
end;

begin
  if trim(Excelfilename) = '' then begin
    MessageDlgXP_Vista('Please choose the Excel File', mtWarning, [mbOK], 0);
    Exit;
  end;
  if not fileExists(Excelfilename) then begin
    MessageDlgXP_Vista(Excelfilename + ' Doesn''t Exists', mtWarning, [mbOK], 0);
    Exit;
  end;

  fiLCID := GetUserDefaultLCID;

  ExcelApp.Connect;

{try .. except in the following section, ignores the error incase if excel is already opened}
  try
    (*try*)
      ExcelWb := ExcelApp.Workbooks.Open(
        Excelfilename,
        emptyParam, emptyParam, emptyParam, emptyParam,
        emptyParam, emptyParam, emptyParam, emptyParam,
        emptyParam, emptyParam, emptyParam, emptyParam,emptyParam,emptyParam,
        fiLCID
      );
    (*Except  on E:Exception do begin    HandleOleError(E);  end;end;*)

      if DoShow then begin
        (*try*)ExcelApp.Application.Visible[0] := false;   (*Except on E:Exception do begin    HandleOleError(E);  end;end;*)
        (*try*)ExcelSt := ExcelWb.Sheets[1] as _WorkSheet; (*Except on E:Exception do begin    HandleOleError(E);  end;end;*)
        (*try*)ExcelSt.Activate(fiLCID);                   (*Except on E:Exception do begin    HandleOleError(E);  end;end;*)
        (*try*)ExcelApp.Application.Visible[0] := true;    (*Except on E:Exception do begin    HandleOleError(E);  end;end;*)
      end;
  Except
    on E:Exception do begin
      HandleOleError(E);
    end;
  end;
end;
class Function  TExcelObj.OpenExcel(AOwner:TComponent;aExcelfilename: String;aonDblclick: TExcelObjDblclick):TExcelObj;
begin
  Result := TExcelObj.Create(AOwner);
  Result.OpenExcel( aExcelfilename, aonDblclick);
end;
procedure TExcelObj.OpenExcel(aExcelfilename: String;  aonDblclick: TExcelObjDblclick);
var
  hWnd  :THandle;
begin
  if Excelfilename <>aExcelfilename then begin
    Excelfilename :=aExcelfilename;
    onDblclick := aonDblclick;
    DoExecute(true);
  end else begin
    hWnd := FindWindow('XLMAIN', nil);
    if hWnd <> 0 then AppActivate(hWnd);
  end;
end;
class Function  TExcelObj.OpenExcelSheet(AOwner:TComponent;aExcelfilename: String;aOnExcelObjEvent: TExcelObjEvent):TExcelObj;
begin
  Result := TExcelObj.Create(AOwner);
  Result.OpenExcelSheet( aExcelfilename, aOnExcelObjEvent);
end;
procedure TExcelObj.OpenExcelSheet(aExcelfilename: String;  aOnExcelObjEvent: TExcelObjEvent);
var
  hWnd  :THandle;
begin
  if Excelfilename <>aExcelfilename then begin
    Excelfilename :=aExcelfilename;
    OnExcelObjEvent := aOnExcelObjEvent;
    DoExecute(true);
  end else begin
    hWnd := FindWindow('XLMAIN', nil);
    if hWnd <> 0 then AppActivate(hWnd);
  end;
  if Assigned(aOnExcelObjEvent) then aOnExcelObjEvent(Self, teoetShowSelectionMsg);
end;
procedure TExcelObj.setActiveCellColumn(const Value: Integer);
begin
  SetfocustoCell(ExcelApp.ActiveCell.Row ,Value);
end;

procedure TExcelObj.SetActiveCellRow(const Value: Integer);
begin
  SetfocustoCell(Value , ExcelApp.ActiveCell.Column);
end;

procedure TExcelObj.SetExcelCellAddress(const Value: TExcelCellAddress);
begin
  ActiveCellrow := Value.Rowno;
  ActiveCellColumn := Value.columnno;
end;

function TExcelObj.getActiveCellRow: Integer;
begin
  REsult :=ExcelApp.ActiveCell.Row;
end;
function TExcelObj.getExcelCellAddress: TExcelCellAddress;
var
  aExcelCellAddress :TExcelCellAddress;
begin
  aExcelCellAddress.Rowno:= ActiveCellrow ;
  aExcelCellAddress.columnno:= ActiveCellColumn;
  result :=  aExcelCellAddress;
end;

function TExcelObj.getActiveCellColumn: Integer;
begin
  REsult :=ExcelApp.ActiveCell.Column;
end;
Function TExcelObj.CellValue(arow,acol:Integer):String;
begin
  REsult := '';
  if (arow =0) or ( acol =0) then exit;
  result:= ExcelApp.Cells.Item[arow,acol];
end;
function TExcelObj.SelectedValue: String;
begin
  REsult := '';
  if (ActiveCellRow =0) or ( ActiveCellColumn =0) then exit;
  result:= ExcelApp.Cells.Item[ActiveCellRow,ActiveCellColumn];
end;

Procedure TExcelObj.SendEscape;
begin
  SendKeys('{ESC}',True);
end;
Procedure TExcelObj.SetfocustoCell(irow, icol:Integer);
begin
try
  if (irow>0) and (icol>0) then begin
    logtext('befre activate: ' + inttostr(ExcelApp.ActiveCell.Row)+',' +inttostr(ExcelApp.ActiveCell.column));
    ExcelApp.Range[irow,icol].Activate;
    logtext('after activate: ' + inttostr(ExcelApp.ActiveCell.Row)+',' +inttostr(ExcelApp.ActiveCell.column));
  end;
Except
  on E:Exception do begin
    MessageDlgXP_vista(E.message, mtWarning, [mbOK], 0);
  end;
end;
end;
function TExcelObj.calcpartsforexcelprice(const fiProductId: Integer;var fbpartsforexcelpriceOverrides: Boolean;var fbHaspartsforexcelprice: Boolean; var fdpartsforexcelpriceDefaultQty:Double; ShowMsgifExcelPricenotExists :Boolean;OpenExcelsheet:Boolean; aOnExcelObjEvent : TExcelObjEvent): Double;
var
  aPartsForExcelPrice : TPartsForExcelPrice;
  s:String;
  Procedure DoShowMsgifExcelPricenotExists(Const Msg:String);
  begin
    if ShowMsgifExcelPricenotExists then
      MessageDlgXP_Vista(quotedstr(getProduct(fiProductId))+' - '+Msg, mtWarning, [mbOK], 0);
  end;
begin
    aPartsForExcelPrice := TPartsForExcelPrice.CreateWithSharedConn(nil);
      try
        aPartsForExcelPrice.loadselect('ProductId = ' + inttostr(fiProductId)+' and Active ="T"');
        if aPartsForExcelPrice.count =0                                           then begin DoShowMsgifExcelPricenotExists('has no Excel Price Assigned')                                                  ; exit; end;
        fbHaspartsforexcelprice := True;
        if trim(aPartsForExcelPrice.ExcelFilename) = ''                           then begin DoShowMsgifExcelPricenotExists('Excel Price File is not Selected')                                           ; exit;end;
        if not FileExists(aPartsForExcelPrice.ExcelFilename)                      then begin DoShowMsgifExcelPricenotExists('Selected file '+ quotedstr(aPartsForExcelPrice.ExcelFilename)+' is missing') ; exit;end;
        if (aPartsForExcelPrice.PriceRow<=0) or (aPartsForExcelPrice.PriceCol<=0) then begin DoShowMsgifExcelPricenotExists('Price Column are not Selected')                                              ; exit;end;

         Excelfilename :=aPartsForExcelPrice.Excelfilename;
         OnExcelObjEvent := aOnExcelObjEvent;
         DoExecute(OpenExcelsheet);
         if not OpenExcelsheet then begin
           s:= ExcelApp.Cells.Item[aPartsForExcelPrice.PriceRow,aPartsForExcelPrice.PriceCol];
           if isnumber(s) then begin
              result := strtofloat(s);
              fbpartsforexcelpriceOverrides := aPartsForExcelPrice.ExcelPriceOverrides;
           end else begin
              DoShowMsgifExcelPricenotExists('Price is not Provided in the Cells Selected'); Exit;
           end;
           s:= ExcelApp.Cells.Item[aPartsForExcelPrice.qtyRow,aPartsForExcelPrice.qtyCol];
           if (s<> '') and isnumber(s) then begin
              fdpartsforexcelpriceDefaultQty := strtofloat(s);
           end;
         end;
         if Assigned(aOnExcelObjEvent) then aOnExcelObjEvent(Self, teoetShowSelectionMsg);
      finally
        FreeandNil(aPartsForExcelPrice);
      end;
end;
class function TExcelObj.calcpartsforexcelprice(AOwner:TComponent; const fiProductId: Integer;
                                                var fbpartsforexcelpriceOverrides:Boolean;
                                                var fbHaspartsforexcelprice:Boolean;
                                                var fdpartsforexcelpriceDefaultQty:Double;
                                                ShowMsgifExcelPricenotExists :Boolean): Double;
var
  aExcelObj :TExcelObj;
  aOnExcelObjEvent : TExcelObjEvent;
  Procedure DoShowMsgifExcelPricenotExists(Const Msg:String);
  begin
    if ShowMsgifExcelPricenotExists then
      MessageDlgXP_Vista(quotedstr(getProduct(fiProductId))+' - '+Msg, mtWarning, [mbOK], 0);
  end;
begin
  result := 0;
  fbHaspartsforexcelprice := False;
  aExcelObj := nil;
  if (Aowner <> nil)  then
    aExcelObj := TExcelObj(GetComponentByClassName('TExcelObj' , true , AOwner));
  if aExcelObj = nil then aExcelObj := TExcelObj.create(Aowner);
  try
      aOnExcelObjEvent := nil;
      result:= aExcelObj.calcpartsforexcelprice(fiProductId,fbpartsforexcelpriceOverrides,fbHaspartsforexcelprice,fdpartsforexcelpriceDefaultQty,ShowMsgifExcelPricenotExists,False, aOnExcelObjEvent);
  finally
    Freeandnil(aExcelObj);
  end;
end;
end.
