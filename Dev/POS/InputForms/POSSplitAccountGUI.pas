unit POSSplitAccountGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Grids, Wwdbigrd, Wwdbgrid, StdCtrls, wwdblook,
  Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, SelectionDialog, AppEvnts, DB,
  ActnList, DBAccess, MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, MemDS, Shader,
  ImgList, ProgressDialog;

const
  SX_CalcTotalsMsg = WM_USER + 110;

type
  TPOSSplitAccount = class(TBaseInputGUI)
    cmdSave: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    Label1: TLabel;
    cboClientFrom: TwwDBLookupCombo;
    Label2: TLabel;
    cboClient: TwwDBLookupCombo;
    grdFromBarTab: TwwDBGrid;
    grdToBarTab: TwwDBGrid;
    btnMoveItem: TDNMSpeedButton;
    qryFromBarTab: TERPQuery;
    qryToBarTab: TERPQuery;
    DSFromBarTab: TDataSource;
    DSToBarTab: TDataSource;
    cboClientLookup: TERPQuery;
    cboClientLookupClientId: TAutoIncField;
    cboClientLookupCompany: TWideStringField;
    cboClientLookupBalance: TFloatField;
    cboClientLookupPayMethodID: TIntegerField;
    qryFromBarTabSaleID: TAutoIncField;
    qryFromBarTabProductID: TIntegerField;
    qryFromBarTabProductName: TWideStringField;
    qryFromBarTabProduct_Description: TWideStringField;
    qryFromBarTabPARTTYPE: TWideStringField;
    qryFromBarTabUnitOfMeasureQtySold: TFloatField;
    qryFromBarTabQtySold: TFloatField;
    qryFromBarTabTotalLineAmountInc: TFloatField;
    qryFromBarTabLinePrice: TFloatField;
    qryFromBarTabLinePriceInc: TFloatField;
    qryFromBarTabUnitOfMeasureMultiplier: TFloatField;
    qryFromBarTabLineTaxRate: TFloatField;
    qryFromBarTabINCOMEACCNT: TWideStringField;
    qryFromBarTabASSETACCNT: TWideStringField;
    qryFromBarTabCOGSACCNT: TWideStringField;
    qryFromBarTabProductGroup: TWideStringField;
    qryFromBarTabLineCost: TFloatField;
    qryFromBarTabLineCostInc: TFloatField;
    qryFromBarTabLineTaxCode: TWideStringField;
    qryFromBarTabUnitOfMeasureSaleLines: TWideStringField;
    qryFromBarTabTillID: TSmallintField;
    qryFromBarTabArea: TWideStringField;
    qryFromBarTabSaleDate: TDateField;
    qryFromBarTabTimeOfSale: TWideStringField;
    qryToBarTabSaleID: TAutoIncField;
    qryToBarTabProductID: TIntegerField;
    qryToBarTabProductName: TWideStringField;
    qryToBarTabProduct_Description: TWideStringField;
    qryToBarTabPARTTYPE: TWideStringField;
    qryToBarTabUnitOfMeasureQtySold: TFloatField;
    qryToBarTabQtySold: TFloatField;
    qryToBarTabTotalLineAmountInc: TFloatField;
    qryToBarTabLinePrice: TFloatField;
    qryToBarTabLinePriceInc: TFloatField;
    qryToBarTabUnitOfMeasureMultiplier: TFloatField;
    qryToBarTabLineTaxRate: TFloatField;
    qryToBarTabINCOMEACCNT: TWideStringField;
    qryToBarTabASSETACCNT: TWideStringField;
    qryToBarTabCOGSACCNT: TWideStringField;
    qryToBarTabProductGroup: TWideStringField;
    qryToBarTabLineCost: TFloatField;
    qryToBarTabLineCostInc: TFloatField;
    qryToBarTabLineTaxCode: TWideStringField;
    qryToBarTabUnitOfMeasureSaleLines: TWideStringField;
    qryToBarTabTillID: TSmallintField;
    qryToBarTabArea: TWideStringField;
    qryToBarTabSaleDate: TDateField;
    qryToBarTabTimeOfSale: TWideStringField;
    tblMaster: TERPQuery;
    qryFromBarTabSaleLineID: TAutoIncField;
    qryToBarTabSaleLineID: TAutoIncField;
    lsTDNMSpeedButtonActions: TActionList;
    MoveItem: TAction;
    btnMoveAll: TDNMSpeedButton;
    Label3: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboClientFromCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cmdSaveClick(Sender: TObject);
    procedure MoveItemExecute(Sender: TObject);
    procedure MoveItemUpdate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure btnMoveAllClick(Sender: TObject);

  private
    { Private declarations }
    bSwipeCardInProgress: boolean;
    sCardNumber: string;        // swipe card number
    fiClientID: integer;
    fiFromClientID: integer;
    fiToClientID: integer;
    fiToSaleID: integer;
    fiFromSaleID: integer;
    procedure RefreshBarTabQueries;
    procedure SaveTransaction;
    procedure CreateSaleHeader;
    procedure MoveLineItem(SaleLineID, ToSaleID: integer);
    procedure CalcTotals;
    procedure SwipeCardFn;
    procedure EndSwipeCard;
    procedure ResetAccountTotals(SaleID: integer);
    procedure SetClientID(iValue: integer);
    procedure OnCustomerSelect(Sender: TwwDBGrid);
  protected
    procedure DivertComboDblClick(Sender: TObject); override;  
    procedure PerformCalcTotals(var Msg: TMessage); message SX_CalcTotalsMsg;
  public
    { Public declarations }
    
    property FromClientID: integer read fiFromClientID write fiFromClientID;
    property ClientIDFromList: integer read fiClientID write SetClientID;
  end;

