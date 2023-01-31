unit WorkOrders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TWorkOrdersGUI = class(TBaseListingGUI)
    qryMainPPid: TIntegerField;
    qryMainProctreeId: TIntegerField;
    qryMainsaleId: TIntegerField;
    qryMainsaleLineId: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainShipDate: TDateTimeField;
    qryMainCaption: TWideStringField;
    qryMainCaptionIntend: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainResourceName: TWideStringField;
    qryMainResourceDetailName: TWideStringField;
    qryMainDuration: TWideStringField;
    qryMainTimeStart: TDateTimeField;
    qryMainTimeEnd: TDateTimeField;
    qryMainSchdDate: TDateField;
    qryMaintotalqty: TFloatField;
    qryMainquantity: TFloatField;
    qryMainManufactureUOMQty: TFloatField;
    qryMainFromStockUOMQty: TFloatField;
    qryMainOnOrderUOMQty: TFloatField;
    qryMainProcessTimeId: TLargeintField;
    procedure grpFiltersClick(Sender: TObject);override;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);
  private
    procedure BeforeshowList(Sender: TObject);
    procedure intBOMSalesPieceRateConf(Sender: TObject);
  Protected
    Procedure MakeQrymain;virtual;
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonDbLib, CommonFormLib,dateutils, LogLib, TemplateReportsLib,
  CommonLib, MySQLConst, WorkOrdersUnScheduled,
  frmWorkOrder;

{$R *.dfm}

{ TBaseListingGUI1 }

procedure TWorkOrdersGUI.cmdPrintClick(Sender: TObject);
var
  strSQL:String;
  fsTemplate:String;
begin

       if (grpfilters.ItemIndex =0)  then fsTemplate := 'Work Order (Employee)'
  else if (grpfilters.ItemIndex =1)  then fsTemplate := 'Work Order (Date)'
  else if (grpfilters.ItemIndex =2)  then fsTemplate := 'Work Order (Resource)'
  else if (grpfilters.ItemIndex =3)  then fsTemplate := 'Work Order (Sale)'
  else Exit;

  strSQL:=companyInfoSQL('', FilterDAteFrom, FilterdateTo);
  strSQL:= strSQL +'~|||~{Details}'+ ReplaceStr(ReplaceStr(Qrymain.SQL.Text,':DateFrom' ,  'convert('+Quotedstr(FormatdateTime(mySQLdateTimeformat , FilterDAteFrom))+',dateTime) '),
                                                                            ':DateTo'   ,  'convert('+Quotedstr(FormatdateTime(mySQLdateTimeformat , FilterdateTo  ))+',dateTime) ');
  clog(strSQL);
  ReportSQLSupplied := True;
  PrintTemplateReport(fsTemplate, strsql,False,1);
end;

procedure TWorkOrdersGUI.FormCreate(Sender: TObject);
begin
  MakeQrymain;
  inherited;
end;

procedure TWorkOrdersGUI.FormShow(Sender: TObject);
begin
  inherited;
  grpfilters.visible := True;
end;

procedure TWorkOrdersGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if Sametext(field.FieldName , grdmain.GroupFieldName) then begin
    AFont.Style := AFont.Style + [fsBold];
  end;
end;

procedure TWorkOrdersGUI.grdMainDblClick(Sender: TObject);
begin

  if sametext(Activefieldname, qrymainsaleId.fieldname) or
     sametext(Activefieldname, qrymainCustomerName.fieldname) or
     sametext(Activefieldname, qrymainsaleDate.fieldname) or
     sametext(Activefieldname, qrymainShipdate.fieldname) then
       OpenERPFormModal('TfmWorkOrder' , 0 , intBOMSalesPieceRateConf)
  else OpenERPFormModal('TfmWorkOrderForSingleItem' , 0 , intBOMSalesPieceRateConf);
(*  inherited;*)
end;
procedure TWorkOrdersGUI.intBOMSalesPieceRateConf(Sender: TObject);
begin
  if  (sender is TfmWorkOrder) then begin
    TfmWorkOrder(Sender).SalesLineId := QrymainSaleLineId.asInteger;
    TfmWorkOrder(Sender).saleId := QrymainSaleId.asInteger;
    if   sametext(Activefieldname, qrymainsaleId.fieldname) or
         sametext(Activefieldname, qrymainCustomerName.fieldname) or
         sametext(Activefieldname, qrymainsaleDate.fieldname) or
         sametext(Activefieldname, qrymainShipdate.fieldname) then
    else TfmWorkOrder(Sender).ProctreeId := QrymainProctreeId.asInteger;
  end;
end;

procedure TWorkOrdersGUI.grpFiltersClick(Sender: TObject);
var
  fsListname:String;
