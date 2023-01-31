unit frmPartsExcelPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, wwcheckbox, DNMSpeedButton, StdCtrls, Mask, wwdbedit,
  DBCtrls, ExtCtrls, DNMPanel, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  Menus , ExcelXP , frmPartsFrm, frmPartsSubBase, ExcelfileObj,
  Busobjpartsforexcelprice,BusObjBase,BaseInputForm;

type
  TfmPartsExcelPrice = class(TfmPartsSubBase)
    dspartsForExcelPrice: TDataSource;
    qrypartsForExcelPrice: TERPQuery;
    qrypartsForExcelPriceID: TIntegerField;
    qrypartsForExcelPriceProductId: TIntegerField;
    qrypartsForExcelPriceExcelPopupOption: TWideStringField;
    qrypartsForExcelPriceExcelFilename: TWideStringField;
    qrypartsForExcelPricePriceRow: TIntegerField;
    qrypartsForExcelPricePriceCol: TIntegerField;
    qrypartsForExcelPriceCostRow: TIntegerField;
    qrypartsForExcelPriceCostCol: TIntegerField;
    qrypartsForExcelPriceQtycol: TIntegerField;
    qrypartsForExcelPriceQtyRow: TIntegerField;
    qrypartsForExcelPriceActive: TWideStringField;
    qrypartsForExcelPricemsUpdateSiteCode: TWideStringField;
    qrypartsForExcelPricemstimeStamp: TDateTimeField;
    qrypartsForExcelPricePriceCell: TWideStringField;
    qrypartsForExcelPriceCostCell: TWideStringField;
    qrypartsForExcelPriceQtyCell: TWideStringField;
    qrypartsForExcelPriceExcelSellPriceOverridesOtherPrices: TWideStringField;
    qrypartsForExcelPriceUseCostInSales: TWideStringField;
    OpenDialog1: TOpenDialog;
    pnlMsg: TDNMPanel;
    lblMsg: TLabel;
    tmrExcelEscape: TTimer;
    Shape3: TDnmPanel;
    Shape4: TDnmPanel;
    Shape5: TDnmPanel;
    lblPrice: TLabel;
    Label3: TLabel;
    edtPriceCell: TwwDBEdit;
    btnPrice: TDNMSpeedButton;
    Label4: TLabel;
    edtQtyCell: TwwDBEdit;
    btnQty: TDNMSpeedButton;
    lblQty: TLabel;
    Label2: TLabel;
    edtCostCell: TwwDBEdit;
    btncost: TDNMSpeedButton;
    lblCost: TLabel;
    chkUseCostInSales: TwwCheckBox;
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    wwDBEdit1: TwwDBEdit;
    btnchooseExcelFileForPrice: TDNMSpeedButton;
    pnlActive: TDNMPanel;
    DBCheckBox1: TwwCheckBox;
    chkExcelSellPriceOverridesOtherPrices: TwwCheckBox;
    Shape1: TShape;
    Shape2: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    btnclearCost: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    DNMPanel2: TDNMPanel;
    lblNote: TLabel;
    wwCheckBox1: TwwCheckBox;
    procedure btnchooseExcelFileForPriceClick(Sender: TObject);
    procedure btncostClick(Sender: TObject);
    procedure qrypartsForExcelPriceAfterInsert(DataSet: TDataSet);
    procedure qrypartsForExcelPriceCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure btnPriceClick(Sender: TObject);
    procedure btnQtyClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tmrExcelEscapeTimer(Sender: TObject);
    procedure wwDBEdit1Exit(Sender: TObject);
    procedure chkExcelSellPriceOverridesOtherPricesExit(Sender: TObject);
    procedure chkUseCostInSalesExit(Sender: TObject);
    procedure wwCheckBox1Exit(Sender: TObject);
    procedure DBCheckBox1Exit(Sender: TObject);
    procedure btnclearCostClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
  private
    ExcelPricecelltype:String;
    aExcelObj :TExcelObj;
    ExcelObjLastEventtype:TExcelObjEventtype;
    PartsForExcelPriceobj: TPartsForExcelPrice;
    fsSelectedPrice, fsSelectedCost:String;
    procedure DoChoosecell;
    procedure OnDblClickCell(ASender: TObject;const Sh: IDispatch; const Target: ExcelRange; var Cancel: WordBool);
    function ExcelObj :TExcelObj;
    Function ExcelObjEvent(sender :TExcelObj ; Eventtype :TExcelObjEventtype):Boolean;
    Function  OnChooseCell(ASender: TObject):Boolean;
    procedure OnAfterDestroy(ASender: TObject);
    procedure OnbeforeDestory(ASender: TObject);
    procedure OnSheetDeactivate(ASender: TObject);
    procedure OnWbBeforeSave(ASender: TObject);
    procedure OnWbDeactivate(ASender: TObject);
    procedure OnWindowDeactivate(ASender: TObject);
    procedure onShowSelectionMsg(ASender: TObject);
    procedure NewBusObjinstance;
    Procedure Openrec(aconnection :TMyconnection);
    Procedure EnableExcelEscapeTimer;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Class Function  Makeinstance(AOwner :TfrmParts; ParentPanel :TDnmPanel):TfmPartsSubBase;  Override;
    Procedure Initinstance(ParentPanel :TDnmPanel);override;
  end;


