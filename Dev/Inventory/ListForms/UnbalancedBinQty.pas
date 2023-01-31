unit UnbalancedBinQty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, wwdblook,  Shader,
  Forms,kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TUnbalancedBinQtyGUI = class(TBaseListingGUI)
    Panel4: TPanel;
    Label4: TLabel;
    cboClass: TwwDBLookupCombo;
    cboClassQry: TERPQuery;
    qryMainProductName: TWideStringField;
    qryMainSalesDescription: TWideStringField;
    qryMainInStock: TFloatField;
    qryMainInBins: TFloatField;
    qryMainFirstcolumn: TWideStringField;
    qryMainSecondcolumn: TWideStringField;
    qryMainthirdcolumn: TWideStringField;
    qryMainPartsID: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    fbformShown:Boolean;
    procedure PickSlipBeforeshow(Sender: TObject);

    { Private declarations }
  public
    { Public declarations }
  protected
    procedure RefreshQuery; override;
    procedure ReadnApplyGuiPrefExtra;override;
  end;

  //var
  //  UnbalancedBinQtyGUI: TUnbalancedBinQtyGUI;

implementation

uses pqalib, frmPartsFrm, PickSlipList, CommonLib,
  AppEnvironment, ProductQtyLib, busobjPQA, frmStockAdjustEntryFlat,
  CommonFormLib;

{$R *.dfm}
procedure TUnbalancedBinQtyGUI.ReadnApplyGuiPrefExtra;
begin
  grpFilters.itemindex := 3;
end;

procedure TUnbalancedBinQtyGUI.RefreshQuery;
begin
  if QryMain.Active then QryMain.Close;
  qrymain.Params.ParamByName('ClassID').AsString := cboClassQry.FieldByName('ClassID').AsString;
  QryMain.filter := '[In Bins] <> [In Stock]';
  QryMain.Filtered := True;
  //QryMain.Open;
  inherited;

  qryMain.FieldByName('Product Name').DisplayWidth := 15;
  qryMain.FieldByName('ThirdColumn').DisplayWidth := 15;
  qryMain.FieldByName('SecondColumn').DisplayWidth := 15;
  qryMain.FieldByName('FirstColumn').DisplayWidth := 15;
  qryMain.FieldByName('Sales Description').DisplayWidth := 31;
end;

procedure TUnbalancedBinQtyGUI.FormShow(Sender: TObject);
begin
  cboClassQry.Open;
  cboClassQry.Locate('ClassName', AppEnv.DefaultClass.DefaultClassName, [loCaseInsensitive]);
  cboClass.LookupValue := AppEnv.DefaultClass.DefaultClassName;
  qryMain.Close;
  grpFilters.ItemIndex:= 2;
  inherited;
  fbformShown:= true;
end;

procedure TUnbalancedBinQtyGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;

procedure TUnbalancedBinQtyGUI.cmdNewClick(Sender: TObject);
var 
  Form: TComponent;
begin
  inherited;
  if not FormStillOpen('TfrmParts') then begin
    Form := GetComponentByClassName('TfrmParts');
    if Assigned(Form) then begin //if has acess
      with TForm(Form) do begin
        FormStyle := fsmdiChild;
        BringToFront;
      end;
    end;  
  end else begin
    with TForm(FindExistingComponent('TfrmParts')) do begin
      Show;
      BringToFront;
    end;
  end;
end;

procedure TUnbalancedBinQtyGUI.grdMainDblClick(Sender: TObject);
var 
  Form: TComponent;
  ans :Integer;
