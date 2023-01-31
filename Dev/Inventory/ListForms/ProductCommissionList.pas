unit ProductCommissionList;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 16/03/05  1.00.00 IJB  Initial verson.


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup;

type
  TProductCommissionListGUI = class(TBaseListingGUI)
    qryMainProductCommissionId: TIntegerField;
    qryMainPartsId: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainIsPercentage: TWideStringField;
    qryMainCommissionRate: TFloatField;
    qryMainActive: TWideStringField;
    qryMainManufacturer: TWideStringField;
    qryMainType: TWideStringField;
    qryMainDept: TWideStringField;
    qryMainEmployeeId: TLargeintField;
    qryMainForAllEmployees: TWideStringField;
    qryMainPartname: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainemployeename: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure qryMainCommissionRateGetText(Sender: TField; var Text: string; DisplayText: boolean);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure grdMainDrawDataCell(Sender: TObject; const Rect: TRect; Field: TField; State: TGridDrawState);
  private
    { Private declarations }
  Protected
    Procedure SetGridColumns;override;
  public
    { Public declarations }
    procedure RefreshQuery; override;
  end;

//var
//  fmProductCommissionList: TProductCommissionListGUI;

implementation

{$R *.dfm}

uses FastFuncs,frmProductCommission, tcConst, CommonLib;

procedure TProductCommissionListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Self.DefaultMaxGridColumnWidth := 40;
end;

procedure TProductCommissionListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TProductCommissionListGUI.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

procedure TProductCommissionListGUI.RefreshQuery;
begin
  inherited;
  grdMain.DataSource.DataSet.DisableControls;
  try
    qryMain.Close;
    qryMain.ParamByName('Active').AsString := grpFilters.Items[grpFilters.ItemIndex];
    qryMain.Open;
  finally
    grdMain.DataSource.DataSet.EnableControls;
  end;
end;

procedure TProductCommissionListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmProductCommission');
  if Assigned(Form) then begin //if has acess
    with TfmProductCommission(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      KeyId     := 0;
      BringToFront;
    end;
  end;  
end;

procedure TProductCommissionListGUI.qryMainCommissionRateGetText(Sender: TField; var Text: string; DisplayText: boolean);
begin
  inherited;
  if qryMainIsPercentage.AsBoolean then Text := FormatFloat('###0.00###"%"', Sender.AsFloat)
  else Text := FormatFloat('"$"####,###,###,##0.00', Sender.AsFloat);
end;

procedure TProductCommissionListGUI.grpFiltersClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TProductCommissionListGUI.grdMainDrawDataCell(Sender: TObject; const Rect: TRect; Field: TField; State: TGridDrawState);
begin
  inherited;
  if Sysutils.SameText(Field.FieldName, 'CommisionRate') then TCurrencyField(Field).DisplayFormat := FIELD_MASK_PERCENT;
end;

procedure TProductCommissionListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ProductcommissionId');
  RemoveFieldfromGrid('PartsId');
  RemoveFieldfromGrid('Globalref');
  RemoveFieldfromGrid('EmployeeId');
  RemoveFieldfromGrid('mstimestamp');
end;

initialization
  RegisterClassOnce(TProductCommissionListGUI);
end.

