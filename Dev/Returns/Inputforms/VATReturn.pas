unit VATReturn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, StdCtrls, Mask, DBCtrls,
  DNMPanel, wwcheckbox, DNMSpeedButton, wwdbedit, Wwdotdot, Wwdbcomb,
  wwclearbuttongroup, wwradiogroup, MemDS, CustomInputBox, VATObj, Shader,
  ImgList;

type
  TVATReturnGUI = class(TBaseInputGUI)
    btnOptions: TDNMSpeedButton;
    btnCompleted: TDNMSpeedButton;
    BtnRefresh: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    Label73: TLabel;
    Panel1: TPanel;
    Label77: TLabel;
    Button2: TDNMSpeedButton;
    VAT1: TDBEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    DNMSpeedButton1: TDNMSpeedButton;
    VAT2: TDBEdit;
    VAT3: TDBEdit;
    DNMSpeedButton3: TDNMSpeedButton;
    VAT4: TDBEdit;
    VAT5: TDBEdit;
    DNMSpeedButton5: TDNMSpeedButton;
    VAT6: TDBEdit;
    DNMSpeedButton6: TDNMSpeedButton;
    VAT7: TDBEdit;
    DNMSpeedButton7: TDNMSpeedButton;
    VAT8: TDBEdit;
    DNMSpeedButton8: TDNMSpeedButton;
    VAT9: TDBEdit;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label21: TLabel;
    Label3: TLabel;
    Panel10: TPanel;
    YearLabel: TLabel;
    MonthLabel: TLabel;
    Period: TwwRadioGroup;
    Month: TwwDBComboBox;
    Year: TwwDBComboBox;
    Label2: TLabel;
    tblMaster: TERPQuery;
    DSMaster: TDataSource;
    tblMasterGlobalRef: TWideStringField;
    tblMasterID: TIntegerField;
    tblMasterType: TWideStringField;
    tblMasterMonth: TWideStringField;
    tblMasterYear: TIntegerField;
    tblMasterAccMethod: TWideStringField;
    tblMasterAllClass: TWideStringField;
    tblMasterClassID: TIntegerField;
    tblMasterVAT1: TFloatField;
    tblMasterVAT1Selected: TWideStringField;
    tblMasterVAT2: TFloatField;
    tblMasterVAT2Selected: TWideStringField;
    tblMasterVAT3: TFloatField;
    tblMasterVAT3Selected: TWideStringField;
    tblMasterVAT4: TFloatField;
    tblMasterVAT4Selected: TWideStringField;
    tblMasterVAT5: TFloatField;
    tblMasterVAT5Selected: TWideStringField;
    tblMasterVAT6: TFloatField;
    tblMasterVAT6Selected: TWideStringField;
    tblMasterVAT7: TFloatField;
    tblMasterVAT7Selected: TWideStringField;
    tblMasterVAT8: TFloatField;
    tblMasterVAT8Selected: TWideStringField;
    tblMasterVAT9: TFloatField;
    tblMasterVAT9Selected: TWideStringField;
    tblMasterActive: TWideStringField;
    lblMethod: TLabel;
    tblMasterVATDesc: TWideStringField;
    CustomInputBox: TCustomInputBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnElectronic: TDNMSpeedButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnOptionsClick(Sender: TObject);
    procedure BtnRefreshClick(Sender: TObject);

    procedure OpenTaxSelect(const Box: TDBEdit);
    procedure Silent_OpenTaxSelect(const Box: TDBEdit);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PeriodChange(Sender: TObject);
    procedure tblMasterVAT1Change(Sender: TField);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure DNMSpeedButton3Click(Sender: TObject);
    procedure DNMSpeedButton5Click(Sender: TObject);
    procedure DNMSpeedButton6Click(Sender: TObject);
    procedure DNMSpeedButton7Click(Sender: TObject);
    procedure DNMSpeedButton8Click(Sender: TObject);
    procedure VATDblClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnElectronicClick(Sender: TObject);
  private
    { Private declarations }
    VAT: TVATObj;
    fbNoCashBasis :Boolean; 
    procedure GetDefaults;
    procedure RefreshTypeValues;
    procedure Quarterly(const Box: TwwDBComboBox);
    procedure Monthly(const Box: TwwDBComboBox);
    function FromDate(const Month, Year: string): TDateTime;
    function ToDate(const Period, Month, Year: string): TDateTime;
    function MonthNameToNumber(const Month: string): integer;
    function GetMonthEnding:string;
    procedure RefreshAll;
    procedure PrintReport(const ReportName: string; const Print: boolean = false);
    procedure SetButtons;
    Procedure InfoSumDate;
  public
    { Public declarations }
     procedure PrepareCashBasis;
     Property NoCashBasis: boolean read fbNoCashBasis;
  end;