implementation

uses CommonDbLib, CommonLib, LogLib, AppEnvironment, tcConst , BusObjConst;


{$R *.dfm}

procedure TfmPartsExcelPrice.btnchooseExcelFileForPriceClick(Sender: TObject);
begin
  inherited;
  if devmode then OpenDialog1.FileName := 'D:\ERP\MVRAC.xlsx';
  if OpenDialog1.Execute then begin
      EditDB(qrypartsForExcelPrice);
      qrypartsForExcelPriceExcelFilename.AsString := OpenDialog1.FileName;
      PostDB(qrypartsForExcelPrice);
  end;
end;
procedure TfmPartsExcelPrice.btncostClick (Sender: TObject);begin  ExcelPricecelltype := 'C';  DoChoosecell;  highlightcontrol(edtCostCell) ;HighlightextraControl1(pnlMsg);end;
procedure TfmPartsExcelPrice.btnPriceClick(Sender: TObject);begin  ExcelPricecelltype := 'P';  DoChoosecell;  highlightcontrol(edtPriceCell);HighlightextraControl1(pnlMsg);end;
procedure TfmPartsExcelPrice.btnQtyClick  (Sender: TObject);begin  ExcelPricecelltype := 'Q';  DoChoosecell;  highlightcontrol(edtQtyCell)  ;HighlightextraControl1(pnlMsg);end;


procedure TfmPartsExcelPrice.chkExcelSellPriceOverridesOtherPricesExit(
  Sender: TObject);
begin
  inherited;
  PartsForExcelPriceobj.postdb;
end;


function TfmPartsExcelPrice.ExcelObj: TExcelObj;
begin
  if aExcelObj = nil then begin
    aExcelObj :=  TExcelObj.Create(Self);
    Logtext('aExcelObj created');
  end;
  REsult := aExcelObj;
end;


procedure TfmPartsExcelPrice.FormCreate(Sender: TObject);
begin
  inherited;
  ExcelPricecelltype:= '';
  aExcelObj := nil;
  Logtext('aExcelObj = nil');
  ExcelObjLastEventtype := teoetNone;
  NewBusObjinstance;
  tmrExcelEscape.enabled := False;
  fsSelectedPrice:= '';
  fsSelectedCost:= '';

  lblCost.caption :=  'When Selected, This Updates Product Card Cost if blank.'+NL+'It is NOT Used in Sales as the Sales Cost' (*+NL+
                      iif(Appenv.companyprefs.CostEditableinSales , 'Preference to Edit Sales Cost is Not Enabled, So cost will not be used in Sales' ,
                                                                    'Preference to Edit Sales Cost is Enabled, So Based on the Flag Below, Cost will be used in Sales' )*);
   lblPrice.caption := 'Updates Product Card Price if blank.'+NL+
                        'Uses this Price for Sales Price Calculation.  This is the Ex(Tax) Price' ;
   lblQty.caption := 'Default Sales Quantity on the Order.';
   lblNote.caption := 'Adding/Removing Rows/Columns in the Excel Sheet'+NL+'WILL NOT'+NL+
                      'Make Relative changes to the Selections Above. ';
end;


procedure TfmPartsExcelPrice.FormDestroy(Sender: TObject);
begin
  Logtext('TfmPartsExcelPrice.FormDestroy' );
  Try
    Logtext('Freeandnil(aExcelObj)' );
    Freeandnil(aExcelObj);
  Except
    on  E:Exception do begin
      if devmode then
        Logtext('Exception Freeandnil(aExcelObj):' + E.message);
    end;
  End;
  Freeandnil(PartsForExcelPriceobj);
  inherited;
