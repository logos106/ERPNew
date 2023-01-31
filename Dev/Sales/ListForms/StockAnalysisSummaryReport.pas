unit StockAnalysisSummaryReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StockAnalysisReport, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel, GIFImg;

type
  TStockAnalysisSummaryReportGUI = class(TStockAnalysisReportGUI)
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
  Protected
    Procedure MakeQrymain;Override;
    Procedure PopulateGridFields;Override;
    function GrpfiltersItemidex :Integer ; Override;
  public
    Procedure RefreshQuery; Override;
  end;


implementation

uses CommonLib, LogLib, AppEnvironment, salesAnalysisLib;

{$R *.dfm}


procedure TStockAnalysisSummaryReportGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if sametext(field.FieldName , 'Field' + inttostr(i_Available ) ) or
     sametext(field.FieldName , 'Field' + inttostr(i_instock ) ) then
      if TFloatfield(Field).AsFloat <0 then
        Doredhighlight(Afont , ABrush );
end;

function TStockAnalysisSummaryReportGUI.GrpfiltersItemidex: Integer;
begin
  Result := 0;
end;

procedure TStockAnalysisSummaryReportGUI.MakeQrymain;
begin
  closedb(Qrymain);
  Qrymain.SQL.Clear;
      Qrymain.SQL.AdD('Select');
      Qrymain.SQL.AdD('distinct T.PartsId as PartsId,');
      Qrymain.SQL.AdD('T.ClassId as ClassId,');
      Qrymain.SQL.AdD('T.Partname as Partname,');
      Qrymain.SQL.AdD('C.classname as classname,');
      if CountQuote        then Qrymain.SQL.AdD('(Select T1.finalQty from ' + fstablename +'  T1 where T1.PArtsId = T.partsId and T1.ClassId = T.classId and T1.fieldSeqno=' + inttostr(i_Quote     )+' )  as Field' + inttostr(i_Quote     )+' ,');
      if CountSO           then Qrymain.SQL.AdD('(Select T1.finalQty from ' + fstablename +'  T1 where T1.PArtsId = T.partsId and T1.ClassId = T.classId and T1.fieldSeqno=' + inttostr(i_SO        )+' )  as Field' + inttostr(i_SO        )+' ,');
      if CountSOBO         then Qrymain.SQL.AdD('(Select T1.finalQty from ' + fstablename +'  T1 where T1.PArtsId = T.partsId and T1.ClassId = T.classId and T1.fieldSeqno=' + inttostr(i_SOBO      )+' )  as Field' + inttostr(i_SOBO      )+' ,');
      if CountFSO          then Qrymain.SQL.AdD('(Select T1.finalQty from ' + fstablename +'  T1 where T1.PArtsId = T.partsId and T1.ClassId = T.classId and T1.fieldSeqno=' + inttostr(i_FSO       )+' )  as Field' + inttostr(i_FSO       )+' ,');
      if CountFSOBO        then Qrymain.SQL.AdD('(Select T1.finalQty from ' + fstablename +'  T1 where T1.PArtsId = T.partsId and T1.ClassId = T.classId and T1.fieldSeqno=' + inttostr(i_FSOBO     )+' )  as Field' + inttostr(i_FSOBO     )+' ,');
      if CountINV          then Qrymain.SQL.AdD('(Select T1.finalQty from ' + fstablename +'  T1 where T1.PArtsId = T.partsId and T1.ClassId = T.classId and T1.fieldSeqno=' + inttostr(i_INV       )+' )  as Field' + inttostr(i_INV       )+' ,');
      if CountINVBO        then Qrymain.SQL.AdD('(Select T1.finalQty from ' + fstablename +'  T1 where T1.PArtsId = T.partsId and T1.ClassId = T.classId and T1.fieldSeqno=' + inttostr(i_INVBO     )+' )  as Field' + inttostr(i_INVBO     )+' ,');
      if CountNERPS        then Qrymain.SQL.AdD('(Select T1.finalQty from ' + fstablename +'  T1 where T1.PArtsId = T.partsId and T1.ClassId = T.classId and T1.fieldSeqno=' + inttostr(i_NERPS     )+' )  as Field' + inttostr(i_NERPS     )+' ,');
      if CountONBUILD      then Qrymain.SQL.AdD('(Select T1.finalQty from ' + fstablename +'  T1 where T1.PArtsId = T.partsId and T1.ClassId = T.classId and T1.fieldSeqno=' + inttostr(i_ONBUILD   )+' )  as Field' + inttostr(i_ONBUILD   )+' ,');
      if CountONBUILD      then Qrymain.SQL.AdD('(Select T1.finalQty from ' + fstablename +'  T1 where T1.PArtsId = T.partsId and T1.ClassId = T.classId and T1.fieldSeqno=' + inttostr(I_USEDTOBuilD   )+' )  as Field' + inttostr(I_USEDTOBuilD   )+' ,');
      if CountBUILDING     then Qrymain.SQL.AdD('(Select T1.finalQty from ' + fstablename +'  T1 where T1.PArtsId = T.partsId and T1.ClassId = T.classId and T1.fieldSeqno=' + inttostr(i_BUILDING  )+' )  as Field' + inttostr(i_BUILDING  )+' ,');
      if CountTRANS        then Qrymain.SQL.AdD('(Select T1.finalQty from ' + fstablename +'  T1 where T1.PArtsId = T.partsId and T1.ClassId = T.classId and T1.fieldSeqno=' + inttostr(i_TRANS     )+' )  as Field' + inttostr(i_TRANS     )+' ,');
      if CountADJ          then Qrymain.SQL.AdD('(Select T1.finalQty from ' + fstablename +'  T1 where T1.PArtsId = T.partsId and T1.ClassId = T.classId and T1.fieldSeqno=' + inttostr(i_ADJ       )+' )  as Field' + inttostr(i_ADJ       )+' ,');
      if CountPO           then Qrymain.SQL.AdD('(Select T1.finalQty from ' + fstablename +'  T1 where T1.PArtsId = T.partsId and T1.ClassId = T.classId and T1.fieldSeqno=' + inttostr(i_PO        )+' )  as Field' + inttostr(i_PO        )+' ,');
      if CountPOBO         then Qrymain.SQL.AdD('(Select T1.finalQty from ' + fstablename +'  T1 where T1.PArtsId = T.partsId and T1.ClassId = T.classId and T1.fieldSeqno=' + inttostr(i_POBO      )+' )  as Field' + inttostr(i_POBO      )+' ,');
      if CountBuilt        then Qrymain.SQL.AdD('(Select T1.finalQty from ' + fstablename +'  T1 where T1.PArtsId = T.partsId and T1.ClassId = T.classId and T1.fieldSeqno=' + inttostr(i_BUILT     )+' )  as Field' + inttostr(i_BUILT     )+' ,');
                                Qrymain.SQL.AdD('(Select T1.finalQty from ' + fstablename +'  T1 where T1.PArtsId = T.partsId and T1.ClassId = T.classId and T1.fieldSeqno=' + inttostr(i_Available )+' )  as Field' + inttostr(i_Available )+' ,');
                                Qrymain.SQL.AdD('(Select T1.finalQty from ' + fstablename +'  T1 where T1.PArtsId = T.partsId and T1.ClassId = T.classId and T1.fieldSeqno=' + inttostr(i_instock   )+' )  as Field' + inttostr(i_instock   )+' ,');
      Qrymain.SQL.AdD('T.SmartOrderQty  as SmartOrderQty');
      Qrymain.SQL.AdD('from');
      Qrymain.SQL.AdD('' + fstablename +'  T left  join tblclass C on T.classId = C.classId');
      Qrymain.SQL.AdD('Order by Partname , classname');
  RefreshOrignalSQL(False);
  logtext(Qrymain.SQL.text);
