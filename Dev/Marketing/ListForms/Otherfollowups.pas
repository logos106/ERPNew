unit Otherfollowups;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DAScript, MyScript;

type
  TOtherfollowupsGUI = class(TBaseListingGUI)
    qryMainFollowUpID: TIntegerField;
    qryMainOtherContactID: TIntegerField;
    qryMainRepairID: TIntegerField;
    qryMainEmployeeID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainFollowUpDate: TDateTimeField;
    qryMainDone: TWideStringField;
    qryMainAppearDays: TIntegerField;
    qryMainCreationDate: TDateTimeField;
    qryMainUpdateDate: TDateField;
    qryMainIsSupplier: TWideStringField;
    qryMainIsOtherContact: TWideStringField;
    qryMainIsCustomer: TWideStringField;
    qryMainCategory: TWideStringField;
    qryMainHours: TFloatField;
    qryMainIsPhoneFollowUp: TWideStringField;
    qryMainCustomField1: TWideStringField;
    qryMainCustomField2: TWideStringField;
    qryMainCustomField3: TWideStringField;
    qryMainCustomField4: TWideStringField;
    qryMainCustomField5: TWideStringField;
    qryMainCustomField6: TWideStringField;
    qryMainCustomField7: TWideStringField;
    qryMainCustomField8: TWideStringField;
    qryMainCustomField9: TWideStringField;
    qryMainCustomField10: TWideStringField;
    qryMainClientName: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainResultTypeName: TWideStringField;
    qryMaintypeName: TWideStringField;
    qryMainNotes: TWideMemoField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
  private
    { Private declarations }
  Protected
    Procedure SetGridColumns;Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TOtherfollowupsGUI }

procedure TOtherfollowupsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('FollowUpID');
  RemoveFieldfromGrid('OtherContactID');
  RemoveFieldfromGrid('EmployeeID');
  RemoveFieldfromGrid('ClientID');
end;

procedure TOtherfollowupsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  qryMainCreationDate.Displayformat:= FormatSettings.ShortDateformat;
end;

procedure TOtherfollowupsGUI.grdMainDblClick(Sender: TObject);
begin
  if qryMainIsSupplier.asboolean then SubsequentID := Chr(95) + 'Supplier'
  else if qryMainIsCustomer.asboolean then SubsequentID := Chr(95) + 'Customer'
  else if qryMainIsOtherContact.asboolean then SubsequentID := Chr(95) + 'Other Contact'
  else if qryMainEmployeeID.asInteger <> 0 then SubsequentID := Chr(95) + 'Employee'
  else if qryMainRepairID.asInteger <> 0 then SubsequentID := Chr(95) + 'Repair'
  else SubsequentID := '';
  inherited;

end;

initialization
  RegisterClassOnce(TOtherfollowupsGUI);

end.
