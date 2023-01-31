unit UserPasswordDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TUserPasswordDetailsGUI = class(TBaseListingGUI)
    qryMainemployeeId: TIntegerField;
    qryMainEmployeeName: TWideStringField;
    qryMainPasswordDate: TDateField;
    qryMainusername: TWideStringField;
    qryMainuserpassword: TWideStringField;
    qryMainLoginExpireDays: TWideMemoField;
    qryMainLoginExpireon: TDateTimeField;
    qryMainPasswordNeverExpires: TWideStringField;
    qryMainCanChangePassword: TWideStringField;
    qryMainLoginExpiredDays: TIntegerField;
    qryMainIsPasswordExpired: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
  private
  Protected
    procedure SetGridColumns; Override;
  public
  end;


implementation

uses CommonLib;

{$R *.dfm}
procedure TUserPasswordDetailsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
  fbSaveListSortOrder := True;
end;

procedure TUserPasswordDetailsGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  if qrymainLoginExpiredDays.asInteger <0 then
      qrymainIsPasswordExpired.asString := 'T' else qrymainIsPasswordExpired.asString := 'F';
end;

procedure TUserPasswordDetailsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainemployeeId.fieldname);
  RemoveFieldfromGrid(qryMainuserpassword.fieldname);
end;

initialization
  RegisterClassOnce(TUserPasswordDetailsGUI);

end.
