unit TransactionExpressList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel,TransactionListBase , TransactionListSQL;

type
  TTransactionExpressListGUI = class(TTransactionListBaseGUI)
    edtBalanceex: TEdit;
    edtBalanceinc: TEdit;
    qryMaintransid: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainGLOBALREF: TWideStringField;
    qryMainTYPE: TWideStringField;
    qryMainDEBITSEX: TFloatField;
    qryMainCREDITSEX: TFloatField;
    qryMainDEBITSINC: TFloatField;
    qryMainCREDITSINC: TFloatField;
    qryMainEXDiff: TFloatField;
    qryMainIncDiff: TFloatField;
    btnfinddiff: TDNMSpeedButton;
    btnfindnfix: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure actClearFilterExecute(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);
    procedure dofindDiff(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);
  private
    //fsTranslistTablename: String;
    findingdiff:boolean;
    EnableCalcfooter:Boolean;
    procedure makeQrymain;
    Procedure showDiff;
    procedure initBOMSalesPPGTransJournal(Sender: TObject);
    procedure RecalculateTreecostnPrice(SaleID:Integer);
  Protected
    procedure RefreshTotals; override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    Function TransListtype : TTransListtype;Override;
  public
    //Property TranslistTablename :String read fsTranslistTablename write fsTranslistTablename;
    Procedure RefreshQuery;Override;
  end;

implementation

uses LogLib, tcConst, BusobjCustomFilter, CommonLib, CommonDbLib, CommonFormLib,
  BOMSalesPPGTransJournal, BusObjSales;

{$R *.dfm}

procedure TTransactionExpressListGUI.actClearFilterExecute(Sender: TObject);
begin
  inherited;
  if findingdiff then exit;
  RefreshTotals;
end;

procedure TTransactionExpressListGUI.dofindDiff(Sender: TObject);
var
  sGloablref, stype:String;
begin
  Qrymain.disablecontrols;
  try
    if not findingdiff then begin
      clog('');
      qryMain.IndexFieldNames := Qrymaintype.fieldname +' ASC, ' + Qrymainglobalref.FieldName +' ASC';
      Qrymain.First;
    end;
    DoShowProgressbar(Qrymain.recordcount,WAITMSG);
    try
    While Qrymain.Eof = False do begin
      EnableCalcfooter:= False;
      try
        if findingdiff then begin
            sGloablref:= Qrymainglobalref.asString;
            stype := Qrymaintype.asString;
            Qrymain.Last;
            mnuClearFilter.Click;
            while (Qrymain.Eof = False) and Sametext(sGloablref ,Qrymainglobalref.AsString) and sametext(stype, qrymaintype.asString) do  Qrymain.Next;
        end;

        if Qrymain.Eof then begin
          findingdiff:= False;
          mnuClearFilter.Click;
          Exit;
        end;
        findingdiff:= True;
        Customfilter.Addfilter(Qrymainglobalref, AndFilter);
        Customfilter.Addfilter(qrymaintype, AndFilter);
        RefreshfilterLabel;
      finally
        EnableCalcfooter:= true;
      end;
      PreviewFilteredReport;
      Logtext( qryMainType.AsString +':' +  Qrymainglobalref.asString +'-> Ex = ' +  edtBalanceex.Text +' ,  Inc = ' +edtBalanceinc.text);
      if (abs(strValue(edtBalanceex.Text)) >=0.05) or (abs(strValue(edtBalanceinc.text))>=0.05) then begin
        if sender = btnfindnfix then begin
            if ((qryMainEXDiff.asFloat <>0) or (qryMainIncDiff.asFloat <>0))
               and (qrymaintype.asString ='Manufacturing') then begin
               RecalculateTreecostnPrice(qrymainSaleId.asInteger);
              dofindDiff(Sender);
            end;
        end else begin
          break;
        end;
      end;
      DoStepProgressbar(qrymaintype.asString +' # ' +Qrymainglobalref.AsString );
    end;
    finally
      DoHideProgressbar;
    end;
  finally
    Qrymain.enablecontrols;
  end;
end;

procedure TTransactionExpressListGUI.FormCreate(Sender: TObject);
begin
  findingdiff := False;
  EnableCalcfooter := true;
  ReportonForeignCurrency := False;
  fbIncludehistory:= True;
  inherited;
  //btnfinddiff.visible := Devmode;
  btnfindnfix.visible := Devmode;
  SearchMode:= smFullList;
  //HaveDateRangeSelection:=False;
  //fsTranslistTablename := '';
  edtBalanceex.visible := devmode;
  edtBalanceinc.visible := devmode;
  Addcalccolumn(Qrymaindebitsex.FieldName , true);
  Addcalccolumn(QrymaincreditsEx.FieldName , true);
  Addcalccolumn(Qrymaindebitsinc.FieldName , true);
  Addcalccolumn(Qrymaincreditsinc.FieldName , true);
  Addcalccolumn(QrymainEXDiff.FieldName , true);
  Addcalccolumn(QrymainIncDiff.FieldName , true);
end;
procedure TTransactionExpressListGUI.FormDestroy(Sender: TObject);
begin
  //if not devmode then if FormstillOpen('TTransactionListGUI') then else  DeleteTable(TranslistTablename);
  inherited;
end;

procedure TTransactionExpressListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if grpfilters.itemindex <>2  then
    if sametext(Field.fieldname , qrymaintransId.fieldname) or
       sametext(Field.fieldname , qrymainGlobalref.fieldname) then
      DoHide(Field,State,AFont,ABrush);
end;
procedure TTransactionExpressListGUI.initBOMSalesPPGTransJournal(Sender: TObject);
begin
 if sender is TBOMSalesPPGTransJournalGUI then begin
   TBOMSalesPPGTransJournalGUI(Sender).SalesRef := Qrymainglobalref.asString;
 end;
