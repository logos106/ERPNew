unit EmpWorkOrders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel, IntegerListObj;

type
  TEmpWorkOrdersGUI = class(TBaseListingGUI)
    qryMainPPQID: TIntegerField;
    qryMainProcessPartId: TIntegerField;
    qryMainDuration: TFloatField;
    qryMainActive: TWideStringField;
    qryMainPCTQ_SchdID: TIntegerField;
    qryMainPCTQ_BuiltID: TIntegerField;

    qryMainBuilddate: TDateTimeField;
    qryMainQtyScheduled: TFloatField;
    qryMainTimeStart: TDateTimeField;
    qryMainTimeEnd: TDateTimeField;
    qryMaincDuration: TWideStringField;
    qryMainemployeeName: TWideStringField;
    qryMainResourcedetails: TWideStringField;
    qryMainResource: TWideStringField;
    qryMainCaption: TWideStringField;
    qryMainSaleLineID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainProcessStep: TWideStringField;

    qryMainsaleID: TIntegerField;
    qryMainLevel: TIntegerField;
    qryMainProcTreeID: TIntegerField;
    qryMainProcessTimeId: TIntegerField;
    qryMainID: TIntegerField;
    qryMainDetails: TIntegerField;
    qryMainProcessStepId: TIntegerField;
    qryMainProcessStepSeq: TIntegerField;
    qryMainResDetID: TIntegerField;
    qryMainResID: TIntegerField;
    qryMainSAle_RowNum: TIntegerField;
    qryMainSaleLine_RowNum: TIntegerField;
    qryMainProctree_RowNum: TIntegerField;
    qryMainProcessPart_RowNum: TIntegerField;
    qryMainResDet_RowNum: TIntegerField;
    qryMainPS_RowNum: TIntegerField;
    qryMainRes_RowNum: TIntegerField;
    qryMainSelected: TWideStringField;
    qryMainEmployeeId: TIntegerField;
    qryMainFormulaId: TIntegerField;
    qryMainFormulaName : TWideStringField;
    qryMainformula     : TWideStringField;
    qryMainformulaDetails : TWideStringField;
    qryMainFormulaQty1  : TFloatfield;
    qryMainFormulaQty2  : TFloatfield;
    qryMainFormulaQty3  : TFloatfield;
    qryMainFormulaQty4  : TFloatfield;
    qryMainFormulaQty5  : TFloatfield;


    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);override;
    procedure cmdPrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    tmp_main :String;
    ProcessStepIDs:TIntegerList;
    EmployeeIDs:TIntegerList;
    procedure OnProcessOrEmpSelection(Sender: TObject);
    procedure SelectAll(const value: Boolean);
    procedure ClosePrintWorkOrders;
  Protected
    procedure SetGridColumns; Override;
    procedure MakeTemplateSQL;Override;
    Procedure AdjustDisplayLabels; override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CommonDbLib, DbSharedObjectsObj, LogLib, tcConst, MySQLConst,
  CommonFormLib, frmPrintWorkOrders , MessageInterface , WorkOrderLib;

{$R *.dfm}
procedure TEmpWorkOrdersGUI.cmdPrintClick(Sender: TObject);
var
  Form : TfmPrintWorkOrders;
begin
  if FormStillOpen('TfmPrintWorkOrders') then Exit;

  SelectAll(true);
  try
  //OpenERPForm('TfmPrintWorkOrders',0 ,nil, initPrintWorkOrders) ;
    form := TfmPrintWorkOrders.Create(Self);
    form.tmp_EmpWorkOrder := tmp_main;
    //form.tmp_processtime := tmp_processtime;
    form.CallingFormname := Self.classname;
    form.OnSelection := OnProcessOrEmpSelection;
    form.dateFrom := filterdateFrom;
    form.DateTo := FilterDateTo;
    form.FormStyle := fsStayonTop;
    form.Show;
    form.BringToFront;
    //form.WindowState := wsNormal;
  finally
    SelectAll(False);
  end;
end;
Procedure TEmpWorkOrdersGUI.SelectAll(const value:Boolean);
var
  fid:Integer;
begin
  //inherited;
  with Scriptmain do begin
    SQL.Clear;
    if (ProcessStepIDs <> nil) and (EmployeeIDs<>nil) then begin
      SQL.Add('update '+ tmp_main+' set selected ="F";');
      SQL.Add('update '+ tmp_main+' set selected ="T" where ifnull(EmployeeId,0)<>0 and ifnull(ProcessStepId,0)<> 0 and EmployeeId in ('+ EmployeeIDs.commatext+') and ProcessStepId in ( ' + ProcessStepIDs.commatext +') ;');
    end else begin
      SQL.Add('update '+ tmp_main+' set selected ="T" where ifnull(EmployeeId,0)<>0 and ifnull(ProcessStepId,0)<> 0 ;');
    end;
    Execute;
    fid:= qrymainId.asInteger;
    try
      closedb(Qrymain);
      Opendb(Qrymain);
    finally
      Qrymain.Locate('ID' , fid , []);
    end;
  end;