implementation

uses FastFuncs,DateUtils, CommonLib, CommonDbLib, FormFactory, BasOptionsPopup,
     DNMExceptions, CashBasis, VATSelectionPopup,tcTypes,
     TransAccountDetailsForm, CashBasisDetails,frmVATElectronicFrm,AppEnvironment,
     DnMLib;

{$R *.dfm}

procedure TVATReturnGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TVATReturnGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
end;

procedure TVATReturnGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbNoCashBasis := False;
  VAT := TVATObj.Create;
end;

procedure TVATReturnGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      if BtnRefresh.enabled then BtnRefresh.enabled := AccessLevel <5;
      if btnElectronic.enabled then btnElectronic.enabled := AccessLevel <5;
      if btnOptions.enabled then btnOptions.enabled := AccessLevel <5;
      if btnPrint.enabled then btnPrint.enabled := AccessLevel <5;


      tblMaster.Params.ParamByName('ID').asInteger := KeyID;
      tblMaster.Open;

      if (KeyID = 0) then begin
        if AccessLevel <5 then begin
          tblMaster.Append;
          tblMaster.FieldByName('AllClass').AsBoolean := True;
          tblMaster.FieldByName('Month').AsString := 'January';
          tblMaster.FieldByName('Type').AsString := 'Quarterly';
          Quarterly(Month);
          Year.SelText := FormatDateTime('yyyy', Now);
          tblMaster.FieldByName('Year').AsString := FormatDateTime('yyyy', Now);
        end;
      end else if (KeyID <> 0) then begin
        EditNoAbort(tblMaster);
        if (Period.Value = 'Quarterly') then begin
          Quarterly(Month);
        end else if (Period.Value = 'Monthly') then begin
          Monthly(Month);
        end;
      end;

      SetButtons;

      if (tblMasterAccMethod.AsString = 'Cash') then begin
        PrepareCashBasis;
        lblMethod.caption := 'Accounting Method Cash';
      end else begin
        lblMethod.caption := 'Accounting Method Non-Cash (Accruals)';
      end;
      GetDefaults;

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TVATReturnGUI.SetButtons;
begin
  if AppEnv.CompanyPrefs.UseElectronicVAT then begin
    btnCompleted.Left     := 21;
    btnOptions.Left       := 128;
    btnRefresh.Left       := 235;
    btnPrint.Left         := 343;
    btnElectronic.Left    := 450;
    btnElectronic.Visible := True;
  end else begin
    btnCompleted.Left     := 21;
    btnOptions.Left       := 155;
    btnRefresh.Left       := 289;
    btnPrint.Left         := 423;
    btnElectronic.Left    := 450;
    btnElectronic.Visible := False;
  end;
end;

procedure TVATReturnGUI.GetDefaults;
var
  qryTemp: TERPQuery;
