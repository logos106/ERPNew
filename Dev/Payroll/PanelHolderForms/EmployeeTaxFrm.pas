unit EmployeeTaxFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,BusObjEmployeePay, StdCtrls, ExtCtrls, DNMPanel,
  wwclearbuttongroup, wwradiogroup, wwcheckbox, wwdblook, Mask, DBCtrls,
  DB, MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbedit, frmBase, BusObjBase,
  Menus, Grids, Wwdbigrd, Wwdbgrid;

type

  TEmpTaxGUI = class(TfrmBaseGUI)
    DSEmployees: TDataSource;
    qryTaxScales: TERPQuery;
    qrySuppliers: TERPQuery;
    dsEmpPaySettings: TDataSource;
    qryTaxScale: TERPQuery;
    pnlMain: TDNMPanel;
    qryHECSTaxScales: TERPQuery;
    qryStudentLoanTaxScales: TERPQuery;
    qryAccount: TERPQuery;
    ScrollMain: TScrollBox;
    pnlTax: TDNMPanel;
    pnlExtraTax: TDNMPanel;
    Label1: TLabel;
    Label20: TLabel;
    ExtraTaxOptions: TwwRadioGroup;
    ExtraTax: TDBEdit;
    pnlExtra: TDNMPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Workcover: TwwDBLookupCombo;
    chkHECS: TwwCheckBox;
    cboHECSTaxScales: TwwDBLookupCombo;
    chkSFSS: TwwCheckBox;
    cboStudentLoanTaxScales: TwwDBLookupCombo;
    pnlAccounts: TDNMPanel;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label12: TLabel;
    Label15: TLabel;
    wwDBLookupCombo1: TwwDBLookupCombo;
    wwDBLookupCombo2: TwwDBLookupCombo;
    wwDBLookupCombo3: TwwDBLookupCombo;
    wwDBLookupCombo4: TwwDBLookupCombo;
    wwDBLookupCombo5: TwwDBLookupCombo;
    wwDBLookupCombo6: TwwDBLookupCombo;
    wwDBLookupCombo11: TwwDBLookupCombo;
    wwDBLookupCombo12: TwwDBLookupCombo;
    wwDBLookupCombo18: TwwDBLookupCombo;
    wwDBLookupCombo19: TwwDBLookupCombo;
    dsPersonalPreferences: TDataSource;
    TaxScaleList: TDNMPanel;
    lblTaxName: TLabel;
    lblTaxScale: TLabel;
    lblAllowanceQty: TLabel;
    pnlTFN: TDNMPanel;
    lblTFN: TLabel;
    edTFN: TDBEdit;
    lblABN: TLabel;
    ABN: TDBEdit;
    lblExpenseAccount: TLabel;
    lblLiabilityAccount: TLabel;
    edtNonwageIncome: TDBEdit;
    Label13: TLabel;
    procedure SetSubEmpPay(Const Value :Temployeepay );
    procedure chkHECSClick(Sender: TObject);
    procedure chkSFSSClick(Sender: TObject);
    procedure qryTaxScaleBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    fSubEmpPay: Temployeepay;
//    procedure HandleEmployeeTaxErrors;


    procedure LoadTaxScaleConfig;


  public
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    property SubEmpPay:Temployeepay  read fSubEmpPay write SetSubEmpPay ;
  end;

implementation

uses
  Math, BusObjConst,CommonLib, AppEnvironment, {frmEmployeefrm,} tcTypes, GridFieldsObj,
  BusObjPayTaxScaleConfig, DbSharedObjectsObj, fraPayTaxScaleConfig, fraPayTaxScaleConfigUSA,
  TaxScaleListFrm;

{$R *.dfm}

procedure TEmpTaxGUI.SetSubEmpPay(Const Value :Temployeepay);
begin
  fSubEmpPay := Value;

  TPayTaxScaleConfig.CreateAllForEmployee(fSubEmpPay.EmployeeDetails.ID, fSubEmpPay.Connection.Connection);

