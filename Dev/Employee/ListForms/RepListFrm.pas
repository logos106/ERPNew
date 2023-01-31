unit RepListFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, PrintDAT, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ImgList, ActnList, Menus, AdvMenus, ComCtrls,AdvOfficeStatusBar,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel,
  DBAccess, MyAccess,ERPdbComponents, MemDS, wwdbdatetimepicker, ProgressDialog,
   wwdblook, Shader, kbmMemTable, DAScript, MyScript, wwcheckbox;

type
  TRepListGUI = class(TBaseListingGUI)
    grpFilter: TRadioGroup;
    qryMainEmployeeID: TAutoIncField;
    qryMainEmployeeName: TWideStringField;
    qryMainAddress: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainState: TWideStringField;
    qryMainPostcode: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainCountry: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdNewClick(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RepListGUI: TRepListGUI;

implementation

uses frmRepFrm, CommonLib, frmAppointments;

{$R *.dfm}

procedure TRepListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  RepListGUI := nil;
end;

procedure TRepListGUI.cmdNewClick(Sender: TObject);
var 
  Form: TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfrmRep');
    if Assigned(Form) then begin //if has acess
      with TfrmRep(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
    //  MainForm.Representative1Click(Sender);
  finally
    EnableForm;
  end;  
end;

procedure TRepListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TRepListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TRepListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TRepListGUI);
end.
