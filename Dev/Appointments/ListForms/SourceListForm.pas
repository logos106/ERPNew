unit SourceListForm;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 07/09/05  1.00.01 IJB  Modified to use new filtering on base listing.
 }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB,   Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar, ImgList, Menus, AdvMenus, ActnList,
  PrintDAT, Mask, wwdbedit, Wwdbspin, wwDataInspector,
  wwcheckbox, wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS,
  DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,UserLockObj,
   wwdblook, Shader, kbmMemTable, DAScript, MyScript, CustomInputBox;

type
  TSourceListGUI = class(TBaseListingGUI)
    edtEnquiries: TwwDBSpinEdit;
    qryMainMedTypeID: TAutoIncField;
    qryMainAccountName: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainEnquiries: TLargeIntField;
    qryMainSourceName: TWideStringField;
    qryMainAppointmentCount: TLargeIntField;
    dsToggleSource: TDataSource;
    btnExpand: TwwExpandButton;
    grdInspector: TwwDataInspector;
    qryMainSuccessRate: TFloatField;
    qryMainAccount: TIntegerField;
    qryMainCostEx: TCurrencyField;
    qryMainCostInc: TCurrencyField;
    qryBalances: TERPQuery;
    qryToggleSource: TERPQuery;
    qryToggleSourceMedTypeID: TAutoIncField;
    qryToggleSourceEnquires: TLargeIntField;
    qryMainGlobalRef: TWideStringField;
    qryMainEstimatedCost: TFloatField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExpandBeforeExpand(Sender: TObject);
    procedure btnExpandAfterCollapse(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
    UserLock: TUserLock;
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

implementation

uses
  frmSourceFrm,CommonLib;

{$R *.dfm}
procedure TSourceListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;
end;

procedure TSourceListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not ErrorOccurred then begin
    qryToggleSource.Close;
    qryBalances.Close;
  end;

  inherited;
end;

procedure TSourceListGUI.cmdNewClick(Sender: TObject);
var 
  Form: TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfrmSource');
    if Assigned(Form) then begin
      with TfrmSource(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TSourceListGUI.FormShow(Sender: TObject);
begin
  if not UserLock.Lock('tblSource',0,'Source List') then begin
    AccessLevel:= 6;
    CommonLib.MessageDlgXP_Vista('Currently the User "' + UserLock.LockInfo.Username + '" is Editing the Source List. Try Again Later.', mtWarning, [mbOK], 0);
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
    Exit;
  end;

  inherited;
  if ErrorOccurred then Exit;
  if fbFormOpenedOk then begin
    qryToggleSource.Connection := qryMain.Connection;
    qryToggleSource.Open;
  end;
end;

procedure TSourceListGUI.btnExpandBeforeExpand(Sender: TObject);
begin
  inherited;
  qryToggleSource.Close;
  qryToggleSource.Params.ParamByName('xMedTypeID').AsInteger := qryMain.FieldByName('MedTypeID').AsInteger;
  qryToggleSource.Open;
end;

procedure TSourceListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('xStartDate').AsDateTime := dtFrom.DateTime;
  qryMain.Params.ParamByName('xEndDate').AsDateTime := dtTo.DateTime;

  qryBalances.Connection := qryMain.Connection;
  qryBalances.Close;
  qryBalances.Params.ParamByName('dtFrom').AsDateTime := dtFrom.DateTime;
  qryBalances.Params.ParamByName('dtTo').AsDateTime := dtTo.DateTime;
  qryBalances.Open;
  inherited;
  qryMainEstimatedCost.DisplayLabel :=   'Estimated Cost (Ex)';
end;

procedure TSourceListGUI.btnExpandAfterCollapse(Sender: TObject);
begin
  inherited;
  if qryMain.FieldByName('MedTypeID').AsInteger > 0 then begin
    if qryToggleSource.Modified then begin
      qryToggleSource.Post;
      qryToggleSource.Edit;
      RefreshQuery;
    end;
  end;
end;

procedure TSourceListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainSuccessRate.AsFloat := DivZer(qryMainAppointmentCount.AsFloat, qryMainEnquiries.AsFloat) * 100;
end;

procedure TSourceListGUI.FormCreate(Sender: TObject);
begin
  qryBalances.SQL.text := ChangeQuery(qryBalances.SQL.text);
  inherited;
  UserLock := TUserLock.Create(self);
  UserLock.Enabled := True;
end;

procedure TSourceListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TSourceListGUI.cmdExportClick(Sender: TObject);
begin
  Disableform;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TSourceListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TSourceListGUI);
end.
