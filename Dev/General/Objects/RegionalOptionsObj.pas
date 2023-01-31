unit RegionalOptionsObj;

interface

uses DB, Classes, SysUtils, Forms, Dialogs, MessageInterface,tcTypes;

type
  TRegionalOptionsObj = class(TComponent)
  private
    fRegion: TRegion;
    fRegionID: integer;
    fCurrencySymbol: string;
    fCurrencyFormat: integer;
    fNegCurrFormat: integer;
    fWholeCurrencyName: string;
    fDecimalCurrencyName: string;
    fShortDateFormat: string;
    fDateSeparator: string;
    fPostcodeLength: integer;
    fPostcodeMask: string;
    fPhoneNumberLength: integer;
    fPhoneNumberMask: string;
    fMobileNumberLength: integer;
    fCustomerABNLength:Integer;
    fMobileNumberMask: string;
    fCustomerABNMask :String;
    fSuburbName: string;
    fStateName: string;
    fBSBName: string;
    fBSBLength: integer;
    fBSBMask: string;
    fBankAccountLength: integer;
    fBankAccountMask: string;
    fForeignExDefault: string;
    fSalesTaxcodeDefault: string;
    fPurchaseTaxcodeDefault: string;
    fBussinessNoName: string;

    (*procedure EmptyEventProc(Sender: TObject);
    procedure AbortEventProc(Sender: TObject);*)
    procedure ApplyPOSFuncFormatting;
    procedure ApplyDefaultProductFormatting;
    procedure ApplyDefaultForeignExFormatting;
    procedure ApplyDefaultTaxStatmentFormatting;
    procedure ApplyCurrencyFormatting(const Component: TComponent);
    procedure ApplyBankFormatting(const Component: TComponent);
    procedure ApplyLocationsFormatting(const Component: TComponent);
    procedure ApplyPhoneNumFormatting(const Component: TComponent);
    procedure ApplyPostCodeFormatting(const Component: TComponent);
    procedure ApplyBussinessNoFormatting(const Component: TComponent);
    procedure ApplyBaseListingsFormatting(const Component: TComponent);
    function RegionTypeToRegionID(const Region: TRegion): integer;

  public
    constructor Create(const AOwner: TComponent; const Region: string); reintroduce;
    destructor Destroy; override;
    procedure ResetRegion(const Region: string);
    procedure SetupRegion;
    function ChangeStr(const Str: string): string;
    procedure ChangeForm(const Form: TForm);
    procedure ChangeQuery(const Query: TDataset);
    procedure ChangeList(const Component: TComponent);
    property Region: TRegion read fRegion;
    property RegionID: integer read fRegionID;
    property CurrencySymbol: string read fCurrencySymbol;
    property WholeCurrencyName: string read fWholeCurrencyName;
    property DecimalCurrencyName: string read fDecimalCurrencyName;
    property ShortDateFormat: string read fShortDateFormat;
    property DateSeparator: string read fDateSeparator;
    property PostcodeLength: integer read fPostcodeLength;
    property PhoneNumberLength: integer read fPhoneNumberLength;
    property SuburbName: string read fSuburbName;
    property StateName: string read fStateName;
    property BSBName: string read fBSBName;
    property BSBLength: integer read fBSBLength;
    property BSBMask: string read fBSBMask;
    property BankAccountLength: integer read fBankAccountLength;
    property BankAccountMask: string read fBankAccountMask;
    property ForeignExDefault: string read fForeignExDefault;
    property SalesTaxcodeDefault: string read fSalesTaxcodeDefault;
    property PurchaseTaxcodeDefault: string read fPurchaseTaxcodeDefault;
    property BussinessNoName: string read fBussinessNoName;
    function RegionNameToRegionType(const RegionName: string): TRegion;
    function RegionTypeToRegionName(const RegionType: TRegion):  string;
    function RegionName: string;
  end;

implementation

uses FastFuncs,Windows, Messages, 
     StdCtrls,  MyAccess,ERPdbComponents, AdvGrid, ExtCtrls,
     wwdblook, Wwdbgrid, CommonLib, DBCtrls, CommonDbLib,
     DNMPanel, wwdbedit, wwcheckbox, AppEnvironment, tcConst;

constructor TRegionalOptionsObj.Create(const AOwner: TComponent; const Region: string);
begin
  inherited Create(AOwner);
  ResetRegion(Region);
end;

destructor TRegionalOptionsObj.Destroy;
begin 
  inherited;
end;

function TRegionalOptionsObj.RegionTypeToRegionID(const Region: TRegion): integer;
begin
  Result := StrToIntDef(RegionNo[Region], 0);
end;

function TRegionalOptionsObj.RegionNameToRegionType(const RegionName: string): TRegion;
var
  i: TRegion;
begin
  Result := rAust;
  for i := Low(TRegion) to High(TRegion) do begin
    if FastFuncs.SameText(RegionName, RegionPlace[i]) then begin
      Result := i;
      Break;
    end;
  end;
end;