//var
//  POSSplitAccount: TPOSSplitAccount;

implementation
 
uses FastFuncs,DNMExceptions, AuditObj,  DnmLib, FormFactory, CustomerListForm,
  CommonLib, AppEnvironment, tcConst;
{$R *.dfm}

procedure TPOSSplitAccount.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
//  POSSplitAccount := nil;
end;

procedure TPOSSplitAccount.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
  fbTabSettingEnabled := false;
end;

procedure TPOSSplitAccount.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TPOSSplitAccount.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      MyConnection.Connected := true;
      if not MyConnection.intransaction then begin
        MyConnection.StartTransaction;
      end;
      RefreshBarTabQueries;
      OpenQueries;
      cboClientFrom.LookupTable.Locate('ClientID', fiFromClientID, [loCaseInsensitive]);
      cboClientFrom.Text := cboClientFrom.LookupTable.FieldByName('Company').AsString;

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TPOSSplitAccount.cboClientFromCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  fiFromClientID := LookupTable.FieldByName('ClientID').AsInteger;
  RefreshBarTabQueries;
end;

procedure TPOSSplitAccount.cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  fiToClientID := LookupTable.FieldByName('ClientID').AsInteger;
  RefreshBarTabQueries;
  fiToSaleID := 0;
end;

procedure TPOSSplitAccount.RefreshBarTabQueries;
begin
  //From BarTab
  qryFromBarTab.Close;
  qryFromBarTab.Connection := MyConnection;
  qryFromBarTab.ParamByName('xClientID').asInteger := fiFromClientID;
  qryFromBarTab.Open;

  //To BarTab
  qryToBarTab.Close;
  qryToBarTab.Connection := MyConnection;
  qryToBarTab.ParamByName('xClientID').asInteger := fiToClientID;
  qryToBarTab.Open;

  //Refresh Totals
  PostMessage(self.Handle, SX_CalcTotalsMsg, 0, 0);
  SetControlFocus(grdFromBarTab);
end;

procedure TPOSSplitAccount.cmdSaveClick(Sender: TObject);
begin
  inherited;
  SaveTransaction;
  Self.Close;
end;

procedure TPOSSplitAccount.SaveTransaction;
begin
  if (MyConnection.intransaction) then try
      CommitTransaction;
    except
      on e: Exception do begin
        Audit.AddEntry(e, Self);
        RollbackTransaction;
        raise Exception.Create(e.Message + Chr(13) + 'Errors occured in ' + Self.ClassName);
      end;
    end;
end;

procedure TPOSSplitAccount.MoveLineItem(SaleLineID, ToSaleID: integer);
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := MyConnection;
  try
    qryTemp.Sql.Add('UPDATE tblsaleslines_pos SET SaleID =' + IntToStr(ToSaleID) + ' ');
    qryTemp.Sql.Add('WHERE SaleLineID =' + IntToStr(SaleLineID) + ';');
    try
      qryTemp.Execute;
    except
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TPOSSplitAccount.CreateSaleHeader;
begin
  //Get Current Sale
  tblMaster.Close;
  tblMaster.Connection := MyConnection;
  tblMaster.ParamByName('ID').asInteger := fiFromSaleID;
  tblMaster.Open;
  //Clone It
  fiToSaleID := CloneRecord(tblMaster, 'SaleID');
  //Refresh to Get Cloned Record
  tblMaster.Close;
  tblMaster.Connection := MyConnection;
  tblMaster.ParamByName('ID').asInteger := fiToSaleID;
  tblMaster.Open;
  //Changes Fields As Needed
  tblMaster.Edit;
  tblMaster.FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + tblMaster.FieldByName('SaleID').AsString;
  tblMaster.FieldByName('CustomerName').AsString := cboClient.Text;
  tblMaster.FieldByName('ClientID').AsString := cboClient.LookupTable.FieldByName('ClientID').AsString;
  tblMaster.Post;
  tblMaster.Close;
