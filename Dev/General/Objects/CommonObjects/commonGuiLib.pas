unit commonGuiLib;

interface

Uses TypesLib, ERPdbComponents, Types, Controls, classes, WwDBGrid ,BusObjBase , BaseInputForm , SelectionDialog, dialogs;


  function formLeft(const cnt:TControl):Integer;
  function formTop(const cnt:TControl):Integer;
  function ScreenLeft(const cnt:TControl):Integer;
  function ScreenTop(const cnt:TControl):Integer;
  Function MDIPosition(Const Comp :TControl): TPoint;
  Function GridMDIPosition(Const Grid :TwwDBGrid; fieldname:String; formwidth:Integer; posontitle:Boolean=False): TPoint;
  Function MiddlealignLeft(Const Comp1, comp2 :TControl; comp1Left :Integer):Integer;
  Function MDIParentLeft(Const comp:TControl):Integer;
  Function MDIParentTOp(Const comp:TControl):Integer;
  Function ReadStrProp(const Control :TControl ; const PropName :String):String;
  Function ReadIntProp(const Control :TControl ; const PropName :String):Integer;
  Function ReadObjProp(const Control :TControl ; const PropName :String):TObject;
  Function ReadMethProp(const Control :TControl ; const PropName :String):TMethod;
  Function ReadActionName(const Control :TControl):String;
  Procedure Logcomponents(Comp :TComponent; Prefix :String = '');
  function GdicolumnPosition(Grid :TwwDBGrid;ColumnName:String;posontitle :Boolean):TRect;
  procedure Swapfields(form : TBaseInputGUI; grd:TwwDBGrid; Field1, Field2, DisplayLabel:String;      Proc :TGeneralProc);
  function controlTop(const cnt:TControl) :Integer;
  function controlLeft(const cnt:TControl) :Integer;
  procedure LoadSerials(const PartsID, ClassID: integer;dlgSerialSelect: TSelectionDialog);
  function MessageDlgLargefont(const MsgText, FooterMsg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint;CustomButtonsStr :String = '' ): Word;


implementation

uses forms, LogLib, sysutils, MAIN, TypInfo, ActnList,DNMSpeedButton, DNMLib,
  DbSharedObjectsObj, ProductQtyLib, CommonDbLib,  frmMessageBase, frmMessage ;


Function MDIParentLeft(Const comp:TControl):Integer;
begin
  result := 0;
  if comp is Tform then
    if Tform(Comp).FormStyle = fsMDIChild then
      if Application.MainForm = MainForm then result := result + MainForm.left
      else result := result +Application.MainForm.Left;
end;
Function MDIParentTOp(Const comp:TControl):Integer;
begin
  result := 0;
  if comp is Tform then
    if Tform(Comp).FormStyle = fsMDIChild then
      if Application.MainForm = MainForm then result := result + MainForm.Top
      else result := result +Application.MainForm.top;
end;
function ScreenLeft(const cnt:TControl):Integer;
begin
  result := cnt.Left;
  if Assigned(cnt.Parent) then result := result + ScreenLeft(cnt.Parent)
  else result := result + MDIParentLeft(cnt);
end;
function ScreenTop(const cnt:TControl):Integer;
begin
  result := cnt.Top;
  if Assigned(cnt.Parent) then result := result + ScreenTop(cnt.Parent)
  else result := result + MDIParentTop(cnt);
end;

Function MDIPosition(Const Comp :TControl):TPoint;
begin
  result:= comp.ClientToScreen(Point(0,0));
end;
Function GridMDIPosition(Const Grid :TwwDBGrid; fieldname:String; formwidth:Integer; posontitle:Boolean=False): TPoint;
var
  Rect :Trect;
