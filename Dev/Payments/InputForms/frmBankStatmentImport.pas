unit frmBankStatmentImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel, wwdblook,
  wwcheckbox, wwdbedit, Mask, Wwdotdot, Wwdbcomb,
  BusObjBase, BusObjBankStatementImportFormat, ComCtrls;

type
  TfmBankStatmentImport = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdOk: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    edtInputFile: TEdit;
    Label1: TLabel;
    btnSelectFile: TButton;
    OpenDialog: TOpenDialog;
    Label2: TLabel;
    cboBankAccount: TwwDBLookupCombo;
    qryBankAccountLookup: TERPQuery;
    memSample: TMemo;
    chkAutoDetect: TwwCheckBox;
    pnlConfig: TDNMPanel;
    qryFormat: TERPQuery;
    qryFormatGlobalRef: TWideStringField;
    qryFormatID: TIntegerField;
    qryFormatAccountID: TIntegerField;
    qryFormatAutoDetect: TWideStringField;
    qryFormatFirstLineColumnNames: TWideStringField;
    qryFormatSeperator: TWideStringField;
    qryFormatDateColumnNo: TIntegerField;
    qryFormatDebitColumnNo: TIntegerField;
    qryFormatCreditColumnNo: TIntegerField;
    qryFormatDescriptionColumnNo: TIntegerField;
    qryFormatDateFormat: TWideStringField;
    qryFormatmsTimeStamp: TDateTimeField;
    qryFormatmsUpdateSiteCode: TWideStringField;
    dsFormat: TDataSource;
    Bevel1: TBevel;
    Label3: TLabel;
    chkFirstLineColumnNames: TwwCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    edtDateFormat: TwwDBEdit;
    Label6: TLabel;
    wwDBEdit2: TwwDBEdit;
    Label7: TLabel;
    edtCreditColumnNo: TwwDBEdit;
    lblDebitColumnNo: TLabel;
    edtDebitColumnNo: TwwDBEdit;
    Label8: TLabel;
    Label9: TLabel;
    wwDBEdit3: TwwDBEdit;
    Label10: TLabel;
    edtSeperator: TwwDBComboBox;
    dtFrom: TDateTimePicker;
    Label11: TLabel;
    Label12: TLabel;
    dtTo: TDateTimePicker;
    procedure btnSelectFileClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtInputFileChange(Sender: TObject);
    procedure cboBankAccountChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure chkAutoDetectClick(Sender: TObject);
  private
    fLastInputFile: string;
    ImportFormat: TBankStatementImportFormat;
    fRecordCount, fImportCount: integer;
    procedure ImportData;
  protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string); override;
  public
    { Public declarations }
  end;

implementation

uses
  BankStatementImportObj, CommonLib, BusObjConst, CommonDbLib;

{$R *.dfm}

procedure TfmBankStatmentImport.btnSelectFileClick(Sender: TObject);
begin
  inherited;
  if OpenDialog.Execute then
    edtInputFile.Text := OpenDialog.FileName;
end;

procedure TfmBankStatmentImport.cboBankAccountChange(Sender: TObject);
var
  qry: TERPQuery;