begin
  tblMaster.Edit;
  tblMasterVAT1Selected.AsString  := 'S,E';
  tblMasterVAT2Selected.AsString  := 'EP,EZ';

  tblMasterVAT4Selected.AsString  := 'S,E,Z';

  tblMasterVAT6Selected.AsString  := 'S,E';
  tblMasterVAT7Selected.AsString  := 'S,E,Z';
  tblMasterVAT8Selected.AsString  := 'EP,EZ';
  tblMasterVAT9Selected.AsString  := 'EP,EZ';

  {Set Default From Las Record If One}
  QryTemp :=commonDBlib.TempMyQuery;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT ID, VAT1Selected, VAT2Selected, VAT3Selected, VAT4Selected, ');
    qryTemp.Sql.Add('VAT5Selected, VAT6Selected, VAT7Selected, VAT8Selected, VAT9Selected ');
    qryTemp.Sql.Add('FROM tblvatreturns Where Active="T" ');
    qryTemp.Sql.Add('Order By ID desc Limit 1;');
    qryTemp.Open;
    if (qryTemp.RecordCount > 0) then begin
      qryTemp.First;
      tblMaster.Edit;
      tblMasterVAT1Selected.AsString  := qryTemp.FieldByName('VAT1Selected').AsString;
      tblMasterVAT2Selected.AsString  := qryTemp.FieldByName('VAT2Selected').AsString;
      tblMasterVAT3Selected.AsString  := qryTemp.FieldByName('VAT3Selected').AsString;
      tblMasterVAT4Selected.AsString  := qryTemp.FieldByName('VAT4Selected').AsString;
      tblMasterVAT5Selected.AsString  := qryTemp.FieldByName('VAT5Selected').AsString;
      tblMasterVAT6Selected.AsString  := qryTemp.FieldByName('VAT6Selected').AsString;
      tblMasterVAT7Selected.AsString  := qryTemp.FieldByName('VAT7Selected').AsString;
      tblMasterVAT8Selected.AsString  := qryTemp.FieldByName('VAT8Selected').AsString;
      tblMasterVAT9Selected.AsString  := qryTemp.FieldByName('VAT9Selected').AsString;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TVATReturnGUI.PrepareCashBasis;
begin
  //Cash Basis Prepare
  If CashBasis.IsCashBasisTransSummarised(FromDate(Month.Text, Year.Text),
    ToDate(Period.Value, Month.Text, Year.Text)) then Begin
    fbNoCashBasis := True;
    Exit;
  end;
  CashBasis.PrepareCashBasisDetails(FromDate(Month.Text, Year.Text),
    ToDate(Period.Value, Month.Text, Year.Text), 'VAT');
end;

procedure TVATReturnGUI.btnCompletedClick(Sender: TObject);
var
  s: string;
  Form : TComponent;
