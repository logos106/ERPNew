unit BOMSalesPPGTransJournal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TBOMSalesPPGTransJournalGUI = class(TBaseListingGUI)
    qryMainSeqno: TIntegerField;
    qryMainProcProgressID: TIntegerField;
    qryMainInProcProgressId: TIntegerField;
    qryMaincaption: TWideStringField;
    qryMainBuiltCaption: TWideStringField;
    qryMainPaymentLineID: TIntegerField;
    qryMaincreditsEx: TFloatField;
    qryMainDebitsEx: TFloatField;
    qryMaincreditsInc: TFloatField;
    qryMaindebitsIbc: TFloatField;
    qryMaindiffEx: TFloatField;
    qryMaindiffInc: TFloatField;
    qryMainQty: TFloatField;
    qryMainProductUnitCost: TFloatField;
    qryMainSequencedown: TIntegerField;
    qryMainchildSequencedown: TIntegerField;
    qryMainNotes: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);
  private
    fsSalesRef: String;
    fsTablename :String;
    Procedure PopulateQrymain;
  Protected
    procedure SetGridColumns; Override;
  public
    Property SalesRef:String read fsSalesRef write fsSalesRef;
    Procedure RefreshQuery;override;
  end;

var
  BOMSalesPPGTransJournalGUI: TBOMSalesPPGTransJournalGUI;

implementation

uses CommonDbLib, CommonLib;

{$R *.dfm}

procedure TBOMSalesPPGTransJournalGUI.FormCreate(Sender: TObject);
begin
  fsTableName := GetUserTemporaryTableName('BOnshipqty');
  Qrymain.SQL.clear;
  Qrymain.SQL.add('SELECT');
  Qrymain.SQL.add('*');
  Qrymain.SQL.add('FROM '+ fsTablename);
  Qrymain.SQL.add('ORDER BY PaymentLineID, seqno, Sequencedown, childSequencedown');
  inherited;
  SearchMode:= smFullList;
  HaveDateRangeSelection:= False;
end;
procedure TBOMSalesPPGTransJournalGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(fsTablename);
  inherited;
end;

procedure TBOMSalesPPGTransJournalGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Qrymainseqno.asInteger =1  then begin
    DoGreenhighlight(Afont, ABrush);
    if sametext(Field.fieldname, qrymainBuiltCaption.fieldname) or
       sametext(Field.fieldname, qrymainQty.fieldname) or
       sametext(Field.fieldname, qrymainProductUnitCost.fieldname) or
       sametext(Field.fieldname, qrymainNotes.fieldname) then
        DoHide(Field,State,AFont,ABrush);
  end;
  if (qrymaindiffEx.asFloat<>0) or
     (qrymaindiffInc.asFloat<>0) then  RedFont(AFont);
  if sametext(Field.fieldname, qrymaindiffEx.fieldname) then
    if (qrymaindiffEx.asFloat=0 ) then DoHide(Field,State,AFont,ABrush);
  if sametext(Field.fieldname, qrymaindiffInc.fieldname) then
    if (qrymaindiffInc.asFloat=0 ) then DoHide(Field,State,AFont,ABrush);
end;

procedure TBOMSalesPPGTransJournalGUI.grpFiltersClick(Sender: TObject);
begin
  if grpfilters.itemindex = 0 then
       GroupFilterString := 'DiffEx <> 0 or DiffInc <> 0'
  else GroupFilterString := '';
  inherited;

end;

