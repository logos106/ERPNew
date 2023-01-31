unit frmProductInvInfo;

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
  TfrmProductBOInfoGUI = class(TBaseInputGUI)
    DNMPanel2: TDNMPanel;
    grdMain: TwwDBGrid;
    qryETA: TERPQuery;
    dsETA: TDataSource;
    qryETAProductName: TWideStringField;
    qryETAProductID: TIntegerField;
    qryETABackorder: TFloatField;
    qryETAInv: TIntegerField;
    qryETADept: TWideStringField;
    qryETAGlobalRef: TWideStringField;
    qryETACustomerName: TWideStringField;
    DNMPanel1: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    btnClose: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
    procedure qryETAAfterOpen(DataSet: TDataSet);
    procedure btnCloseClick(Sender: TObject);

  private
    { Private declarations }
    procedure PerformCalcTotals(var Msg: TMessage); message SX_CalcTotalsMsg;
  public
    { Public declarations }
  end;

implementation

uses
  DNMExceptions, FormFactory, frmInvoice, 
  AppContextObj, CommonLib, FastFuncs;

{$R *.dfm}

{ TBaseInputGUI }

procedure TfrmProductBOInfoGUI.FormShow(Sender: TObject);
var
  iClassID: integer;
begin
  DisableForm;
  try
    try
      inherited;
      iClassID := 0;
      qryETA.SQL.Clear;
      qryETA.SQL.Add('SELECT S.CustomerName , S.GlobalRef,');
      qryETA.SQL.Add('SL.ProductName, SL.ProductID, Sum(SL.Backorder) AS Backorder, SL.SaleID AS "Inv #", S.Class AS "Dept"');
      qryETA.SQL.Add('FROM tblsaleslines SL');
      qryETA.SQL.Add('INNER JOIN tblsales S Using(SaleID)');
      qryETA.SQL.Add('Left join tblsales BO on BO.globalref = S.BOID and BO.deleted ="F"');
      qryETA.SQL.Add('WHERE S.IsInvoice="T" AND SL.ProductID = :xPartID AND SL.BackOrder <> 0 AND');
      qryETA.SQL.Add('SL.shipped =0 AND (SL.PARTTYPE="INV" OR SL.PARTTYPE="GRP") and (ifnull(S.BOID,"") ="" Or ifnull(BO.saleID,0)=0)');
      if AppContext.ContextExists('PartDrillInfo') then begin
        if AppContext['PartDrillInfo'].VarExists('Department') then begin
          iClassID := AppContext['PartDrillInfo'].IntVar['Department'];
        end;

        AppContext.DeleteContext('PartDrillInfo');
      end;

      if iClassID <> 0 then begin
        qryETA.SQL.Add('AND S.ClassID = ' + IntToStr(iClassID));
      end;

      qryETA.SQL.Add('GROUP BY SL.SaleID;');

      qryETA.Params.ParamByName('xPartID').AsInteger := KeyID;
      OpenQueries;

      // Our exception handler.
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

procedure TfrmProductBOInfoGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  // Release form from memory.
  Action := caFree;
end;

procedure TfrmProductBOInfoGUI.FormCreate(Sender: TObject);
begin
  // Ignore Access Levels.
  Self.fbIgnoreAccessLevels := true;
  inherited;
end;

procedure TfrmProductBOInfoGUI.grdMainDblClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  // If the PO # is valid then open related purchase order.
  if (not qryETA.FieldByName('Inv #').IsNull) and (qryETA.FieldByName('Inv #').AsInteger <> 0) then begin
    Form := GetComponentByClassName('TInvoiceGUI');
    if Assigned(Form) then begin //if has acess
      with TInvoiceGUI(Form) do begin
        KeyID := qryETA.FieldByName('Inv #').AsInteger;
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  end;

  // Close the form down.
  Close;
end;

procedure TfrmProductBOInfoGUI.qryETAAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryETA.IndexFieldNames := '"Inv #" ASC CIS';
  PostMessage(Self.Handle, SX_CalcTotalsMsg, 0, 0);
end;

procedure TfrmProductBOInfoGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmProductBOInfoGUI.PerformCalcTotals(var Msg: TMessage);
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
      dTotal := dTotal + mem.FieldByName('Backorder').AsFloat;
      // Fetch next record.
      mem.Next;
    end;

    // Now show in footer.
    grdMain.ColumnByName('Backorder').FooterValue := FloatToStrF(dTotal, ffFixed, 15, 4);
  finally
    // Free our allocated objects.
    if Assigned(mem) then
      FreeAndNil(mem);
  end;
end;

initialization
  RegisterClassOnce(TfrmProductBOInfoGUI);
  with FormFact do begin
    RegisterMe(TfrmProductBOInfoGUI, 'TProductListGUI_AllocatedBO_OnBORequest=PARTSID');
    RegisterMe(TfrmProductBOInfoGUI, 'TProductQtylistGUI_AllocatedBO_OnBORequest=PARTSID');
    //RegisterMe(TfrmProductBOInfoGUI, 'TProductSalesListGUI_Invoice BO=PartsID');
    RegisterMe(TfrmProductBOInfoGUI, 'TProductSalesListFormSoldGUI_Invoice BO=PartsID');
    RegisterMe(TfrmProductBOInfoGUI, 'TProductSalesListFormNotSoldGUI_Invoice BO=PartsID');

  end;
end.
