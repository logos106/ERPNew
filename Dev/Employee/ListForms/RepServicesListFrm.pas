{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 27/06/05  1.00.01 BJ   Added new field in the table to indicate a fixed rate service.
                        When a fixedrate service is selected in the appointment, the
                        Rate will not be multiplied by the time, just the rate is
                        the total amount.
}
unit RepServicesListFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar,
  DBAccess, MyAccess,ERPdbComponents, MemDS, wwDialog, Wwlocate,
  SelectionDialog, DNMPanel, wwdbdatetimepicker, ProgressDialog,
   wwdblook, Shader, kbmMemTable, DAScript, MyScript, wwcheckbox;

type
  TRepServicesListGUI = class(TBaseListingGUI)
    qryMainServiceID: TAutoIncField;
    qryMainDescription: TWideStringField;
    qryMainRate: TFloatField;
    qryMainRanking: TSmallintField;
    qryMainHardware: TWideStringField;
    qryMainSoftware: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainIsFixedRate: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses frmRepServicesFrm, CommonLib, Forms;

{$R *.dfm}

procedure TRepServicesListGUI.cmdNewClick(Sender: TObject);
var 
  Form: TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfrmRepServices');
    if Assigned(Form) then begin //if has acess
      with TfrmRepServices(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;    
end;

procedure TRepServicesListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TRepServicesListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TRepServicesListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TRepServicesListGUI);
end.
