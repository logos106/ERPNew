unit frmProductSOInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog,
  AppEvnts, DB,  ExtCtrls, DNMPanel, MemDS, Grids, Wwdbigrd,
  Wwdbgrid, StdCtrls, Buttons, DNMSpeedButton, KbmMemTable, Menus, AdvMenus, Shader,
  ImgList, ProgressDialog;

const
  SX_CalcTotalsMsg = WM_USER + 100;

type
  TfrmProductSOInfoGUI = class(TBaseInputGUI)
    DNMPanel2: TDNMPanel;
    grdMain: TwwDBGrid;
    qryETA: TERPQuery;
    dsETA: TDataSource;
    btnClose: TDNMSpeedButton;
    qryETAProductName: TWideStringField;
    qryETAProductID: TIntegerField;
    qryETASO: TIntegerField;
    qryETAQty: TFloatField;
    qryETADept: TWideStringField;
    qryETACustomerName: TWideStringField;
    qryETAGlobalRef: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryETAShipDate: TDateField;
    chkshowETA: TCheckBox;
    qryETAminETADate: TDateField;
    qryETAMaxETADate: TDateField;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
    procedure qryETAAfterOpen(DataSet: TDataSet);
    procedure btnCloseClick(Sender: TObject);
    procedure chkshowETAClick(Sender: TObject);
  private
    fbIsBO: Boolean;
    { Private declarations }
    procedure PerformCalcTotals(var Msg: TMessage); message SX_CalcTotalsMsg;
    procedure SetIsBO(const Value: Boolean);
    procedure RefreshQuery;
    
  public
    Property IsBO :Boolean read fbIsBO write SetIsBO;
  end;

implementation

uses
  DNMExceptions, FormFactory, frmSalesOrder,
  AppContextObj, CommonLib, FastFuncs;

{$R *.dfm}

{ TBaseInputGUI }
procedure TfrmProductSOInfoGUI.RefreshQuery;
var
  iClassID: integer;
begin
    try
      iClassID := 0;
      qryETA.disablecontrols;
      try
        closedb(qryETA);
        qryETA.SQL.Clear;
        qryETA.SQL.Add('SELECT S.GlobalRef,');
        qryETA.SQL.Add('S.CustomerName,');
        qryETA.SQL.Add('SL.ProductName, SL.ProductID, ');
        qryETA.SQL.Add('Sum(PQa.Qty) AS Qty, ');
        qryETA.SQL.Add('SL.SaleID AS "SO#", S.Class AS "Dept",');
        qryETA.SQL.Add('S.ShipDate as ShipDate,');
        if chkshowETA.checked then qryETA.SQL.Add('POL.minETADate, POL.MaxETADate')
        else qryETA.SQL.Add('convert(null , Datetime)  as minETADate, convert(null , Datetime)  as MaxETADate');
        qryETA.SQL.Add('FROM tblsaleslines SL');
        qryETA.SQL.Add('INNER JOIN tblsales S Using(SaleID)');
        qryETA.SQL.Add('inner join tblpqa pqa on sL.SaleId = pqa.transId and SL.saleLineId =  Pqa.translineId and pqa.transtype IN ("TSalesOrderline", "TPOSLaybyLines")  and pqa.active ="T"');
        if chkshowETA.checked then
          qryETA.SQL.Add('Left join (Select SaleLineID, Min(ETADate) minETADate, Max(ETADate) MaxETADate from    tblpurchaselines group by SaleLineID) POL on SL.SaleLineID = POL.SaleLineID');
        qryETA.SQL.Add('WHERE (S.IsSalesOrder="T" or (S.ISLayby = "T" and S.Paid = "F")) AND S.Converted="F" AND SL.ProductID = :xPartID ');
        if fbIsBO then qryETA.SQL.Add('AND PQa.isbo="T"') else qryETA.SQL.Add('AND PQa.ISBO ="F"');
        if AppContext.ContextExists('PartDrillInfo') then begin
          if AppContext['PartDrillInfo'].VarExists('Department') then begin
            iClassID := AppContext['PartDrillInfo'].IntVar['Department'];
          end;
          AppContext.DeleteContext('PartDrillInfo');
        end;

        if iClassID <> 0 then begin
          qryETA.SQL.Add('AND ClassID = ' + IntToStr(iClassID));
        end;

        qryETA.SQL.Add('GROUP BY SL.SaleID;');

        qryETA.Params.ParamByName('xPartID').AsInteger := KeyID;
        opendb(qryETA);
      finally
        qryETA.enablecontrols;
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
procedure TfrmProductSOInfoGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
      inherited;
      if GuiPrefs.active = False then GuiPrefs.active := True;
      chkshowETA.checked :=  GuiPrefs.Node['Options.showETA'].AsBoolean;
      RefreshQuery;
      OpenQueries;
      qryETAminETADate.Visible :=chkshowETA.checked ;
      qryETAmaxETADate.Visible :=chkshowETA.checked ;
  finally
    EnableForm;
  end;  
