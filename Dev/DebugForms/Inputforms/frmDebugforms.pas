unit frmDebugforms;

{$I ERP.inc}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, DNMSpeedButton, StdCtrls, Shader, ExtCtrls,
  ActnList, DNMAction, DNMPanel, Menus, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, SelectionDialog, AppEvnts, DAScript, MyScript;

type
  TfmDebugforms = class(TBaseInputGUI)
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    ERPScript1: TERPScript;
    sbMain: TScrollBox;
    btnA: TDNMSpeedButton;
    btnk: TDNMSpeedButton;
    btnb: TDNMSpeedButton;
    btnl: TDNMSpeedButton;
    btnm: TDNMSpeedButton;
    btnd: TDNMSpeedButton;
    btnn: TDNMSpeedButton;
    btne: TDNMSpeedButton;
    btno: TDNMSpeedButton;
    btnp: TDNMSpeedButton;
    btnu: TDNMSpeedButton;
    btnv: TDNMSpeedButton;
    btnw: TDNMSpeedButton;
    btnx: TDNMSpeedButton;
    btny: TDNMSpeedButton;
    btnf: TDNMSpeedButton;
    btnc: TDNMSpeedButton;
    btnq: TDNMSpeedButton;
    btng: TDNMSpeedButton;
    btn1: TDNMSpeedButton;
    btn2: TDNMSpeedButton;
    btnh: TDNMSpeedButton;
    btnr: TDNMSpeedButton;
    btns: TDNMSpeedButton;
    btnj: TDNMSpeedButton;
    btni: TDNMSpeedButton;
    btnt: TDNMSpeedButton;
    btn3: TDNMSpeedButton;
    btn4: TDNMSpeedButton;
    btn5: TDNMSpeedButton;
    btn6: TDNMSpeedButton;
    btn7: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
    btn8: TDNMSpeedButton;
    btn9: TDNMSpeedButton;

    procedure btnAClick(Sender: TObject);
    procedure btnbClick(Sender: TObject);
    procedure btnlClick(Sender: TObject);
    procedure btnkClick(Sender: TObject);
    procedure btnmClick(Sender: TObject);
    procedure btndClick(Sender: TObject);
    procedure btnnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCloseClick(Sender: TObject);
    procedure btneClick(Sender: TObject);
    procedure btnoClick(Sender: TObject);
    procedure btnpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnuClick(Sender: TObject);
    procedure btnClick(Sender: TObject);
    procedure btnwClick(Sender: TObject);
    procedure btnxClick(Sender: TObject);
    procedure btnyClick(Sender: TObject);
    procedure btnfClick(Sender: TObject);
    procedure btncClick(Sender: TObject);
    procedure btnqClick(Sender: TObject);
    procedure btngClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btnhClick(Sender: TObject);
    procedure btnrClick(Sender: TObject);
    procedure btnsClick(Sender: TObject);
    procedure btnjClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btniClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btntClick(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure Label1DblClick(Sender: TObject);
    procedure BeforeExecuteScript(Sender: TObject; var SQL: string; var Omit: Boolean);
    procedure OnScriptError(Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btn8Click(Sender: TObject);
    procedure btn9Click(Sender: TObject);
  private
    KeysPressed:String;
    procedure FindCorrectUOMFOrProduct;
    procedure MyScriptBeforeExecute(Sender: TObject; var SQL: String; var Omit: Boolean);
    procedure Activatebtns(Const Value :Boolean =False);
    
  public
    { Public declarations }
  end;


implementation

uses CommonLib, VerifynFixPayments, CommonFormLib ,
  CommonDbLib,  tcConst, DebugLib,LogLib, DbSharedObjectsObj, PQALib,
  StoredProcedures;

{$R *.dfm}
{ TfmDebugforms }



procedure TfmDebugforms.btnAClick(Sender: TObject);
begin
  inherited;
  TVerifynFixPaymentsGUI.VerifynFixCustPayments;
end;

procedure TfmDebugforms.btnbClick(Sender: TObject);
begin
  inherited;
  TVerifynFixPaymentsGUI.VerifynFixCustPrePayments;
end;

procedure TfmDebugforms.btnsClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TERPShortcutsGUI');
end;

procedure TfmDebugforms.btntClick(Sender: TObject);
begin
  inherited;
    OpenERPListForm('TPurchaseOrders_RoundFixGUI');
end;

procedure TfmDebugforms.btnlClick(Sender: TObject);
begin
  inherited;
   TVerifynFixPaymentsGUI.VerifynFixSuppPrePayments;
end;

procedure TfmDebugforms.btnkClick(Sender: TObject);
begin
  inherited;
  TVerifynFixPaymentsGUI.VerifynFixSuppPayments;
end;


procedure TfmDebugforms.btnmClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TBillsnCheque_LinesDeletedGUI',0);
end;

procedure TfmDebugforms.btndClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TSalesTotalAmountMisMatchGUI',0);
end;

procedure TfmDebugforms.btnnClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TPOTotalAmountMisMatchGUI',0);
end;

procedure TfmDebugforms.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmDebugforms.FormCreate(Sender: TObject);
begin
  if devmode then begin
    btna.Caption := 'A' + 	NL +	btna.Caption ;
    btnb.Caption := 'B' + 	NL +	btnb.Caption ;
    btnc.Caption := 'C' + 	NL +	btnc.Caption ;
    btnd.Caption := 'D' + 	NL +	btnd.Caption ;
    btne.Caption := 'E' + 	NL +	btne.Caption ;
    btnf.Caption := 'F' + 	NL +	btnf.Caption ;
    btng.Caption := 'G' + 	NL +	btng.Caption ;
    btnh.Caption := 'H' + 	NL +	btnh.Caption ;
    btni.Caption := 'I' + 	NL +	btni.Caption ;
    btnj.Caption := 'J' + 	NL +	btnj.Caption ;
    btnk.Caption := 'K' + 	NL +	btnk.Caption ;
    btnl.Caption := 'L' + 	NL +	btnl.Caption ;
    btnm.Caption := 'M' + 	NL +	btnm.Caption ;
    btnn.Caption := 'N' + 	NL +	btnn.Caption ;
    btno.Caption := 'O' + 	NL +	btno.Caption ;
    btnp.Caption := 'P' + 	NL +	btnp.Caption ;
    btnq.Caption := 'Q' + 	NL +	btnq.Caption ;
    btnr.Caption := 'R' + 	NL +	btnr.Caption ;
    btns.Caption := 'S' + 	NL +	btns.Caption ;
    btnt.Caption := 'T' + 	NL +	btnt.Caption ;
    btnu.Caption := 'U' + 	NL +	btnu.Caption ;
    btnv.Caption := 'V' + 	NL +	btnv.Caption ;
    btnw.Caption := 'W' + 	NL +	btnw.Caption ;
    btnx.Caption := 'X' + 	NL +	btnx.Caption ;
    btny.Caption := 'Y' + 	NL +	btny.Caption ;
    btn1.Caption := '1' + 	NL +	btn1.Caption ;
    btn2.Caption := '2' + 	NL +	btn2.Caption ;
    btn3.Caption := '3' + 	NL +	btn3.Caption ;
    btn4.Caption := '4' + 	NL +	btn4.Caption ;
    btn5.Caption := '5' + 	NL +	btn5.Caption ;
    btn6.Caption := '6' + 	NL +	btn6.Caption ;
    btn7.Caption := '7' + 	NL +	btn7.Caption ;
  end;

    btno.Hint := 'PO with wrong amounts.' + NL +NL +
          'PO.Payment       <> Payment.Total ' +NL +
          'PO.Total         <  Payment.Total' +NL +
          'PO.Total         <> PO Payment +PO Balance' +NL +
          'Header.Total     <  Lines.Total' +NL +
          'Header.Total(Inc)<  Lines.Total(Inc)' +NL;
    btne.hint := 'Sales with wrong amounts.' + NL +NL +
          'Sales.Payment       <> Payment.Total ' +NL +
          'Sales.Total         <  Payment.Total' +NL +
          'Sales.Total         <> Sales Payment +Sales Balance' +NL +
          'Header.Total     <  Lines.Total' +NL +
          'Header.Total(Inc)<  Lines.Total(Inc)' +NL;
    btnp.hint :='List with all Negative PO-BO and option to Delete them'+NL;
    btnd.hint :='Sales Header Total <> Lines.Total' +NL +NL+'Option to Delete line ore recalculate the Sales total'+NL;
    btnn.hint :='PO Header Total <> Lines.Total' +NL +NL+'Option to Delete line ore recalculate the PO total'+NL;
    btnm.Hint :='Purchase Order /Cheque/Bill with Lines missing'+NL;
    btnb.hint :='List of Customer Prepayments where total <> balance + Applied Payment' + NL + NL +'Option to Recalculate'+NL;
    btnl.hint :='List of Supplier Prepayments where total <> balance + Applied Payment'+ NL + NL +'Option to Recalculate'+NL;
    btnk.hint :='List of PO where PO.Payment <> Total Payments '+ NL + NL +'Option to Recalculate'+NL;
    btnA.hint :='List of Sales where PO.Payment <> Total Payments '+ NL + NL +'Option to Recalculate'+NL;
    btnr.hint :='This is the list of sales where cost is updated to the product''s cost1.'+NL+'Recalculate will update all records to the original cost used in sales before update'+NL;
    btnq.hint :='Calculates the Average cost for the selected product based on the ''IN'' transactions'+NL;
    btns.hint :='This list looks for the UOM mismatches for the Qty allocated for BOM lines of Salesorder'+NL;
    btnt.Hint := 'This will open the list of purchase Orders where totals in the header and lines doesn''t match.'+NL+'Fix will add a ''rounding'' Product to lines to fix it '+NL;


(*    if btna.hint <> '' then AddDisablescontrolforHint(pnbtns , btna, '');
    if btnb.hint <> '' then AddDisablescontrolforHint(pnbtns , btnb, '');
    if btnc.hint <> '' then AddDisablescontrolforHint(pnbtns , btnc, '');
    if btnd.hint <> '' then AddDisablescontrolforHint(pnbtns , btnd, '');
    if btne.hint <> '' then AddDisablescontrolforHint(pnbtns , btne, '');
    if btnf.hint <> '' then AddDisablescontrolforHint(pnbtns , btnf, '');
    if btng.hint <> '' then AddDisablescontrolforHint(pnbtns , btng, '');
    if btnh.hint <> '' then AddDisablescontrolforHint(pnbtns , btnh, '');
    if btni.hint <> '' then AddDisablescontrolforHint(pnbtns , btni, '');
    if btnj.hint <> '' then AddDisablescontrolforHint(pnbtns , btnj, '');
    if btnk.hint <> '' then AddDisablescontrolforHint(pnbtns , btnk, '');
    if btnl.hint <> '' then AddDisablescontrolforHint(pnbtns , btnl, '');
    if btnm.hint <> '' then AddDisablescontrolforHint(pnbtns , btnm, '');
    if btnn.hint <> '' then AddDisablescontrolforHint(pnbtns , btnn, '');
    if btno.hint <> '' then AddDisablescontrolforHint(pnbtns , btno, '');
    if btnp.hint <> '' then AddDisablescontrolforHint(pnbtns , btnp, '');
    if btnq.hint <> '' then AddDisablescontrolforHint(pnbtns , btnq, '');
    if btnr.hint <> '' then AddDisablescontrolforHint(pnbtns , btnr, '');
    if btns.hint <> '' then AddDisablescontrolforHint(pnbtns , btns, '');
    if btnt.hint <> '' then AddDisablescontrolforHint(pnbtns , btnt, '');
    if btnu.hint <> '' then AddDisablescontrolforHint(pnbtns , btnu, '');
    if btnv.hint <> '' then AddDisablescontrolforHint(pnbtns , btnv, '');
    if btnw.hint <> '' then AddDisablescontrolforHint(pnbtns , btnw, '');
    if btnx.hint <> '' then AddDisablescontrolforHint(pnbtns , btnx, '');
    if btny.hint <> '' then AddDisablescontrolforHint(pnbtns , btny, '');
    if btn1.hint <> '' then AddDisablescontrolforHint(pnbtns , btn1, '');
    if btn2.hint <> '' then AddDisablescontrolforHint(pnbtns , btn2, '');*)


  inherited;
  KeysPressed:=''

end;
Procedure TfmDebugforms.Activatebtns(Const Value :Boolean =False);
var
  ctr:Integer;
begin
  for ctr := 0 to ComponentCount-1 do
       if (Components[ctr] is TDNMSpeedButton) and (Components[ctr]  <> cmdClose) then begin
          TDNMSpeedButton(Components[ctr]).enabled          := Value;
          TDNMSpeedButton(Components[ctr]).Visible          := Value;
       end;

    {enable buttons for databases when required}


    {if not Value then begin
      btnMS.enabled                   := (*Devmode or *)IsDbSelected('Ashford') ;
      btnundoMS.Enabled               := (*Devmode or *)IsDbSelected('itm_live');
      btnBOMPQAUOM.enabled            := (*Devmode or *)IsDbSelected('itm_live');
      btnrecalcAvg.enabled            := (*Devmode or *)IsDbSelected('itm_live') or IsDbSelected('Ashford');
      btnPqamismatch.enabled := true;
      btnBOMPQAUOM.enabled := true;
      btnBOMPQAUOM.enabled            := True;
      btnERPShortcuts.visible         := Devmode;
      tbnotimeprocesses.Enabled       := true;
      btnTreeQty.Enabled              := true;
    end;}
end;
procedure TfmDebugforms.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  comp: TComponent;
begin
  inherited;
  if (ssCtrl in Shift ) then
    if ((Key >= ord('A')) and (Key <= ord('Z'))) or ((Key >= ord('0')) and (Key <= ord('7')) ) then begin
      comp := findcomponent('btn'+ char(key));
      if assigned(Comp) and (comp is TDNMSPeedbutton) then begin
        if TDNMSPeedbutton(Comp).hint <> '' then
          if MessageDlg(TDNMSPeedbutton(Comp).Hint+NL + 'Do you want to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
        TDNMSPeedbutton(Comp).click;
      end;
    end;



end;

procedure TfmDebugforms.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (ssCtrl in Shift ) and (Key in [ord('A') , ord('C') , ord('T') , ord('I') , ord('V'), ord('A'), ord('T'), ord('E'), ord('A'), ord('L'), ord('L')]) then begin
      KeysPressed :=KeysPressed +chr(key);
    if Sysutils.SameText(KeysPressed , 'ACTIVATEALL') then begin
      Activatebtns(true);
    end;
  end else KeysPressed := '';

end;

procedure TfmDebugforms.cmdCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmDebugforms.btn4Click(Sender: TObject);
begin
  inherited;
  OpenERPListform('TBankDepositofDeletedPaymentsGUI');
end;

procedure TfmDebugforms.btn5Click(Sender: TObject);
var
  scr :TERPScript;
begin
  inherited;
  scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
  try
    scr.SQL.Text := 'insert ignore into  tblproductclasses(ProductID, ProductName, ClassID, ProductGroup, Classname) '+
                      ' select PArtsID , PArtname,  '+
                      ' (SElect ClassId from tblclass where classname ="Default") as ClassID, ProductGroup, "Default"  '+
                      ' from tblparts where partsID not in (Select productID from tblproductclasses)';
    scr.Execute;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;
end;

procedure TfmDebugforms.btn6Click(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TAccountsReceiveListDebugGUI');
end;

procedure TfmDebugforms.btn7Click(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TAccountsPayListFormDebugGUI');
end;

procedure TfmDebugforms.btn8Click(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TBOMOrdersGUI');
end;

procedure TfmDebugforms.btn9Click(Sender: TObject);
begin
  inherited;
  clog(SPUpdate_Serial_Number_ListSQL);
end;

procedure TfmDebugforms.BeforeExecuteScript(Sender: TObject; var SQL: string; var Omit: Boolean);
begin
  inherited;
  if devmode then DoStepProgressbar(SQL) else DoStepProgressbar;
end;

procedure TfmDebugforms.btniClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TTranswithBOMissingGUI');
end;

procedure TfmDebugforms.btneClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TSalesSummaryGUI',0);
end;

procedure TfmDebugforms.btnoClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TPOSummaryGUI',0);
end;

procedure TfmDebugforms.btnpClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TNegativePOBOGUI',0);
end;

procedure TfmDebugforms.FormShow(Sender: TObject);
begin
  inherited;
  {all buttons disabled by default}
    cmdClose.Enabled := true;
    if not devmode then
      Setcontrolfocus(cmdClose);

    ActivateBtns;

  btn6.Enabled := True;   btn6.visible := True;
  btn7.Enabled := True;   btn7.visible := True;
  btn8.Enabled := True;   btn8.visible := True;
  btny.Enabled := True;   btny.visible := True;
  btn9.Enabled := True;   btn9.visible := True;
end;

procedure TfmDebugforms.Label1DblClick(Sender: TObject);
begin
  inherited;
  if devmode then
    Activatebtns(true);
end;

procedure TfmDebugforms.btnuClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TRecMismatchGui',0);
end;

procedure TfmDebugforms.btn3Click(Sender: TObject);
var
  scr:TERPScript;
begin
  inherited;
  processingcursor(True);
  try
      //with SharedScript do begin
      scr := DbSharedObj.GetScript(CommonDBLib.GetSharedMyDacConnection);
      try
          with scr do begin
            BeforeExecute := BeforeExecuteScript;
            OnError := OnScriptError;
            try
              SQL.clear;
              SQL.add('create table if not exists erpfix_uom_' + curdbverno +' like tblunitsofmeasure;');
              SQL.add('insert ignore into erpfix_uom_' + curdbverno +' Select * from tblunitsofmeasure;');

              SQL.add(InsertUOMFromTransSQL('tblproctree'     ,'PartsId'  ,'TreePartUOM'  ,'TreePartUOMMultiplier'  ,'TreePartUOMID'));
              SQL.add(InsertUOMFromTransSQL('tblproctreePart' ,'ProductId','UnitOfMeasure','UnitOfMeasureMultiplier','UnitOfMeasureID'));
              SQL.add(InsertUOMFromTransSQL('tblextraprice' ,'PartsID','UOM','UOMMultiplier','UOMId'));
              SQL.add(InsertUOMFromTransSQL('tblextrapricesell' ,'PartsID','UOM','UOMMultiplier','UOMId'));
              SQL.add(InsertUOMFromTransSQL('tblforeignprice' ,'PartsID','UOM','UOMMultiplier','UOMId'));
              SQL.add(InsertUOMFromTransSQL('tblparts' ,'PartsID','ProductUOM','','ProductUOMID'));
              SQL.add(InsertUOMFromTransSQL('tblPurchaselines' ,'ProductId','UnitofMeasurePOLines','UnitofMeasureMultiplier','UnitOfMeasureID'));
              SQL.add(InsertUOMFromTransSQL('tblsaleslines' ,'ProductId','UnitofMeasureSaleLines','UnitofMeasureMultiplier','UnitOfMeasureID'));
              SQL.add(InsertUOMFromTransSQL('tblstockadjustentrylines' ,'ProductId','uom','UOMMultiplier','uomid'));
              SQL.add(InsertUOMFromTransSQL('tblstocktransferentrylines' ,'ProductId','uom','UOMMultiplier','uomid'));
              SQL.add(InsertUOMFromTransSQL('tblStockmovementlines' ,'ProductId','uom','UOMMultiplier','uomid'));
              SQL.add(InsertUOMFromTransSQL('tblpqa' ,'ProductId','UOM','UOMMultiplier','UOMID'));

              SQL.add('create table if not exists erpfix_pqa_' + curdbverno +' like  tblPQa;');
              SQL.add('insert ignore into erpfix_pqa_' + curdbverno +' Select * from tblPQa;');
              SQL.add('update tblpqa pqa '+
                      ' inner join tblpurchaselines   		PL  on PQa.transId 			= pl.purchaseorderID and PQa.translineid = PL.purchaselineId and pqa.transtype = "TPurchaseOrderLine"  '+
                      ' set pqa.UOM = PL.UnitofMeasurePOLines , pqa.UOMMultiplier = PL.UnitofMeasureMultiplier , pqa.UOMID = PL.UnitOfMeasureId   '+
                      ' where pqa.UOMID <> PL.UnitOfMeasureId ;');
              SQL.add('update tblpqa pqa  '+
                      ' inner join tblsaleslines 					SL  on PQa.transId 			= SL.saleId 				 and PQa.translineid = SL.SaleLineID  '+
                      ' and pqa.transtype in ("TInvoiceLine" , "TSalesOrderline" , "TRefundSaleLine" , "TPOSCashSaleline" , "TPOSLaybylines" , "TCashSaleLine")  '+
                      ' set pqa.UOM = SL.UnitofMeasureSaleLines , pqa.UOMMultiplier = SL.UnitofMeasureMultiplier , pqa.UOMID = SL.UnitOfMeasureId   '+
                      ' where pqa.UOMID <> SL.UnitOfMeasureId ;');
              SQL.add('update tblPQa PQa  '+
                      ' inner join tblproctreepart 				ptp on PQa.TransLineID 	= ptp.ProcTreePartId and pqa.transtype in ( ' + ManufactureTypes +' )  '+
                      ' set pqa.UOM = ptp.UnitOfMeasure , pqa.UOMMultiplier = ptp.UnitOfMeasureMultiplier , pqa.UOMID = ptp.UnitOfMeasureId  '+
                      ' where pqa.UOMID <> ptp.UnitOfMeasureId;');
              SQL.add('update tblpqa pqa  '+
                      ' inner join tblstockmovementlines 	SL  on PQa.transId 			= SL.StockmovementID and PQa.translineid = SL.StockmovementLinesID and pqa.transtype in ("TStockMovementLines")  '+
                      ' set pqa.UOM = SL.UOM, pqa.UOMMultiplier = SL.UOMMultiplier, pqa.UOMID = SL.UOMID  '+
                      ' where pqa.UOMID <> SL.UOMID;');
              SQL.add('delete from tblextraprice where ifnull(PartsID,0)<> 0 and (ifnull(UOMId,0) = 1);');
              SQL.add('delete from tblextrapricesell where ifnull(PartsID,0)<> 0 and (ifnull(UOMId,0) = 1);');
              SQL.add('delete from tblforeignprice where ifnull(PartsID,0)<> 0 and (ifnull(UOMId,0) = 1);');

              clog(SQL.text);
              DoShowProgressbar(SQL.Count , WAITMSG);
              try
                Execute;
              finally
                DoHideProgressbar;
              end;
            finally
              SQL.clear;
              BeforeExecute := nil;
              OnError := nil;
            end;
          end;
      finally
        DbSharedObj.ReleaseObj(scr);
      end;
  finally
    Processingcursor(False);
  end;
end;

procedure TfmDebugforms.btnClick(Sender: TObject);
begin
  inherited;
 OpenERPForm('TIncompleteproctreepartGUI',0);
end;

procedure TfmDebugforms.btnrClick(Sender: TObject);
begin
  inherited;
 //OpenERPListform('TUOMMismatchinBOMPQAGUI');
 OpenERPListform('TUOMMismatchGUI');
end;

procedure TfmDebugforms.btnwClick(Sender: TObject);
begin
  inherited;
  FindCorrectUOMFOrProduct;
end;
procedure TfmDebugforms.btnxClick(Sender: TObject);
begin
  inherited;
 OpenERPListform('TTransMissingBOList');
end;

procedure TfmDebugforms.btncClick(Sender: TObject);
begin
  inherited;
  openerplistform('TTranstotalMismatchGUI');
end;

procedure TfmDebugforms.btngClick(Sender: TObject);
begin
  inherited;
  openerplistform('TManufactureSalesGUI');
end;

procedure TfmDebugforms.btn2Click(Sender: TObject);
begin
  inherited;
  //openerplistform('TManufactureProductsGUI');
  openerplistform('TProctreePartFixGUI');
end;

procedure TfmDebugforms.btnhClick(Sender: TObject);
begin
  inherited;
  openerplistform('TundoManufactureSalesGUI');
end;

procedure TfmDebugforms.btn1Click(Sender: TObject);
begin
  inherited;
  openerplistform('TNonManufactureSalesGUI');
end;

procedure TfmDebugforms.btnyClick(Sender: TObject);
begin
  inherited;
 OpenERPListform('TPQAMismatchGUI');
 //OpenERPListform('TpqaFixGUI');

end;

procedure TfmDebugforms.btnfClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TQtySQLsGUI',0);
end;

procedure TfmDebugforms.btnqClick(Sender: TObject);
begin
  inherited;
  openerplistform('TProductlisttorecalcAvgCostGUI');
end;

Procedure TfmDebugforms.FindCorrectUOMFOrProduct;

  function FixSQL(tablename,idfieldname, uomidfieldname , uomnamefieldname , partsIdfieldname, multiplierfieldName,extraWhere:String):String;
  begin
    REsult := ' Drop table if exists tmp_1; ' +
                ' create table tmp_1  ' +
                      ' Select MainTable.'+IDfieldName +', ' +
                      ' ifnull(U.UnitID,GU.UnitID) UOMID,  ' +
                      ' ifnull(U.Multiplier,GU.Multiplier) Multiplier ,  ' +
                      ' MainTable.'+uomidfieldname+' as FPUOMID  ' +
                      ' from  '+tablename+' MainTable   ' +
                      ' Left join tblunitsofmeasure  U  on  U.UnitName = MainTable.'+uomnamefieldname+' and ifnull( U.PartID , 0) = MainTable.'+partsIdfieldname+
                      ' Left join tblunitsofmeasure  GU on GU.UnitName = MainTable.'+uomnamefieldname+' and ifnull(GU.PartID , 0) = 0 '+
                      extraWhere+';' +
                'Alter table tmp_1 add index '+IDfieldName +'idx ('+IDfieldName +');'+
                'Alter table tmp_1 add index uomididx (uomid);'+
                'update  '+tablename+' MainTable  '+
                      ' inner join tmp_1 T on T.'+IDfieldName +' = MainTable.'+IDfieldName +
                      ' Set MainTable.'+uomidfieldname+' = T.UOMID , '+
                      ' MainTable.'+multiplierfieldName+ '= T.Multiplier '+
                      ' where MainTable.'+uomidfieldname+'<> T.UOMID;'
  end;
begin
   With CommonDbLib.TempMyScript do try
    {foreign sell and buy price}SQL.add(FixSQL('tblforeignprice'        , 'ForeignPriceID'        , 'uomid' ,'UOM' , 'PartsId' , 'UOMMultiplier' ,''));
    {Extra Sell Price}          SQL.add(FixSQL('tblExtraPriceSell'      , 'PriceID'               , 'uomid' ,'UOM' , 'PartsId' , 'UOMMultiplier' ,''));
    {Extra Buy Price}           SQL.add(FixSQL('tblextraprice'          , 'ExtraPartPriceID'      , 'uomid' ,'UOM' , 'PartsId' , 'UOMMultiplier' ,''));
    {Product Reward Points}     SQL.add(FixSQL('tblProductREwardPoints' , 'ProductRewardPointsId' , 'uomid'         ,'UOM' , 'PartsId' , 'UOMMultiplier' ,''));
    {Manufacture Tree}          SQL.add(FixSQL('tblproctree'            , 'ProcTreeId'            , 'TreePartUOMID' ,'TreePartUOM' , 'MasterId' , 'TreePartUOMMultiplier' , ' WHERE mainTable.MasterType = "mtProduct"'));
    SQL.add(' Drop table if exists tmp_1; ');
    beforeExecute := MyScriptBeforeExecute;
    DoShowProgressbar(26 , 'UOM search');
    try
      Execute;
    finally
      DoHideProgressbar;
    end;
   finally
       Free;
   end;
end;
procedure TfmDebugforms.MyScriptBeforeExecute(Sender: TObject;var SQL: String; var Omit: Boolean);
begin
  DoStepProgressbar;
end;

procedure TfmDebugforms.OnScriptError(Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction);
begin
  inherited;
  if devmode then begin
    Logtext(SQL);
    Logtext(E.Message);
  end;
  Action := eaContinue;
end;

procedure TfmDebugforms.btnjClick(Sender: TObject);
begin
  inherited;
  openerplistform('TProcesseswithNotimeGUI');
end;

initialization
  RegisterClassOnce(TfmDebugforms);

end.
