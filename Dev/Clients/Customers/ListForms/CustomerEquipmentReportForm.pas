unit CustomerEquipmentReportForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls, StdCtrls, ExtCtrls, DNMPanel, DBAccess, MyAccess, MemDS,
  wwdbdatetimepicker, ProgressDialog, CustomInputBox, wwdblook, Shader;

type
  TCustomerEquipmentGUI = class(TBaseListingGUI)
    procedure grdMainDblClick(Sender: TObject); override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  CustomerEquipmentGUI: TCustomerEquipmentGUI;

implementation

uses CommonLib;

{$R *.dfm}

procedure TCustomerEquipmentGUI.grdMainDblClick(Sender: TObject);
begin
  if not (grdMain.GetActiveField.FieldName = 'Notes') then begin
    SubsequentID := Chr(95) + qryMain.Fields.FieldByName('IsJob').AsString;
    inherited;
  end;
end;

procedure TCustomerEquipmentGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  CustomerEquipmentGUI := nil;
end;

initialization
  RegisterClassOnce(TCustomerEquipmentGUI);
end.