end;
procedure TStockAnalysisSummaryReportGUI.PopulateGridFields;
  Function TotalQtyGroupCaption:String;
  begin
      REsult := 'Total Quantity  as on ' + Quotedstr(FormatDateTime(FormatSettings.shortdateformat, filterdateto));
  end;
begin
  FieldList := TStringList.Create;
  try
    FieldList.add(SelectedText('Partname' ,AppEnv.DefaultClass.PartColumn ,20 , ''));
    FieldList.add(SelectedText('Classname' ,AppEnv.DefaultClass.ClassHeading ,10 , ''));
      if CountQuote        then FieldList.add(SelectedText('Field' + inttostr(i_Quote       ),'Quote'              ,10,TotalQtyGroupCaption));
      if CountSO           then FieldList.add(SelectedText('Field' + inttostr(i_SO          ),'Alloc SO'           ,10,TotalQtyGroupCaption));
      if CountSOBO         then FieldList.add(SelectedText('Field' + inttostr(i_SOBO        ),'Alloc SO BO'        ,10,TotalQtyGroupCaption));
      if CountFSO          then FieldList.add(SelectedText('Field' + inttostr(i_FSO         ),'Future Alloc SO'    ,10,TotalQtyGroupCaption));
      if CountFSOBO        then FieldList.add(SelectedText('Field' + inttostr(i_FSOBO       ),'Future Alloc SO BO' ,10,TotalQtyGroupCaption));
      if CountINV          then FieldList.add(SelectedText('Field' + inttostr(i_INV         ),'Sold'               ,10,TotalQtyGroupCaption));
      if CountINVBO        then FieldList.add(SelectedText('Field' + inttostr(i_INVBO       ),'Alloc BO'           ,10,TotalQtyGroupCaption));
      if CountNERPS        then FieldList.add(SelectedText('Field' + inttostr(i_NERPS       ),'NON ERP Sales'      ,10,TotalQtyGroupCaption));
      if CountONBUILD      then FieldList.add(SelectedText('Field' + inttostr(i_ONBUILD     ),'On Build Raw'       ,10,TotalQtyGroupCaption));
      if CountONBUILD      then FieldList.add(SelectedText('Field' + inttostr(I_USEDTOBuilD ),'Used to Build'      ,10,TotalQtyGroupCaption));
      if CountBUILDING     then FieldList.add(SelectedText('Field' + inttostr(i_BUILDING    ),'Building'           ,10,TotalQtyGroupCaption));
      if CountTRANS        then FieldList.add(SelectedText('Field' + inttostr(i_TRANS       ),'Transfers'          ,10,TotalQtyGroupCaption));
      if CountADJ          then FieldList.add(SelectedText('Field' + inttostr(i_ADJ         ),'Adjustments'        ,10,TotalQtyGroupCaption));
      if CountPO           then FieldList.add(SelectedText('Field' + inttostr(i_PO          ),'Purchases'          ,10,TotalQtyGroupCaption));
      if CountPOBO         then FieldList.add(SelectedText('Field' + inttostr(i_POBO        ),'On Order'           ,10,TotalQtyGroupCaption));
      if CountBuilt        then FieldList.add(SelectedText('Field' + inttostr(i_BUILT       ),'Built'              ,10,TotalQtyGroupCaption));
      if GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_ApplyTo].asInteger = 1 then begin
                                FieldList.add(SelectedText('Field' + inttostr(i_Available ),'Available'          ,10,TotalQtyGroupCaption));
                                FieldList.add(SelectedText('Field' + inttostr(i_instock   ),'Instock'          ,10,TotalQtyGroupCaption));
      end else begin
                                FieldList.add(SelectedText('Field' + inttostr(i_instock   ),'Instock'          ,10,TotalQtyGroupCaption));
                                FieldList.add(SelectedText('Field' + inttostr(i_Available ),'Available'          ,10,TotalQtyGroupCaption));
      end;
    FieldList.add(SelectedText('SmartOrderQty' ,'Ordering~Quantity' ,10));
  finally
    grdMain.Selected := FieldList;
    FreeandNil(FieldList);
    grdMain.Applyselected;
    logtext(grdMain.Selected.text);
  end;
end;
procedure TStockAnalysisSummaryReportGUI.RefreshQuery;
begin
  Processingcursor(True);
  try
      inherited;
  finally
    Processingcursor(False);
  end;
end;

initialization
  RegisterClassOnce(TStockAnalysisSummaryReportGUI);

end.