end;

procedure TfmPartsExcelPrice.Initinstance(ParentPanel :TDnmPanel);
begin
  inherited;
  closedb(qrypartsForExcelPrice);
  OpenRec(PartsForm.MyConnection);
  pnlMsg.visible := False;
  lblMsg.autosize := False;
  lblMsg.caption := '';
  lblMsg.left := 0;
  lblMsg.top :=0;
  lblMsg.width := pnlMsg.width;
  lblMsg.height := pnlMsg.height;
  lblMsg.alignment := taCenter;

end;

Class function  TfmPartsExcelPrice.Makeinstance(AOwner :TfrmParts; ParentPanel :TDnmPanel):TfmPartsSubBase;
begin
  result := TfmPartsExcelPrice.Create(AOwner);
  result.initinstance(ParentPanel);
end;

procedure TfmPartsExcelPrice.NewBusObjinstance;
begin
  {$WARNINGS OFF}
  PartsForExcelPriceobj := TPartsForExcelPrice.CreateWithNewConn(Self);
  PartsForExcelPriceobj.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}
end;

procedure TfmPartsExcelPrice.qrypartsForExcelPriceAfterInsert(DataSet: TDataSet);
begin
  inherited;
   qrypartsForExcelPriceProductId.asinteger := PartsForm.qryProductPARTSID.asInteger;
end;

procedure TfmPartsExcelPrice.qrypartsForExcelPriceCalcFields(DataSet: TDataSet);
begin
  inherited;
  if qrypartsForExcelPricePriceRow.asInteger <> 0 then
       qrypartsForExcelPricePriceCell.asString :='(' +trim(inttostr( qrypartsForExcelPricePriceRow.asInteger)) +','+trim(inttostr( qrypartsForExcelPricePriceCol.asInteger)) +')'
  else qrypartsForExcelPricePriceCell.asString :='';

  if  qrypartsForExcelPriceCostRow.asInteger <> 0 then
       qrypartsForExcelPriceCostCell.asString :='(' +trim(inttostr( qrypartsForExcelPriceCostRow.asInteger)) +','+trim(inttostr( qrypartsForExcelPriceCostCol.asInteger)) +')'
  else qrypartsForExcelPriceCostCell.asString :='';

  if qrypartsForExcelPriceQtyRow.asInteger <> 0 then
       qrypartsForExcelPriceQtyCell.asString :='(' + trim(inttostr( qrypartsForExcelPriceQtyRow.asInteger)) +','+ trim(inttostr( qrypartsForExcelPriceQtyCol.asInteger)) +')'
  else qrypartsForExcelPriceQtyCell.asString :='';

end;

procedure TfmPartsExcelPrice.DoBusinessObjectEvent(const Sender: TDatasetBusObj;
  const EventType, Value: string);
begin
  inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TPartsForExcelPrice then TPartsForExcelPrice(Sender).Dataset  := qrypartsForExcelPrice;
     end;
end;

procedure TfmPartsExcelPrice.DoChoosecell;
begin
  inherited;
  if trim(qrypartsForExcelPriceExcelFilename.AsString) = '' then  btnchooseExcelFileForPrice.Click;
  if trim(qrypartsForExcelPriceExcelFilename.AsString) = '' then  Exit;
  if not fileExists(qrypartsForExcelPriceExcelFilename.AsString) then begin
    MessageDlgXP_Vista('selected file '+quotedstr(qrypartsForExcelPriceExcelFilename.AsString)+' Doesn''t Exists', mtWarning, [mbOK], 0);
    Exit;
  end;
  ExcelObj.OpenExcelSheet(qrypartsForExcelPriceExcelFilename.AsString , ExcelObjEvent);
end;
procedure TfmPartsExcelPrice.OnDblClickCell(ASender: TObject;const Sh: IDispatch; const Target: ExcelRange; var Cancel: WordBool);
begin
  OnChooseCell(ASender);
end;