end;


procedure TPOSSplitAccount.MoveItemExecute(Sender: TObject);
var
  OldSaleID, i: integer;
begin
  inherited;
  if (grdFromBarTab.SelectedList.Count > 0) then begin
    qryFromBarTab.GotoBookmark(grdFromBarTab.SelectedList.Items[0]);
    fiFromSaleID := qryFromBarTab.FieldByName('SaleID').AsInteger;
    if (fiToSaleID = 0) then begin
      CreateSaleHeader;
    end;
    for i := 0 to grdFromBarTab.SelectedList.Count - 1 do begin
      qryFromBarTab.GotoBookmark(grdFromBarTab.SelectedList.Items[i]);
      OldSaleID := qryFromBarTab.FieldByName('SaleID').AsInteger;
      //Move Item
      MoveLineItem(qryFromBarTab.FieldByName('SaleLineID').AsInteger, fiToSaleID);
      //Reset Total From
      ResetAccountTotals(OldSaleID);
      //Reset Total To
      ResetAccountTotals(fiToSaleID);
    end;
    grdFromBarTab.UnselectAll;
    //Refresh Grids
    RefreshBarTabQueries;
  end else Begin
      fiFromSaleID := qryFromBarTab.FieldByName('SaleID').AsInteger;
      if (fiToSaleID = 0) then begin
        CreateSaleHeader;
      end;
      OldSaleID := qryFromBarTab.FieldByName('SaleID').AsInteger;
      //Move Item
      MoveLineItem(qryFromBarTab.FieldByName('SaleLineID').AsInteger, fiToSaleID);
      //Reset Total From
      ResetAccountTotals(OldSaleID);
      //Reset Total To
      ResetAccountTotals(fiToSaleID);

    grdFromBarTab.UnselectAll;
    //Refresh Grids
    RefreshBarTabQueries;

  end;
end;

procedure TPOSSplitAccount.MoveItemUpdate(Sender: TObject);
begin
  inherited;
  btnMoveItem.Enabled := not Empty(cboClient.Text);
  btnMoveAll.Enabled := btnMoveItem.Enabled;
end;

procedure TPOSSplitAccount.CalcTotals;
var
  dTotalAmountInc, dTotalAmountInc2: currency;
