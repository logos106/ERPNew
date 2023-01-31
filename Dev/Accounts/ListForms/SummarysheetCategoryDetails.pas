unit SummarysheetCategoryDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SummarysheetCategory, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  AdvSplitter, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton,
  wwclearbuttongroup, wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TSummarysheetCategoryDetailsGUI = class(TSummarysheetCategoryGUI)
    qryMaininDBCurrAmt1: TFloatField;
    qryMaininDBCurrAmt2: TFloatField;
    qryMaininDBCurrAmt3: TFloatField;
    qryMaininDBCurrAmt4: TFloatField;
    qryMaininDBCurrAmt5: TFloatField;
    qryMaininDBCurrAmt6: TFloatField;
    qryMaininDBCurrAmt7: TFloatField;
    qryMaininDBCurrAmt8: TFloatField;
    qryMaininDBCurrAmt9: TFloatField;
    qryMaininDBCurrAmt10: TFloatField;
    qryMaininDBCurrAmt11: TFloatField;
    qryMaininDBCurrAmt12: TFloatField;
    qryMaininDBCurrAmt13: TFloatField;
    qryMaininDBCurrAmt14: TFloatField;
    qryMaininDBCurrAmt15: TFloatField;
    qryMaininDBCurrAmt16: TFloatField;
    qryMaininDBCurrAmt17: TFloatField;
    qryMaininDBCurrAmt18: TFloatField;
    qryMaininDBCurrAmt19: TFloatField;
    qryMaininDBCurrAmt20: TFloatField;
    qryMaininDBCurrAmt21: TFloatField;
    qryMaininDBCurrAmt22: TFloatField;
    qryMaininDBCurrAmt23: TFloatField;
    qryMaininDBCurrAmt24: TFloatField;
    qryMaininDBCurrAmt25: TFloatField;
    qryMaininDBCurrAmt26: TFloatField;
    qryMaininDBCurrAmt27: TFloatField;
    qryMaininDBCurrAmt28: TFloatField;
    qryMaininDBCurrAmt29: TFloatField;
    qryMaininDBCurrAmt30: TFloatField;
    qryMaininDBCurrAmt31: TFloatField;
    qryMaininDBCurrAmt32: TFloatField;
    qryMaininDBCurrAmt33: TFloatField;
    qryMaininDBCurrAmt34: TFloatField;
    qryMaininDBCurrAmt35: TFloatField;
    qryMaininDBCurrAmt36: TFloatField;
    qryMaininDBCurrAmt37: TFloatField;
    qryMaininDBCurrAmt38: TFloatField;
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string;
      AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure FormShow(Sender: TObject);
  private
    procedure FormatinDBfields(AFieldName: String; AFont: TFont;
      ABrush: TBrush);
  Protected
    Procedure ExtraFields;Override;
    Procedure MakeQrymain;Override;
  public
  end;

implementation

uses CommonLib, CommonFormLib;

{$R *.dfm}

procedure TSummarysheetCategoryDetailsGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  OpenERpListForm('TSummarysheetCategoryGUI', CopyParamsto);
  CloseWait;
end;