end;

procedure TEmpWorkOrdersGUI.OnProcessOrEmpSelection(Sender:TObject);
begin
  if not(Sender is TfmPrintWorkOrders) then exit;
    ProcessStepIDs:=TfmPrintWorkOrders(Sender).ProcessStepIDs;
    EmployeeIDs   :=TfmPrintWorkOrders(Sender).EmployeeIDs;
    try
      if ProcessStepIDs.count =0 then ProcessStepIDs.add(0);
      if EmployeeIDs.count    =0 then EmployeeIDs.add(0);
      SelectAll(TRue);
    finally
      ProcessStepIDs:=nil;
      EmployeeIDs   :=nil;
    end;
end;
procedure TEmpWorkOrdersGUI.MakeTemplateSQL;
begin

end;

procedure TEmpWorkOrdersGUI.FormCreate(Sender: TObject);
begin
  ProcessStepIDs:=nil;
  EmployeeIDs:=nil;
  tmp_main :=CommonDbLib.GetUserTemporaryTablename('EMP_WO' );
  Qrymain.SQL.text := 'Select * from '+ tmp_main +' Order by SaleId, SaleLineId, Level , ProctreeId , ProcessPartId , Builddate  ,Resource , Resourcedetails ,  details' ;
  inherited;
end;

procedure TEmpWorkOrdersGUI.FormDestroy(Sender: TObject);
begin
  ClosePrintWorkOrders;
  DestroyUserTemporaryTable(tmp_main);
  inherited;
end;
procedure TEmpWorkOrdersGUI.FormShow(Sender: TObject);
begin
  inherited;
  if grpfilters.itemindex <0 then begin
      grpfilters.itemindex := 1;
      grpfiltersclick(grpfilters);

  end;
end;

procedure TEmpWorkOrdersGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Qrymainselected.AsBoolean then ABrush.Color := GridColhighLightGreen;

  if (QrymainDEtails.asInteger=1) and (Grpfilters.itemindex =1) then begin
      Afont.color := GridColhighLightGreen;
      Afont.Style := Afont.Style +[fsBold];
      //AFont.size := 12;
  end;
  if (QrymainDEtails.asInteger=1)  and
           (Sametext(Field.fieldname ,    qryMainemployeeName.Fieldname ) or
           Sametext(Field.fieldname ,    qryMainResourcedetails.Fieldname ) or
           Sametext(Field.fieldname ,    qryMainResource.Fieldname )) then
    Afont.color := ABrush.color;

  if (QrymainDEtails.asInteger=2)  and
           (Sametext(Field.fieldname ,    qryMainBuilddate.Fieldname ) or
           Sametext(Field.fieldname ,    qryMainSaleID.Fieldname ) or
           Sametext(Field.fieldname ,    qryMainProductname.Fieldname ) or
           Sametext(Field.fieldname ,    qryMainCaption.Fieldname ) or
           Sametext(Field.fieldname ,    qryMainQtyScheduled.Fieldname )) then
    Afont.color := ABrush.color;

       if qryMainSAle_RowNum.AsInteger       >1 then if Sametext(Field.fieldname ,    qryMainSaleID.Fieldname          ) then Afont.color := ABrush.color
  else if qryMainSaleLine_RowNum.AsInteger   >1 then if Sametext(Field.fieldname ,    qryMainProductname.Fieldname     ) then Afont.color := ABrush.color
  else if qryMainProctree_RowNum.AsInteger   >1 then if Sametext(Field.fieldname ,    qryMainCaption.Fieldname         ) then Afont.color := ABrush.color
  else if qryMainRes_RowNum.AsInteger        >1 then if Sametext(Field.fieldname ,    qryMainResource.Fieldname        ) then Afont.color := ABrush.color
  else if qryMainResDet_RowNum.AsInteger     >1 then if Sametext(Field.fieldname ,    qryMainResourceDetails.Fieldname ) then Afont.color := ABrush.color
  else if qryMainPS_RowNum.AsInteger         >1 then if Sametext(Field.fieldname ,    qryMainProcessStep.Fieldname     ) then Afont.color := ABrush.color;

end;

procedure TEmpWorkOrdersGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Details' , ['1',''], true);
  inherited;
end;

procedure TEmpWorkOrdersGUI.AdjustDisplayLabels;
var
  Qryfenames :TERPQuery;
