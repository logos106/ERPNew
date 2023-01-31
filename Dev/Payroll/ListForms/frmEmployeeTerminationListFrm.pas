unit frmEmployeeTerminationListFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton;

type
  TfrmEmployeeTerminationList = class(TBaseListingGUI)
    qryMainEmployeeName: TWideStringField;
    qryMainStartDate: TDateTimeField;
    qryMainEndDate: TDateTimeField;
    qryMainReasonLeft: TWideStringField;
    qryMainIsPayEntitled: TWideStringField;
    qryMainPayID: TIntegerField;
    qryMainTerminationID: TIntegerField;
    qryMainComplete: TWideStringField;
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}
uses
  CommonLib, frmEmployeeTerminate, CommonFormLib;

procedure TfrmEmployeeTerminationList.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmEmployeeTerminationList.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmEmployeeTerminationList.cmdNewClick(Sender: TObject);
var
  form: TfrmEmployeeTerminateGUI;
begin
  DisableForm;
  try
    inherited;
    form := TfrmEmployeeTerminateGUI(GetComponentByClassName('TfrmEmployeeTerminateGUI'));
    If not Assigned(form) then Exit;
    with form do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmEmployeeTerminationList.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmEmployeeTerminationList.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('TerminationID');
end;

procedure TfrmEmployeeTerminationList.grdMainDblClick(Sender: TObject);
begin
  inherited;
//  CommonFormLib.OpenERPForm('TfmTerminationWizard',qryMainTerminationID.AsInteger);
end;

initialization
  RegisterClassOnce(TfrmEmployeeTerminationList);
end.
