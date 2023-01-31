unit POSCashierEOP;
{This form is for Blind balancing but also saves End of Period Data to tblposeopreprint
 so that EOP reports can be reprinted later.

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 04/04/05  1.00.01 IJB  Added CallingClassName property. This is automatically


}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, StdCtrls, DNMPanel,
  DNMSpeedButton, Mask, wwdbedit, MemDS, Shader, ImgList, ProgressDialog,
  DBCtrls, BusObjPOSTillEOPConfig, BusObjBase;

type
  TfrmPOSCashierEOP = class(TBaseInputGUI)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    DNMPanel2: TDNMPanel;
    Bevel1: TBevel;
    Label3: TLabel;
    lblamt1: tLabel;
    lblamt2: tLabel;
    lblamt3: tLabel;
    lblamt4: tLabel;
    lblamt5: tLabel;
    lblamt6: tLabel;
    lblamt7: tLabel;
    lblamt8: tLabel;
    lblamt9: tLabel;
    lblamt10: tLabel;
    lblamt11: tLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    edHundred: TwwDBEdit;
    edFifty: TwwDBEdit;
    edTwenty: TwwDBEdit;
    edTen: TwwDBEdit;
    edFive: TwwDBEdit;
    edTwo: TwwDBEdit;
    edOne: TwwDBEdit;
    edFiftyCents: TwwDBEdit;
    edTwentyCents: TwwDBEdit;
    edTenCents: TwwDBEdit;
    edFiveCents: TwwDBEdit;
    edTotal: TwwDBEdit;
    edFloat: TwwDBEdit;
    edSubCash: TwwDBEdit;
    edPettyCash: TwwDBEdit;
    Label28: TLabel;
    edEFTPOS: TwwDBEdit;
    edVisa: TwwDBEdit;
    edMaster: TwwDBEdit;
    edDiners: TwwDBEdit;
    edBankCard: TwwDBEdit;
    edAmex: TwwDBEdit;
    edCheques: TwwDBEdit;
    edInvoicePayments: TwwDBEdit;
    qryTillEOP: TERPQuery;
    qryTillEOPPeriodID: TIntegerField;
    qryTillEOPStart: TDateTimeField;
    qryTillEOPTillID: TIntegerField;
    qryTillEOPEmployeeID: TIntegerField;
    qryTillEOPHundred: TIntegerField;
    qryTillEOPFifty: TIntegerField;
    qryTillEOPTwenty: TIntegerField;
    qryTillEOPTen: TIntegerField;
    qryTillEOPFive: TIntegerField;
    qryTillEOPTwo: TIntegerField;
    qryTillEOPOne: TIntegerField;
    qryTillEOPFiftyCents: TIntegerField;
    qryTillEOPTwentyCents: TIntegerField;
    qryTillEOPTenCents: TIntegerField;
    qryTillEOPFiveCents: TIntegerField;
    qryTillEOPTotalCash: TFloatField;
    qryTillEOPSubTotal: TFloatField;
    qryTillEOPPettyCash: TFloatField;
    qryTillEOPEFTPOS: TFloatField;
    qryTillEOPVisa: TFloatField;
    qryTillEOPMasterCard: TFloatField;
    qryTillEOPDiners: TFloatField;
    qryTillEOPBankCard: TFloatField;
    qryTillEOPCheques: TFloatField;
    qryTillEOPInvoicePayments: TFloatField;
    qryTillEOPPeriodTotal: TFloatField;
    DataSource1: TDataSource;
    Label29: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    qryTillEOPEmployeeName: TWideStringField;
    qrySales: TERPQuery;
    qryTillEOPAmex: TFloatField;
    qryTillEOPEndDate: TDateTimeField;
    qryTillEOPVariation: TFloatField;
    edPeriodID: TwwDBEdit;
    qryTillEOPCashSales: TFloatField;
    qryTillEOPTillFloat: TFloatField;
    qryTillEOPTotalSalesAmount: TFloatField;
    edCreditCard: TwwDBEdit;
    Label33: TLabel;
    qryTillEOPCreditCard: TFloatField;
    qryTillEOPTwoCents: TIntegerField;
    qryTillEOPOneCent: TIntegerField;
    qryTillEOPDebitCard: TFloatField;
    qryTillEOPMaestro: TFloatField;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label2: TLabel;
    lblamt12: tLabel;
    edTwoCents: TwwDBEdit;
    lblamt13: tLabel;
    edOneCent: TwwDBEdit;
    Label35: TLabel;
    edDebitCard: TwwDBEdit;
    Label27: TLabel;
    edPeriodTotal: TwwDBEdit;
    Bevel2: TBevel;
    pnlCashSales: TDNMPanel;
    Bevel6: TBevel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    edCashSales: TwwDBEdit;
    edStart: TwwDBEdit;
    edEnd: TwwDBEdit;
    Label36: TLabel;
    edMaestro: TwwDBEdit;
    Label37: TLabel;
    wwDBEdit1: TwwDBEdit;
    qryTillEOPTrafficCount: TLargeintField;
    qryTillEOPSalecount: TLargeintField;
    qryTillEOPGlobalRef: TWideStringField;
    qryTillEOPHundredMult: TFloatField;
    qryTillEOPFiftyMult: TFloatField;
    qryTillEOPTwentyMult: TFloatField;
    qryTillEOPTenMult: TFloatField;
    qryTillEOPFiveMult: TFloatField;
    qryTillEOPTwoMult: TFloatField;
    qryTillEOPOneMult: TFloatField;
    qryTillEOPFiftyCentsMult: TFloatField;
    qryTillEOPTwentyCentsMult: TFloatField;
    qryTillEOPTenCentsMult: TFloatField;
    qryTillEOPFiveCentsMult: TFloatField;
    qryTillEOPTwoCentsMult: TFloatField;
    qryTillEOPOneCentMult: TFloatField;
    qryTillEOPmsTimeStamp: TDateTimeField;
    qryTillEOPmsUpdateSiteCode: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure edHundredExit(Sender: TObject);
    procedure edEFTPOSExit(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure qryTillEOPAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure qryTillEOPAfterInsert(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fdEmployeeID: integer;
    fdEmployeeName: String;
    fdTillID: integer;
    POSTillEOPConfig : TPOSTillEOPConfig;

    procedure AddCash;
    procedure AddNonCash;
    procedure ShowNonCashTender;
    function SaveData: boolean;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
    property EmployeeID : integer read fdEmployeeID write fdEmployeeID;
    property EmployeeName : String read fdEmployeeName write fdEmployeeName;
    property TillID:integer read fdTillID write fdTillID;
  end;


implementation

uses
  CommonLib,FormFactory, FastFuncs, BusObjPosTill, CommonDbLib,
  DbSharedObjectsObj, AppEnvironment;

var
  StartOfPeriod: TDateTime;
  bReEnter: boolean;    //True if opening form from report to possibly re enter some data

{$R *.dfm}

procedure TfrmPOSCashierEOP.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    try
      POSTillEOPConfig.Load;
      if KeyID <> 0 then begin
        with qryTillEOP do begin
          bReEnter := True;
          SQL.Clear;
          SQL.Add('SELECT * FROM tblpostilleop WHERE PeriodID = ');
          SQL.Add(IntToStr(KeyID));
          btnSave.ModalResult := mrNone;
          btnCancel.ModalResult := mrNone;
          pnlCashSales.Visible := True;
          Open;
          Label2.Caption := TPosTill.IDToggle(FieldByName('TillId').AsInteger);
        end;
      end else begin
        with qryTillEOP do begin
          bReEnter := false;
          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM tblpostilleop');
          Open;
          Insert;
          FieldByName('TillId').AsInteger := fdTillID;
          Post;           //add a blank record cause we need an ID
          KeyID := FieldByName('PeriodID').AsInteger;
          Label2.Caption := TPosTill.IDToggle(fdTillID);

        end;

        ShowNonCashTender;
        AddNonCash;
      end;
    except

    end;
  finally
    EnableForm;
  end;  
end;


procedure TfrmPOSCashierEOP.qryTillEOPAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryTillEOPHundredMult.asfloat     := POSTillEOPConfig.Multiplier1;
  qryTillEOPFiftyMult.asfloat       := POSTillEOPConfig.Multiplier2;
  qryTillEOPTwentyMult.asfloat      := POSTillEOPConfig.Multiplier3;
  qryTillEOPTenMult.asfloat         := POSTillEOPConfig.Multiplier4;
  qryTillEOPFiveMult.asfloat        := POSTillEOPConfig.Multiplier5;
  qryTillEOPTwoMult.asfloat         := POSTillEOPConfig.Multiplier6;
  qryTillEOPOneMult.asfloat         := POSTillEOPConfig.Multiplier7;
  qryTillEOPFiftyCentsMult.asfloat  := POSTillEOPConfig.Multiplier8;
  qryTillEOPTwentyCentsMult.asfloat := POSTillEOPConfig.Multiplier9;
  qryTillEOPTenCentsMult.asfloat    := POSTillEOPConfig.Multiplier10;
  qryTillEOPFiveCentsMult.asfloat   := POSTillEOPConfig.Multiplier11;
  qryTillEOPTwoCentsMult.asfloat    := POSTillEOPConfig.Multiplier12;
  qryTillEOPOneCentMult.asfloat     := POSTillEOPConfig.Multiplier13;
end;

procedure TfrmPOSCashierEOP.qryTillEOPAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lblamt1.Caption := POSTillEOPConfig.AmtCaption1;
  lblamt2.Caption := POSTillEOPConfig.AmtCaption2;
  lblamt3.Caption := POSTillEOPConfig.AmtCaption3;
  lblamt4.Caption := POSTillEOPConfig.AmtCaption4;
  lblamt5.Caption := POSTillEOPConfig.AmtCaption5;
  lblamt6.Caption := POSTillEOPConfig.AmtCaption6;
  lblamt7.Caption := POSTillEOPConfig.AmtCaption7;
  lblamt8.Caption := POSTillEOPConfig.AmtCaption8;
  lblamt9.Caption := POSTillEOPConfig.AmtCaption9;
  lblamt10.Caption:= POSTillEOPConfig.AmtCaption10;
  lblamt11.Caption:= POSTillEOPConfig.AmtCaption11;
  lblamt12.Caption:= POSTillEOPConfig.AmtCaption12;
  lblamt13.Caption:= POSTillEOPConfig.AmtCaption13;

  edHundred.Enabled     := POSTillEOPConfig.Is1Active;
  edFifty.Enabled       := POSTillEOPConfig.Is2Active;
  edTwenty.Enabled      := POSTillEOPConfig.Is3Active;
  edTen.Enabled         := POSTillEOPConfig.Is4Active;
  edFive.Enabled        := POSTillEOPConfig.Is5Active;
  edTwo.Enabled         := POSTillEOPConfig.Is6Active;
  edOne.Enabled         := POSTillEOPConfig.Is7Active;
  edFiftyCents.Enabled  := POSTillEOPConfig.Is8Active;
  edTwentyCents.Enabled := POSTillEOPConfig.Is9Active;
  edTenCents.Enabled    := POSTillEOPConfig.Is10Active;
  edFiveCents.Enabled   := POSTillEOPConfig.Is11Active;
  edTwoCents.Enabled    := POSTillEOPConfig.Is12Active;
  edOneCent.Enabled     := POSTillEOPConfig.Is13Active;

  edHundred.Color      := iif(POSTillEOPConfig.Is1Active , clwhite , clGray);
  edFifty.Color        := iif(POSTillEOPConfig.Is2Active , clwhite , clGray);
  edTwenty.Color       := iif(POSTillEOPConfig.Is3Active , clwhite , clGray);
  edTen.Color          := iif(POSTillEOPConfig.Is4Active , clwhite , clGray);
  edFive.Color         := iif(POSTillEOPConfig.Is5Active , clwhite , clGray);
  edTwo.Color          := iif(POSTillEOPConfig.Is6Active , clwhite , clGray);
  edOne.Color          := iif(POSTillEOPConfig.Is7Active , clwhite , clGray);
  edFiftyCents.Color   := iif(POSTillEOPConfig.Is8Active , clwhite , clGray);
  edTwentyCents.Color  := iif(POSTillEOPConfig.Is9Active , clwhite , clGray);
  edTenCents.Color     := iif(POSTillEOPConfig.Is10Active , clwhite , clGray);
  edFiveCents.Color    := iif(POSTillEOPConfig.Is11Active , clwhite , clGray);
  edTwoCents.Color     := iif(POSTillEOPConfig.Is12Active , clwhite , clGray);
  edOneCent.Color      := iif(POSTillEOPConfig.Is13Active , clwhite , clGray);

end;

procedure TfrmPOSCashierEOP.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmPOSCashierEOP.FormCreate(Sender: TObject);
begin
  inherited;
  POSTillEOPConfig := TPosTilleopConfig.CreateWithNewConn(Self);
  POSTillEOPConfig.Connection.connection := Self.MyConnection;
  POSTillEOPConfig.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfrmPOSCashierEOP.FormDestroy(Sender: TObject);
begin
  Freeandnil(POSTillEOPConfig);
  inherited;

end;

procedure TfrmPOSCashierEOP.btnSaveClick(Sender: TObject);
begin
  inherited;
  AddNonCash;
  if SaveData() then begin
    Notify;
    if btnSave.ModalResult = mrNone then  Close;
  end;
end;

procedure TfrmPOSCashierEOP.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited ;
end;

procedure TfrmPOSCashierEOP.edHundredExit(Sender: TObject);
begin
  inherited;
  AddCash;
end;

procedure TfrmPOSCashierEOP.AddCash;
var
  Hundred,Fifty,Twenty,Ten,Five,Two,One: Double;
  FiftyCents,TwentyCents,TenCents,FiveCents,TwoCents,OneCent:   Double;
  Total,SubTotal,Float: Double;
begin
  Hundred       := edHundred.Field.AsFloat;
  Fifty         := edFifty.Field.AsFloat;
  Twenty        := edTwenty.Field.AsFloat;
  Ten           := edTen.Field.AsFloat;
  Five          := edFive.Field.AsFloat;
  Two           := edTwo.Field.AsFloat;
  One           := edOne.Field.AsFloat;
  FiftyCents    := edFiftyCents.Field.AsFloat;
  TwentyCents   := edTwentyCents.Field.AsFloat;
  TenCents      := edTenCents.Field.AsFloat;
  FiveCents     := edFiveCents.Field.AsFloat;
  TwoCents      := edTwoCents.Field.AsFloat;
  OneCent       := edOneCent.Field.AsFloat;

  Float         := edFloat.Field.AsCurrency;

  Total  := (Hundred      * qryTillEOPHundredMult.asFloat     ) +
            (Fifty        * qryTillEOPFiftyMult.asFloat       ) +
            (Twenty       * qryTillEOPTwentyMult.asFloat      ) +
            (Ten          * qryTillEOPTenMult.asFloat         ) +
            (Five         * qryTillEOPFiveMult.asFloat        ) +
            (Two          * qryTillEOPTwoMult.asFloat         ) +
            (One          * qryTillEOPOneMult.asFloat         ) +
            (FiftyCents   * qryTillEOPFiftyCentsMult.asFloat  ) +
            (TwentyCents  * qryTillEOPTwentyCentsMult.asFloat ) +
            (TenCents     * qryTillEOPTenCentsMult.asFloat    ) +
            (FiveCents    * qryTillEOPFiveCentsMult.asFloat   ) +
            (TwoCents     * qryTillEOPTwoCentsMult.asFloat    ) +
            (OneCent      * qryTillEOPOneCentMult.asFloat     );

  SubTotal := Total - Float;

  qryTillEOP.Edit;
  edTotal.Field.AsFloat   := Total;
  edSubCash.Field.AsFloat := SubTotal;
  AddNonCash;
end;

procedure TfrmPOSCashierEOP.edEFTPOSExit(Sender: TObject);
begin
  inherited;
  AddNonCash;
end;

procedure TfrmPOSCashierEOP.AddNonCash;
var
  EFTPOS,Visa,Master,Diners,BankCard,Amex,Cheques,InvoicePayments,CreditCard,Maestro,DebitCard: double;
begin
  EFTPOS          := edEFTPOS.Field.AsFloat;
  Visa            := edVisa.Field.AsFloat;
  Master          := edMaster.Field.AsFloat;
  Diners          := edDiners.Field.AsFloat;
  BankCard        := edBankCard.Field.AsFloat;
  Amex            := edAmex.Field.AsFloat;
  Cheques         := edCheques.Field.AsFloat;
  InvoicePayments := edInvoicePayments.Field.AsFloat;
  CreditCard      := edCreditCard.Field.AsFloat;
  DebitCard       := edDebitCard.Field.AsFloat;
  Maestro         := edMaestro.Field.AsFloat;

  qryTillEOP.Edit;
  edPeriodTotal.Field.AsFloat := EFTPOS + Visa + Master + Diners + BankCard + Amex + Cheques + InvoicePayments +
                                  CreditCard + DebitCard + Maestro + edSubCash.Field.AsFloat;

end;

function TfrmPOSCashierEOP.SaveData: boolean;
var
  Variation: Double;
  TotalSalesAmount:Double;
  SaleCount:Integer;

  procedure UpdateTraffic;
  begin

  end;


begin
  if bReEnter = True then begin
    with qrySales do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT  * FROM tblpostilleop WHERE PeriodID = ');
      SQL.Add(IntToStr(KeyID));
      Open;
      Edit;
      FieldByName('Variation').AsFloat :=  edPeriodTotal.Field.AsFloat - FieldByName('TotalSalesAmount').AsFloat;
      Post;
    end;
    qryTillEOP.Post;
    CommitTransaction;
    Result := true;
  end else begin
     with qrySales do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT  count(SaleID) AS Salecount  FROM tblSales');
      SQL.Add(' WHERE IsLayby = "F" and POS = "T" and TillID = ' + inttostr(fdTillID));
      Open;
      SaleCount := FieldByName('Salecount').asInteger;
     end;

    with qrySales do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT  Sum(TotalLineAmountInc) AS Amount  FROM tblSalesLines INNER JOIN tblSales');
      SQL.Add(' ON tblSalesLines.SaleID = tblSales.SaleID WHERE IsLayby = "F" and POS = "T" and tillid = ' +inttostr(fdTillID) +' GROUP BY PayMethod');
      Open;
      TotalSalesAmount := 0;
      while not Eof do begin
        TotalSalesAmount := TotalSalesAmount + FieldByName('Amount').AsFloat;
        Next;
      end;
    end;
    Result := false;
    if (SaleCount<> 0) then begin
      if not (qryTillEOP.State in [dsInsert, dsEdit]) then qryTillEOP.Edit;
      qryTillEOP.FieldByName('Salecount').AsFloat := qryTillEOP.FieldByName('Salecount').AsFloat + SaleCount;
      qryTillEOP.Post;
    end;

    if (TotalSalesAmount > 0)  or (edPeriodTotal.Field.AsFloat >0) then begin //ASK DEAN WHAT ABOUT PETTY CASH

      Variation :=  edPeriodTotal.Field.AsFloat - TotalSalesAmount;

      if not Empty(edPeriodTotal.Text) then begin
        qryTillEOP.Edit;
        if not (qryTillEOP.State in [dsBrowse]) then begin
          qryTillEOP.FieldByName('TillID').AsInteger        := fdTillID;
          qryTillEOP.FieldByName('EmployeeID').AsInteger    := fdEmployeeID;
          qryTillEOP.FieldByName('EmployeeName').AsString   := fdEmployeeName;
          qryTillEOP.FieldByName('EndDate').AsDateTime          :=  Now;
          qryTillEOP.FieldByName('Start').AsDateTime := iif(StartOfPeriod=0 , now ,StartOfPeriod);
          qryTillEOP.FieldByName('Variation').AsFloat := Variation;
          qryTillEOP.FieldByName('TotalSalesAmount').AsFloat := TotalSalesAmount;
          qryTillEOP.Post;
        end;
        CommitTransaction;
        Result := true;
      end else begin
        CommonLib.MessageDlgXP_Vista('Period Total cannot be blank.', mtWarning, [mbOK], 0);
        SetControlFocus(edHundred);
      end;
    end;
  end;
end;

procedure TfrmPOSCashierEOP.ShowNonCashTender;
(*var
  dtTimeOfSale: TDateTime;*)
begin
  with qrySales do begin
    Close;
    SQL.Clear;
    (*SQL.Add('SELECT  Sum(TotalLineAmountInc) AS Amount, PayMethod,SaleDate, TimeOfSale,SaleDateTime FROM tblSalesLines INNER JOIN tblSales');
    SQL.Add(' ON tblSalesLines.SaleID = tblSales.SaleID WHERE IsLayby = "F" and POS = "T" AND TillID = ');
    SQL.Add(IntToStr(fdTillID));
    SQL.Add('GROUP BY PayMethod');*)
    SQL.Add(' SELECT');
    SQL.Add(' `tblsalespayments`.`PayMethod`,');
    SQL.Add(' `tblsales`.`SaleDate`,');
    SQL.Add(' `tblsales`.`SaleDateTime`,');
    SQL.Add(' `tblsales`.`TimeOfSale`,');
    SQL.Add(' `tblsales`.`SaleDateTime`,');
    SQL.Add(' Sum(`tblsalespayments`.`Amount`) as Amount');
    SQL.Add(' FROM');
    SQL.Add(' `tblsales`');
    SQL.Add(' Inner Join `tblsalespayments` ON `tblsales`.`SaleID` = `tblsalespayments`.`SaleID`');
    SQL.Add(' WHERE IsLayby = "F" and POS = "T" AND TillID = ');
    SQL.Add(IntToStr(fdTillID));
    SQL.Add(' GROUP BY `tblsalespayments`.`PayMethod`');
    SQL.add('Order by SaleDateTime');
    Open;
    StartOfPeriod :=0;
    if recordcount > 0 then begin

      First;
    //  StartOfPeriod := FieldByName('SaleDate').AsDateTime + FieldByName('TimeOfSale').AsDateTime;

      (*dtTimeOfSale :=  qrySales.FieldByName('TimeOfSale').AsDateTime ;*)

      (*StartOfPeriod :=  qrySales.FieldByName('SaleDate').AsDateTime + dtTimeOfSale;*)
      StartOfPeriod :=  qrySales.FieldByName('SaleDateTime').AsDateTime ;


      qryTillEOP.Edit;
      While not Eof do begin                        //CHECK IF THIS IS ALL THE PAYMENT METHODS ????????????????
        if FieldByName('PayMethod').AsString = 'Master Card' then  edMaster.Field.AsFloat := FieldByName('Amount').AsFloat;
        if FieldByName('PayMethod').AsString = 'Amex' then  edAmex.Field.AsFloat := FieldByName('Amount').AsFloat;
        if FieldByName('PayMethod').AsString = 'VISA' then  edVisa.Field.AsFloat := FieldByName('Amount').AsFloat;
        if FieldByName('PayMethod').AsString = 'Diners Club' then  edDiners.Field.AsFloat := FieldByName('Amount').AsFloat;
        if FieldByName('PayMethod').AsString = 'Bank Card' then  edBankCard.Field.AsFloat := FieldByName('Amount').AsFloat;
        if FieldByName('PayMethod').AsString = 'E.F.T.' then  edEFTPOS.Field.AsFloat := FieldByName('Amount').AsFloat;
        if FieldByName('PayMethod').AsString = 'Cheque' then  edCheques.Field.AsFloat := FieldByName('Amount').AsFloat;
        if FieldByName('PayMethod').AsString = 'Invoice' then  edInvoicePayments.Field.AsFloat := FieldByName('Amount').AsFloat;
        if FieldByName('PayMethod').AsString = 'Cash' then  edCashSales.Field.AsFloat := FieldByName('Amount').AsFloat;
        if FieldByName('PayMethod').AsString = 'Credit Card' then  edCreditCard.Field.AsFloat := FieldByName('Amount').AsFloat;
        if FieldByName('PayMethod').AsString = 'Debit Card' then  edDebitCard.Field.AsFloat := FieldByName('Amount').AsFloat;
        if FieldByName('PayMethod').AsString = 'Maestro' then  edMaestro.Field.AsFloat := FieldByName('Amount').AsFloat;
        Next;
      end;
    end;
  end;
end;


procedure TfrmPOSCashierEOP.btnCancelClick(Sender: TObject);
begin
  inherited;
  if btnCancel.ModalResult = mrNone then  Close;
end;

initialization
  RegisterClassOnce(TfrmPOSCashierEOP);
  FormFact.RegisterMe(TfrmPOSCashierEOP, 'TfrmBlindBalanceReport_*=PeriodID');
end.
