unit ProcProgressAllocationReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , BaseListDetails,
  DBCtrls, wwclearbuttongroup, wwradiogroup, GIFImg, ProcessProgressAllocSQL;

type
  TProcProgressAllocationReportGUI = class(TBaseListDetailsGUI)
    qryMainsaleId: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainuom: TWideStringField;
    qryMainCaption: TWideStringField;
    qryMainBuildDate: TDateTimeField;
    qryMainuomMult: TWideStringField;
    qryMainBatchnoin: TWideStringField;
    qryMainExpiryDatein: TDateTimeField;
    qryMainbinlocationin: TWideStringField;
    qryMainBinnumberin: TWideStringField;
    qryMainSerialnumberin: TWideStringField;
    qryMainbatchQtyin: TFloatField;
    qryMainbinQtyin: TFloatField;
    qryMainsnQtyin: TFloatField;
    qryMaininqty: TFloatField;
    qryMainpartnamein: TWideStringField;

    qryMainoutqty: TFloatField;
    qryMainpartnameout: TWideStringField;
    qryMainBatchnoout: TWideStringField;
    qryMainExpiryDateout: TDateTimeField;
    qryMainbinlocationout: TWideStringField;
    qryMainBinnumberout: TWideStringField;
    qryMainSerialnumberout: TWideStringField;
    qryMainbatchQtyout: TFloatField;
    qryMainbinQtyout: TFloatField;
    qryMainsnQtyout: TFloatField;
    qryMainPPInNo: TLargeintField;
    qryMainbuildstatus: TWideStringField;
    qryMainsalelineNo: TLargeintField;
    qryMainPPcolorno: TLargeintField;
    qryMainsaleLineId: TIntegerField;
    Label2: TLabel;
    DBText1: TDBText;

    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryMainAfterOpen(DataSet: TDataSet);
  private
    fiSaleID: Integer;
    fiSaleLineID: Integer;
    procedure SetSaleID(const Value: Integer);
    procedure SetSaleLineID(const Value: Integer);
    function Gridcolour:TColor;
  Protected
    Function ExpressDetailListName:String;Override;
    Procedure CopyParamsto(Sender:TObject);Override;
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
    Property SaleID :Integer read fiSaleID write SetSaleID;
    Property SaleLineID :Integer read fiSaleLineID write SetSaleLineID;
  end;


implementation

uses ProductQtyLib, CommonLib, LogLib, ProcProgressReport, tcConst, tcDataUtils;

{$R *.dfm}

{ TProcProgressAllocationReportGUI }

procedure TProcProgressAllocationReportGUI.CopyParamsto(Sender: TObject);
begin
  inherited;
  if (sender is TProcProgressReportGUI) then begin
    TProcProgressReportGUI(Sender).SaleLineID := SaleLineID;
    TProcProgressReportGUI(Sender).Left := Self.left;
    TProcProgressReportGUI(Sender).top := Self.top;
  end;
end;

function TProcProgressAllocationReportGUI.ExpressDetailListName: String;
begin
  REsult := 'TProcProgressReportGUI';
end;

procedure TProcProgressAllocationReportGUI.FormCreate(Sender: TObject);
begin
  SaleID := 0;
  SaleLineID := 0;