end;

procedure TfrmProductSOInfoGUI.chkshowETAClick(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = chkshowETA then RefreshQuery;
end;

procedure TfrmProductSOInfoGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  GuiPrefs.Node['Options.showETA'].AsBoolean:= chkshowETA.checked;
  // Release form from memory.
  Action := caFree;
end;

procedure TfrmProductSOInfoGUI.FormCreate(Sender: TObject);
begin
  // Ignore Access Levels.
  Self.fbIgnoreAccessLevels := true;

  inherited;
end;

procedure TfrmProductSOInfoGUI.grdMainDblClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  // If the PO # is valid then open related purchase order.
  if (not qryETA.FieldByName('SO#').IsNull) and (qryETA.FieldByName('SO#').AsInteger <> 0) then begin
    Form := GetComponentByClassName('TSalesOrderGUI');
    if Assigned(Form) then begin //if has acess
      with TSalesOrderGUI(Form) do begin
        KeyID := qryETA.FieldByName('SO#').AsInteger;
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  end;

  // Close the form down.
  Close;
end;

procedure TfrmProductSOInfoGUI.qryETAAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryETA.IndexFieldNames := '"SO#" ASC CIS';
  PostMessage(Self.Handle, SX_CalcTotalsMsg, 0, 0);
  qryETAminETADate.Visible :=chkshowETA.checked ;
  qryETAmaxETADate.Visible :=chkshowETA.checked ;
  if chkshowETA.checked  then width :=868 else width :=691;
end;

procedure TfrmProductSOInfoGUI.SetIsBO(const Value: Boolean);
begin
  fbIsBO := Value;
  if Value then TitleLabel.caption := 'Product Allocated S.O.B.O. Information'
  else TitleLabel.caption := 'Product Allocated S.O. Information';
  Self.caption :=TitleLabel.caption;
end;

procedure TfrmProductSOInfoGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmProductSOInfoGUI.PerformCalcTotals(var Msg: TMessage);
var
  mem: TKbmMemTable;
  dTotal: double;
begin
  dTotal := 0; 
  mem := TKbmMemTable.Create(nil);
  try
    mem.LoadFromDataset(qryETA, [mtcpoStructure, mtcpoProperties]);
    mem.First;

    while not mem.Eof do begin
      // Accumulate total.
      dTotal := dTotal + mem.FieldByName('Qty').AsFloat;
      // Fetch next record.
      mem.Next;
    end;

    // Now show in footer.
    grdMain.ColumnByName('Qty').FooterValue := FloatToStrF(dTotal, ffFixed, 15, 4);
  finally
    // Free our allocated objects.
    if Assigned(mem) then
      FreeAndNil(mem);
  end;
end;

initialization
  RegisterClassOnce(TfrmProductSOInfoGUI);
  with FormFact do begin
    RegisterMe(TfrmProductSOInfoGUI, 'TProductListGUI_AllocatedSO_OnSORequest=PARTSID');
    RegisterMe(TfrmProductSOInfoGUI, 'TProductListGUI_SOBackOrders_OnSORequest=PARTSID');
    RegisterMe(TfrmProductSOInfoGUI, 'TProductQtylistGUI_AllocatedSO_OnSORequest=PARTSID');
    RegisterMe(TfrmProductSOInfoGUI, 'TProductQtylistGUI_SOBackOrders_OnSORequest=PARTSID');
    //RegisterMe(TfrmProductSOInfoGUI, 'TProductSalesListGUI_Sales Orders=PartsID');
    RegisterMe(TfrmProductSOInfoGUI, 'TProductSalesListFormSoldGUI_Sales Orders=PartsID');
    RegisterMe(TfrmProductSOInfoGUI, 'TProductSalesListFormNotSoldGUI_Sales Orders=PartsID');
  end;
end.