procedure TSummarysheetCategoryDetailsGUI.ExtraFields;
begin
  inherited;
      if (fiPageno = 1) then begin
        AddGridSelectedfield('inDBCurrAmt1'         ,12 ,'Cash in~Hand'       , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt2'         ,12 ,'Accounts~Receivable', 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt3'         ,12 ,'Accounts~Payable'   , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt4'         ,12 ,'Balance~Sheet'      , 'In Local Currency');
      end else if (fiPageno = 2) then begin
        AddGridSelectedfield('inDBCurrAmt5'         ,12 ,'Current'            , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt6'         ,12 ,'1 - 30'             , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt7'         ,12 ,'31 - 60'            , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt8'         ,12 ,'61 - 90'            , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt9'         ,12 ,'90 +'               , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAPtotal'      ,12 ,'Total'              , 'In Local Currency');
      end else if (fiPageno = 3) then begin
        AddGridSelectedfield('inDBCurrAmt10'        ,12 ,'Current'            , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt11'        ,12 ,'1 - 30'             , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt12'        ,12 ,'31 - 60'            , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt13'        ,12 ,'61 - 90'            , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt14'        ,12 ,'90 +'               , 'In Local Currency');
        AddGridSelectedfield('inDBCurrARtotal'      ,12 ,'Total'              , 'In Local Currency');
      end else if (fiPageno = 4) then begin
        AddGridSelectedfield('inDBCurrAmt15'        ,12 ,'Sales'              , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt16'        ,12 ,'Cost of Goods'      , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt17'        ,12 ,'Expenses'           , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt18'        ,12 ,'Profit & Loss'      , 'In Local Currency');
      end else if (fiPageno = 5) then begin
        AddGridSelectedfield('inDBCurrAmt19'        ,12 ,'Sales'              , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt20'        ,12 ,'Cost of Goods'      , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt21'        ,12 ,'Expenses'           , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt22'        ,12 ,'Profit & Loss'      , 'In Local Currency');
      end else if (fiPageno = 6) then begin
        AddGridSelectedfield('inDBCurrAmt23'        ,12 ,'Sales'              , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt24'        ,12 ,'Cost of Goods'      , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt25'        ,12 ,'Expenses'           , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt26'        ,12 ,'Profit & Loss'      , 'In Local Currency');
      end else if (fiPageno = 7) then begin
        AddGridSelectedfield('inDBCurrAmt27'        ,12 ,'Sales'              , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt28'        ,12 ,'Cost of Goods'      , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt29'        ,12 ,'Expenses'           , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt30'        ,12 ,'Profit & loss'      , 'In Local Currency');
      end else if (fiPageno = 8) then begin
        AddGridSelectedfield('inDBCurrAmt31'        ,12 ,'Sales'              , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt32'        ,12 ,'Cost of Goods'      , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt33'        ,12 ,'Expenses'           , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt34'        ,12 ,'Profit & loss'      , 'In Local Currency');
      end else if (fiPageno = 9) then begin
        AddGridSelectedfield('inDBCurrAmt35'        ,12 ,'Sales'              , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt36'        ,12 ,'Cost of Goods'      , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt37'        ,12 ,'Expenses'           , 'In Local Currency');
        AddGridSelectedfield('inDBCurrAmt38'        ,12 ,'Profit & loss'      , 'In Local Currency');
      end;
end;


procedure TSummarysheetCategoryDetailsGUI.grdMainCalcCellColors(Sender: TObject;Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;ABrush: TBrush);
begin
  inherited;
  FormatinDBfields(Field.FieldName, AFont, ABrush);
end;
procedure TSummarysheetCategoryDetailsGUI.grdMainCalcTitleAttributes(  Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush;var ATitleAlignment: TAlignment);
begin
  inherited;
  FormatinDBfields(AFieldName, AFont, ABrush);
end;
procedure TSummarysheetCategoryDetailsGUI.FormatinDBfields(AFieldName:String;AFont: TFont;ABrush: TBrush);
begin
  if sametext(AFieldName , 'inDBCurrAmt1') or
     sametext(AFieldName , 'inDBCurrAmt2') or
     sametext(AFieldName , 'inDBCurrAmt3') or
     sametext(AFieldName , 'inDBCurrAmt4') or
     sametext(AFieldName , 'inDBCurrAmt5') or
     sametext(AFieldName , 'inDBCurrAmt6') or
     sametext(AFieldName , 'inDBCurrAmt7') or
     sametext(AFieldName , 'inDBCurrAmt8') or
     sametext(AFieldName , 'inDBCurrAmt9') or
     sametext(AFieldName , 'inDBCurrAmt10') or
     sametext(AFieldName , 'inDBCurrAmt11') or
     sametext(AFieldName , 'inDBCurrAmt12') or
     sametext(AFieldName , 'inDBCurrAmt13') or
     sametext(AFieldName , 'inDBCurrAmt14') or
     sametext(AFieldName , 'inDBCurrAmt15') or
     sametext(AFieldName , 'inDBCurrAmt16') or
     sametext(AFieldName , 'inDBCurrAmt17') or
     sametext(AFieldName , 'inDBCurrAmt18') or
     sametext(AFieldName , 'inDBCurrAmt19') or
     sametext(AFieldName , 'inDBCurrAmt20') or
     sametext(AFieldName , 'inDBCurrAmt21') or
     sametext(AFieldName , 'inDBCurrAmt22') or
     sametext(AFieldName , 'inDBCurrAmt23') or
     sametext(AFieldName , 'inDBCurrAmt24') or
     sametext(AFieldName , 'inDBCurrAmt25') or
     sametext(AFieldName , 'inDBCurrAmt26') or
     sametext(AFieldName , 'inDBCurrAmt27') or
     sametext(AFieldName , 'inDBCurrAmt28') or
     sametext(AFieldName , 'inDBCurrAmt29') or
     sametext(AFieldName , 'inDBCurrAmt30') or
     sametext(AFieldName , 'inDBCurrAmt31') or
     sametext(AFieldName , 'inDBCurrAmt32') or
     sametext(AFieldName , 'inDBCurrAmt33') or
     sametext(AFieldName , 'inDBCurrAmt34') or
     sametext(AFieldName , 'inDBCurrAmt35') or
     sametext(AFieldName , 'inDBCurrAmt36') or
     sametext(AFieldName , 'inDBCurrAmt37') or
     sametext(AFieldName , 'inDBCurrAmt38') then begin
      DoGreenhighlight(AFont,ABrush);
  end;
end;

procedure TSummarysheetCategoryDetailsGUI.FormShow(Sender: TObject);
begin
  inherited;
  Widerform(1400);
end;

procedure TSummarysheetCategoryDetailsGUI.MakeQrymain;
begin
  inherited;
  With Scriptmain do begin
    SQL.clear;
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt1 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt2 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt3 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt4 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt5 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt6 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt7 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt8 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt9 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt10 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt11 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt12 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt13 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt14 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt15 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt16 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt17 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt18 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt19 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt20 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt21 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt22 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt23 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt24 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt25 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt26 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt27 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt28 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt29 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt30 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt31 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt32 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt33 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt34 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt35 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt36 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt37 double DEFAULT 0;');
      SQL.Add('alter table '+tablename +'  Add column inDBCurrAmt38 double DEFAULT 0;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt1 = Amt1 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt2 = Amt2 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt3 = Amt3 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt4 = Amt4 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt5 = Amt5 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt6 = Amt6 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt7 = Amt7 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt8 = Amt8 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt9 = Amt9 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt10 = Amt10 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt11 = Amt11 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt12 = Amt12 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt13 = Amt13 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt14 = Amt14 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt15 = Amt15 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt16 = Amt16 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt17 = Amt17 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt18 = Amt18 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt19 = Amt19 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt20 = Amt20 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt21 = Amt21 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt22 = Amt22 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt23 = Amt23 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt24 = Amt24 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt25 = Amt25 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt26 = Amt26 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt27 = Amt27 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt28 = Amt28 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt29 = Amt29 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt30 = Amt30 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt31 = Amt31 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt32 = Amt32 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt33 = Amt33 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt34 = Amt34 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt35 = Amt35 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt36 = Amt36 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt37 = Amt37 * ExchangeRate;');
      SQL.AdD('update ' +tablename +' set inDBCurrAmt38 = Amt38 * ExchangeRate;');
      Execute;
  end;
end;

procedure TSummarysheetCategoryDetailsGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
      SetForeignFieldDisplayFormat('inDBCurrAmt1' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt2' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt3' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt4' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt5' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt6' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt7' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt8' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt9' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt10' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt11' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt12' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt13' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt14' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt15' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt16' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt17' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt18' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt19' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt20' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt21' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt22' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt23' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt24' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt25' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt26' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt27' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt28' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt29' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt30' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt31' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt32' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt33' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt34' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt35' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt36' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt37' , '');
      SetForeignFieldDisplayFormat('inDBCurrAmt38' , '');

end;

initialization
  RegisterClass(TSummarysheetCategoryDetailsGUI);
end.
