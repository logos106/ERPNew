unit ScheduledReports;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel, DBCtrls,
  CustomInputBox, wwclearbuttongroup, wwradiogroup;

type
  TScheduledReportsGUI = class(TBaseListingGUI)
    btnreports: TDNMSpeedButton;
    qryMainEmployeeName: TWideStringField;
    qryMainFormName: TWideStringField;
    qryMainStartDate: TDateTimeField;
    qryMainEndDate: TDateTimeField;
    qryMainLastEmaileddate: TDateTimeField;
    qryMainNextDueDate: TDateTimeField;
    qryMainlastEmailStatus: TWideStringField;
    edtLastEmailStatus: TDBText;
    qryMainEmployeeId: TIntegerField;
    qryMainFormID: TIntegerField;
    qryMainContinueIndefinitely: TWideStringField;
    procedure btnreportsClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, MainSwitchFrm2, frmReportSelectorFrm, tcConst;

{$R *.dfm}

{ TScheduledReportsGUI }

procedure TScheduledReportsGUI.btnreportsClick(Sender: TObject);
begin
  inherited;
  MainSwitch2.btnReports.Click;
end;


procedure TScheduledReportsGUI.FormShow(Sender: TObject);
begin
  inherited;
  qryMainStartDate.displayFormat := formatSettings.ShortDateFormat;
  qryMainEndDate.displayFormat := formatSettings.ShortDateFormat;
  qryMainLastEmaileddate.displayFormat := formatSettings.ShortDateFormat;
  qryMainNextDueDate.displayFormat := formatSettings.ShortDateFormat;
  edtLastEmailStatus.Visible := devmode;
end;

procedure TScheduledReportsGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if qryMainNextDueDate.AsDateTime > now then Afont.Color := clInactiveCaption;
  if sametext(copy(QrymainlastEmailStatus.AsString+'       ' , 1, 7) , 'Failed:') then
    if SAmetext(field.fieldname,QrymainLastEmaileddate.FieldName) or
       SAmetext(field.fieldname,QrymainlastEmailStatus.FieldName) then
      Afont.Color := clRed;
end;

procedure TScheduledReportsGUI.grdMainDblClick(Sender: TObject);
begin
//  inherited;
  if Sametext(ActiveFieldname , qryMainlastEmailStatus.FieldName) and (qryMainlastEmailStatus.asString <> '') then
    commonlib.MessageDlgXP_Vista(qryMainEmployeeName.AsString +'''s ' + qryMainlastEmailStatus.displaylabel+ ' of ' + qryMainformname.AsString + NL+NL+ qryMainlastEmailStatus.asString , mtInformation , [mbok] ,0)
  else  btnreports.Click;
end;

procedure TScheduledReportsGUI.RefreshQuery;
begin
  inherited;
end;

procedure TScheduledReportsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainemployeeID.fieldname);
  RemoveFieldfromGrid(QrymainformId.fieldname);
end;

initialization
  RegisterClassOnce(TScheduledReportsGUI);
end.

