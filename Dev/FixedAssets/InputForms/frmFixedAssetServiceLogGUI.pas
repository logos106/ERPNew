unit frmFixedAssetServiceLogGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB,  SelectionDialog, AppEvnts, StdCtrls,
  DBCtrls, Mask, wwdblook, wwdbdatetimepicker, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel,
  DBAccess, MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, MemDS, Shader,
  ImgList, ProgressDialog, wwcheckbox;

type
  TServiceLogGUI = class(TBaseInputGUI)
    qryServicelog: TERPQuery;
    DSServicelog: TDataSource;
    cmdOk: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    cboPurchDate: TwwDBDateTimePicker;
    Label1: TLabel;
    Label3: TLabel;
    cboAssetCode: TwwDBLookupCombo;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    Label5: TLabel;
    qryServicelogServiceID: TAutoIncField;
    qryServicelogAssetID: TIntegerField;
    qryServicelogAssetCode: TWideStringField;
    qryServicelogAssetName: TWideStringField;
    qryServicelogServiceDate: TDateField;
    qryServicelogNextServiceDate: TDateField;
    qryServicelogServiceNotes: TWideMemoField;
    Label7: TLabel;
    Label8: TLabel;
    AssetName: TDBEdit;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    DBMemo1: TDBMemo;
    Bevel1: TBevel;
    qryServicelogServiceProvider: TWideStringField;
    qryAssets: TERPQuery;
    qryAssetsAssetID: TAutoIncField;
    qryAssetsAssetCode: TWideStringField;
    qryAssetsAssetName: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryServicelogemployeeID: TIntegerField;
    qryServicelogEmployeeName: TWideStringField;
    Label2: TLabel;
    cboRep: TwwDBLookupCombo;
    qryRep: TERPQuery;
    qryRepEmployeeID: TIntegerField;
    qryRepEmployeeName: TWideStringField;
    qryServicelogCreationDate: TDateTimeField;
    qryServicelogHoursFornextService: TIntegerField;
    qryServicelogKmsForNextService: TIntegerField;
    Label6: TLabel;
    DBEdit1: TDBEdit;
    Label9: TLabel;
    DBEdit3: TDBEdit;
    Label10: TLabel;
    Label11: TLabel;
    chkActive: TwwCheckBox;
    qryServicelogDone: TWideStringField;
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cboAssetCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboRepCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
    procedure qryServicelogAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
    fAssetCode: string;
    function ValidateData: boolean;
  public
    { Public declarations }
    
    property PassAssetCode: string read fAssetCode write fAssetCode;
  end;

//var
//  ServiceLogGUI: TServiceLogGUI;

implementation

uses FormFactory, DNMExceptions, CommonLib;

{$R *.dfm}

procedure TServiceLogGUI.cboRepCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not(modified) then exit;
  EditDB(qryServicelog);
  qryServicelogemployeeID.asInteger :=qryRepEmployeeID.asInteger;
end;

procedure TServiceLogGUI.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;
function TServiceLogGUI.ValidateData:boolean;
begin
  result:= False;
  if Empty(cboAssetCode.Text) then begin
      CommonLib.MessageDlgXP_Vista('AssetCode cannot be blank.', mtWarning, [mbOK], 0);
      SetControlFocus(cboAssetCode);
      Exit;
  end;

  if qryServicelogemployeeID.AsInteger =0  then begin
      CommonLib.MessageDlgXP_Vista('Please Select a Rep.', mtWarning, [mbOK], 0);
      SetControlFocus(cboAssetCode);
      Exit;
  end;
  Result:= True;
end;
procedure TServiceLogGUI.cmdOkClick(Sender: TObject);
begin
  try
    if not(ValidateData) then exit;

      qryServicelog.Edit;
      qryServicelog.Post;
      Notify;
      Self.Close;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TServiceLogGUI.cmdNewClick(Sender: TObject);
begin
  try
    if not Empty(cboAssetCode.Text) then begin
      qryServicelog.Edit;
      qryServicelog.Post;
      Notify;
      KeyID := 0;
      FormShow(nil);
      SetControlFocus(cboAssetCode);
    end else begin
      CommonLib.MessageDlgXP_Vista('AssetCode cannot be blank.', mtWarning, [mbOK], 0);
      SetControlFocus(cboAssetCode);
    end;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TServiceLogGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      if qryServicelog.Active then begin
        if not (qryServicelog.State in [dsBrowse]) then begin
          qryServicelog.Post;
          Notify;
        end;
        CloseQueries;
      end;
      qryServicelog.ParamByName('ID').asInteger := KeyID;
      OpenQueries;
      if KeyID = 0 then begin
        qryServicelog.Insert;
      end else begin
        qryServicelog.Edit;
      end;
      if not Empty(fAssetCode) then begin
        cboAssetCode.Text := fAssetCode;
        cboAssetCode.LookupTable.Locate('AssetCode', fAssetCode, [loCaseInsensitive]);
        cboAssetCodeCloseUp(cboAssetCode, cboAssetCode.LookupTable, cboAssetCode.DataSource.DataSet, true);
      end;
      SetControlFocus(cboAssetCode);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TServiceLogGUI.qryServicelogAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryServicelogCreationDate.asDateTime := Now;
end;

procedure TServiceLogGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
//  ServiceLogGUI := nil;
end;

procedure TServiceLogGUI.cboAssetCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  qryServicelogAssetName.AsString := cboAssetCode.LookupTable.FieldByName('AssetName').AsString;
  qryServicelogAssetID.AsInteger := cboAssetCode.LookupTable.FieldByName('AssetID').AsInteger;
end;

initialization
  RegisterClassOnce(TserviceLogGUI);
  FormFact.RegisterMe(TServiceLogGUI, 'TServiceLogListGUI_*=ServiceID');
  (*FormFact.RegisterMe(TServiceLogGUI, 'TRemindersListGUI_*_Service Log=ID');*)
  FormFact.RegisterMe(TServiceLogGUI, 'TReminderListGUI_*_Service Log=ID');
end.