function TRegionalOptionsObj.RegionTypeToRegionName(const RegionType: TRegion):  string;
begin
  Result := RegionPlace[RegionType];
end;

procedure TRegionalOptionsObj.SetupRegion;
var
  MsgObj: TMsgObj;
  MsgHandler: TMsgHandler;
begin
  PostMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0, 0);
  Application.UpDateFormatSettings := False;
  SysUtils.CurrencyString := fCurrencySymbol;
  SysUtils.CurrencyFormat := fCurrencyFormat;
  SysUtils.NegCurrFormat := fNegCurrFormat;
  SysUtils.ShortDateFormat := fShortDateFormat;
  SysUtils.DateSeparator := fDateSeparator[1];
  MsgHandler := TMsgHandler.Create(Self);

  try
    if Assigned(FindExistingComponent('TMainForm')) then begin
      MsgObj := TMsgObj.Create;
      MsgObj.ClassStr := 'TMainForm';
      MsgObj.MethodStr := 'SetRegionCaption';
      MsgObj.StrValue := RegionABREV[fRegion];
      MsgHandler.Send(MsgObj);
    end;

    MsgObj := TMsgObj.Create;
    MsgObj.ClassStr := 'TdtmMainGUI';
    MsgObj.MethodStr := 'SetRegionValues';


    {except Main}
    if (fRegion = rAust) then begin
      MsgObj.BoolValue := True;
      MsgHandler.Send(MsgObj);
    end else begin
      MsgObj.BoolValue := False;
      MsgHandler.Send(MsgObj);
    end;
  finally
    FreeAndNil(MsgHandler);
  end;

  ApplyDefaultForeignExFormatting;
  ApplyDefaultProductFormatting;
  ApplyPOSFuncFormatting;
  ApplyDefaultTaxStatmentFormatting;
end;

function TRegionalOptionsObj.ChangeStr(const Str: string): string;
begin 
  Result := FastFuncs.AnsiStringReplace(Str, '$', fCurrencySymbol, [rfReplaceAll,rfIgnoreCase]);
end;

procedure TRegionalOptionsObj.ChangeQuery(const Query: TDataset);
var 
  iIndex: integer;
  Component: TComponent;
begin
  if Query is TERPQuery then begin
    if not TERPQuery(Query).Active then TERPQuery(Query).SQL.Text := FastFuncs.AnsiStringReplace(TERPQuery(Query).SQL.Text, '$', fCurrencySymbol, [rfReplaceAll,rfIgnoreCase]);
  end;
  if Query is TERPQuery then begin
    if not TERPQuery(Query).Active then TERPQuery(Query).SQL.Text := FastFuncs.AnsiStringReplace(TERPQuery(Query).SQL.Text, '$', fCurrencySymbol, [rfReplaceAll,rfIgnoreCase]);
  end;
  for iIndex := 0 to Query.FieldCount - 1 do begin 
    Component := Query.Fields[iIndex];
    if Component is TNumericField then begin
      TNumericField(Component).DisplayFormat := FastFuncs.AnsiStringReplace(TNumericField(Component).DisplayFormat, '$', fCurrencySymbol, [rfReplaceAll,rfIgnoreCase]);
      TNumericField(Component).EditFormat := FastFuncs.AnsiStringReplace(TNumericField(Component).EditFormat, '$', fCurrencySymbol, [rfReplaceAll,rfIgnoreCase]);
    end;
    if Component is TField then begin
      TField(Component).DisplayLabel := FastFuncs.AnsiStringReplace(TField(Component).DisplayLabel, '$', fCurrencySymbol, [rfReplaceAll,rfIgnoreCase]);
      if not TField(Component).DataSet.Active then TField(Component).FieldName := FastFuncs.AnsiStringReplace(TField(Component).FieldName, '$', fCurrencySymbol, [rfReplaceAll,rfIgnoreCase]);
      TField(Component).Origin := '';
    end;
  end;
end;

procedure TRegionalOptionsObj.ChangeForm(const Form: TForm);
var
  iIndex: integer;
  Component: TComponent;
begin
  for iIndex := 0 to Form.ComponentCount - 1 do begin
    Component := Form.Components[iIndex];
    ApplyCurrencyFormatting(Component);
    ApplyLocationsFormatting(Component);
    ApplyBankFormatting(Component);
    ApplyPhoneNumFormatting(Component);
    ApplyPostCodeFormatting(Component);
    ApplyBussinessNoFormatting(Component);

  end;
end;

