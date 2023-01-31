// Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 07/09/05  1.00.## ISB	Modified To Work With New Filtering on Baselisting.

unit CanvasserListFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, PrintDAT, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ImgList, ActnList, Menus, AdvMenus, ComCtrls,AdvOfficeStatusBar,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable;

type
  TCanvasserListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    qryMainEmployeeName: TWideStringField;
    qryMainAddress: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainState: TWideStringField;
    qryMainPostcode: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainFaxNumber: TWideStringField;
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

uses Forms, frmCanvasserFrm, CommonLib;

{$R *.dfm}

procedure TCanvasserListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfrmCanvasser');
    if Assigned(Form) then begin //if has acess
      with TfrmCanvasser(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
    //  MainForm.Canvasser1Click(Sender);
  finally
    EnableForm;
  end;  
end;

procedure TCanvasserListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TCanvasserListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TCanvasserListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TCanvasserListGUI);

end.
