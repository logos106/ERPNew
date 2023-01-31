unit frmAwardsListFrm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 25/05/05  1.00.01 DSP  Fixed problem with grpFilter not calling
                        ApplyGroupFilter after setting GroupFilterString.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, wwcheckbox,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable;

type
  TfrmAwardsList = class(TBaseListingGUI)
    grpFilter: TRadioGroup;
    qryMainAwardName: TWideStringField;
    qryMainDepartment: TWideStringField;
    qryMainPayPeriod: TWideStringField;
    qryMainSuperType: TWideStringField;
    qryMainSuperValue: TWideStringField;
    qryMainActive: TWideStringField;
    chkActive: TwwCheckBox;
    qryMainAwardID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure grpFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses Forms, frmAwardsFrm, CommonLib;

{$R *.dfm}

procedure TfrmAwardsList.cmdNewClick(Sender: TObject);
var tmpComponent:TComponent;
begin
  DisableForm;
  try
    inherited;
    tmpComponent:=GetComponentByClassName('TfrmAwards');
    if not assigned(tmpComponent) then exit;
    with TfrmAwards(tmpComponent) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmAwardsList.grpFilterClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilter.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Active=' + QuotedStr('T');
      end;
    1: 
      begin
        GroupFilterString := 'Active=' + QuotedStr('F');
      end;
  end;

  ApplyQueryFilter;
  inherited;
end;

procedure TfrmAwardsList.FormShow(Sender: TObject);
begin
  inherited;
  if not qryMain.Active then Exit;
  qryMain.FieldByName('Active').DisplayWidth := 8;
  grdMain.SetControlType('Active', fctCustom, 'chkActive');
  grdMain.Invalidate;
  grdMain.RefreshDisplay;
  grpFilterClick(Sender);
  //  except
  //    on EAbort do HandleEAbortException;
  //    on e: ENoAccess do HandleNoAccessException(e);
  //    on e: Exception do HandleUnknownException(e);
  //  end;
end;

procedure TfrmAwardsList.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmAwardsList.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmAwardsList.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TfrmAwardsList);
end.
