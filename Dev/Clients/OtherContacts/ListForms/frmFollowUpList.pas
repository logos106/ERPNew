unit frmFollowUpList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, BaseListingForm, ProgressDialog, 
  wwdblook, Shader, kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TfmFollowUpList = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainFollowUpID: TIntegerField;
    qryMainOtherContactID: TIntegerField;
    qryMainRepairID: TIntegerField;
    qryMainEmployeeID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainFollowUpDate: TDateTimeField;
    qryMainDone: TWideStringField;
    qryMainEditedFlag: TWideStringField;
    qryMainAppearDays: TIntegerField;
    qryMainCreationDate: TDateTimeField;
    qryMainUpdateDate: TDateField;
    qryMainIsSupplier: TWideStringField;
    qryMainIsOtherContact: TWideStringField;
    qryMainIsCustomer: TWideStringField;
    qryMainHours: TFloatField;
    qryMainTypeId: TIntegerField;
    qryMainResultTypeId: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainResultTypeName: TWideStringField;
    qryMainDuration: TDateTimeField;
    qryMainNotes: TWideMemoField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses frmFollowUp, CommonLib;

procedure TfmFollowUpList.FormCreate(Sender: TObject);
begin
  inherited;
  //
  DefaultMaxGridColumnWidth := 52;
end;

procedure TfmFollowUpList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  //
  Action := caFree;
end;

procedure TfmFollowUpList.FormShow(Sender: TObject);
begin
  if Self.ErrorOccurred then Exit;
  qryMain.Close;
  qryMain.ParamByName('DTFrom').AsDate := dtFrom.Date;
  qryMain.ParamByName('DTTo').AsDateTime := (dtTo.Date + 0.999999999);
  qryMain.ParamByName('Done').AsString := grpFilters.Items[grpFilters.ItemIndex];
  inherited;
  //
end;

procedure TfmFollowUpList.RefreshQuery;
begin
  qryMain.Close;
  qryMain.ParamByName('DTFrom').AsDate := FilterDateFrom;
  qryMain.ParamByName('DTTo').AsDateTime := filterDateTo;
  qryMain.ParamByName('Done').AsString := grpFilters.Items[grpFilters.ItemIndex];
  inherited;
end;

procedure TfmFollowUpList.grpFiltersClick(Sender: TObject);
begin
  inherited;
  Self.RefreshQuery;
end;

procedure TfmFollowUpList.cmdNewClick(Sender: TObject);
var
  aClientId, aFollowUpId: integer;
begin
  inherited;
  aClientId := 0;
  aFollowUpId := 0;
  frmFollowUp.DoPhoneFollowUp(true, aClientId, aFollowUpId);
end;

procedure TfmFollowUpList.grdMainDblClick(Sender: TObject);
var
  aClientId, aFollowUpId: integer;
begin
  //inherited;
  aClientId := 0;
  aFollowUpId := qryMain.FieldByName('FollowUpId').AsInteger;
  frmFollowUp.DoPhoneFollowUp(false, aClientId, aFollowUpId);
end;

initialization
  RegisterClassOnce(TfmFollowUpList);
end.