begin
  dTotalAmountInc := 0.00;
  dTotalAmountInc2 := 0.00;
  qryFromBarTab.DisableControls;
  qryToBarTab.DisableControls;
  with qryFromBarTab do begin
    First;
    while not Eof do begin
      dTotalAmountInc := dTotalAmountInc + qryFromBarTabTotalLineAmountInc.AsFloat;
      Next;
    end;
  end;
  with qryToBarTab do begin
    First;
    while not Eof do begin
      dTotalAmountInc2 := dTotalAmountInc2 + qryToBarTabTotalLineAmountInc.AsFloat;
      Next;
    end;
  end;
  qryFromBarTab.EnableControls;
  qryToBarTab.EnableControls;
  grdFromBarTab.ColumnByName('TotalLineAmountInc').FooterValue := FloatToStrF(dTotalAmountInc, ffCurrency, 15, CurrencyRoundPlaces);
  grdToBarTab.ColumnByName('TotalLineAmountInc').FooterValue := FloatToStrF(dTotalAmountInc2, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TPOSSplitAccount.PerformCalcTotals(var Msg: TMessage);
begin
  CalcTotals;
end;

procedure TPOSSplitAccount.EndSwipeCard;
var
  iClientID: integer;
begin
  bSwipeCardInProgress := false;
  if not Empty(sCardNumber) then begin
    iClientID := GetClientIDFromCard(sCardNumber);
    if iClientID <> 0 then begin
      cboClient.LookupTable.Locate('ClientID', iClientID, [loCaseInsensitive]);
      cboClient.Text := Trim(cboClient.LookupTable.FieldByName('Company').AsString);
      fiToClientID := cboClient.LookupTable.FieldByName('ClientID').AsInteger;
      RefreshBarTabQueries;
      fiToSaleID := 0;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('Invalid Card Number', mtWarning, [mbOK], 0); // or some other appropriate message
  end;
end;

procedure TPOSSplitAccount.FormKeyPress(Sender: TObject; var Key: char);

  procedure AddCharToCardNumber(cChar: char);
  begin
    sCardNumber := sCardNumber + cChar;
  end;
begin
  inherited;
  if bSwipeCardInProgress then begin
    if Key = #13 then begin
      EndSwipeCard;
    end else if IsPrintable(char(Key)) then begin
      AddCharToCardNumber(char(Key));
    end;
    Key := #0;
  end else begin
    case Key of
      '%', ';':
        begin
          SwipeCardFn;
          AddCharToCardNumber(Key);
        end;
    end;
    // Key := #0;
  end;
end;

procedure TPOSSplitAccount.SwipeCardFn;
begin
  bSwipeCardInProgress := true;
  sCardNumber := '';
end;

procedure TPOSSplitAccount.ResetAccountTotals(SaleID: integer);
var
  qryTemp: TERPQuery;
  TotalInc, TotalEx, TotalTax: currency;

  function GetSalelinesTotals(const ID: string; var TotalEx: currency; var TotalTax: currency): currency;
  begin
    with qryTemp do begin
      {Correct SaleLines}
      SQL.Clear;
      Sql.Add('SELECT  SaleID, Sum(TotalLineAmountInc) as TotalSaleInc, Sum(TotalLineAmount) as TotalSaleEx ');
      Sql.Add('FROM tblsaleslines_pos Where SaleID = ' + ID + ' Group By SaleID ');
      //Prepared := false;
      Application.ProcessMessages;
      Open;
      if not qryTemp.IsEmpty then begin
        Result := qryTemp.FieldByName('TotalSaleInc').asCurrency;
        TotalEx := qryTemp.FieldByName('TotalSaleEx').asCurrency;
        TotalTax := RoundCurrency(Result - TotalEx);
      end else begin
        Result := 0.00;
        TotalEx := 0.00;
        TotalTax := 0.00;
      end;
    end;
  end;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := MyConnection;
  try
    TotalInc := GetSalelinesTotals(IntToStr(SaleID), TotalEx, TotalTax);
    qryTemp.SQL.Clear;
    qryTemp.Sql.Add('UPDATE tblsales_pos SET TotalTax =' + FloatToStr(TotalTax) + ',TotalAmount =' + FloatToStr(TotalEx) + ',');
    qryTemp.Sql.Add('TotalAmountInc =' + FloatToStr(TotalInc) + ' ');
    qryTemp.Sql.Add('WHERE SaleID =' + IntToStr(SaleID) + ';');
    try
      qryTemp.Execute;
    except
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;  

procedure TPOSSplitAccount.SetClientID(iValue: integer);
begin
  fiClientID := iValue;
  if fiClientID <> 0 then begin
    cboClient.LookupTable.Locate('ClientID', fiClientID, [loCaseInsensitive]);
    cboClient.Text := Trim(cboClient.LookupTable.FieldByName('Company').AsString);
    fiToClientID   := cboClient.LookupTable.FieldByName('ClientID').AsInteger;
    RefreshBarTabQueries;
    fiToSaleID := 0;
  end;
end;

procedure TPOSSplitAccount.DivertComboDblClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  foCombo := TPOSSplitAccount(Self).cboClient;
  if not FormStillOpen('TCustomerListGUI') then begin
    tmpComponent := GetComponentByClassName('TCustomerListGUI');
    If not Assigned(tmpComponent) then Exit;
    with TCustomerListGUI(tmpComponent) do begin
        FormStyle := fsMDIChild;
        OnGridDataSelect := OnCustomerSelect;
        BringToFront;
    end;
  end else begin
    with TCustomerListGUI(FindExistingComponent('TCustomerListGUI')) do begin
        Show;
        BringToFront;
    end;    
  end;

//  if not Assigned(CustomerListGUI) then begin
//    CustomerListGUI           := TCustomerListGUI.Create(self);
//    CustomerListGUI.FormStyle := fsMDIChild;
//    CustomerListGUI.OnGridDataSelect := OnCustomerSelect;
//    CustomerListGUI.BringToFront;
//  end else begin
//    CustomerListGUI.Show;
//    CustomerListGUI.BringToFront;
//  end;
end;

procedure TPOSSplitAccount.OnCustomerSelect(Sender: TwwDBGrid);
begin
  ClientIDFromList := Sender.DataSource.DataSet.FieldByName('ClientID').AsInteger;
end;

procedure TPOSSplitAccount.btnMoveAllClick(Sender: TObject);
begin
  inherited;
  grdFromBarTab.SelectAll;
  Application.ProcessMessages;
  btnMoveItem.Click;
end;

initialization
  RegisterClassOnce(TPOSSplitAccount);
  with FormFact do begin
    //
  end;
end.