//  closedb(qrymain);
//  qrymain.SQL.Clear;
//  qrymain.SQL.add('Select');
//  qrymain.SQL.add('SL.saleLineId,');
//  qrymain.SQL.add('convert(@salelineNo:=if(@salelineID <> Sl.salelineID,  @salelineNo:= 1 ,  @salelineNo+1), unsigned) as salelineNo,');
//  qrymain.SQL.add(' @salelineID := Sl.salelineID,');
//  qrymain.SQL.add(' convert(@PPInNo:=if(@PPInID <> PPIN.ProcProgressID,  @PPcolorno:= if(@PPcolorno=1 ,2,1) , @PPcolorno), unsigned) as PPcolorno,');
//  qrymain.SQL.add('convert(@PPInNo:=if(@PPInID <> PPIN.ProcProgressID,  @PPInNo:= 1 ,  @PPInNo+1), unsigned) as PPInNo,');
//  qrymain.SQL.add(' @PPInID := PPIN.ProcProgressID,');
//  qrymain.SQL.add('Sl.saleId      as saleId,');
//  qrymain.SQL.add('SL.ProductName as ProductName,');
//  qrymain.SQL.add('Concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier , ")" )  as uom ,');
//  qrymain.SQL.add('Convert(TreeNodeCaption(PT.Level, PT.caption ),char(255)) as Caption  ,');
//  qrymain.SQL.add('Concat(PPIN.uom , "(" , PPIN.uomMultiplier , ")" )                           as uomMult ,');
//  qrymain.SQL.add('if(PPIN.buildstatus ="W", "Wastage" , if(PPIN.buildstatus ="D", "Done" ,"On Hold" )) as buildstatus,');
//  qrymain.SQL.add('PPIN.Progressdate      as BuildDate,');
//  qrymain.SQL.add('PPIN.uomqty            as inqty,');
//  qrymain.SQL.add('PPout.uomqty           as outqty, ');
//  qrymain.SQL.add('Pin.partname           as partnamein, ');
//  qrymain.SQL.add('Pout.partname          as partnameout, ');
//  qrymain.SQL.add('PQABatchin.Value       as Batchnoin ,');
//  qrymain.SQL.add('PQABatchin.UOMQty      as batchQtyin,');
//  qrymain.SQL.add('PQABatchin.ExpiryDate  as ExpiryDatein,');
//  qrymain.SQL.add('PBInIn.binlocation     as binlocationin,');
//  qrymain.SQL.add('PBInIn.Binnumber       as Binnumberin,');
//  qrymain.SQL.add('PQAbinsin.UOMQty       as binQtyin,');
//  qrymain.SQL.add('PQASNin.value          as Serialnumberin,');
//  qrymain.SQL.add('PQAsnin.UOMQty         as snQtyin,');
//  qrymain.SQL.add('PQABatchout.Value      as Batchnoout ,');
//  qrymain.SQL.add('PQABatchout.ExpiryDate as ExpiryDateout,');
//  qrymain.SQL.add('PQABatchout.UOMQty     as batchQtyout,');
//  qrymain.SQL.add('PBInout.binlocation    as binlocationout,');
//  qrymain.SQL.add('PBInout.Binnumber      as Binnumberout,');
//  qrymain.SQL.add('PQAbinsout.UOMQty      as binQtyout,');
//  qrymain.SQL.add('PQASNout.value         as Serialnumberout,');
//  qrymain.SQL.add('PQAsnout.UOMQty        as snQtyout');
//  qrymain.SQL.add('from  ');
//  qrymain.SQL.add('(SELECT @PPInNo:=0) t1,  ');
//  qrymain.SQL.add('(SELECT @PPInID:=0) t2,  ');
//  qrymain.SQL.add('(SELECT @salelineNo:=0) t3 ,  ');
//  qrymain.SQL.add('(SELECT @salelineID:=0) t4,   ');
//  qrymain.SQL.add('(Select @PPcolorno := 0) as t5,  ');
//  qrymain.SQL.add('tblsales S inner join tblsaleslines SL on S.saleId = sl.saleId ' +
//                  ' inner join tblproctree PT on PT.MasterId = SL.SaleLineID and PT.mastertype <> "mtProduct"');
//
//  qrymain.SQL.add('Left join tblprocProgress PPIN on PT.ProcTreeId = PPIN.ProcTreeId ');
//  qrymain.SQL.add(replacestr(replacestr(TransTables(tDetailswithSno  , 'PPIN' , 'SaleId' , 'ProcProgressID' , QuotedStr('TProcProgressIn' ),'In'),'PPIN.SaleID', 'SL.saleID'), 'inner join ' , 'Left join '));
//  qrymain.SQL.add('Left join tblprocProgress PPOUT  on PPIN.ProcProgressID = PPOUT.InProcProgressId' );
//  qrymain.SQL.add(replacestr(replacestr(TransTables(tDetailswithSno , 'PPout' , 'SaleId' , 'ProcProgressID' , QuotedStr('TProcProgressOUT'), 'Out'),'PPout.SaleID', 'SL.saleID'), 'inner join ' , 'Left join '));
//  qrymain.SQL.add(' where ((S.saleId      = :SaleId     or :SaleId     =0) ' +
//                  ' and    (Sl.saleLineId = :SaleLineId or :SaleLineId =0)   ' +
//                  ' and    (:IgnoreDates ="T" Or S.saleDate Between :Datefrom and :DateTo    ))');
//  qrymain.SQL.add(' Order by s.SaleId, sl.saleLineId , PT.TreeRootId , PPIN.Progressdate  , PPIN.ProcProgressID');
//  clog(qrymain.SQL.Text);
  inherited;
  HaveDateRangeSelection := TRue;
  DisableSortoncolumtitleclick:= TRue;
end;

procedure TProcProgressAllocationReportGUI.grdMainCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean;
  AFont: TFont; ABrush: TBrush);