begin
  inherited;
  if not IsFormshown then exit;
       if (grpfilters.ItemIndex =0)  then fsListname:= 'TWorkOrdersByEmpGUI'
  else if (grpfilters.ItemIndex =1)  then fsListname:= 'TWorkOrdersByDateGUI'
  else if (grpfilters.ItemIndex =2)  then fsListname:= 'TWorkOrdersByResGUI'
  else if (grpfilters.ItemIndex =3)  then fsListname:= 'TWorkOrdersBySaleGUI'
  else if (grpfilters.ItemIndex =4)  then fsListname:= 'TWorkOrdersUnScheduledGUI'
  else exit;

  if Classnameis(fsListname) then exit;
  OpenERpListForm(fsListname, BeforeshowList);
  CloseWait;
end;
procedure TWorkOrdersGUI.BeforeshowList(Sender: TObject);
begin
  copyParamsto(Sender);
end;

procedure TWorkOrdersGUI.MakeQrymain;
begin
  closedb(Qrymain);
  Qrymain.SQL.Clear;
  Qrymain.SQL.add('select');
  Qrymain.SQL.add('convert(PCT.ProcessTimeId,UNSIGNED) as ProcessTimeId,');
  Qrymain.SQL.add('PP.ID as PPid,');
  Qrymain.SQL.add('PT.ProctreeId as ProctreeId,');
  Qrymain.SQL.add('S.saleId as saleId,');
  Qrymain.SQL.add('SL.saleLineId as saleLineId,');
  Qrymain.SQL.add('S.CustomerName as CustomerName,');
  Qrymain.SQL.add('S.SaleDate as SaleDate,');
  Qrymain.SQL.add('SL.ShipDate as ShipDate,');
  Qrymain.SQL.add('PT.Caption as Caption,');
  Qrymain.SQL.add('replace(Convert(TreeNodeCaption(PT.Level, PT.caption ), char(255)),"," , "\n") CaptionIntend,');
  Qrymain.SQL.add('E.EmployeeName as EmployeeName,');
  Qrymain.SQL.add('PR.ResourceName as ResourceName,');
  Qrymain.SQL.add('PRD.Description as ResourceDetailName,');
  Qrymain.SQL.add('(PCT.TimeStart) as TimeStart ,');
  Qrymain.SQL.add('date(PCT.timeStart)as SchdDate,');
  Qrymain.SQL.add('(DATE_ADD(PCT.TimeStart , INTERVAL PCT.Duration Second)) as TimeEnd,');
  Qrymain.SQL.add('PT.totalqty as totalqty,');
  Qrymain.SQL.add('PT.quantity as quantity,');
  Qrymain.SQL.add('Pt.ManufactureUOMQty as ManufactureUOMQty,');
  Qrymain.SQL.add('PT.FromStockUOMQty as FromStockUOMQty,');
  Qrymain.SQL.add('PT.OnOrderUOMQty as OnOrderUOMQty,');
  Qrymain.SQL.add('convert(FormatSecondsTotime(PCT.Duration ), char(50)) as Duration');
  Qrymain.SQL.add('from tblSales S ');
  Qrymain.SQL.add('inner join tblSaleslines SL on S.saleId = SL.saleID');
  Qrymain.SQL.add('inner join tblprocTree PT on PT.masterId = SL.saleLineId and PT.mastertype <> "mtProduct"');
  Qrymain.SQL.add('inner join tblprocesspart PP on PT.ProctreeId = PP.ProcTreeId');
  Qrymain.SQL.add('inner join  tblprocesstime PCT on PCT.ProcessPartId = PP.ID');
  Qrymain.SQL.add('inner join tblprocresourcedetails PRD on PRD.ID = PCT.ResourcedetailsID');
  Qrymain.SQL.add('inner join tblprocresource PR on PRD.ProcResourceId = PR.ProcResourceId');
  Qrymain.SQL.add('inner join tblemployees E on E.EmployeeID = PCT.EmployeeId');
  Qrymain.SQL.add('where ((PCT.TimeStart between :DateFrom and :DateTo) ');
  Qrymain.SQL.add('Or (PCT.TimeEnd between :DateFrom and :DateTo)');
  Qrymain.SQL.add('Or (PCT.TimeStart <= :DateFrom and PCT.TimeEnd >= :DateTo))');
  Qrymain.SQL.add('Order by ');
       if grpfilters.ItemIndex =0 then Qrymain.SQL.add('EmployeeName,')
  else if grpfilters.ItemIndex =1 then Qrymain.SQL.add('TimeStart,')
  else if grpfilters.ItemIndex =2 then Qrymain.SQL.add('ResourceName,ResourceDetailName,')
  else if grpfilters.ItemIndex =3 then Qrymain.SQL.add('SaleID,');
  Qrymain.SQL.add('SchdDate, SaleId, SaleLineId , Sequencedown  , PP.ProcessStepSeq;');
  clog(qrymain.SQLText);
end;

procedure TWorkOrdersGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMainShipDate.displayFormat := FormatSettings.Shortdateformat;
end;

procedure TWorkOrdersGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
  clog(qrymain.SQLtext);
end;

procedure TWorkOrdersGUI.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid(qryMainProcessTimeId.FieldName);
    RemoveFieldfromGrid(qryMainPPid.FieldName);
    RemoveFieldfromGrid(qryMainProctreeId.FieldName);
    RemoveFieldfromGrid(qryMainsaleLineId.FieldName);
end;

end.
