unit frmMessageWithGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmMessageBase, DB, Grids, Wwdbigrd, Wwdbgrid, Menus, ExtCtrls,
  IntegerListObj,StdCtrls, DNMPanel;

type
  TfmMessageWithGrid = class(TfmMessageBase)
    grdmain: TwwDBGrid;
    dsMain: TDataSource;
  private
    fMsgDs: TDataset;
    fsdisplayLabels: String;
    fsFieldNames: String;
    fsDisplaywidths: String;
    //fsMsgTExtForGrid: String;
    fbMultiSelect :Boolean;
    fsIdFieldname:String;
    procedure setMsgDs(const Value: TDataset);
    procedure SetMultiSelect(const Value: Boolean);
    function getIdsSelected: String;
  Protected
    Procedure InitMsgDlg;overload;Override;
  public
    class function MsgDlg:Integer;overload;Override;
    class function MsgDlg(var SelectedIds:TIntegerList):Integer;overload;
    class function MsgList(AOwner:TComponent):TfmMessageWithGrid;
    Property MsgDs :TDataset read fMsgDs write setMsgDs;
    Property FieldNames:String read fsFieldNames write fsFieldNames;
    Property displayLabels :String read fsdisplayLabels write fsdisplayLabels;
    Property Displaywidths :String read fsDisplaywidths write fsDisplaywidths;
    Property MultiSelect :Boolean read fbMultiSelect write SetMultiSelect;
    Property IdFieldname :String read fsIdFieldname write fsIdFieldname;
    Property IdsSelected :String read getIdsSelected;
  end;


implementation

uses  CommonLib;

{$R *.dfm}

{ TfmMessageWithGrid }

function TfmMessageWithGrid.getIdsSelected: String;
begin
  REsult := '';
  if IdFieldname ='' then exit;
  if dsmain.DataSet.FindField(IdFieldname) = nil then exit;
  Result := SelectedIDs(grdmain , IdFieldname , true);
end;

procedure TfmMessageWithGrid.InitMsgDlg;
begin
  inherited;
  FieldNames    := PopupMsgParams.FieldNames;
  displayLabels := PopupMsgParams.displayLabels;
  Displaywidths := PopupMsgParams.Displaywidths;
  MultiSelect   := PopupMsgParams.MultiSelect;
  IdFieldname   := PopupMsgParams.IdFieldname;
  MsgDs         := PopupMsgParams.MsgDs;
end;

class function TfmMessageWithGrid.MsgDlg(  var SelectedIds: TIntegerList): Integer;
begin
  With TfmMessageWithGrid.Create(nil) do try
  initMsgDlg;
  ShowModal;
  result :=  fiMsgResult;
  SelectedIds.CommaText :=IdsSelected;
finally
  Free;
end;

end;

class function TfmMessageWithGrid.MsgList(AOwner:TComponent): TfmMessageWithGrid;
begin
  result:= TfmMessageWithGrid.Create(AOwner);
  Result.initMsgDlg;
  Result.FormStyle := fsMDIChild;
  Result.bringToFront;
end;

class function TfmMessageWithGrid.MsgDlg: Integer;
begin
  result := inherited MsgDlg;
end;

procedure TfmMessageWithGrid.setMsgDs(const Value: TDataset);
var
  ctr:Integer;
  stFieldNames, stDisplayLabels:TStringlist;
  ilDisplayWidths:TIntegerList;
  i:Integer;
  FieldList: TStringList;
begin
  dsmain.dataset := Value;

  grdmain.DataSource := dsmain;
  grdmain.UseTFields := true;

  if Value.active =False then Value.open;
  stFieldNames:=TStringlist.Create;
  stDisplayLabels:=TStringlist.Create;
  ilDisplayWidths:=TIntegerList.Create;
  try
    stFieldNames.CommaText := Fieldnames;
    stDisplayLabels.Delimiter := ',';
    stDisplayLabels.DelimitedText := displayLabels;
    ilDisplayWidths.CommaText :=Displaywidths;
    for ctr:= 0 to Value.FieldCount-1 do begin
      i:= stFieldNames.IndexOf(Value.Fields[ctr].FieldName);
      if i >=0 then begin
        Value.Fields[ctr].Visible := True;
        Value.Fields[ctr].Displaylabel := stDisplayLabels[i];
        Value.Fields[ctr].DisplayWidth := ilDisplayWidths[i];

      end else begin
        Value.Fields[ctr].Visible := False;
      end;
    end;
    FieldList:= TStringList.create;
    try
      for ctr:= 0 to stDisplayLabels.Count-1 do FieldList.add(SelectedText(stFieldNames[ctr], stDisplayLabels[ctr] , ilDisplayWidths[ctr], '', True));
      grdmain.selected.text:=FieldList.Text;
      grdmain.ApplySelected;
    finally
      Freeandnil(fieldlist);
    end;
  finally
    Freeandnil(stFieldNames);
    Freeandnil(stDisplayLabels);
    Freeandnil(ilDisplayWidths);
  end;
end;


procedure TfmMessageWithGrid.SetMultiSelect(const Value: Boolean);
begin
  fbMultiSelect := Value;
  if not(dgMultiselect    in grdMain.Options) then grdMain.Options := grdMain.Options + [dgMultiselect];
  if not(dgRowSelect      in grdMain.Options) then grdMain.Options := grdMain.Options + [dgRowSelect];
  if not(msoAutoUnselect  in grdMain.MultiSelectOptions) then grdMain.MultiSelectOptions := grdMain.MultiSelectOptions + [msoAutoUnselect];
  if not(msoShiftSelect   in grdMain.MultiSelectOptions) then grdMain.MultiSelectOptions := grdMain.MultiSelectOptions + [msoShiftSelect];
end;

end.