begin
  Rect.Left :=0; Rect.Top := 0;
  try
    Rect := GdicolumnPosition(Grid , fieldname , posontitle);

    try if Assigned(Grid.indicatorbutton) then Rect.Left := Rect.Left +Grid.indicatorbutton.width; except end;// add the width of indicator width

    try Rect.Left := Rect.Left +trunc(Grid.ColumnByName(fieldname).DisplayWidth); except end;// middle of the column

    try if formwidth >0 then Rect.Left := Rect.Left - trunc(formwidth/2); except end;// formwidth is the width of the hintform

    (*if Rect.Left<0 then Rect.Left := 0;
    if Rect.top <0 then Rect.top  := 0;*)
  finally
    result:= Grid.ClientToScreen(Point(0,0));
    result.X := result.X + rect.Left;
  end;

end;
function formLeft(const cnt:TControl):Integer;
begin
  result := cnt.Left;
  if not(cnt.Parent is Tform) then result := result + formleft(cnt.Parent);
end;
function formTop(const cnt:TControl):Integer;
begin
  result := cnt.Top;
  if not(cnt.Parent is Tform) then result := result + formTop(cnt.Parent);
end;

Function MiddlealignLeft(Const Comp1, comp2 :TControl; comp1Left :Integer):Integer;
begin
  result := comp1Left + trunc(Twincontrol(Comp1).width/2);
  result := result - trunc(Twincontrol(Comp2).width/2);
end;

Function ReadStrProp(const Control :TControl ; const PropName :String):String;
var
  PropInfo: PPropInfo;
begin
    Result := '';
    if control = nil then exit;
    PropInfo:= GetPropInfo(Control, PropName);
    if Assigned(PropInfo) then
      REsult :=GetStrProp(Control,PropInfo);
end;
function ReadActionName(const Control: TControl): String;
var
  Action :TObject;
begin
  result := '';
  if control = nil then exit;
  Action := ReadObjProp(control , 'Action');
  if assigned(Action)  and (Action is TAction) then result := TAction(ACtion).Name;
end;

Function ReadIntProp(const Control :TControl ; const PropName :String):Integer;
var
  PropInfo: PPropInfo;
begin
    Result := 0;
    if control = nil then exit;
    PropInfo:= GetPropInfo(Control, PropName);
    if Assigned(PropInfo) then
      REsult :=GetInt64Prop(Control,PropInfo);
end;
Function ReadObjProp(const Control :TControl ; const PropName :String):TObject;
var
  PropInfo: PPropInfo;
begin
    Result := nil;
    if control = nil then exit;
    PropInfo:= GetPropInfo(Control, PropName);
    if Assigned(PropInfo) then
      REsult :=GetObjectProp(Control,PropInfo);
end;
Function ReadMethProp(const Control :TControl ; const PropName :String):TMethod;
var
  PropInfo: PPropInfo;
begin
  REsult.Code := nil;
  REsult.Data:= nil;
    if control = nil then exit;
    PropInfo:= GetPropInfo(Control, PropName);
    if Assigned(PropInfo) then
      REsult :=GetMethodProp(Control,PropInfo);
end;
Procedure Logcomponents(Comp :TComponent; prefix :String = '');
var
  ctr:Integer;
begin
  if prefix = '' then clog('');
  for ctr := 0 to Comp.ComponentCount-1 do begin
    if comp.components[ctr] is TDNMSpeedbutton then
      Logtext(Prefix+TDNMSpeedbutton(comp.components[ctr]).name+'.visible =' + BoolToStr(TDNMSpeedbutton(comp.components[ctr]).visible));
    Logcomponents(comp.components[ctr] ,Prefix+comp.components[ctr].name+'.');
  end;
end;

function GdicolumnPosition(Grid :TwwDBGrid;ColumnName:String; posontitle:Boolean):TRect;
var
  i:Integer;
begin
  i := GetGridColumnIndex(Grid, ColumnName);
  if i>=0 then if posontitle then result := Grid.CellRect(i+1, 1) else result := Grid.CellRect(i+1, Grid.DataSource.DataSet.RecNo);
