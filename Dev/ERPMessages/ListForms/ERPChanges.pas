unit ERPChanges;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ERPMessages, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,
  CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList,
  AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel, ERPChangesBase,
  wwclearbuttongroup, wwradiogroup, Mask, wwdbedit, DNMAction, GIFImg;

type
  TERPChangesGUI = class(TERPChangesBaseGUI)
    Label2: TLabel;
    qryMainerphelpdocDesc: TWideStringField;
    actChanges: TDNMAction;
    btnhistory: TDNMSpeedButton;
    pnlShowVideoMenuAtStartup: TDNMPanel;
    chkShowVideoMenuAtStartup: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);
    procedure actChangesUpdate(Sender: TObject);
    procedure actChangesExecute(Sender: TObject);
    procedure qryMainAfterScroll(DataSet: TDataSet);
    procedure chkShowVideoMenuAtStartupClick(Sender: TObject);
  private
    function ShowERPHelp: Boolean;
  Protected
    procedure SetGridColumns; Override;
  public
  end;


implementation

uses ERPMessageTypes, CommonLib, CommonFormLib, DocReaderObj, tcConst,
  AppEnvironment;

{$R *.dfm}

procedure TERPChangesGUI.actChangesExecute(Sender: TObject);
begin
  inherited;
  if ShowERPHelp then exit;
end;

procedure TERPChangesGUI.actChangesUpdate(Sender: TObject);
begin
  inherited;
  //actChanges.enabled := qryMainerphelpdocDesc.AsString<> '';
(*  if Trim(qryMainerphelpdocDesc.asString)<> '' then begin
    btnhistory.color := GridColhighLightGreen;
    btnhistory.ParentColor := false;
    btnhistory.Transparent := False;
    btnhistory.HotTrackColor := GridColhighLightGreen;
   end  else begin
    btnhistory.color := clBlack;
    btnhistory.ParentColor := True;
    btnhistory.Transparent := True;
    btnhistory.HotTrackColor := clBtnShadow;
   end;*)


end;

procedure TERPChangesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Tasktype:=ERPMESSAGE_Bug;
  Tasktype2:=ERPMESSAGE_FEATURE;
end;

procedure TERPChangesGUI.FormShow(Sender: TObject);
begin
  inherited;
  grpfilters.itemindex := 1;
  //OpenERPFormModal('TfmERPChangeshint' , 0, nil);
  chkShowVideoMenuAtStartup.checked := not (AppEnv.Employee.ShowVideoMenuAtStartup);
end;

procedure TERPChangesGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  //if sametext(Field.fieldname, qryMainOpenHelpDoc.fieldname ) then
  if (Trim(qryMainerphelpdocDesc.asString)<> '') and not(sametext(field.fieldname ,qryMainVersionno.fieldname)) then
    //DoGreenhighlight(Afont, ABrush);
    ABrush.color := clYellow;
    Afont.color := clBlack;
end;

procedure TERPChangesGUI.grdMainDblClick(Sender: TObject);
begin
  if ShowERPHelp then exit;
  inherited;
end;
procedure TERPChangesGUI.qryMainAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if Trim(qryMainerphelpdocDesc.asString)<> '' then begin
    //shapehint.Pen.color := GridColhighLightGreen;
    highlightcontrol(btnhistory);
  end else begin
    hidehighlightcontrol;
    //shapehint.Pen.color := clYellow;
  end;
end;

function TERPChangesGUI.ShowERPHelp:Boolean;
begin
    Result := False;
    if qryMainerphelpdocDesc.AsString <> '' then
      REsult := TDocReaderObj.ShowERPHelp(nil, Self, true, qryMainerphelpdocDesc.AsString)
    else ListTimerMsg('No Help Provided for '+NL+  quotedstr(qryMainDetails.asString));
end;

procedure TERPChangesGUI.chkShowVideoMenuAtStartupClick(Sender: TObject);
begin
  inherited;
  AppEnv.Employee.ShowVideoMenuAtStartup  := not(chkShowVideoMenuAtStartup.checked);
end;

procedure TERPChangesGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainerphelpdocDesc.fieldname);
end;

initialization
  RegisterClassOnce(TERPChangesGUI);

end.