procedure TRegionalOptionsObj.ApplyCurrencyFormatting( const Component: TComponent);
begin
  if Component is TLabel then begin
    TLabel(Component).Caption := FastFuncs.AnsiStringReplace(TLabel(Component).Caption, '$', fCurrencySymbol, [rfReplaceAll,rfIgnoreCase]);
  end;
  if Component is TERPQuery then begin
    if not TERPQuery(Component).Active then TERPQuery(Component).SQL.Text := FastFuncs.AnsiStringReplace(TERPQuery(Component).SQL.Text, '$', fCurrencySymbol, [rfReplaceAll,rfIgnoreCase]);
  end;
  if Component is TERPQuery then begin
    if not TERPQuery(Component).Active then TERPQuery(Component).SQL.Text := FastFuncs.AnsiStringReplace(TERPQuery(Component).SQL.Text, '$', fCurrencySymbol, [rfReplaceAll,rfIgnoreCase]);
  end;
  if Component is TNumericField then begin
    TNumericField(Component).DisplayFormat := FastFuncs.AnsiStringReplace(TNumericField(Component).DisplayFormat, '$', fCurrencySymbol, [rfReplaceAll,rfIgnoreCase]);
    TNumericField(Component).EditFormat := FastFuncs.AnsiStringReplace(TNumericField(Component).EditFormat, '$', fCurrencySymbol, [rfReplaceAll,rfIgnoreCase]);
  end;
  if Component is TField then begin
    TField(Component).DisplayLabel := FastFuncs.AnsiStringReplace(TField(Component).DisplayLabel, '$', fCurrencySymbol, [rfReplaceAll,rfIgnoreCase]);
    if not TField(Component).DataSet.Active then TField(Component).FieldName := FastFuncs.AnsiStringReplace(TField(Component).FieldName, '$', fCurrencySymbol, [rfReplaceAll,rfIgnoreCase]);
    TField(Component).Origin := '';
  end;
  if Component is TAdvStringGrid then begin
    TAdvStringGrid(Component).ColumnHeaders.Text := FastFuncs.AnsiStringReplace(TAdvStringGrid(Component).ColumnHeaders.Text, '$', fCurrencySymbol, [rfReplaceAll,rfIgnoreCase]);
  end;
  if Component is TRadioGroup then begin
    TRadioGroup(Component).Items.Text := FastFuncs.AnsiStringReplace(TRadioGroup(Component).Items.Text, 'Dollar', fWholeCurrencyName, [rfReplaceAll,rfIgnoreCase]);
  end;
  if Component is TLabel then begin
    TLabel(Component).Caption := FastFuncs.AnsiStringReplace(TLabel(Component).Caption, 'Cents', fDecimalCurrencyName, [rfReplaceAll,rfIgnoreCase]);
  end;
  if Component is TwwCheckBox then begin
    TwwCheckBox(Component).Caption := FastFuncs.AnsiStringReplace(TwwCheckBox(Component).Caption, '$', fCurrencySymbol, [rfReplaceAll,rfIgnoreCase]);
  end;
end;

procedure TRegionalOptionsObj.ApplyLocationsFormatting(const Component: TComponent);
var
  iStrlst, iIndex: integer;
  ComboStrings: TStringList;
  sField, sWidth, sDesc, sEnd: string;
const
  aysSuburbCombs: array[0..2] of string = ('Suburb', 'Suburb2', 'BillSuburb');
  aysSuburbLabels: array[0..2] of string = ('lblSuburb', 'lblSuburb2', 'lblBillSuburb');
  aysStateEdit: array[0..2] of string = ('State', 'State2', 'BillState');
  aysStateLabels: array[0..2] of string = ('lblState', 'lblState2', 'lblBillState');
  aysPcodeEdit: array[0..2] of string = ('Postcode', 'Postcode2', 'BillPostcode');
  aysPcodeLabels: array[0..2] of string = ('lblPostcode', 'lblPostcode2', 'lblBillPostcode');