end;
function controlTop(const cnt:TControl) :Integer;
begin
    REsult := cnt.Top;
    if Assigned(cnt.parent) and (not(cnt.Parent is TForm)) then
      result := result + controlTop(cnt.Parent );
end;
function controlLeft(const cnt:TControl) :Integer;
begin
    REsult := cnt.Left;
    if Assigned(cnt.parent) and (not(cnt.Parent is TForm)) then
      result := result + controlLeft(cnt.Parent );
end;
procedure Swapfields(form : TBaseInputGUI; grd:TwwDBGrid; Field1, Field2, DisplayLabel:String;      Proc :TGeneralProc);
begin
      grd.AddField(Field2);
      Form.AddFieldtoGrid(grd ,Field2 , grd.datasource.dataset.FieldByName(Field1).Index);
      grd.ColumnByName(Field2).readonly := grd.ColumnByName(Field1).readonly;
      grd.RemoveField(Field1);
      //grd.datasource.dataset.FieldByName(Field2).Index := grd.datasource.dataset.FieldByName(Field1).Index;
      grd.ColumnByName(Field2).DisplayLabel := DisplayLabel;
      grd.datasource.dataset.FieldByName(Field2).displaywidth := grd.datasource.dataset.FieldByName(Field2).displaywidth;
      grd.SetActiveField(Field2);
      if assigned(Proc) then Proc;
end;
procedure LoadSerials(const PartsID, ClassID: integer;dlgSerialSelect: TSelectionDialog);
var
  qryTemp: TERPQuery;
begin
  qryTemp := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  with qryTemp do try
      Sql.Clear;
      SQL.add(StockQtyDetailswithSno(True, PartsID , ClassID ));
      Open;
      dlgSerialSelect.Items.Clear;
      if not IsEmpty then begin
        First;
        while not Eof do begin
          if FieldByName('SerialNumber').AsString <> '' then dlgSerialSelect.Items.Add(FieldByName('SerialNumber').AsString);
          Next;
        end;
      end;
    finally
      FreeAndNil(qryTemp);
    end;
end;
function MessageDlgLargefont(const MsgText, FooterMsg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint;CustomButtonsStr :String = '' ): Word;
function MsgOptions:String;
  var
    st:TStringlist;
  begin
  st:= TStringlist.create;
  try
      st.Duplicates := dupIgnore;
      if CustomButtonsStr <> '' then st.CommaText := CustomButtonsStr;
      if mbYes      in Buttons then st.add('Yes');
      if mbNo       in Buttons then st.add('No');
      if mbOK       in Buttons then st.add('OK');
      if mbCancel   in Buttons then st.add('Cancel');
      if mbAbort    in Buttons then st.add('Abort');
      if mbRetry    in Buttons then st.add('Retry');
      if mbIgnore   in Buttons then st.add('Ignore');
      if mbAll      in Buttons then st.add('All');
      if mbNoToAll  in Buttons then st.add('No to All');
      if mbYesToAll in Buttons then st.add('Yes to All');
      if mbClose    in Buttons then st.add('Close');
  finally
    result := st.commatext;
    freeandnil(st);
  end;
  end;
begin
      InitMsgParams;
      PopupMsgParams.LargeFont := True;
           if DlgType = mtWarning       then PopupMsgParams.Msgcaption := 'Warning'
      else if DlgType = mtError         then PopupMsgParams.Msgcaption := 'Error'
      else if DlgType = mtInformation   then PopupMsgParams.Msgcaption := 'Information'
      else if DlgType = mtConfirmation  then PopupMsgParams.Msgcaption := 'Confirmation';

      PopupMsgParams.Custombuttons   := MsgOptions;
      PopupMsgParams.MsgText := MsgText;
      PopupMsgParams.Msg1 :=PopupMsgParams.Msgcaption;
      PopupMsgParams.Msg2:=  FooterMsg;
      result := TfmMessage.MsgDlg;
end;
end.