begin
  inherited;
  //
  if qryBankAccountLookup.FieldByName('AccountID').AsInteger  > 0 then begin

    if ImportFormat.Dirty then begin
      if CommonLib.MessageDlgXP_Vista('Do you want to save the changes to this Data Format?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        if ImportFormat.Save then begin
          ImportFormat.Dirty := false;
          self.CommitTransaction;
          self.BeginTransaction;
        end;
      end
      else begin
        self.RollbackTransaction;
        self.BeginTransaction;
      end;
    end;

    ImportFormat.LoadSelect('AccountID = ' + IntToStr(qryBankAccountLookup.FieldByName('AccountID').AsInteger));
    if ImportFormat.Count = 0 then begin
      ImportFormat.New;
      ImportFormat.AccountID := qryBankAccountLookup.FieldByName('AccountID').AsInteger;
    end
    else begin
      ImportFormat.Dirty := false;
    end;

    qry := TERPQuery.Create(nil);
    try
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;
      qry.SQL.Add('select MAX(TransactionDate) as TransactionDate from tblbankstatementline');
      qry.SQL.Add('where AccountID = ' + IntToStr(qryBankAccountLookup.FieldByName('AccountID').AsInteger));
      qry.Open;
      if not qry.IsEmpty then
        dtFrom.Date := qry.FieldByName('TransactionDate').AsDateTime + 1
      else
        dtFrom.Date := 0;
    finally
      qry.Free;
    end;

  end;
end;

procedure TfmBankStatmentImport.chkAutoDetectClick(Sender: TObject);
begin
  inherited;
//  pnlConfig.Enabled := not chkAutoDetect.Checked;
end;

procedure TfmBankStatmentImport.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmBankStatmentImport.cmdOkClick(Sender: TObject);
begin
  inherited;
  if ImportFormat.Dirty then begin
    if CommonLib.MessageDlgXP_Vista('Do you want to save the changes to this Data Format?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
      if ImportFormat.Save then begin
        ImportFormat.Dirty := false;
        self.CommitTransaction;
        self.BeginTransaction;
      end;
    end
    else begin
      self.RollbackTransaction;
      self.BeginTransaction;
      ImportFormat.LoadSelect('AccountID = ' + IntToStr(qryBankAccountLookup.FieldByName('AccountID').AsInteger));
    end;
  end;
  ImportData;
end;

procedure TfmBankStatmentImport.DoBusinessObjectEvent(
  const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TBankStatementImportFormat then begin
      TBankStatementImportFormat(Sender).DataSet:= qryFormat;
    end;
  end;
end;

procedure TfmBankStatmentImport.edtInputFileChange(Sender: TObject);
var
  x: integer;
  sl: TStringList;
begin
  inherited;
  if FileExists(edtInputFile.Text) then begin
    memSample.Clear;
    sl := TStringList.Create;
    try
      sl.LoadFromFile(edtInputFile.Text);
      for x := 0 to 2 do begin
        if x < sl.Count then
          memSample.Lines.Add(sl[x]);

      end;
    finally
      sl.Free;
    end;

  end
  else begin
    memSample.Text := 'File Not Found';
  end;

end;

procedure TfmBankStatmentImport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmBankStatmentImport.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := true;
  if ImportFormat.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do you want to save the changes to this Data Format?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
      mrYes:
        begin
          if ImportFormat.Save then begin
            ImportFormat.Dirty := false;
            self.CommitTransaction;
          end
          else begin
            CanClose := false;
          end;
        end;
      mrNo:
        begin
          self.CommitTransaction;
          ImportFormat.Dirty := false;
        end;
      mrCancel:
        begin
          CanClose := false;
        end;
    end;
  end;
end;

procedure TfmBankStatmentImport.FormCreate(Sender: TObject);
begin
  inherited;
  fLastInputFile := '';
  ImportFormat := TBankStatementImportFormat.Create(self);
  ImportFormat.Connection := TMyDacDataConnection.Create(ImportFormat);
  ImportFormat.Connection.MyDacConnection := MyConnection;
  ImportFormat.BusObjEvent := DoBusinessObjectEvent;
  ImportFormat.Load(0);
  ImportFormat.Dirty := false;
  dtTo.Date := Date;
end;

procedure TfmBankStatmentImport.FormShow(Sender: TObject);
begin
  inherited;
  OpenQueries;
  self.BeginTransaction;
end;

procedure TfmBankStatmentImport.ImportData;
var
  BTI: TBankTransImport;
  msg: string;
begin
  if edtInputFile.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Please select a file to import.',mtInformation,[mbOk],0);
    exit;
  end;
  if cboBankAccount.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Please select the Bank Account to import for.',mtInformation,[mbOk],0);
    exit;
  end;
  if edtInputFile.Text = fLastInputFile then begin
    if CommonLib.MessageDlgXP_Vista('Do you want to process the same file again?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
      exit;
  end;

  fRecordCount := 0;
  fImportCount := 0;

  BTI := TBankTransImport.Create;
  try
    BTI.DbConnection := self.MyConnection;
    BTI.BankAccountId := qryBankAccountLookup.FieldByName('AccountID').AsInteger;
    BTI.BankAccountName := qryBankAccountLookup.FieldByName('AccountName').AsString;
    BTI.DateFrom := dtFrom.Date;
    BTI.DateTo := dtTo.Date;
    if ImportFormat.AutoDetect then  begin


    end
    else begin
      BTI.DateColumnNo := ImportFormat.DateColumnNo -1;
      BTI.DateFormat := ImportFormat.DateFormat;
      BTI.DebitColumnNo := ImportFormat.DebitColumnNo -1;
      BTI.CreditColumnNo := ImportFormat.CreditColumnNo -1;
      BTI.DescriptionColumnNo := ImportFormat.DescriptionColumnNo -1;
      BTI.FirstLineColumnNames := ImportFormat.FirstLineColumnNames;
      BTI.Seperator := ImportFormat.Seperator;
    end;
    self.BeginTransaction;
    try
      if BTI.ReadFromFile(edtInputFile.Text, msg) then begin
        self.CommitTransaction;
        CommonLib.MessageDlgXP_Vista('Imported ' + IntToStr(BTI.RecordsProcessedCount) +
        ' of ' + IntToStr(BTI.RecordsReadCount) +' records for the date range selected.',mtInformation,[mbOk],0);
      end
      else begin
        self.RollbackTransaction;
        CommonLib.MessageDlgXP_Vista('Import failed: ' + msg,mtInformation,[mbOk],0);
      end;
    except
      on e: exception do begin
        self.RollbackTransaction;
        CommonLib.MessageDlgXP_Vista(e.Message,mtInformation,[mbOk],0);
      end;
    end;
  finally
    BTI.Free;
  end;
  fLastInputFile := edtInputFile.Text;
end;

initialization
  RegisterClass(TfmBankStatmentImport);

end.