//  qryPayTaxScaleConfig.Connection := fSubEmpPay.Connection.Connection;
//  qryPayTaxScaleConfig.ParamByName('EmployeeId').AsInteger := fSubEmpPay.EmployeeDetails.ID;
//  qryPayTaxScaleConfig.Filter := 'TaxActive = "T"';
//  qryPayTaxScaleConfig.Filtered := true;
//  qryPayTaxScaleConfig.Open;
//  qryPayTaxConfig.Connection := fSubEmpPay.Connection.Connection;
//  qryPayTaxConfig.Open;
  qryAccount.Connection := fSubEmpPay.Connection.Connection;
  qryAccount.Open;

  LoadTaxScaleConfig;

//  if AppEnv.RegionalOptions.RegionType = rAust then begin
//    self.qryPayTaxScaleConfigAllowanceQty.Visible := false;
//    self.qryPayTaxScaleConfigPrimaryTax.Visible := false;
//    TGridFieldList.SetDisplayWidth(grdScale,'ScaleName',40);
////    grdScale.ColumnByName('TaxName').DisplayWidth := grdScale.ColumnByName('TaxName').DisplayWidth + 2;
////    grdScale.ColumnByName('ScaleName').DisplayWidth := 30; //   grdScale.ColumnByName('ScaleName').DisplayWidth + 2;
////    qryPayTaxScaleConfigTaxName.DisplayWidth := qryPayTaxScaleConfigTaxName.DisplayWidth + 2;
////    qryPayTaxScaleConfigScaleName.DisplayWidth := qryPayTaxScaleConfigScaleName.DisplayWidth + 2;
//  end;

end;


procedure TEmpTaxGUI.chkHECSClick(Sender: TObject);
begin
//  if not SubEmpPay.EmployeeDetails.Hecsindicator then SubEmpPay.EmployeeDetails.HecsTaxScale := 0;
  if not chkHECS.Checked then SubEmpPay.EmployeeDetails.HecsTaxScale := 0;
end;

procedure TEmpTaxGUI.chkSFSSClick(Sender: TObject);
begin
  if not chkSFSS.Checked then SubEmpPay.EmployeeDetails.StudentloanTaxScale := 0;
end;

procedure TEmpTaxGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
var
  ErrorCode: integer;
begin
  inherited ;
  if Value = BusobjEventVal_FailedTaxationValidateData then begin
//    HandleEmployeeTaxErrors;
    ErrorCode := StrToIntDef(EventType,0);
    case ErrorCode of
      BOR_Employee_Err_HECSTaxScale : begin
                                        SubEmpPay.EmployeeDetails.HecsTaxScale := 0;
                                        cboHECSTaxScales.RefreshDisplay;
                                        SetControlFocus(chkHECS);
                                        exit;
                                      end;
      BOR_Employee_Err_NoHECSTaxScale : begin
                                        SetControlFocus(cboHECSTaxScales);
                                        exit;
                                      end;
      BOR_Employee_Err_StudentLoanTaxScale : begin
                                              SubEmpPay.EmployeeDetails.StudentloanTaxScale := 0;
                                              cboStudentLoanTaxScales.RefreshDisplay;
                                              SetControlFocus(chkSFSS);
                                              exit;
                                            end;
      BOR_Employee_Err_NoStudentLoanTaxScale : begin
                                                SetControlFocus(cboStudentLoanTaxScales);
                                                exit;
                                              end;


   end;
  end;
end;

