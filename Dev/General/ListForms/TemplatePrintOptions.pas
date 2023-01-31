unit TemplatePrintOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  Mask, wwdbedit, Wwdotdot, Wwdbcomb, ERPDbLookupCombo, dblookup, DBCtrls;

type

  TTemplateNotifyEvent = procedure (const ATemplateName, APrinterName : string) of object;

  TTempatePrintOptionsGUI = class(TBaseListingGUI)
    qryMainTemplName: TWideStringField;
    qryMainPrinterName: TWideStringField;
    qryMainPreview: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainPrint: TWideStringField;
    qryMainActive: TWideStringField;
    qryTemplates: TERPQuery;
    qryTemplatesTemplId: TIntegerField;
    qryTemplatesTemplName: TWideStringField;
    qryMainTemplId: TIntegerField;
    cbTemplates: TwwDBLookupCombo;
    cbPrinters: TwwDBComboBox;
    btnOK: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    cmdDelete: TERPCommand;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGridClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainKeyPress(Sender: TObject; var Key: Char);
    procedure grdMainMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure grdMainDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
    procedure chkActiveClick(Sender: TObject);
    procedure cbTemplatesCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdMainKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    fPrintersList: TStringList;
    fTemplateTypeId: integer;
    FNewConnection: TERPConnection;
    procedure SetNewConnection(const Value: TERPConnection);
    { Private declarations }
  protected
    procedure BuildPrintersTable;
    procedure Resize;override;
    function BooleanField(const AFieldName : string) : boolean;
    procedure PrepareQueries;
    property PrintersList : TStringList read fPrintersList write fPrintersList;
    property NewConnection : TERPConnection read FNewConnection write SetNewConnection;
  public
    { Public declarations }
    procedure RefreshQuery;override;
    property TemplateTypeId : integer read fTemplateTypeId write fTemplateTypeId;
  end;

  procedure DoReport(ATypeId : integer; APrintCallback, AEmailCallBack, APreviewCallBack : TTemplateNotifyEvent);

implementation

{$R *.dfm}
uses
  Printers, CommonLib, CommonDBLib;

const
  csQryMainAll    = 'SELECT PrintOptionsId, P.TemplId, TemplName, PrinterName, Preview, Email, Print, P.Active'#13#10+
                  'from tblTemplatePrintOptions P'#13#10 +
                  'inner join tblTemplates T on T.TemplId=P.TemplId'#13#10+
                  'order by TemplName';
  csQryMainParams = 'SELECT PrintOptionsId, P.TemplId, TemplName, PrinterName, Preview, Email, Print, P.Active'#13#10+
                  'from tblTemplatePrintOptions P'#13#10 +
                  'inner join tblTemplates T on T.TemplId=P.TemplId'#13#10+
                  'where T.TypeId=%d'#13#10+
                  'order by TemplName';
  csQryTemplatesAll='select TemplId, TemplName from tblTemplates order by TemplName';
  csQryTemplatesParams='select TemplId, TemplName from tblTemplates where TypeId=%d order by TemplName';

function GetPrintersList : TStringList;
var
  idx : integer;
begin
  Result := TStringList.Create;
  Result.Duplicates := dupIgnore;
  Result.CaseSensitive := false;
  Result.Sorted := true;

  for idx := 0 to Printer.Printers.Count  - 1 do
    Result.Add(Printer.Printers[idx]);
end;


function TTempatePrintOptionsGUI.BooleanField(
  const AFieldName: string): boolean;
begin
  Result := SameText(AFieldName, 'Preview') or
          SameText(AFieldName, 'Email') or
          SameText(AFieldName, 'Print') or
          SameText(AFieldName, 'Active');
end;

procedure TTempatePrintOptionsGUI.btnGridClick(Sender: TObject);
begin
  inherited;
  qryMain.Delete;
end;

procedure TTempatePrintOptionsGUI.btnOKClick(Sender: TObject);
begin

  if qryMain.State in [dsEdit, dsInsert] then
    qryMain.Post;
  cmdDelete.Execute;
  if qryMain.Connection.InTransaction then
    qryMain.Connection.Commit;
  Close;
end;

procedure TTempatePrintOptionsGUI.BuildPrintersTable;
var
  sl : TStringList;
  idx : integer;
  qry : TERPQuery;
begin
  sl := TStringList.Create;
  try
    sl.CaseSensitive := false;
    sl.Duplicates := dupIgnore;
    sl.Sorted := true;
    sl.Assign(PrintersList);
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := GetSharedMyDacConnection;
      qry.Close;
      qry.SQL.Text := 'select distinct PrinterName from tblTemplatePrintOptions';
      qry.Open;

      while not qry.eof do
      begin
        sl.Add(qry.Fields[0].asString);
        qry.Next;
      end;

    finally
      qry.Free;
    end;

    for idx := 0 to sl.Count - 1 do
      cbPrinters.Items.Add(sl[idx]);

//    for idx := 0 to  grdmain.Co

  finally
    sl.Free;
  end;
end;

procedure TTempatePrintOptionsGUI.cbTemplatesCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  qryMainTemplId.AsInteger := qryTemplatesTemplId.AsInteger;
end;

procedure TTempatePrintOptionsGUI.chkActiveClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TTempatePrintOptionsGUI.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if qryMain.State in [dsEdit, dsInsert] then
    qryMain.Post;
  if qryMain.Connection.InTransaction then
    qryMain.Connection.Rollback;
  Close;
end;

procedure TTempatePrintOptionsGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if qryMain.Connection.InTransaction  then
    qryMain.Connection.Rollback;
end;