begin
  ans:= MessageDlgXP_Vista('Do you wish to View the Product?'+chr(13) +chr(13)+'Click on ''Fix Bin'' to adjust the Bin''s Quantity.', mtconfirmation ,[mbyes, mbno], 0 , nil, '','',False, nil, 'Fix Bin');
  if ans = mrno then Exit;
  if ans = mrYes then begin
    Form := GetComponentByClassName('TfrmParts');
    if Assigned(Form) then begin //if has acess
      with TfrmParts(Form) do begin
        OpenToQuantities;
        KeyID := qryMainPartsID.asInteger;
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        Pagecontrol.ActivePage :=tabBatch;
        OnTabTabBatch(Pagecontrol);
        BringToFront;
      end;
    end;
  end else begin
    form :=  GetComponentByClassName('TfmStockAdjustEntryflat');
    if Assigned(form) then begin
        TfmStockAdjustEntryflat(Form).FormStyle := fsMDIChild;
        TfmStockAdjustEntryflat(Form).BringToFront;
        TfmStockAdjustEntryflat(Form).stockAdjust.New;
        if TfmStockAdjustEntryflat(Form).StockAdjust.accountID> 0 then begin
            TfmStockAdjustEntryflat(Form).StockAdjust.PostDB;
            TfmStockAdjustEntryflat(Form).StockAdjust.Lines.New;
            TfmStockAdjustEntryflat(Form).StockAdjust.Lines.ProductID := qryMainPartsID.asInteger;
            TfmStockAdjustEntryflat(Form).StockAdjust.Lines.DeptID    := cboClassQry.FieldByName('ClassID').asInteger;
            TfmStockAdjustEntryflat(Form).StockAdjust.Lines.PostDB;
            SetControlFocus(TfmStockAdjustEntryflat(Form).grdTransactions);
        end;
    end;
    self.Close;
  end;
end;

procedure TUnbalancedBinQtyGUI.grpFiltersClick(Sender: TObject);
begin
  {baselisting trying to read the filter index from preference and when not found sets to 0 which is opening the picking slip list}
  if not fbformShown then begin
    grpFilters.ItemIndex:= 2;
    Exit;
  end;

  if grpFilters.ItemIndex in [0, 1] then  begin
    OpenErpListform('TPickSlipGUI' , PickSlipBeforeshow);
    Self.close;
  end;
end;
procedure TUnbalancedBinQtyGUI.PickSlipBeforeshow(Sender: TObject);
begin
  if not(Sender is TPickSlipGUI) then exit;
  TPickSlipGUI(Sender).grpfilters.ItemIndex := Self.grpfilters.ItemIndex;
end;

procedure TUnbalancedBinQtyGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  grpfilters.visible := False;
  try
      inherited;
  finally
    grpfilters.Visible := True
  end;


end;

procedure TUnbalancedBinQtyGUI.FormCreate(Sender: TObject);
begin
  fbformShown:= False;
  inherited;
  Qrymain.Disablecontrols;
  try
    if Qrymain.Active then Qrymain.close;
    Qrymain.SQL.Clear;
    Qrymain.SQL.add('SELECT ');
    Qrymain.SQL.Add('PARTNAME as "Product Name",');
    Qrymain.SQL.add('PARTSDESCRIPTION as "Sales Description",');
    Qrymain.SQL.add(Firstcolumn + ' as Firstcolumn,');
    Qrymain.SQL.add(Secondcolumn + ' as Secondcolumn,');
    Qrymain.SQL.add(Thirdcolumn + ' as ThirdColumn,');
    Qrymain.Sql.Add(SQL4Qty(tInStock)+' as "In Stock",');
    Qrymain.Sql.Add('ifnull(sum((Select ' + SQL4Qty(tInStock, 'PQA' ,'PQABins.Qty' )+
                          ' from  tblPQADetails as PQABins Where PQABins.PQAtype = ' + QuotedStr(TPQAbins.PQADetailtype) +
                          '  and  PQABins.PQAID = PQA.PQAID )),0) as "In Bins",');
    Qrymain.SQL.add('P.PartsID');
    Qrymain.Sql.Add('FROM ' + ProductTables(tSummary));
    Qrymain.Sql.Add('WHERe P.Multiplebins = "T" and PC.ClassID = :ClassID   ');
    Qrymain.SQL.Add('GROUP BY P.PARTSID');
    RefreshOrignalSQL;
  finally
      Qrymain.enableControls;
  end;
end;

initialization
  RegisterClassOnce(TUnbalancedBinQtyGUI);
end.