procedure TEmpTaxGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ScrollMain.Left := 0;
  ScrollMain.Top := 0;
  ScrollMain.Width := pnlMain.ClientWidth -2;
  ScrollMain.Height := pnlMain.ClientHeight -2;

  if AppEnv.RegionalOptions.RegionType = rAust then begin
    qryTaxScale.SQL.Clear;
    qryTaxScale.SQL.Add('select * from (');
    qryTaxScale.SQL.Add('Select ScaleID, ScaleDescription, 1 as SortOrder');
    qryTaxScale.SQL.Add('FROM tblTaxScales');
    qryTaxScale.SQL.Add('Where (((scaledescription not LIKE "%HELP%")');
    qryTaxScale.SQL.Add('and (scaledescription not LIKE "%SFSS%"))');
    qryTaxScale.SQL.Add('or (scaledescription LIKE "%Use this code%"))');
    qryTaxScale.SQL.Add('AND Active = "T" and RegionID = :RegionID');
    qryTaxScale.SQL.Add('union all');
    qryTaxScale.SQL.Add('select 0 as ScaleId, "" as ScaleDecription, 0 as SortOrder');
    qryTaxScale.SQL.Add('from dual');
    qryTaxScale.SQL.Add(') a order by SortOrder, ScaleDescription');
  end
  else begin
    qryTaxScale.SQL.Clear;
    qryTaxScale.SQL.Add('SELECT * FROM (');
    qryTaxScale.SQL.Add('SELECT ScaleID, ScaleDescription, 1 as SortOrder');
    qryTaxScale.SQL.Add('FROM tblTaxScales');
    qryTaxScale.SQL.Add('WHERE Active = "T" and RegionID = :RegionID');
    qryTaxScale.SQL.Add('UNION ALL');
    qryTaxScale.SQL.Add('SELECT 0 as ScaleId, "" as ScaleDecription, 0 as SortOrder');
    qryTaxScale.SQL.Add('FROM dual');
    qryTaxScale.SQL.Add(') a order by SortOrder, ScaleDescription');


    if AppEnv.RegionalOptions.RegionType = rUK then begin
      lblTFN.Caption := 'National Insurance No';
      lblABN.Caption := 'EIN';
    end else if AppEnv.RegionalOptions.RegionType = rRSA then begin
      lblTFN.Caption := 'Tax Ref Number';
      lblABN.Caption := 'EIN';
    end    else begin
      lblTFN.Caption := 'Social Security No';
      lblABN.Caption := 'EIN';
    end;

    pnlExtra.Visible := false;
  end;

  pnlMain.Height := pnlTax.Height + (2 * pnlTax.Top);


end;



procedure TEmpTaxGUI.LoadTaxScaleConfig;
var
  qry: TERPQuery;

  lineAus: TfrPayTaxScaleConfig;
  lineOther: TfrPayTaxScaleConfigUSA;


  adj: integer;
  lText : string;
  c : TBitmap;
begin

  while TaxSCaleList.ControlCount > 0 do
    TaxSCaleList.Controls[0].Free;
  adj := 0;

  qry := DbSharedObj.GetQuery(fSubEmpPay.Connection.Connection);
  try

    qry.SQL.Text := 'SELECT LENGTH(ScaleDescription), ScaleDescription FROM tblTaxScales WHERE RegionId=:RegionId AND Active="T"';