begin
  if Component is TwwDBLookupCombo then begin
    for iIndex := 0 to High(aysSuburbCombs) do begin
      if (FastFuncs.PosEx(FastFuncs.UpperCase(aysSuburbCombs[iIndex]), FastFuncs.UpperCase(TwwDBLookupCombo(Component).Name)) <> 0) then begin
        ComboStrings := TStringList.Create;
        try
          ComboStrings.Text := TwwDBLookupCombo(Component).Selected.Text;
          for iStrlst := 0 to ComboStrings.Count - 1 do begin
            sField := CommonLib.ExtractStrPortion(ComboStrings[iStrlst], #9, 1);
            sWidth := '20';
            sDesc := CommonLib.ExtractStrPortion(ComboStrings[iStrlst], #9, 3);
            sEnd := CommonLib.ExtractStrPortion(ComboStrings[iStrlst], #9, 4);
            sDesc := FastFuncs.AnsiStringReplace(sDesc, 'Suburb', fSuburbName, [rfReplaceAll,rfIgnoreCase]);
            sDesc := FastFuncs.AnsiStringReplace(sDesc, 'State', fStateName, [rfReplaceAll,rfIgnoreCase]);
            ComboStrings[iStrlst] := sField + #9 + sWidth + #9 + sDesc + #9 + sEnd;
          end;
          TwwDBLookupCombo(Component).Selected.Text := ComboStrings.Text;
          if (fRegion = rUK) then TwwDBLookupCombo(Component).Width := 186;
          (*if AppEnv.CompanyPrefs.InternationalAddresses then begin
            TwwDBLookupCombo(Component).ShowButton := False;
            TwwDBLookupCombo(Component).SeqSearchOptions := [];
            TwwDBLookupCombo(Component).OnDblClick := EmptyEventProc;
            TwwDBLookupCombo(Component).OnBeforeDropDown := AbortEventProc;
          end;*)
        finally
          FreeAndNil(ComboStrings);
        end;
      end;
    end;
  end;
  if Component is TLabel then begin
    for iIndex := 0 to High(aysSuburbLabels) do begin
      if (FastFuncs.PosEx(FastFuncs.UpperCase(aysSuburbLabels[iIndex]), FastFuncs.UpperCase(TLabel(Component).Name)) <> 0) then begin
        TLabel(Component).AutoSize := true;
        TLabel(Component).WordWrap := false;
        TLabel(Component).Caption := fSuburbName + CommonLib.ExtractLabelSuffix(TLabel(Component).Caption);
      end;
    end;
  end;
  if Component is TDBEdit then begin
    for iIndex := 0 to High(aysStateEdit) do begin
      if (FastFuncs.PosEx(FastFuncs.UpperCase(aysStateEdit[iIndex]), FastFuncs.UpperCase(TDBEdit(Component).Name)) <> 0) then begin
        if (fRegion = rUK) then TDBEdit(Component).Width := 186;
      end;
    end;
  end;
  if Component is TLabel then begin
    for iIndex := 0 to High(aysStateLabels) do begin
      if (FastFuncs.PosEx(FastFuncs.UpperCase(aysStateLabels[iIndex]), FastFuncs.UpperCase(TLabel(Component).Name)) <> 0) then begin
        TLabel(Component).AutoSize := true;
        TLabel(Component).WordWrap := false;
        TLabel(Component).Caption := fStateName + CommonLib.ExtractLabelSuffix(TLabel(Component).Caption);
      end;
    end;
  end;
  if Component is TLabel then begin
    for iIndex := 0 to High(aysPcodeLabels) do begin
      if (FastFuncs.PosEx(FastFuncs.UpperCase(aysPcodeLabels[iIndex]), FastFuncs.UpperCase(TLabel(Component).Name)) <> 0) then begin
        TLabel(Component).AutoSize := true;
        TLabel(Component).WordWrap := false;
        TLabel(Component).Caption := 'Postcode' + CommonLib.ExtractLabelSuffix(TLabel(Component).Caption);
      end;
    end;
  end;
  if FastFuncs.SameText(Component.Owner.ClassName, 'TLocationListGUI') then begin
    if (Component is TERPQuery) and FastFuncs.SameText(Component.Name, 'qryMain') then begin
      if not TERPQuery(Component).Active then TERPQuery(Component).SQL.Text := FastFuncs.AnsiStringReplace(TERPQuery(Component).SQL.Text, 'as City_Sub', 'as "' + fSuburbName + '"', [rfReplaceAll,rfIgnoreCase]);
      if not TERPQuery(Component).Active then TERPQuery(Component).SQL.Text := FastFuncs.AnsiStringReplace(TERPQuery(Component).SQL.Text, 'as State', 'as ' + fStateName, [rfReplaceAll,rfIgnoreCase]);
    end;
  end;
end;

procedure TRegionalOptionsObj.ApplyPhoneNumFormatting(const Component: TComponent);
var
  iPhIndex: integer;
  iPhExcludeIndex: integer;
  ExcludeComponent :Boolean;
const
  aysPhExclude: array[0..4] of string = ('PHONESUPPORTPERIODNO','PHONESUPPORTAMOUNTNO','FAXTO','FAXBY','FAXSPOOL');
  aysPh: array[0..7] of string = ('PHONE', 'FAX', 'CONTACTPH', 'CONTACTALTPH', 'CONTACTFAX', 'TXTPHONE', 'BILLPHONE', 'BILLFAX');
  aysMOB: array[0..1] of string = ('MOBILE', 'CONTACTMOB');
  aysABN:Array[0..0] of String =('ABN');
begin
  ExcludeComponent := False;
  if (Component is TField) and (not TField(Component).DataSet.Active) then begin
    for iPhIndex := 0 to High(aysPh) do begin
      if (FastFuncs.PosEx(aysPh[iPhIndex], FastFuncs.UpperCase(TField(Component).FieldName)) <> 0) or (FastFuncs.PosEx(aysPh[iPhIndex], FastFuncs.UpperCase(TField(Component).DisplayName)) <> 0) then begin
        for iPhExcludeIndex := 0 to High(aysPhExclude) do begin
          if (FastFuncs.PosEx(aysPhExclude[iPhExcludeIndex], FastFuncs.UpperCase(TField(Component).FieldName)) <> 0) then begin
            ExcludeComponent:= True;
          end;
        end;
        If not ExcludeComponent then
          if AppEnv.CompanyPrefs.PhoneNumberFormatting then begin
            TField(Component).EditMask := fPhoneNumberMask;
            // Size 1 = Boolean
            if (TField(Component).DataType = ftString) AND (TField(Component).Size>1) then TField(Component).Size := fPhoneNumberLength;
            if (TField(Component).DataType = ftString) AND (TField(Component).Size>1) then TField(Component).DisplayWidth := fPhoneNumberLength;
          end else begin
            TField(Component).EditMask := '';
          end;
      end;
    end;
    for iPhIndex := 0 to High(aysMOB) do begin
      if (FastFuncs.PosEx(aysMOB[iPhIndex], FastFuncs.UpperCase(TField(Component).FieldName)) <> 0) or (FastFuncs.PosEx(aysMOB[iPhIndex], FastFuncs.UpperCase(TField(Component).DisplayName)) <> 0) then begin
        if AppEnv.CompanyPrefs.PhoneNumberFormatting then begin
          TField(Component).EditMask := fMobileNumberMask;
          // Size 1 = Boolean
          if (TField(Component).DataType = ftString) AND (TField(Component).Size>1) then TField(Component).Size := fMobileNumberLength;
          if (TField(Component).DataType = ftString) AND (TField(Component).Size>1) then TField(Component).DisplayWidth := fMobileNumberLength;
        end else begin
          TField(Component).EditMask := '';
        end;
      end;
    end;

    for iPhIndex := 0 to High(aysABN) do begin
      if (FastFuncs.PosEx(aysABN[iPhIndex], FastFuncs.UpperCase(TField(Component).Name)) <> 0) or (FastFuncs.PosEx(aysABN[iPhIndex], FastFuncs.UpperCase(TField(Component).DisplayName)) <> 0) then begin
        if AppEnv.CompanyPrefs.CustomerABNFormating then begin
          TField(Component).EditMask := fCustomerABNMask;
          // Size 1 = Boolean
          if (TField(Component).DataType = ftString) AND (TField(Component).Size>1) then TField(Component).Size := fCustomerABNLength;
          if (TField(Component).DataType = ftString) AND (TField(Component).Size>1) then TField(Component).DisplayWidth := fCustomerABNLength;
        end else begin
          TField(Component).EditMask := '';
        end;
      end;
    end;
  end;
end;

procedure TRegionalOptionsObj.ApplyPostCodeFormatting(const Component: TComponent);
const
  aysPCode: array[0..1] of string = ('POSTCODE', 'PCODE');
var
  iPCodeIndex: integer;
begin
  if (Component is TField) and (not TField(Component).DataSet.Active) then begin
    for iPCodeIndex := 0 to High(aysPCode) do begin
      if (FastFuncs.PosEx(aysPCode[iPCodeIndex], FastFuncs.UpperCase(TField(Component).FieldName)) <> 0) or (FastFuncs.PosEx(aysPCode[iPCodeIndex], FastFuncs.UpperCase(TField(Component).DisplayName)) <> 0) then begin
        if AppEnv.CompanyPrefs.PostcodeFormatting then begin
          TField(Component).EditMask := fPostcodeMask;
          //Size 1 = Boolean
          if (TField(Component).DataType = ftString) AND (TField(Component).Size>1) then TField(Component).Size := fPostcodeLength;
          if (TField(Component).DataType = ftString) AND (TField(Component).Size>1) then TField(Component).DisplayWidth := fPostcodeLength;
        end else begin
          TField(Component).EditMask := '';
        end;
      end;
    end;
  end;
end;

procedure TRegionalOptionsObj.ApplyDefaultForeignExFormatting;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  try
    qryTemp.Connection := GetSharedMyDacConnection;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('UPDATE tblcurrencyconversion SET BuyRate= 0, SellRate= 0, Active= "F" WHERE `BuyRate` = 1 AND `SellRate` = 1;');
    Try
      qryTemp.Execute;
    except
    end;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('UPDATE tblcurrencyconversion SET BuyRate= 1, SellRate= 1, Active= "T" WHERE `Code` = '+QuotedStr(fForeignExDefault)+';');
    Try
      qryTemp.Execute;
    except
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TRegionalOptionsObj.ApplyBankFormatting(const Component: TComponent);
const
  aysBSBLabel: array[0..1] of string = ('BSB','lblBSB');
  aysBSBField: array[0..1] of string = ('BSB','edtBSB');
  aysBankAccountField: array[0..1] of string = ('BankAccountNo','edtBankAccNo');
  aysBankCodeLabel: array[0..0] of string = ('Bank Code');
  aysBankCodeField: array[0..1] of string = ('Bank Code','BankCode');
var
  iIndex: integer;
begin
  if Component is TField then begin
    if not TField(Component).DataSet.Active then begin
      // BSB Field
      for iIndex := 0 to High(aysBSBField) do begin
        if (FastFuncs.PosEx(FastFuncs.UpperCase(aysBSBField[iIndex]), FastFuncs.UpperCase(TField(Component).FieldName)) <> 0) or (FastFuncs.PosEx(FastFuncs.UpperCase(aysBSBField[iIndex]), FastFuncs.UpperCase(TField(Component).DisplayName)) <> 0) then begin
          if AppEnv.CompanyPrefs.BankAccFormatting then begin
            TField(Component).EditMask := fBSBMask;
            //Size 1 = Boolean
            if (TField(Component).DataType = ftString) AND (TField(Component).Size>1) then TField(Component).Size := fBSBLength;
            if (TField(Component).DataType = ftString) AND (TField(Component).Size>1) then TField(Component).DisplayWidth := fBSBLength;
          end else begin
            TField(Component).EditMask := '';
          end;

        end;
      end;

      // Bank Account Field
      for iIndex := 0 to High(aysBankAccountField) do begin
        if (FastFuncs.PosEx(FastFuncs.UpperCase(aysBankAccountField[iIndex]), FastFuncs.UpperCase(TField(Component).FieldName)) <> 0) or (FastFuncs.PosEx(FastFuncs.UpperCase(aysBankAccountField[iIndex]), FastFuncs.UpperCase(TField(Component).DisplayName)) <> 0) then begin
          if AppEnv.CompanyPrefs.BankAccFormatting then begin
            TField(Component).EditMask := fBankAccountMask;
            //Size 1 = Boolean
            if (TField(Component).DataType = ftString) AND (TField(Component).Size>1) then TField(Component).Size := fBankAccountLength;
            if (TField(Component).DataType = ftString) AND (TField(Component).Size>1) then TField(Component).DisplayWidth := fBankAccountLength;
          end else begin
            TField(Component).EditMask := '';
          end;
        end;
      end;
    end;
  end;

  if (Component is TLabel)  then begin
    // BSB Label
    for iIndex := 0 to High(aysBSBLabel) do begin
      if (FastFuncs.PosEx(FastFuncs.UpperCase(aysBSBLabel[iIndex]), FastFuncs.UpperCase(TLabel(Component).Caption)) <> 0) then begin
        TLabel(Component).AutoSize := true;
        TLabel(Component).WordWrap := false;
        TLabel(Component).Caption := fBSBName;
      end;
    end;
    //Bank Code Label
    for iIndex := 0 to High(aysBankCodeLabel) do begin
      if (FastFuncs.PosEx(FastFuncs.UpperCase(aysBankCodeLabel[iIndex]), FastFuncs.UpperCase(TLabel(Component).Caption)) <> 0) then begin
        TLabel(Component).Visible := (fRegion = rAust);
      end;
    end;
  end;

  if (Component is TwwDBLookupCombo)  then begin
    // Bank Code Combo
    for iIndex := 0 to High(aysBankCodeField) do begin
      if (FastFuncs.PosEx(FastFuncs.UpperCase(aysBankCodeField[iIndex]), FastFuncs.UpperCase(TwwDBLookupCombo(Component).DataField)) <> 0)then begin
        TwwDBLookupCombo(Component).Visible := (fRegion = rAust);
       end;
    end;
  end;

  if FastFuncs.SameText(Component.Owner.ClassName, 'TfrmChartOfAccounts') then begin
    if (Component is TDNMPanel) and FastFuncs.SameText(Component.Name, 'pnlEFT') then begin
      TDNMPanel(Component).Visible := (fRegion = rAust);
    end;
  end;
end;

procedure TRegionalOptionsObj.ApplyDefaultProductFormatting;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  try
    qryTemp.Connection := GetSharedMyDacConnection;
    If (fRegion = rUK) then Begin
      qryTemp.Sql.Clear;
      qryTemp.Sql.Add('UPDATE tblparts          SET PARTNAME    = "£Discount", PARTSDESCRIPTION= "Pound Discount" WHERE PARTNAME    ="$Discount";');
      qryTemp.Sql.Add('UPDATE tblproductclasses SET ProductName = "£Discount"                                     WHERE ProductName ="$Discount";');
      Try
        qryTemp.Execute;
      except
      end;
      qryTemp.Sql.Clear;
      qryTemp.Sql.Add('UPDATE tblparts          SET PARTNAME    = "£Surcharge", PARTSDESCRIPTION= "Pound Surcharge" WHERE PARTNAME    = "$Surcharge";');
      qryTemp.Sql.Add('UPDATE tblproductclasses SET ProductName = "£Surcharge"                                      WHERE ProductName = "$Surcharge";');
      Try
        qryTemp.Execute;
      except
      end;
    end else Begin
      qryTemp.Sql.Clear;
      qryTemp.Sql.Add('UPDATE tblparts          SET PARTNAME    = "$Discount", PARTSDESCRIPTION= "Dollar Discount"  WHERE PARTNAME   = "£Discount";');
      qryTemp.Sql.Add('UPDATE tblproductclasses SET ProductName = "$Discount"                                       WHERE ProductName= "£Discount";');
      Try
        qryTemp.Execute;
      except
      end;
      qryTemp.Sql.Clear;
      qryTemp.Sql.Add('UPDATE tblparts          SET PARTNAME    = "$Surcharge", PARTSDESCRIPTION= "Dollar Surcharge" WHERE PARTNAME   = "£Surcharge";');
      qryTemp.Sql.Add('UPDATE tblproductclasses SET ProductName = "$Surcharge"                                       WHERE ProductName= "£Surcharge";');
      Try
        qryTemp.Execute;
      except
      end;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TRegionalOptionsObj.ApplyPOSFuncFormatting;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  try
    qryTemp.Connection := GetSharedMyDacConnection;
    If (fRegion = rUK) then Begin
      qryTemp.Sql.Clear;
      qryTemp.Sql.Add('UPDATE tblposfunctions SET FunctionName= "Pound Discount", CaptionLine1= "£££",');
      qryTemp.Sql.Add('Description=REPLACE(Description,"$","£"), Hint = REPLACE(Hint,"dollars","pounds") WHERE ID=9;');
      Try
        qryTemp.Execute;
      except
      end;
      qryTemp.Sql.Clear;
      qryTemp.Sql.Add('UPDATE tblposfunctions SET FunctionName= "Pound Surcharge", CaptionLine1= "£££",');
      qryTemp.Sql.Add('Description=REPLACE(Description,"$","£"), Hint = REPLACE(Hint,"dollars","pounds") WHERE ID=11;');
      Try
        qryTemp.Execute;
      except
      end;
      //POS Func
//      qryTemp.Sql.Clear;
//      qryTemp.Sql.Add('UPDATE tblposfunctions SET FunctionName= "Pound Surcharge", CaptionLine1= "£££",');
//         Cash Back     Back
//      Try
//        qryTemp.Execute;
//      except
//      end;


    end else Begin
      qryTemp.Sql.Clear;
      qryTemp.Sql.Add('UPDATE tblposfunctions SET FunctionName= "Dollar Discount", CaptionLine1= "$$$",');
      qryTemp.Sql.Add('Description=REPLACE(Description,"£","$"), Hint = REPLACE(Hint,"pounds","dollars") WHERE ID=9;');
      Try
        qryTemp.Execute;
      except
      end;
      qryTemp.Sql.Clear;
      qryTemp.Sql.Add('UPDATE tblposfunctions SET FunctionName= "Dollar Surcharge", CaptionLine1= "$$$",');
      qryTemp.Sql.Add('Description=REPLACE(Description,"£","$"), Hint = REPLACE(Hint,"pounds","dollars") WHERE ID=11;');
      Try
        qryTemp.Execute;
      except
      end;
      //POS Func
//
//        Cash Out     Out

    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TRegionalOptionsObj.ApplyBussinessNoFormatting(const Component: TComponent);
const
  aysABNLabel: array[0..0] of string = ('ABN');
var
  iIndex: integer;
begin
  if (Component is TLabel)  then begin
    // ABN Label
    for iIndex := 0 to High(aysABNLabel) do begin
      if (FastFuncs.PosEx(FastFuncs.UpperCase(aysABNLabel[iIndex]), FastFuncs.UpperCase(TLabel(Component).Caption)) <> 0) then begin
        TLabel(Component).AutoSize := true;
        TLabel(Component).WordWrap := false;
        TLabel(Component).Caption := fBussinessNoName;
      end;
    end;
  end;
end;

procedure TRegionalOptionsObj.ApplyBaseListingsFormatting(const Component: TComponent);
var
  iIndex,iIndex2: integer;

const
  aysSuburbDisplayNames: array[0..1] of string = ('Suburb', 'Bill Suburb');
  aysStateDisplayNames: array[0..1] of string = ('State', 'Bill State');

begin
  // BaseListings
  if (Component is TERPQuery) and FastFuncs.SameText(Component.Name, 'qryMain') then begin

    for iIndex2 := 0 to TERPQuery(Component).FieldCount -1  do begin

      //Suburb Display Names
      for iIndex := 0 to High(aysSuburbDisplayNames) do begin
        if (FastFuncs.PosEx(FastFuncs.UpperCase(aysSuburbDisplayNames[iIndex]), FastFuncs.UpperCase(TERPQuery(Component).Fields[iIndex2].DisplayLabel)) <> 0) then
          TERPQuery(Component).Fields[iIndex2].DisplayLabel := FastFuncs.AnsiStringReplace(TERPQuery(Component).Fields[iIndex2].DisplayLabel, aysSuburbDisplayNames[iIndex],fSuburbName, [rfReplaceAll,rfIgnoreCase]);
      end;

      //State Display Names
      for iIndex := 0 to High(aysStateDisplayNames) do begin
        if (FastFuncs.PosEx(FastFuncs.UpperCase(aysStateDisplayNames[iIndex]), FastFuncs.UpperCase(TERPQuery(Component).Fields[iIndex2].DisplayLabel)) <> 0) then
          TERPQuery(Component).Fields[iIndex2].DisplayLabel := FastFuncs.AnsiStringReplace(TERPQuery(Component).Fields[iIndex2].DisplayLabel, aysStateDisplayNames[iIndex],fStateName, [rfReplaceAll,rfIgnoreCase]);
      end;
    end;
  end;
end;

procedure TRegionalOptionsObj.ChangeList(const Component: TComponent);
begin
 ApplyBaseListingsFormatting(Component);
end;

procedure TRegionalOptionsObj.ApplyDefaultTaxStatmentFormatting;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  try
    qryTemp.Connection := GetSharedMyDacConnection;
    qryTemp.Sql.Clear;
    If (fRegion = rUK) then Begin
      qryTemp.Sql.Add('UPDATE tblforms SET FormName= "TVATReturnGUI",' +
        'Description = "VAT Return" WHERE (FormName = "TBASReportGUI");');
    end else if (fRegion = rNZ) then Begin
      qryTemp.Sql.Add('UPDATE tblforms SET FormName= "TVATReturnGUI",' +
        'Description = "GST Return" WHERE (FormName = "TBASReportGUI") or (FormName = "TVATReturnGUI");');
    end else begin
      { aus }
      qryTemp.Sql.Add('UPDATE tblforms SET FormName = "TBASReportGUI",' +
        'Description = "BAS Report" WHERE (FormName= "TVATReturnGUI") or (FormName= "TBASReportGUI");');
    end;
    Try
      qryTemp.Execute;
    except
    end;
    qryTemp.Sql.Clear;
    If (fRegion = rUK) then Begin
      qryTemp.Sql.Add('UPDATE tblforms SET FormName = "TVATReturnListGUI",' +
        'Description= "VAT Return List" WHERE (FormName = "TBASListGUI") or (FormName = "TfrmNZBASReportListingGUI");');
    end else if (fRegion = rNZ) then Begin
      qryTemp.Sql.Add('UPDATE tblforms SET FormName= "TfrmNZBASReportListingGUI",' +
        'Description= "GST Return List" WHERE (FormName = "TBASListGUI") or (FormName = "TVATReturnListGUI");');
    end else Begin
      { aus }
      qryTemp.Sql.Add('UPDATE tblforms SET FormName = "TBASListGUI",' +
        'Description= "BAS Report List" WHERE (FormName = "TVATReturnListGUI") or (FormName = "TfrmNZBASReportListingGUI");');
    end;
    Try
      qryTemp.Execute;
    except
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TRegionalOptionsObj.ResetRegion(const Region: string);
var
  DS: TDataset;
begin
  fRegion := RegionNameToRegionType(Region);
  DS := RetrieveDataset('tblregionaloptions', 'RegionID', RegionTypeToRegionID(fRegion));
  try
    fRegionID          := DS.FieldByName('RegionID').AsInteger;
    fCurrencySymbol    := DS.FieldByName('CurrencySymbol').AsString;
    fCurrencyFormat    := DS.FieldByName('CurrencyFormat').AsInteger;
    fNegCurrFormat     := DS.FieldByName('NegCurrFormat').AsInteger;
    fWholeCurrencyName := DS.FieldByName('WholeCurrencyName').AsString;
    fDecimalCurrencyName := DS.FieldByName('DecimalCurrencyName').AsString;
    fShortDateFormat   := DS.FieldByName('ShortDateFormat').AsString;
    fDateSeparator     := DS.FieldByName('DateSeparator').AsString;
    fPostcodeLength    := DS.FieldByName('PostcodeLength').AsInteger;
    fPostcodeMask      := DS.FieldByName('PostcodeMask').AsString;
    fPhoneNumberLength := DS.FieldByName('PhoneNumberLength').AsInteger;
    fPhoneNumberMask   := DS.FieldByName('PhoneNumberMask').AsString;
    fMobileNumberLength := DS.FieldByName('MobileNumberLength').AsInteger;
    fCustomerABNLength  := DS.fieldbyname('CustomerABNLength').asInteger;
    fMobileNumberMask  := DS.FieldByName('MobileNumberMask').AsString;
    fCustomerABNMask    := Ds.FieldByname('CustomerABNMask').asString;
    fSuburbName        := DS.FieldByName('SuburbName').AsString;
    fStateName         := DS.FieldByName('StateName').AsString;
    fBSBName           := DS.FieldByName('BSBName').AsString;
    fBSBLength         := DS.FieldByName('BSBLength').AsInteger;
    fBSBMask           := DS.FieldByName('BSBMask').AsString;
    fBankAccountLength := DS.FieldByName('BankAccountLength').AsInteger;
    fBankAccountMask   := DS.FieldByName('BankAccountMask').AsString;
    fForeignExDefault  := DS.FieldByName('ForeignExDefault').AsString;
    fSalesTaxcodeDefault  := DS.FieldByName('SalesTaxcodeDefault').AsString;
    fPurchaseTaxcodeDefault  := DS.FieldByName('PurchaseTaxcodeDefault').AsString;
    fBussinessNoName  := DS.FieldByName('BussinessNoName').AsString;
  finally
    FreeAndNil(DS);
  end;
  SetupRegion;
end;

(*procedure TRegionalOptionsObj.EmptyEventProc(Sender: TObject);
begin
end;

procedure TRegionalOptionsObj.AbortEventProc(Sender: TObject);
begin
  Abort;
end;*)

function TRegionalOptionsObj.RegionName: string;
begin
  result:= self.RegionTypeToRegionName(self.Region);
end;

end.