procedure TBOMSalesPPGTransJournalGUI.PopulateQrymain;
begin
    //ADM31002471
    //ADM31002903
    if SalesRef = '' then
      SalesRef:= inputbox('Sales Ref' , 'Sales Ref', '');
    with scriptmain do begin
         SQL.clear;
         SQL.add('DROP TABLE if EXISTS ' + fstablename +';');

         SQL.add('CREATE TABLE ' + fstablename +'  ( ' +
                      '   Seqno             INT(11) NOT NULL DEFAULT "0", ' +
                      '   ProcProgressID    INT(11) NOT NULL DEFAULT "0", ' +
                      '   InProcProgressId  INT(11) DEFAULT "0", ' +
                      '   caption           VARCHAR(255) DEFAULT NULL, ' +
                      '   BuiltCaption      VARCHAR(255) DEFAULT NULL, ' +
                      '   PaymentLineID     INT(11) DEFAULT NULL, ' +
                      '   creditsEx         DOUBLE DEFAULT NULL, ' +
                      '   DebitsEx          DOUBLE DEFAULT NULL, ' +
                      '   creditsInc        DOUBLE DEFAULT NULL, ' +
                      '   debitsIbc         DOUBLE DEFAULT NULL, ' +
                      '   diffEx            DOUBLE DEFAULT NULL, ' +
                      '   diffInc           DOUBLE DEFAULT NULL, ' +
                      '   Qty               DOUBLE DEFAULT NULL, ' +
                      '   ProductUnitCost   DOUBLE DEFAULT NULL, ' +
                      '   Sequencedown      INT(11) DEFAULT "0", ' +
                      '   childSequencedown INT(11) DEFAULT "0", ' +
                      '   Notes             VARCHAR(255) DEFAULT NULL, ' +
                      '   KEY PaymentLineID (PaymentLineID) ' +
                      ' ) ENGINE=MyISAM DEFAULT CHARSET=UTF8;');
         if not IsLimit0selection then begin
         SQL.add('insert ignore into ' + fstablename +'  ' +
                      ' SELECT ' +
                      ' 1 AS Seqno, ' +
                      ' ppg.ProcProgressID, ' +
                      ' ppg.InProcProgressId, ' +
                      ' PT.Caption AS caption, ' +
                      ' NULL AS BuiltCaption, ' +
                      ' trans.PaymentLineID, ' +
                      ' SUM(trans.CreditsEx) creditsEx, ' +
                      ' SUM(trans.DebitsEx) AS DebitsEx, ' +
                      ' SUM(trans.CreditsInc) creditsInc, ' +
                      ' SUM(trans.DebitsInc) debitsIbc, ' +
                      ' SUM(trans.CreditsEx-trans.DebitsEx) AS diffEx, ' +
                      ' SUM(trans.CreditsInc-trans.DebitsInc) diffInc, ' +
                      ' Pt.TotalQty, ' +
                      ' Pt.ProductUnitCost, ' +
                      ' pt.Sequencedown, ' +
                      ' 0 AS childSequencedown, ' +
                      ' NULL AS Notes ' +
                      '  FROM tbltransactions trans ' +
                      '  INNER JOIN tblprocprogress ppg ON trans.PaymentLineID = ppg.ProcProgressID ' +
                      '  INNER JOIN tblproctree Pt ON PT.proctreeid = ppg.ProcTreeId ' +
                      '  WHERE trans.type = "Manufacturing" AND  trans.globalref = ' +Quotedstr(SalesRef) +'  ' +
                      '  GROUP BY trans.PaymentLineID; ' );

         SQL.add('INSERT IGNORE INTO ' + fstablename +'  ' +
                      '  SELECT ' +
                      ' 2 AS Seqno, ' +
                      ' ppg.ProcProgressID, ' +
                      ' ppg.InProcProgressId, ' +
                      ' null AS caption, ' +
                      ' TreeNodeCaption(PT.Level, PT.Caption) AS BuiltCaption, ' +
                      ' trans.PaymentLineID, ' +
                      ' trans.CreditsEx creditsEx, ' +
                      ' trans.DebitsEx AS DebitsEx, ' +
                      ' trans.CreditsInc creditsInc, ' +
                      ' trans.DebitsInc debitsIbc, ' +
                      ' T.diffEx diffEx, ' +
                      ' T.diffInc AS diffInc, ' +
                      ' Pt.totalQty, ' +
                      ' Pt.ProductUnitCost, ' +
                      ' t.Sequencedown, ' +
                      ' pt.Sequencedown , ' +
                      ' `Chq/Ref` AS Notes ' +
                      '  FROM tbltransactions trans ' +
                      '  INNER JOIN tblprocprogress ppg ON trans.PurchaselineID = ppg.ProcProgressID ' +
                      '  INNER JOIN tblproctree Pt ON PT.proctreeid = ppg.ProcTreeId ' +
                      '  INNER JOIN ' + fstablename +'  T ON trans.PaymentlineID = T.PaymentLineID ' +
                      '  WHERE trans.type = "Manufacturing" AND  trans.globalref = ' +Quotedstr(SalesRef) +' ; ' );
            SQL.add('UPDATE ' + fstablename +' Set DiffEx  = round(DiffEx ,3);');
            SQL.add('UPDATE ' + fstablename +' Set DiffInc = round(DiffInc,3);');
         end;
      ExecutewithProgress;
    end;
end;

procedure TBOMSalesPPGTransJournalGUI.RefreshQuery;
begin
  PopulateQrymain;
  inherited;
end;

procedure TBOMSalesPPGTransJournalGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('fieldname');
  RemoveFieldfromGrid(qryMainSeqno.Fieldname);
  RemoveFieldfromGrid(qryMainProcProgressID.Fieldname);
  RemoveFieldfromGrid(qryMainInProcProgressId.Fieldname);
  RemoveFieldfromGrid(qryMainPaymentLineID.Fieldname);
  RemoveFieldfromGrid(qryMainSequencedown.Fieldname);
  RemoveFieldfromGrid(qryMainchildSequencedown.Fieldname);
  if not devmode then RemoveFieldfromGrid(qryMainNotes.Fieldname);
end;

initialization
  RegisterClassOnce(TBOMSalesPPGTransJournalGUI);

end.