begin
  inherited;
  Qryfenames := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    closedb(Qryfenames);
    Qryfenames.SQL.Text := 'select * from tblfenames';
    OpenDb(Qryfenames);
    if Qryfenames.recordcount >=1 then begin
      Qryfenames.First;
      qryMainFormulaQty1.DisplayLabel:=Qryfenames.FieldByName('formulaentryname').AsString;
    end else begin
    end;
    if Qryfenames.recordcount >=2 then begin Qryfenames.Next;qryMainFormulaQty2.DisplayLabel :=Qryfenames.FieldByName('formulaentryname').AsString; end ;
    if Qryfenames.recordcount >=3 then begin Qryfenames.Next;qryMainFormulaQty3.DisplayLabel :=Qryfenames.FieldByName('formulaentryname').AsString; end ;
    if Qryfenames.recordcount >=4 then begin Qryfenames.Next;qryMainFormulaQty4.DisplayLabel :=Qryfenames.FieldByName('formulaentryname').AsString; end ;
    if Qryfenames.recordcount >=5 then begin Qryfenames.Next;qryMainFormulaQty5.DisplayLabel :=Qryfenames.FieldByName('formulaentryname').AsString; end ;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(Qryfenames);
  end;


end;

Procedure TEmpWorkOrdersGUI.ClosePrintWorkOrders;
var
  MsgObj: TMsgObj;
  fMsgHandler: TMsgHandler;
begin
  MsgObj := TMsgObj.Create;
  fMsgHandler := TMsgHandler.Create(Self);
  Try
    MsgObj.SetAddress('TfmPrintWorkOrders', 'CloseIfOpen');
    if fMsgHandler.Send(MsgObj, MsgObj) then begin
      Exit;
    end;
  Finally
    FreeAndNil(MsgObj);
    FreeAndNil(fMsgHandler);
  End;

end;
procedure TEmpWorkOrdersGUI.RefreshQuery;
begin
  ClosePrintWorkOrders;
  PopulateWorkOrderReportTable(tmp_main , filterdateFrom, FilterdateTo, 0);
  inherited;
  if not (chkIgnoreDates.checked) then
        ListTimerMsg('It is the List of Products to be Built During the Selected Period - ' + FormatdateTime(FormatSettings.shortDateFormat , FilterDatefrom) +' and ' + FormatdateTime(FormatSettings.shortDateFormat , FilterDateTo) +'.');
end;

procedure TEmpWorkOrdersGUI.SetGridColumns;
Var
  Qryfenames  :TERPQuery;
begin
  inherited;
  Qryfenames := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    closedb(Qryfenames);
    Qryfenames.SQL.Text := 'select * from tblfenames';
    OpenDb(Qryfenames);
    if Qryfenames.recordcount <1 then begin
      RemoveFieldfromGrid(qryMainFormulaQty1.fieldName);
      RemoveFieldfromGrid(Qrymainformula.fieldName);
      RemoveFieldfromGrid(QrymainformulaDetails.fieldName);
    end;
    if Qryfenames.recordcount < 2 then RemoveFieldfromGrid(qryMainFormulaQty2.fieldName);
    if Qryfenames.recordcount < 3 then RemoveFieldfromGrid(qryMainFormulaQty3.fieldName);
    if Qryfenames.recordcount < 4 then RemoveFieldfromGrid(qryMainFormulaQty4.fieldName);
    if Qryfenames.recordcount < 5 then RemoveFieldfromGrid(qryMainFormulaQty5.fieldName);
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(Qryfenames);
  end;

  RemoveFieldfromGrid(qryMainDetails.fieldname);
  RemoveFieldfromGrid(qryMainPPQID.fieldname);
  RemoveFieldfromGrid(qryMainProcessPartId.fieldname);
  RemoveFieldfromGrid(qryMainProcessTimeId.fieldname);
  RemoveFieldfromGrid(qryMainDuration.fieldname);
  RemoveFieldfromGrid(qryMainActive.fieldname);
  RemoveFieldfromGrid(qryMainPCTQ_SchdID.fieldname);
  RemoveFieldfromGrid(qryMainPCTQ_BuiltID.fieldname);
  RemoveFieldfromGrid(qryMainSaleLineId.fieldname);
  RemoveFieldfromGrid(qryMainSAle_RowNum.fieldname);
  RemoveFieldfromGrid(qryMainSaleLine_RowNum.fieldname);
  RemoveFieldfromGrid(qryMainProctree_RowNum.fieldname);
  RemoveFieldfromGrid(qryMainProcessPart_RowNum.fieldname);
  RemoveFieldfromGrid(qryMainResDet_RowNum.fieldname);
  RemoveFieldfromGrid(qryMainPS_RowNum.fieldname);
  RemoveFieldfromGrid(qryMainRes_RowNum.fieldname);
  RemoveFieldfromGrid(qryMainLevel.fieldname);
  RemoveFieldfromGrid(qryMainProcTreeID.fieldname);
  RemoveFieldfromGrid(qryMainID.fieldname);
  RemoveFieldfromGrid(qryMainProcessStepId.fieldname);
  RemoveFieldfromGrid(qryMainProcessStepSeq.fieldname);
  RemoveFieldfromGrid(qryMainResDetID.fieldname);
  RemoveFieldfromGrid(qryMainResID.fieldname);
  RemoveFieldfromGrid(qryMainSelected.fieldname);
  RemoveFieldfromGrid(qryMainFormulaId.fieldname);

end;

initialization
  RegisterClassOnce(TEmpWorkOrdersGUI);

end.