function TfmPartsExcelPrice.OnChooseCell(ASender: TObject):Boolean;
begin
  REsult := False;
  try
  if Asender is  TExcelObj then begin
     Result := True;
     EditDB(qrypartsForExcelPrice);
     if ExcelPricecelltype ='C' then begin
        qrypartsForExcelPriceCostRow.asInteger := TExcelObj(ASender).ActiveCellRow;
        qrypartsForExcelPriceCostCol.asInteger := TExcelObj(ASender).ActiveCellColumn;
        fsSelectedCost:=TExcelObj(ASender).SelectedValue;
        (*if (s<> '') and (isnumeric(s)) then
          Partsform.initCostifBlank(StrtoFloat(s));*)
        Logtext(qrypartsForExcelPriceCostRow.asString );
        EnableExcelEscapeTimer;
     end else if ExcelPricecelltype ='P' then begin
        qrypartsForExcelPricePriceRow.asInteger := TExcelObj(ASender).ActiveCellRow;
        qrypartsForExcelPricePriceCol.asInteger := TExcelObj(ASender).ActiveCellColumn;
        fsSelectedPrice:=TExcelObj(ASender).SelectedValue;
(*        if (s<> '') and (isnumeric(s)) then
          Partsform.initPriceifBlank(StrtoFloat(s));*)
        Logtext(qrypartsForExcelPricePriceCell.asString );
        EnableExcelEscapeTimer;
     end else if ExcelPricecelltype ='Q' then begin
        qrypartsForExcelPriceQtyRow.asInteger := TExcelObj(ASender).ActiveCellRow;
        qrypartsForExcelPriceQtycol.asInteger := TExcelObj(ASender).ActiveCellColumn;
        Logtext(qrypartsForExcelPriceQtyCell.asString );
        EnableExcelEscapeTimer;
     end else begin
        Result := False;
        Exit;
     end;
     PostDB(qrypartsForExcelPrice);

          if ExcelPricecelltype ='C' then Logtext(qrypartsForExcelPriceCostcell.asString )
     else if ExcelPricecelltype ='P' then Logtext(qrypartsForExcelPricePriceCell.asString )
     else if ExcelPricecelltype ='Q' then Logtext(qrypartsForExcelPriceQtyCell.asString );
  end;
  Except
  on E:Exception do begin
    MessageDlgXP_Vista('E.message', mtWarning, [mbOK], 0);
  end;
  end;
end;
procedure TfmPartsExcelPrice.OnbeforeDestory(ASender: TObject);
begin
    logtext('OnbeforeDestory:'  + FormatdateTime('dd-mm-yyyy hh:nn:ss:zz am/pm' , now));
end;
procedure TfmPartsExcelPrice.OnAfterDestroy(ASender: TObject);
begin
  logtext('OnAfterDestroy:'     + FormatdateTime('dd-mm-yyyy hh:nn:ss:zz am/pm' , now));
end;
procedure TfmPartsExcelPrice.OnWbDeactivate(ASender: TObject);
begin
  logtext('OnWbDeactivate:'     + FormatdateTime('dd-mm-yyyy hh:nn:ss:zz am/pm' , now));
end;
procedure TfmPartsExcelPrice.OnWbBeforeSave(ASender: TObject);
begin
  logtext('OnWbBeforeSave:'     + FormatdateTime('dd-mm-yyyy hh:nn:ss:zz am/pm' , now));
end;
procedure TfmPartsExcelPrice.OnSheetDeactivate(ASender: TObject);
begin
  logtext('OnSheetDeactivate:'  + FormatdateTime('dd-mm-yyyy hh:nn:ss:zz am/pm' , now));
end;
procedure TfmPartsExcelPrice.OnWindowDeactivate(ASender: TObject);
begin
  logtext('OnWindowDeactivate:' + FormatdateTime('dd-mm-yyyy hh:nn:ss:zz am/pm' , now));
end;
procedure TfmPartsExcelPrice.Openrec(aconnection :TMyconnection);
begin
  closedb(qrypartsForExcelPrice);
  qrypartsForExcelPrice.connection := aconnection;
  PartsForExcelPriceobj.Connection.connection := aconnection;
  PartsForExcelPriceobj.Loadselect('ProductId = ' + inttostr(PartsForm.qryProductPARTSID.asInteger));
end;

procedure TfmPartsExcelPrice.onShowSelectionMsg(ASender: TObject);

Function XlcolName:String;
begin
       if ExcelPricecelltype = 'C' then result := 'COST'
  else if ExcelPricecelltype = 'P' then Result := 'PRICE'
  else Result := 'QUANTITY';