end;
procedure TTransactionExpressListGUI.RecalculateTreecostnPrice(SaleID:Integer);
var
  SO:TSalesOrder;
begin
  SO:= TSalesOrder.CreateWithNewConn(Self);
  try
    SO.Load(SaleID);
    SO.connection.begintransaction;
    try
      if SO.RecalculateTreecostnPrice then begin
        SO.connection.CommitTransaction;
      end;
    Except
      on E:Exception do begin
        SO.connection.RollbackTransaction;
      end;
    end;
  finally
    FreeAndnil(SO);
  end;

end;
procedure TTransactionExpressListGUI.grdMainDblClick(Sender: TObject);
begin
showProgressbar(WAITMSG, 5);
try
  if grpFilters.itemindex =0 then begin
        mnuClearFilter.Click;                           StepProgressbar(iif(Devmode, 'Clear Filter' , ''));
        Customfilter.Addfilter(qrymaintype, AndFilter); StepProgressbar(iif(Devmode, 'Add Filter' , ''));
        grpFilters.itemindex := 1;                      StepProgressbar(iif(Devmode, 'Filter Index' , ''));
        PreviewFilteredReport;                          StepProgressbar(iif(Devmode, 'Apply Filter' , ''));
        Exit;
  end;
  if grpFilters.itemindex =1 then begin
    if ((qryMainEXDiff.asFloat <>0) or (qryMainIncDiff.asFloat <>0))
       and (qrymaintype.asString ='Manufacturing') then begin
       RecalculateTreecostnPrice(qrymainSaleId.asInteger);
      OpenERPListForm('TBOMSalesPPGTransJournalGUI' , initBOMSalesPPGTransJournal);
      Exit;
    end;
        mnuClearFilter.Click;                               StepProgressbar(iif(Devmode, 'Clear Filter' , ''));
        Customfilter.Addfilter(Qrymainglobalref, AndFilter);StepProgressbar(iif(Devmode, 'Add Filter' , ''));
        Customfilter.Addfilter(qrymaintype, AndFilter);     StepProgressbar(iif(Devmode, 'Add Filter' , ''));
        grpFilters.itemindex := 2;                          StepProgressbar(iif(Devmode, 'Filter Index' , ''));
        PreviewFilteredReport;                              StepProgressbar(iif(Devmode, 'Apply Filter' , ''));
        Exit;
  end;
finally
  HideProgressbar;
end;
  inherited;
end;

procedure TTransactionExpressListGUI.grpFiltersClick(Sender: TObject);
begin
  if not isformshown then exit;//inherited;
  MakeQrymain;
  inherited RefreshQuery;
end;

procedure TTransactionExpressListGUI.makeQrymain;
var
  msg:String;
begin
  Qrymain.disablecontrols;
  try
    closedb(qryMain);
    Qrymain.SQL.clear;
      (*Qrymain.SQL.add('select ');
      Qrymain.SQL.add('`transID` as `transID` ,');
      Qrymain.SQL.add('`DATE` as `DATE` ,');
      Qrymain.SQL.add('`SaleID` as `SaleID` ,');
      Qrymain.SQL.add('GLOBALREF as GLOBALREF ,');
      Qrymain.SQL.add('`TYPE` as `TYPE` ,');
      Qrymain.SQL.add('sum(DEBITSEX) as DEBITSEX ,');
      Qrymain.SQL.add('sum(CREDITSEX) as CREDITSEX ,');
      Qrymain.SQL.add('sum(DEBITSINC) as DEBITSINC ,');
      Qrymain.SQL.add('sum(CREDITSINC) as CREDITSINC ,');
      Qrymain.SQL.add('Sum(CREDITSEX- DEBITSEX )  as EXDiff,');
      Qrymain.SQL.add('Sum(CREDITSINC - DEBITSINC ) as IncDiff ');
      Qrymain.SQL.add('from ' + fsTablename);
         if grpfilters.itemindex =2 then Qrymain.SQL.add('group by  transId ')
    else if grpfilters.itemindex =1 then Qrymain.SQL.add('group by  type, GLOBALREF')
    else Qrymain.SQL.add('group by   type') ;
    Qrymain.SQL.add('Order by Date DESC');*)
    TransactionListReport.PopulateReportSQL(Qrymain.SQL, msg);
    RefreshOrignalSQL;
    Logtext(Qrymain.SQL.Text);
  finally
    Qrymain.EnableControls;
  end;
end;
procedure TTransactionExpressListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  findingdiff:= false;
  WriteGuiPrefExtra;
end;

procedure TTransactionExpressListGUI.RefreshQuery;
begin
  PopulateReportTable;
  MakeQrymain;
  inherited;
end;

procedure TTransactionExpressListGUI.RefreshTotals;
begin
  if not EnableCalcfooter then exit;
  inherited;
    Calcnshowfooter;
    if devmode then Showdiff;

end;

procedure TTransactionExpressListGUI.showDiff;
begin
  try
      edtBalanceex.text :=FloatToStrF(FooterCalcfieldValue('exdiff') , ffCurrency, 15, 2);
      edtBalanceinc.text:=FloatToStrF(FooterCalcfieldValue('incdiff'), ffCurrency, 15, 2);
  Except
    //kill the exception
  end;
end;
function TTransactionExpressListGUI.TransListtype: TTransListtype;
begin
  Result := tltTransExpList;
end;

procedure TTransactionExpressListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
end;
procedure TTransactionExpressListGUI.WriteGuiPrefExtra;
begin
  inherited;
end;

initialization
  RegisterClassOnce(TTransactionExpressListGUI);

end.
