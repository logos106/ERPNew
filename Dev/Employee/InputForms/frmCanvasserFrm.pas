unit frmCanvasserFrm;

{

 Date    Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 08/12/05  1.00.01 MV   Fixed tab order Tasker Tracker Issue 302

}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, Mask, DBCtrls, ExtCtrls, DBCGrids, ComCtrls,AdvOfficeStatusBar,
  BaseInputForm, wwdblook, DNMPanel, BaseListingForm, kbmMemTable,
  Buttons, DNMSpeedButton, MemDS, DBAccess, MyAccess,ERPdbComponents, Shader, Menus,
  AdvMenus, DataState, SelectionDialog, AppEvnts;

type
  TfrmCanvasser = class(TBaseInputGUI)
    cboCanvasserNameSrc: TDataSource;
    TabCtl20: TPageControl;
    Rep_Info: TTabSheet;
    Address_Info: TTabSheet;
    History: TTabSheet;
    subfrmTrainerHistorySrc: TDataSource;
    chkActive: TDBCheckBox;
    Label36: TLabel;
    cmdNew: TDNMSpeedButton;
    cmdNotes: TDNMSpeedButton;
    txtTrainerID: TDBEdit;
    txtTrainercode: TDBEdit;
    Label133: TLabel;
    EmployeeSrc: TDataSource;
    EmpID: TDBEdit;
    qryTrainerHistory: TERPQuery;
    qryEmployee: TERPQuery;
    qryCanvasser: TERPQuery;
    cboCanvasserName: TwwDBLookupCombo;
    DNMPanel1: TDNMPanel;
    Box76: TBevel;
    Box71: TBevel;
    Label65: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label135: TLabel;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DNMPanel2: TDNMPanel;
    Box72: TBevel;
    Box70: TBevel;
    Box69: TBevel;
    Label25: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label31: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label59: TLabel;
    edtNotes: TDBMemo;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DNMPanel3: TDNMPanel;
    pnlHistory: TDNMPanel;
    grpHistory: TRadioGroup;
    memQryCanvasser: TkbmMemTable;
    memQryCanvasserEmployeeID: TAutoIncField;
    memQryCanvasserCanvasser: TWideStringField;
    memQryCanvasserRepCode: TWideStringField;
    memQryCanvasserEmployeeName: TWideStringField;
    memQryCanvasserEditedFlag: TWideStringField;
    memQryEmployee: TkbmMemTable;
    memQryEmployeeCompany: TWideStringField;
    memQryEmployeeTitle: TWideStringField;
    memQryEmployeeFirstName: TWideStringField;
    memQryEmployeeLastName: TWideStringField;
    memQryEmployeePhone: TWideStringField;
    memQryEmployeeFaxNumber: TWideStringField;
    memQryEmployeeMobile: TWideStringField;
    memQryEmployeeAltContact: TWideStringField;
    memQryEmployeeNotes: TWideMemoField;
    memQryEmployeeStreet: TWideStringField;
    memQryEmployeeStreet2: TWideStringField;
    memQryEmployeeSuburb: TWideStringField;
    memQryEmployeePostcode: TWideStringField;
    memQryEmployeeState: TWideStringField;
    memQryEmployeeABN: TWideStringField;
    memQryEmployeeEmail: TWideStringField;
    memQryEmployeeEmployeeName: TWideStringField;
    memQryEmployeeCanvasser: TWideStringField;
    memQryEmployeeEditedFlag: TWideStringField;
    btnAddDateTime: TDNMSpeedButton;
    cmdOk: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    lblAddress3: TLabel;
    txtAddress3: TDBEdit;
    lblCountry: TLabel;
    txtCountry: TDBEdit;
    procedure cmdNotesClick(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure PostData;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RefreshQueries;
    procedure cboCanvasserNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure grpHistoryClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TabCtl20Change(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure btnAddDateTimeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    ffrmList0: TBaseListingGUI;
    ffrmList1: TBaseListingGUI;
  public
    { Public declarations }
        
  end;

implementation

{$R *.DFM}

uses FastFuncs,FormFactory, DNMExceptions,  AppointmentListForm, SourceListForm, 
  CommonLib, AppEnvironment;

procedure TfrmCanvasser.RefreshQueries;
begin
  CloseQueries;
  qryTrainerHistory.ParamByName('RepID').asInteger := KeyID;
  qryEmployee.ParamByName('EmpID').asInteger := KeyID;
  OpenQueries;
  cboCanvasserName.Text := qryEmployee.FieldByName('EmployeeName').AsString;
end; //RefreshQueries

procedure TfrmCanvasser.cboCanvasserNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  cboCanvasserName.Enabled := false;
  KeyID := qryCanvasser.FieldByName('EmployeeID').asInteger;
  RefreshQueries;
  qryEmployee.Edit;
  qryEmployee.FieldByName('Canvasser').AsString := 'T';
end;

procedure TfrmCanvasser.cmdNotesClick(Sender: TObject);
begin
  TabCtl20.ActivePageIndex := 0;
  SetControlFocus(edtNotes);
end;

procedure TfrmCanvasser.PostData;
begin
  try
    if qryEmployee.State = dsEdit then begin
      qryEmployee.Post;

      Notify;
    end;
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    else raise;
  end;
end;

procedure TfrmCanvasser.cmdOkClick(Sender: TObject);
begin
  PostData;
  Self.Close;
end;

procedure TfrmCanvasser.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    PostData;
    KeyID := 0;
    RefreshQueries;
    cboCanvasserName.Enabled := true;
    qryEmployee.Insert;
  finally
    EnableForm;
  end;  
end;

procedure TfrmCanvasser.cmdCancelClick(Sender: TObject);
begin
  Self.Close;
end;


procedure TfrmCanvasser.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      if qryCanvasser.Active then begin
        qryCanvasser.Post;
        Notify;
        CloseQueries;
      end;

      qryTrainerHistory.ParamByName('RepID').asInteger := KeyID;
      qryEmployee.ParamByName('EmpID').asInteger       := KeyID;
      OpenQueries;
      TabCtl20.ActivePageIndex := 0;
      SetControlFocus(edtNotes);
      if KeyID > 0 then begin
        cboCanvasserName.Text := qryEmployee.FieldByName('EmployeeName').AsString;
        cboCanvasserName.Enabled := false;
      end else begin
        cboCanvasserName.Enabled := true;
        SetControlFocus(cboCanvasserName);
      end;

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmCanvasser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TfrmCanvasser.grpHistoryClick(Sender: TObject);
var
  ffrmList: TBaseListingGUI;
begin
  ffrmList := nil;
  inherited;
  try
    case grpHistory.ItemIndex of
      0: 
        begin
          ffrmList := ffrmList0;
          ffrmList.FilterString := 'ClientID = ' + IntToStr(KeyID);
        end;
      1: 
        begin
          ffrmList := ffrmList1;
        end;
    end;

    if Assigned(ffrmList) then begin
      grpHistory.Color := ffrmList.pnlHeader.Color;
      ffrmList.Parent := pnlHistory;
      ffrmList.BorderStyle := bsNone;
      ffrmList.Show;
      ffrmList.edtSearch.Width := 120;
      ffrmList.lblcustomReport.Visible := False;
      ffrmList.cboCustomReports.Visible := False;      
    end;
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;
end;


procedure TfrmCanvasser.FormDestroy(Sender: TObject);
begin
  FreeandNil(ffrmList0);
  FreeandNil(ffrmList1);
  inherited;
end;

procedure TfrmCanvasser.TabCtl20Change(Sender: TObject);
begin
  inherited;
  if TabCtl20.ActivePage = TTabSheet(History) then begin
    grpHistoryClick(Sender);
  end;
end;

procedure TfrmCanvasser.FormKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
var
  cThisKey: char;
begin
  inherited;
  if Shift = [ssCtrl] then begin
    cThisKey := Chr(Key);
    Key      := 0;
    if cThisKey = 'R' then begin
      TabCtl20.ActivePageIndex := 0;
      TabCtl20Change(Sender);
      Exit;
    end;

    if cThisKey = 'A' then begin
      TabCtl20.ActivePageIndex := 1;
      TabCtl20Change(Sender);
      Exit;
    end;

    if cThisKey = 'H' then begin
      TabCtl20.ActivePageIndex := 2;
      TabCtl20Change(Sender);
      Exit;
    end;
  end;
end;

procedure TfrmCanvasser.btnAddDateTimeClick(Sender: TObject);
begin
  inherited;
  edtNotes.Lines.Text := edtNotes.Lines.Text + ' :- (' + AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName +
    ') ' + FormatDateTime('dddd mmmm d yyyy " at " hh:mm AM/PM', Now) + #13#10;
  qryEmployee.Edit;
  qryEmployee.FieldByName('Notes').AsString := edtNotes.Lines.Text;
  edtNotes.Update;
end;

procedure TfrmCanvasser.FormCreate(Sender: TObject);
begin
  inherited;
  if AppEnv.AccessLevels.GetEmployeeAccessLevel('TAppointmentListGUI') < 6 then
    ffrmList0 := TAppointmentListGUI.Create(pnlHistory);
  if AppEnv.AccessLevels.GetEmployeeAccessLevel('TSourceListGUI') < 6 then
    ffrmList1 := TSourceListGUI.Create(pnlHistory);


  {To Stop FindExistingComponent Finding This Instance}
  if Assigned(ffrmList0) then ffrmList0.Tag := 99;
  if Assigned(ffrmList1) then ffrmList1.Tag := 99;    
end;

initialization
  RegisterClassOnce(TfrmCanvasser);
  with FormFact do begin
    RegisterMe(TfrmCanvasser, 'TCanvasserListGUI_*=EmployeeID');
  end;
end.