procedure TTempatePrintOptionsGUI.FormCreate(Sender: TObject);
begin
  NewConnection := GetNewMyDacConnection(self);
  inherited;
  PrintersList := GetPrintersList;
end;

procedure TTempatePrintOptionsGUI.FormDestroy(Sender: TObject);
begin
  PrintersList.Free;
  inherited;
end;

procedure TTempatePrintOptionsGUI.FormShow(Sender: TObject);
var
  idx : integer;
begin
  for idx := 0 to ComponentCount - 1 do
    if Components[idx] is TERPQuery then
//      if TERPQuery(Components[idx]).Connection=MyConnection1 then
        TERPQuery(Components[idx]).Connection := NewConnection;

  SearchMode := smFullList;
  qryMain.Connection.StartTransaction;

  PrepareQueries;
  inherited;
//
  BuildPrintersTable;


  qryMain.Open;
  qryTemplates.Open;
  cmdDelete.Connection := qryMain.Connection;
  qryMain.Edit;
end;

procedure TTempatePrintOptionsGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin

  if SameText(Field.FieldName, 'PrinterName') then
  begin
    if PrintersList.IndexOf(Field.AsString) < 0 then
    begin
      AFont.Color := clSilver;
    end
    else
      AFont.Color := clWindowText;
  end;
  inherited;
end;

procedure TTempatePrintOptionsGUI.grdMainDrawDataCell(Sender: TObject;
  const Rect: TRect; Field: TField; State: TGridDrawState);
const
  CtrlState: array[Boolean] of integer = (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED) ;
begin
  if (Field.DataType=ftBoolean) or
     (BooleanField(Field.FieldName)) then
  begin
    grdMain.Canvas.FillRect(Rect) ;
    if Field.IsNull then
      DrawFrameControl(grdMain.Canvas.Handle,Rect, DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_INACTIVE) {grayed}
    else
      DrawFrameControl(grdMain.Canvas.Handle,Rect, DFC_BUTTON, CtrlState[Field.AsBoolean]) ; {checked or unchecked}
  end;
  (*
  else if SameText(Field.FieldName, 'PrinterName') then
  begin
    if PrintersList.IndexOf(Field.AsString) < 0 then
      grdMain.Font.Color := clSilver
    else
      grdMain.Font.Color := clWindowText;
  end
  else
  begin
    grdMain.Font.Color := clWindowText;
    inherited;
  end;
  *)
end;

procedure TTempatePrintOptionsGUI.grdMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  if BooleanField(ActiveFieldName) and (Key=VK_SPACE) then
//    exit;
  inherited;

end;

procedure TTempatePrintOptionsGUI.grdMainKeyPress(Sender: TObject;
  var Key: Char);
begin
  if SameText(ActiveFieldName, 'PrinterName') or SameText(ActiveFieldName, 'TemplName') then
    exit
  else
    inherited;
end;

procedure TTempatePrintOptionsGUI.grdMainMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button <> mbLeft then
    inherited
  else if BooleanField(ActiveFieldName) then
  begin
    if qryMain.State = dsBrowse then
      qryMain.Edit;

    ActiveField.AsBoolean := not ActiveField.AsBoolean;

  end
  else
    inherited;
end;

procedure TTempatePrintOptionsGUI.PrepareQueries;
begin
  if TemplateTypeId=0 then
  begin
    qryMain.SQL.Text := csQryMainAll;
    qryTemplates.SQL.Text := csQryTemplatesAll;
  end
  else
  begin
    qryMain.SQL.Text := Format(csQryMainParams, [TemplateTypeId]);
    qryTemplates.SQL.Text := Format(csQryTemplatesParams, [TemplateTypeId]);
  end;

end;

procedure TTempatePrintOptionsGUI.RefreshQuery;
begin
  inherited;

end;

procedure TTempatePrintOptionsGUI.Resize;
begin
  inherited;
  HeaderPanel.Width := TitleLabel.Canvas.TextWidth(TitleLabel.Caption) + 12;
  HeaderPanel.Left := (Self.ClientRect.Right - Self.ClientRect.Left - HeaderPanel.Width) div 2;
end;

procedure TTempatePrintOptionsGUI.SetNewConnection(const Value: TERPConnection);
begin
  FNewConnection := Value;
end;

//=================================================//
procedure DoReport(ATypeId : integer; APrintCallback, AEmailCallBack, APreviewCallBack : TTemplateNotifyEvent);
var
  qry : TERPQuery;
  lPrinters : TStringList;
  templ,
  prn : string;

  function Run(const Name : string) : boolean;
  begin
    Result := qry.FieldByName(Name).AsString = 'T';
  end;

begin

  if ATypeId = 0 then
    exit;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.SQL.Text := Format(csQryMainParams, [ATypeId]);
    qry.Open;
    if qry.RecordCount > 0 then
      lPrinters := GetPrintersList
    else
      exit;
    try
      while not qry.eof do
      begin
        if qry.FieldByName('Active').asString = 'F' then
        begin
          qry.Next;
          Continue;
        end;
        templ := qry.FieldByName('TemplName').AsString;
        prn := qry.FieldByName('PrinterName').AsString;
        if Run('Print') and (@APrintCallBack <> nil) and (lPrinters.IndexOf(prn) >= 0) then
          APrintCallBack(templ, prn);
        if Run('Preview') and (@APreviewCallBack <> nil) then
          APreviewCallBack(templ, prn);
        if Run('Email') and (@AEmailCallBack <> nil) then
          AEmailCallBack(templ, prn);

        qry.Next;
      end;
    finally
      lPrinters.Free;
    end;
  finally
    qry.Free;
  end;

end;

initialization
  RegisterClassOnce(TTempatePrintOptionsGUI);
end.