begin
  inherited;
  s := '';
  CustomInputBox.Buttons := [sbOK, sbCancel];
  CustomInputBox.caption := 'Enter VAT Report Description';
  CustomInputBox.Message := 'Description';
  CustomInputBox.DefaultString := '';
  CustomInputBox.EditBoxFont.Name := 'Arial';
  CustomInputBox.EditBoxFont.Size := 9;
  CustomInputBox.EditBoxFont.Style := [];
  CustomInputBox.MessageFont.Name := 'Arial';
  CustomInputBox.MessageFont.Size := 9;
  CustomInputBox.MessageFont.Style := [fsBold];
  CustomInputBox.Height := 115;
  CustomInputBox.Width := 230;
  try
    while Empty(tblMaster.FieldByName('VATDesc').AsString) do begin;
      if CustomInputBox.Execute then s := CustomInputBox.InputResult;

      tblMaster.FieldByName('VATDesc').AsString := s;
      if Empty(tblMaster.FieldByName('VATDesc').AsString) then begin
        Exit;
      end;
    end;
    if not (tblMaster.State in [dsBrowse]) then begin
      tblMaster.Post;
      Notify;
    end;

    if AppEnv.RegionalOptions.RegionType = rUK then begin
      if CommonLib.MessageDlgXP_Vista('Do you wish to use electronic submission?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
        Form := GetComponentByClassName('TfrmVATElectronic');
        if Assigned(Form) then begin
          with TfrmVATElectronic(Form) do begin
            Position  := poScreenCenter;
            FormStyle := fsNormal;
            VatReturnID := Self.KeyID;
            TfrmVATElectronic(Form).Year := StrToInt(Self.Year.Text);
            TfrmVATElectronic(Form).Month := GetMonthEnding;
            ShowModal;
          end;
          InfoSumDate;
          Self.Close;
        end;
      end else begin
        Self.Close;
      end;
    end
    else begin
      Self.Close;
    end;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TVATReturnGUI.btnOptionsClick(Sender: TObject);
var
  Formoptions: TComponent;
begin
  if not FormStillOpen('TfrmBASoptionsGUI') then begin
    Formoptions := GetComponentByClassName('TfrmBASoptionsGUI',True,Self);
    if Assigned(Formoptions) then begin
      with TfrmBASoptionsGUI(Formoptions) do begin
        AccountMethod := tblMasterAccMethod.AsString;
        Department := GetClassName(tblMasterClassID.AsInteger);
        All := tblMasterAllClass.AsBoolean;
        TfrmBASoptionsGUI(Formoptions).TitleLabel.caption := 'VAT Options';
        TfrmBASoptionsGUI(Formoptions).caption := 'VAT Options';
        ShowModal;
      end;
    end;
  end else begin
    Formoptions := FindExistingComponent('TfrmBASoptionsGUI');
    TForm(Formoptions).ShowModal;
  end;
  If fbNoCashBasis then Self.Close;  
end;

procedure TVATReturnGUI.Monthly(const Box: TwwDBComboBox);
begin
  Box.Items.Clear;
  Box.Items.Add('January');
  Box.Items.Add('February');
  Box.Items.Add('March');
  Box.Items.Add('April');
  Box.Items.Add('May');
  Box.Items.Add('June');
  Box.Items.Add('July');
  Box.Items.Add('August');
  Box.Items.Add('September');
  Box.Items.Add('October');
  Box.Items.Add('November');
  Box.Items.Add('December');
end;

procedure TVATReturnGUI.Quarterly(const Box: TwwDBComboBox);
begin
 // Box.Items.Clear;
//  Box.Items.Add('January');
//  Box.Items.Add('April');
//  Box.Items.Add('July');
//  Box.Items.Add('October');

  Box.Items.Clear;
  Box.Items.Add('January');
  Box.Items.Add('February');
  Box.Items.Add('March');
  Box.Items.Add('April');
  Box.Items.Add('May');
  Box.Items.Add('June');
  Box.Items.Add('July');
  Box.Items.Add('August');
  Box.Items.Add('September');
  Box.Items.Add('October');
  Box.Items.Add('November');
  Box.Items.Add('December');
end;

procedure TVATReturnGUI.BtnRefreshClick(Sender: TObject);
var
  Save_Cursor: TCursor;
begin
  DisableForm;
  try
    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      inherited;
      VAT.Initialize;
      VAT.RefreshCalcFields;
      RefreshAll;
    finally
      Screen.Cursor := Save_Cursor;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TVATReturnGUI.RefreshAll;
begin
  Silent_OpenTaxSelect(VAT1);
  Silent_OpenTaxSelect(VAT2);
  Silent_OpenTaxSelect(VAT4);
  Silent_OpenTaxSelect(VAT6);
  Silent_OpenTaxSelect(VAT7);
  Silent_OpenTaxSelect(VAT8);
  Silent_OpenTaxSelect(VAT9);
end;

procedure TVATReturnGUI.OpenTaxSelect(const Box: TDBEdit);
begin
  if AccessLevel >= 5 then exit;

  if not FormStillOpen('TVATSelectionGUI') then begin
    GetComponentByClassName('TVATSelectionGUI');
  end;

  try
    with TVATSelectionGUI(FindExistingComponent('TVATSelectionGUI')) do begin
      VAT.From     := Box;
      VAT.FromName := Box.Name;
      VAT.ObjType := ftTax;
      VAT.FromDate := Self.FromDate(Month.Text, Year.Text);
      VAT.ToDate := Self.ToDate(Period.Value, Month.Text, Year.Text);
      VAT.AccountingMethod := Self.tblMasterAccMethod.AsString;
      VAT.All := Self.tblMasterAllClass.AsBoolean;
      VAT.Department := GetClassName(Self.tblMasterClassID.AsInteger);
      FormStyle := fsMDIChild;
     end;
  except
    CommonLib.MessageDlgXP_Vista('No Date Period Selected.', mtWarning, [mbOK], 0);
    TVATSelectionGUI(FindExistingComponent('TVATSelectionGUI')).Close;
  end;
end;

procedure TVATReturnGUI.Silent_OpenTaxSelect(const Box: TDBEdit);
begin
  try
    VAT.From := Box;
    VAT.FromName := Box.Name;
    VAT.ObjType := ftTax;
    VAT.AccountingMethod := Self.tblMasterAccMethod.AsString;
    VAT.All := Self.tblMasterAllClass.AsBoolean;
    VAT.Department := GetClassName(Self.tblMasterClassID.AsInteger);
    VAT.Initialize;
    VAT.FromDate := Self.FromDate(Month.Text, Year.Text);
    VAT.ToDate := Self.ToDate(Period.Value, Month.Text, Year.Text);
    VAT.Calc;
  except
    CommonLib.MessageDlgXP_Vista('No Date Period Selected.', mtWarning, [mbOK], 0);
  end;
end;

function TVATReturnGUI.FromDate(const Month, Year: string): TDateTime;
var
  Year1, Month1, Day1: word;
  Date: TDateTime;
begin
  Result := 0;
  Year1 := FastFuncs.StrToInt(Year);
  Month1 := MonthNameToNumber(Month);
  Day1 := 1;
  if TryEncodeDate(Year1, Month1, Day1, Date) then begin
    Result := EncodeDate(Year1, Month1, Day1);
  end;
end;

function TVATReturnGUI.ToDate(const Period, Month, Year: string): TDateTime;
var
  Period1: integer;
  Year1, Month1, Day1: word;
  Date: TDateTime;
begin
  Result := 0;
  Period1 := 0;
  if (Period = 'Quarterly') then begin
    Period1 := 2;
  end else if (Period = 'Monthly') then begin
    Period1 := 0;
  end;

  Year1 := FastFuncs.StrToInt(Year);
  Month1 := MonthNameToNumber(Month) + Period1;
  Day1 := 1;

  if Month1 > 12 then begin  //handle if crossing to next year
    Year1 := Year1 + 1;
    if Month1 = 13 then Month1 := 1
    else if Month1 = 14 then Month1 := 2;
  end;

  if TryEncodeDate(Year1, Month1, Day1, Date) then begin
    Result := EndOfTheMonth(EncodeDate(Year1, Month1, Day1));
  end;
end;

function TVATReturnGUI.MonthNameToNumber(const Month: string): integer;
begin
  if Month = 'January' then begin 
    Result := 1;
  end else if Month = 'February' then begin 
    Result := 2;
  end else if Month = 'March' then begin 
    Result := 3;
  end else if Month = 'April' then begin 
    Result := 4;
  end else if Month = 'May' then begin 
    Result := 5;
  end else if Month = 'June' then begin 
    Result := 6;
  end else if Month = 'July' then begin 
    Result := 7;
  end else if Month = 'August' then begin 
    Result := 8;
  end else if Month = 'September' then begin 
    Result := 9;
  end else if Month = 'October' then begin 
    Result := 10;
  end else if Month = 'November' then begin 
    Result := 11;
  end else if Month = 'December' then begin 
    Result := 12;
  end else begin 
    Result := 0;
  end;
end;

procedure TVATReturnGUI.FormDestroy(Sender: TObject);
begin
  if Assigned(VAT) then FreeandNil(VAT);
  inherited;
end;

procedure TVATReturnGUI.PeriodChange(Sender: TObject);
var
  Save_Cursor: TCursor;
begin
  Save_Cursor := Screen.Cursor;
  try
    inherited;
    Screen.Cursor := crHourGlass;
    if (Period.Value = 'Quarterly') then begin
      MonthLabel.caption := 'Quarter beginning';
      Quarterly(Month);
      Month.Text := 'January';
    end else if (Period.Value = 'Monthly') then begin
      MonthLabel.caption := 'Month  beginning';
      Monthly(Month);
    end;
  finally
    Screen.Cursor := Save_Cursor;
  end;
end;

procedure TVATReturnGUI.RefreshTypeValues;
var
  VATSelectionGUI: TComponent;
begin
  try
    if not FormStillOpen('TVATSelectionGUI') then begin
      VATSelectionGUI := GetComponentByClassName('TVATSelectionGUI');
      with TVATSelectionGUI(VATSelectionGUI) do begin
        VAT.AccountingMethod := tblMasterAccMethod.AsString;
        VAT.All := Self.tblMasterAllClass.AsBoolean;
        VAT.Department := GetClassName(Self.tblMasterClassID.AsInteger);
        VAT.RefreshCalcFields;
      end;
    end else begin
      VATSelectionGUI := FindExistingComponent('TVATSelectionGUI');
      TVATSelectionGUI(VATSelectionGUI).VAT.RefreshCalcFields;
    end;
  except
    CommonLib.MessageDlgXP_Vista('No Date Period Selected.', mtWarning, [mbOK], 0);
    TForm(FindExistingComponent('TVATSelectionGUI')).Close;
  end;
end;

procedure TVATReturnGUI.tblMasterVAT1Change(Sender: TField);
begin
  inherited;
  RefreshTypeValues;
end;

procedure TVATReturnGUI.Button2Click(Sender: TObject);
begin
  inherited;
  OpenTaxSelect(VAT1);
end;

procedure TVATReturnGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenTaxSelect(VAT2);
end;

procedure TVATReturnGUI.DNMSpeedButton3Click(Sender: TObject);
begin
  inherited;
  OpenTaxSelect(VAT4);
end;

procedure TVATReturnGUI.DNMSpeedButton5Click(Sender: TObject);
begin
  inherited;
  OpenTaxSelect(VAT6);
end;

procedure TVATReturnGUI.DNMSpeedButton6Click(Sender: TObject);
begin
  inherited;
  OpenTaxSelect(VAT7);
end;

procedure TVATReturnGUI.DNMSpeedButton7Click(Sender: TObject);
begin
  inherited;
  OpenTaxSelect(VAT8);
end;

procedure TVATReturnGUI.DNMSpeedButton8Click(Sender: TObject);
begin
  inherited;
  OpenTaxSelect(VAT9);
end;

procedure TVATReturnGUI.VATDblClick(Sender: TObject);
var
  SQL:String;
  frmCashBasisDetails: TComponent;
  frmTransAccountDetails : TComponent;  
begin
  //######## Open Listings #####################
  try
    VAT.From := TDBEdit(Sender);
    VAT.FromName := TDBEdit(Sender).Name;
    VAT.ObjType := ftTax;
    VAT.AccountingMethod := Self.tblMasterAccMethod.AsString;
    VAT.All := Self.tblMasterAllClass.AsBoolean;
    VAT.Department := GetClassName(Self.tblMasterClassID.AsInteger);
    VAT.Initialize;
    VAT.FromDate := Self.FromDate(Month.Text, Year.Text);
    VAT.ToDate := Self.ToDate(Period.Value, Month.Text, Year.Text);
    SQL := VAT.Calc(True);
  except
    CommonLib.MessageDlgXP_Vista('No Date Period Selected.', mtWarning, [mbOK], 0);
  end;

  if not (tblMasterAccMethod.AsString = 'Cash') then begin
    if FormStillOpen('TTransAccountDetailsGUI') then TForm(FindExistingComponent('TTransAccountDetailsGUI')).Close;
    if not FormStillOpen('TTransAccountDetailsGUI') then begin
      frmTransAccountDetails := GetComponentByClassName('TTransAccountDetailsGUI');
      if Assigned(frmTransAccountDetails) then begin
        with  TTransAccountDetailsGUI(frmTransAccountDetails) do begin
          FromDate := VAT.FromDate;
          ToDate := VAT.ToDate;
          fbDateRangeSupplied := true;

          if Sysutils.SameText(Trim(tblMasterAccMethod.AsString), 'Accrual') then begin
            {Accrual}
            qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'CASH_DebitsEx', 'DebitsEx');
            qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'CASH_CreditsEx', 'CreditsEx');
            qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text,  'CASH_DebitsInc', 'DebitsInc');
            qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'CASH_CreditsInc', 'CreditsInc');
          end;


          qryMain.SQL.Add(SQL + ' Group by TransID;');
          WhereString := SQL;


          FormStyle := fsmdiChild;
        end;
      end;
    end else begin
      frmTransAccountDetails := FindExistingComponent('TTransAccountDetailsGUI');
      TForm(frmTransAccountDetails).Show;
    end;

  end else begin
    if FormStillOpen('TCashBasisDetailsGUI') then TCashBasisDetailsGUI(FindExistingComponent('TCashBasisDetailsGUI')).Close;
    if not FormStillOpen('TCashBasisDetailsGUI') then begin
      frmCashBasisDetails := GetComponentByClassName('TCashBasisDetailsGUI',True,Self);
      if Assigned(frmCashBasisDetails) then begin
        with TCashBasisDetailsGUI(frmCashBasisDetails) do begin
          ToDate := Self.ToDate(Period.Value, Month.Text, Year.Text);
          FromDate := Self.FromDate(Month.Text, Year.Text);
          WhereString := SQL;
          FormStyle := fsmdiChild;
        end;
      end;  
    end else begin
      TCashBasisDetailsGUI(FindExistingComponent('TCashBasisDetailsGUI')).Show;
    end;
    Exit;
  end;