begin
  inherited;
  ABrush.color := Gridcolour;
  AFont.color := clBlack;
  if sametext(Field.fieldname , qryMainsaleId.FieldName) OR
     sametext(Field.fieldname , qryMainProductName.FieldName) OR
     sametext(Field.fieldname , qryMainuom.FieldName) OR
     sametext(Field.fieldname , qryMainCaption.FieldName) OR
     sametext(Field.fieldname , qryMainuomMult.FieldName)  then begin
        ABrush.color := clwhite;

     end;

  if qryMainsalelineNo.asinteger >1 then begin
    if sametext(Field.fieldname , qryMainsaleId.FieldName) OR
       sametext(Field.fieldname , qryMainProductName.FieldName) OR
       sametext(Field.fieldname , qryMainuom.FieldName) OR
       sametext(Field.fieldname , qryMainCaption.FieldName) OR
       sametext(Field.fieldname , qryMainuomMult.FieldName)  then begin
          Afont.color := ABrush.color;
       end;
  end;
  if qryMainPPInNo.asinteger >1 then begin
    if sametext(Field.fieldname , qryMainsaleId.FieldName) OR
       sametext(Field.fieldname , qryMainProductName.FieldName) OR
       sametext(Field.fieldname , qryMainBuildstatus.FieldName) OR
       sametext(Field.fieldname , qryMainuom.FieldName) OR
       sametext(Field.fieldname , qryMainCaption.FieldName) OR
       sametext(Field.fieldname , qryMainBuildDate.FieldName) OR
       sametext(Field.fieldname , qryMainuomMult.FieldName) OR
       sametext(Field.fieldname , qryMainBatchnoin.FieldName) OR
       sametext(Field.fieldname , qryMainExpiryDatein.FieldName) OR
       sametext(Field.fieldname , qryMainbinlocationin.FieldName) OR
       sametext(Field.fieldname , qryMainBinnumberin.FieldName) OR
       sametext(Field.fieldname , qryMainSerialnumberin.FieldName) OR
       sametext(Field.fieldname , qryMainbatchQtyin.FieldName) OR
       sametext(Field.fieldname , qryMainbinQtyin.FieldName) OR
       sametext(Field.fieldname , qryMainsnQtyin.FieldName) OR
       sametext(Field.fieldname , qryMaininqty.FieldName) OR
       sametext(Field.fieldname , qryMainpartnamein.FieldName) then begin
          Afont.color := ABrush.color;
       end;
  end;
  if (qryMainbatchQtyin.asFloat =0) and sametext(Field.fieldname , qryMainbatchQtyin.FieldName) then
      Afont.color := ABrush.color
  else if (qryMainbinQtyin.asFloat =0) and sametext(Field.fieldname , qryMainbinQtyin.FieldName) then
    Afont.color := ABrush.color
  else if (qryMainsnQtyin.asFloat =0) and sametext(Field.fieldname , qryMainsnQtyin.FieldName) then
    Afont.color := ABrush.color;
end;

procedure TProcProgressAllocationReportGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMainBuildDate.displayformat := FormatSettings.ShortDateformat;
  qryMainsaleID.Alignment := taLeftJustify;
end;

procedure TProcProgressAllocationReportGUI.RefreshQuery;
var
  Report: TProcessProgressAllocReport;
  msg: string;
begin
  showProgressbar(WAITMSG , 10);

  Report := TProcessProgressAllocReport.Create;
  try
//    InitDateFromnDateto;                                                                              stepProgressbar;
    if SaleId =0 then SaleId := tcdatautils.SaleID(SaleLIneID);                                       stepProgressbar;
(*    if chkIgnoreDates.Checked then begin

    end
    else begin
      Report.DateFrom := dtFrom.Date;                                                                 stepProgressbar;
      Report.DateTo := dtTo.Date;                                                                     stepProgressbar;
    end;*)

    Report.DateFrom := FilterdateFrom;                                                                 stepProgressbar;
    Report.DateTo := FilterDateto;                                                                     stepProgressbar;

    Report.SaleID := SaleId;                                                                          stepProgressbar;
    Report.SaleLineID := SaleLineId;                                                                  stepProgressbar;
    Report.PopulateReportSQL(qryMain.SQL,msg);                                                        stepProgressbar;
    RefreshOrignalSQL;                                                                                stepProgressbar;

//    Qrymain.ParamByName('SaleId').asInteger     := SaleId;                                            stepProgressbar;
//    Qrymain.ParamByName('SaleLineId').asInteger := SaleLineId;                                        stepProgressbar;
//    Qrymain.ParamByName('IgnoreDates').asString := iif((saleId =0) and (SaleLineId =0)  , 'F' , 'T'); stepProgressbar;
    inherited;                                                                                        stepProgressbar;
  finally
    Report.Free;
    HideProgressbar;
  end;
end;
procedure TProcProgressAllocationReportGUI.SetGridColumns;
begin
  inherited;
  if not devmode then begin
    RemoveFieldfromGrid(qryMainPPInNo.fieldname);
    RemoveFieldfromGrid(qryMainsalelineNo.fieldname);
    RemoveFieldfromGrid(qryMainPPcolorno.fieldname);
    RemoveFieldfromGrid(qryMainsaleLineId.fieldname);
  end;
end;

procedure TProcProgressAllocationReportGUI.SetSaleID(const Value: Integer);
begin
  fiSaleID := Value;
  if Value <> 0 then HaveDateRangeSelection:= False;
end;

procedure TProcProgressAllocationReportGUI.SetSaleLineID(const Value: Integer);
begin
  fiSaleLineID := Value;
  if Value <> 0 then HaveDateRangeSelection:= False;
end;

function TProcProgressAllocationReportGUI.Gridcolour: TColor;
begin
  if qryMainPPcolorno.asinteger =1  then result := GridColhighLightGreen else result := GridColhighLightYellow1;
end;

initialization
  RegisterClassOnce(TProcProgressAllocationReportGUI);

end.