//    if AppEnv.RegionalOptions.RegionType = rAust then
//      qry.SQL.Add('and  (((scaledescription not LIKE "%HELP%") and (scaledescription not LIKE "%SFSS%")) or (scaledescription LIKE "%Use this code%"))');
    qry.SQL.Add('ORDER BY LENGTH(ScaleDescription) DESC LIMIT 1');
    qry.ParamByName('RegionID').AsInteger := AppEnv.RegionalOptions.ID;
    qry.Open;
    if qry.RecordCount = 0 then
      lText := ''
    else
      lText := qry.Fields[1].AsString;
    qry.Close;
    qry.SQL.Clear;

    qry.SQL.Add('SELECT sc.Id FROM tblPayTaxScaleConfig sc');
    qry.SQL.Add('INNER JOIN tblpaytaxconfig c ON c.ID=sc.PayTaxConfigId AND c.Active="T"');
    qry.SQL.Add('WHERE sc.EmployeeId = ' + IntToStr(fSubEmpPay.EmployeeDetails.ID));
    qry.SQL.Add('AND c.TaxType="employee"');
    qry.SQL.Add('AND c.RegionId = ' + IntToStr(AppEnv.RegionalOptions.ID));

    qry.Open;

    while not qry.Eof do begin

      if (AppEnv.RegionalOptions.RegionType = rAust) then
      begin
         lineAus := TfrPayTaxScaleConfig.Create(self);
         lineAus.Parent := TaxScaleList;
         lineAus.Name := 'TfrPayTaxScaleConfig_' + IntToStr(TaxSCaleList.ControlCount);
         lineAus.Left := 0;
         lineAus.Width := TaxScaleList.ClientWidth;
         lineAus.Top := (TaxSCaleList.ControlCount -1) * lineAus.Height;
         lineAus.lblTaxName.Left := lblTaxName.Left - TaxScaleList.Left;
         lineAus.cboScale.Left := lblTaxScale.Left - TaxScaleList.Left;
         lineAus.edtAllowanceQty.Left := lblAllowanceQty.Left - TaxScaleList.Left + ((lblAllowanceQty.Width - lineAus.edtAllowanceQty.Width) Div 2);
         lineAus.lblTaxName.Width := lineAus.cboScale.Left - lineAus.lblTaxName.Left - 5;
         lineAus.cboScale.Width := lineAus.edtAllowanceQty.Left - lineAus.cboScale.Left -15;
         if lText = '' then
           lineAus.cboScale.DropDownWidth := 0
         else
         begin
           c := TBitmap.Create;
           try
             c.Canvas.Font.Assign(lineAus.cboScale.Font);
             lineAus.cboScale.DropDownWidth := Max(c.Canvas.TextWidth(lText) + 24, lineAus.cboScale.Width);
           finally
            c.Free;
           end;
         end;
         lineAus.cboExpenseAccount.Left := lblExpenseAccount.Left - TaxScaleList.Left;
         lineAus.cboLiabilityAccount.Left := lblLiabilityAccount.Left - TaxScaleList.Left;
         lineAus.Connection := TERPConnection(fSubEmpPay.Connection.Connection);
         lineAus.ID := qry.FieldByName('ID').AsInteger;
         adj := adj + lineAus.Height;
      end
      else
      begin
         lineOther := TfrPayTaxScaleConfigUSA.Create(self);
         lineOther.Parent := TaxScaleList;
         lineOther.Name := 'TfrPayTaxScaleConfig_' + IntToStr(TaxSCaleList.ControlCount);
         lineOther.Left := 0;
         lineOther.Width := TaxScaleList.ClientWidth;
         lineOther.Top := (TaxSCaleList.ControlCount -1) * lineOther.Height;
         lineOther.lblTaxName.Left := lblTaxName.Left - TaxScaleList.Left;
         lineOther.cboScale.Left := lblTaxScale.Left - TaxScaleList.Left;
         lineOther.edtAllowanceQty.Left := lblAllowanceQty.Left - TaxScaleList.Left + ((lblAllowanceQty.Width - lineOther.edtAllowanceQty.Width) Div 2);
         lineOther.lblTaxName.Width := lineOther.cboScale.Left - lineOther.lblTaxName.Left - 5;
         lineOther.cboScale.Width := lineOther.edtAllowanceQty.Left - lineOther.cboScale.Left -15;
         if lText = '' then
           lineOther.cboScale.DropDownWidth := 0
         else
         begin
           c := TBitmap.Create;
           try
             c.Canvas.Font.Assign(lineOther.cboScale.Font);
             lineOther.cboScale.DropDownWidth := Max(c.Canvas.TextWidth(lText) + 24, lineOther.cboScale.Width);
           finally
            c.Free;
           end;
         end;
         lineOther.cboExpenseAccount.Left := lblExpenseAccount.Left - TaxScaleList.Left;
         lineOther.cboLiabilityAccount.Left := lblLiabilityAccount.Left - TaxScaleList.Left;
         lineOther.Connection := TERPConnection(fSubEmpPay.Connection.Connection);
         lineOther.ID := qry.FieldByName('ID').AsInteger;
         adj := adj + lineOther.Height;
      end;


      qry.Next;
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;

  adj := adj - TaxScaleList.Height;
  TaxScaleList.Height := TaxScaleList.Height + adj;
  pnlTax.Height := pnlTax.Height + adj;
  pnlExtraTax.Top := pnlExtraTax.Top + adj;
  pnlAccounts.Top := pnlAccounts.Top + adj;
  pnlExtra.Top := pnlExtra.Top + adj;

end;

procedure TEmpTaxGUI.qryTaxScaleBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryTaxScale.parambyname('RegionID').asInteger := AppEnv.RegionalOptions.ID;
end;

initialization
  RegisterClassOnce(TEmpTaxGUI);
end.