end;
begin
  logtext('onShowSelectionMsg:' + FormatdateTime('dd-mm-yyyy hh:nn:ss:zz am/pm' , now));
  if (ExcelPricecelltype ='C') or (ExcelPricecelltype ='P') or (ExcelPricecelltype ='Q') then begin
    lblMsg.caption := Quotedstr(qrypartsForExcelPriceExcelFilename.AsString) +NL+
                      'is Opened for Selecting the '+quotedstr(XlcolName) +'.'+NL+NL+
                      'Please Double Click on the Cell in the Excel Sheet that'+NL+
                      'has the ' + quotedstr(XlcolName)+
                      ' for '+ appenv.defaultclass.Partcolumn +' '+ quotedstr(PartsForm.qryProductPARTNAME.asString)+'.';
    lblMsg.Refresh;
    pnlMsg.visible := True;
  end else begin
    pnlMsg.visible := False;
    HideHighlightControl;
  end;
end;

Function TfmPartsExcelPrice.ExcelObjEvent(sender :TExcelObj ; Eventtype :TExcelObjEventtype):Boolean;
begin
  Result := True;
       if Eventtype =  teoetDblclick          then Result := OnChooseCell(Sender)
  else if Eventtype =  teoetbeforeDestory     then OnbeforeDestory(Sender)
  else if Eventtype =  teoetAfterDestroy      then OnAfterDestroy(Sender)
  else if Eventtype =  teoetWbDeactivate      then OnWbDeactivate(Sender)
  else if Eventtype =  teoetWbBeforeSave      then OnWbBeforeSave(Sender)
  else if Eventtype =  teoetSheetDeactivate   then OnSheetDeactivate(Sender)
  else if Eventtype =  teoetWindowDeactivate  then OnWindowDeactivate(Sender)
  else if Eventtype =  teoetShowSelectionMsg  then onShowSelectionMsg(Sender)
  else REsult := False;
  ExcelObjLastEventtype := Eventtype;
end;
procedure TfmPartsExcelPrice.EnableExcelEscapeTimer;
begin
    tmrExcelEscape.enabled := true;
end;
procedure TfmPartsExcelPrice.tmrExcelEscapeTimer(Sender: TObject);
begin
  inherited;
  Logtext('tmrExcelEscapeTimer' );
  try
    tmrExcelEscape.enabled := False;
    ExcelObj.SendEscape;
    if (fsSelectedCost<> '') and (isnumeric(fsSelectedCost)) then
      Partsform.initCostifBlank(StrtoFloat(fsSelectedCost));
    if (fsSelectedPrice<> '') and (isnumeric(fsSelectedPrice)) then
      Partsform.initPriceifBlank(StrtoFloat(fsSelectedPrice));
  finally
    fsSelectedPrice :='';
    fsSelectedCost := '';
    Logtext('tmrExcelEscapeTimer... done' );
  end;
end;
procedure TfmPartsExcelPrice.wwCheckBox1Exit(Sender: TObject);begin  inherited;  PartsForExcelPriceobj.postdb;end;
procedure TfmPartsExcelPrice.wwDBEdit1Exit(Sender: TObject);begin  inherited;  PartsForExcelPriceobj.postdb;end;
procedure TfmPartsExcelPrice.chkUseCostInSalesExit(  Sender: TObject);begin  inherited;  PartsForExcelPriceobj.postdb;end;
procedure TfmPartsExcelPrice.DBCheckBox1Exit(Sender: TObject);begin  inherited;  PartsForExcelPriceobj.postdb;end;

procedure TfmPartsExcelPrice.DNMSpeedButton1Click(Sender: TObject);
begin
  EditDB(qrypartsForExcelPrice);
  qrypartsForExcelPricePriceRow.asInteger := 0;
  qrypartsForExcelPricePriceCol.asInteger := 0;
  PostDB(qrypartsForExcelPrice);
end;

procedure TfmPartsExcelPrice.DNMSpeedButton2Click(Sender: TObject);
begin
  EditDB(qrypartsForExcelPrice);
  qrypartsForExcelPriceQtycol.asInteger := 0;
  qrypartsForExcelPriceQtyRow.asInteger := 0;
  PostDB(qrypartsForExcelPrice);
end;
procedure TfmPartsExcelPrice.btnclearCostClick(Sender: TObject);
begin
  EditDB(qrypartsForExcelPrice);
  qrypartsForExcelPriceCostRow.asInteger := 0;
  qrypartsForExcelPriceCostCol.asInteger := 0;
  PostDB(qrypartsForExcelPrice);
end;

end.
