unit StockAnalysisDetailsReport;

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
  TStockAnalysisDetailsReportGUI = class(TStockAnalysisReportGUI)
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
  Protected
    Procedure MakeQrymain;Override;
    Procedure PopulateGridFields;Override;
    function GrpfiltersItemidex :Integer ; Override;
  public
  end;

implementation

uses CommonLib, LogLib, AppEnvironment, salesAnalysisLib;

{$R *.dfm}

procedure TStockAnalysisDetailsReportGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;

    if sametext(Qrymain.fieldbyname('description').asString , 'Available') or
      sametext(Qrymain.fieldbyname('description').asString , 'In-stock') then begin
      if sametext(field.fieldname, 'Partname') then else DoGreenhighlight(Afont,ABrush );
      if (Field is Tfloatfield) and (TFloatField(Field).AsFloat<0) then Doredhighlight(Afont,ABrush );
    end;

    if sametext(Field.fieldname , 'SmartOrderQty') then
           if (qrymain.fieldbyname('FieldSeqno').asInteger <> i_Available) and (qrymain.fieldbyname('FieldSeqno').asInteger <> i_instock) then DoHide(Field,State,Afont , ABrush )
      else if (qrymain.fieldbyname('FieldSeqno').asInteger  = i_Available) and (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_ApplyTo].asInteger <> 0) then DoHide(Field,State,Afont , ABrush )
      else if (qrymain.fieldbyname('FieldSeqno').asInteger  = i_instock)   and (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_ApplyTo].asInteger <> 1) then   Doredhighlight(Afont , ABrush );

end;

function TStockAnalysisDetailsReportGUI.GrpfiltersItemidex: Integer;
begin
  REsult := 1;
end;

procedure TStockAnalysisDetailsReportGUI.MakeQrymain;
var
  ctr:Integer;
  //s:String;
begin
  closedb(Qrymain);
  Qrymain.SQL.Clear;
      Qrymain.SQL.AdD('Select');
      Qrymain.SQL.AdD('T.PartsId as PartsId,');
      Qrymain.SQL.AdD('T.ClassId as ClassId,');
      Qrymain.SQL.AdD('T.Partname as Partname,');
      Qrymain.SQL.AdD('C.classname as classname,');
      Qrymain.SQL.AdD('T.fieldSeqno as FieldSeqno,');
      Qrymain.SQL.AdD('T.Field0 as Field0,');
      for ctr := low(fDurationFields) to high(fDurationFields) do
        Qrymain.SQL.AdD('T.' +fDurationFields[ctr].fieldname+' as ' + fDurationFields[ctr].fieldname+',');
      Qrymain.SQL.AdD('T.FinalQty as FinalQty,');
      Qrymain.SQL.AdD('T.Description as Description,');
      Qrymain.SQL.AdD('T.SmartOrderQty  as SmartOrderQty');

      Qrymain.SQL.AdD('from ');
      Qrymain.SQL.AdD(fstablename +' as T left join tblclass C on T.classId = C.classId');
      Qrymain.SQL.AdD('Order by Partname ,classname ,  FieldSeqno');
  RefreshOrignalSQL(False);
  logtext(Qrymain.SQL.text);
end;
procedure TStockAnalysisDetailsReportGUI.PopulateGridFields;
var
  Ctr :Integer;
begin
  FieldList := TStringList.Create;
  try
    FieldList.add(SelectedText('Partname' ,AppEnv.DefaultClass.PartColumn ,20 , ''));
    FieldList.add(SelectedText('Classname' ,AppEnv.DefaultClass.ClassHeading ,10 , ''));
    FieldList.add(SelectedText('Description' ,'Description' ,20 , ''));
    FieldList.add(SelectedText('Field0' ,'Qty as On~' + FormatdateTime(FormatSettings.Shortdateformat, fDurationFields[low(fDurationFields)].DateTo) ,10));
    for ctr := low(fDurationFields) to high(fDurationFields) do
      if devmode then
           FieldList.add(SelectedText(fDurationFields[ctr].fieldname ,FormatdateTime(FormatSettings.Shortdateformat, fDurationFields[ctr].Datefrom) ,10 , fDurationFields[ctr].groupname))
      else FieldList.add(SelectedText(fDurationFields[ctr].fieldname ,fDurationFields[ctr].Fielddisplaylabel ,10 , fDurationFields[ctr].groupname));
        FieldList.add(SelectedText('FinalQty' ,'Qty as on~' +formatdatetime(FormatSettings.shortdateformat, filterdateto) ,10));
    FieldList.add(SelectedText('SmartOrderQty' ,'Ordering~Quantity' ,10));

  finally
    grdMain.Selected := FieldList;
    FreeandNil(FieldList);
    grdMain.Applyselected;
    logtext(grdMain.Selected.text);
  end;
end;

initialization
  RegisterClassOnce(TStockAnalysisDetailsReportGUI);

end.