end;

procedure TVATReturnGUI.btnPrintClick(Sender: TObject);
begin
  inherited;
  try
    while Empty(tblMaster.FieldByName('VATDesc').AsString) do begin;
      tblMaster.FieldByName('VATDesc').AsString := InputBox('Enter VAT Report Description', 'Description', '');
      if Empty(tblMaster.FieldByName('VATDesc').AsString) then begin
        Exit;
      end;
    end;
    if not (tblMaster.State in [dsBrowse]) then begin
      tblMaster.Post;
      Notify;
    end;
    PrintReport('VAT Report');
    InfoSumDate;
    Self.Close;

  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TVATReturnGUI.PrintReport(const ReportName: string; const Print: boolean);
var
  sSQL: string;
begin
  sSQL := Format(' WHERE  ID = %d', [tblMaster.FieldByName('ID').AsInteger]);
  PrintTemplateReport(ReportName, sSQL, Print, 1);
end;

procedure TVATReturnGUI.btnElectronicClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfrmVATElectronic');
  if Assigned(Form) then begin
    with TfrmVATElectronic(Form) do begin
      Position  := poScreenCenter;
      FormStyle := fsNormal;
      VatReturnID := Self.KeyID;
      TfrmVATElectronic(Form).Year := StrToInt(Self.Year.Text);
      TfrmVATElectronic(Form).Month := GetMonthEnding;
      ShowModal;
    end;
  end;
end;

function TVATReturnGUI.GetMonthEnding:string;
var
  iMonth:integer;
begin
  Result := '';
  iMonth := MonthNameToNumber(Month.Text);
  if Period.ItemIndex = 0 then iMonth := iMonth + 2;
  Result := GetMonthName(iMonth);
end;

procedure TVATReturnGUI.InfoSumDate;
begin
  MessageDlgXP_Vista('When The VAT Report is Finalised, Please change the Summarise Transaction Closing Date in the Preference To Avoid Calculating the Same Transactions in the next BAS Report.', mtInformation, [mbok] , 0 );
end;

initialization
  RegisterClassOnce(TVATReturnGUI);
  FormFact.RegisterMe(TVATReturnGUI, 'TVATReturnListGUI_*=ID');
end.


