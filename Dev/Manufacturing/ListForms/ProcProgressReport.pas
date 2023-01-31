unit ProcProgressReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  DBCtrls , BaseListExpress, DNMAction, CheckComboBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TProcProgressReportGUI = class(TBaseListExpressGUI)
    qryMainID: TIntegerField;
    qryMainPartname: TWideStringField;
    qryMainsaleID: TIntegerField;
    qryMainSaleLineId: TIntegerField;
    qryMainParentId: TIntegerField;
    qryMainSequencedown: TIntegerField;
    qryMainProcTreeID: TIntegerField;
    qryMainproductId: TIntegerField;
    qryMainUnitOfMeasure: TWideStringField;
    qryMainbatch: TWideStringField;
    qryMainQuantity: TFloatField;
    qryMaintotalQty: TFloatField;
    qryMainManufactureUOMQty: TFloatField;
    qryMainManufactureduomQty: TFloatField;
    qryMaintobeManufacturinguomQty: TFloatField;
    qryMainManufacturingUOMQty: TFloatField;
    qryMainProcTreePartId: TIntegerField;
    qryMaintobeManufactureduomQty: TFloatField;
    qryMainPQAValue: TWideStringField;
    qryMainPQAType: TWideStringField;
    qryMainqty_1: TFloatField;
    qryMainqty_2: TFloatField;
    qryMainqty_3: TFloatField;
    qryMainqty_4: TFloatField;
    qryMainBuildStatus: TWideStringField;
    qryMainEmployeename: TWideStringField;
    Label2: TLabel;
    edtSaleID: TEdit;
    qryMainSerialNumber: TStringField;
    DNMPanel1: TDNMPanel;
    chkshowId: TwwCheckBox;
    actPrintSerialnumber: TDNMAction;
    btnprintbarcode: TDNMSpeedButton;
    lblEmployee: TLabel;
    cboProcess: TCheckComboBox;
    chkfilterlist: TwwCheckBox;
    qryMainProcessStep: TWideStringField;
    qryMainseqno: TIntegerField;
    qryMainProcessStepid: TIntegerField;

    qryMainProcessStepofEmp: TWideStringField;
    Label4: TLabel;
    qryMainbBuildStatus: TWideStringField;
    qryMainPPGID: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);override;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure chkshowIdClick(Sender: TObject);
    procedure actPrintSerialnumberUpdate(Sender: TObject);
    procedure actPrintSerialnumberExecute(Sender: TObject);
    procedure chkfilterlistClick(Sender: TObject);
    procedure cboProcessClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    Tablename :String;
    fiSaleLineId: Integer;
    fiEmployeeId: Integer;
    fiProcessEmployeeId: Integer;
    procedure MakeQrymain;
    procedure AftershowPArtsForm(Sender: TObject);
    procedure SetEmployeeId(const Value: Integer);
    function getSelectedProcesssteps: String;
    procedure SetSelectedProcesssteps(const Value: String);
  Protected
    procedure SetGridColumns; Override;
    Function ExpressDetailListName:String;Override;
    Procedure CopyParamsto(Sender:TObject);Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    function GetReportTypeID: integer; Override;
    procedure MakeTemplateSQL;Override;
    Function ShowCurrentUserOnly:Boolean;virtual;
  public
    Property SaleLineId :Integer read fiSaleLineId write fiSaleLineId;
    Procedure RefreshQuery; Override;
    Property EmployeeId :Integer read fiEmployeeId write SetEmployeeId;
    Property ProcessEmployeeId:Integer read fiProcessEmployeeId write fiProcessEmployeeId;
    Property SelectedProcesssteps:String read getSelectedProcesssteps write SetSelectedProcesssteps;
    Procedure Printreport;
  end;


implementation

uses CommonDbLib, DbSharedObjectsObj, CommonLib, LogLib, tcConst,
  busobjProcProgress, frmProcProgress, Barcodeconst, CommonFormLib,
  ProcProgressAllocationReport, frmPartsFrm, tcDataUtils, TemplateReportsLib,
  AppEnvironment ;

{$R *.dfm}
procedure TProcProgressReportGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  try
      //if chkfilterlist.checked = false then
        if (Trim(QrymainProcessStep.asString) <> '') and (qrymainseqno.asInteger = 1) then
          if cboProcess.checked[cboprocess.items.indexof(Trim(QrymainProcessStep.asString))] then
            ABrush.color := GridColHighLightDarkGreen;
  except
    // kill the exception
  end;

       if (Field is tfloatfield)    and (field.asfloat   = 0) then Afont.color := abrush.color
  else if (Field is TIntegerfield)  and (field.asInteger = 0) then Afont.color := abrush.color
  else if (qryMainParentId.asInteger =0) and (sametext(field.fieldname , QrymainQuantity.fieldname) or
                                              sametext(field.fieldname , QrymaintobeManufacturinguomQty.fieldname) or
                                             sametext(field.fieldname , QrymaintotalQty.fieldname)) then Afont.color := abrush.color;
  if sametext(qrymainprocessstep.fieldname, field.fieldname) then
    if qrymainseqno.asInteger <> 1 then Afont.color := aBrush.color;


  if not(ShowCurrentUserOnly) then
    if sametext(qrymainPArtname.fieldname, field.fieldname) and (qryMainseqno.asInteger =0) then
      Afont.color := aBrush.color;

end;

procedure TProcProgressReportGUI.grdMainDblClick(Sender: TObject);
begin
  if Assigned(Owner) and (Owner is TfmProcProgress) then begin
    if (SameText(ActiveFieldname , qryMainPQAValue.fieldname) or SameText(ActiveFieldname , qryMainSerialnumber.fieldname)) and
      (sametext(qryMainPQAType.asString ,'Serial Number')) and (trim(qryMainPQAValue.asString) <> '') then begin
      TfmProcProgress(Owner).BarCode  := Barcode_Prefix_PQASN +'-' + inttostr(qryMainproductId.asInteger) +'-' + trim(qryMainPQAValue.asString);
      Exit;
    end else if (SameText(ActiveFieldname , qryMainPartname.fieldname)) then begin
      OpenERPForm('TfrmParts', qrymainproductid.asInteger,AftershowPArtsForm);
      Exit;
    end;
  end;
  inherited;

end;
procedure TProcProgressReportGUI.grdMainKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
var
  fsFieldname :String;
  fsfieldValue :String;
begin
  inherited;
  if Shift = [ssCtrl] then begin
      fsFieldname := activefieldname;
      if (Key = VK_down) or (Key = vk_up ) then begin
        if (Key = VK_down) and Qrymain.eof then exit;
        if (Key = VK_up)   and Qrymain.bof then exit;

        if sametext(fsFieldname , qrymainpartname.fieldname) or sametext(fsFieldname , qrymainBuildStatus.fieldname)  then begin
          fsfieldvalue :=Qrymain.fieldbyname(fsFieldname).asString;
          While sametext(fsfieldvalue , Qrymain.fieldbyname(fsFieldname).asString) and (Qrymain.eof = false) and (Qrymain.bof = false) do if (Key = VK_down) then qrymain.next else qrymain.Prior;
        end else if sametext(fsFieldname , qrymainqty_2.fieldname) or sametext(fsFieldname , qrymainQty_4.fieldname) then begin
          While (Qrymain.fieldbyname(fsFieldname).asFloat>0) and (Qrymain.eof = false) and (Qrymain.bof = false) do if (Key = VK_down) then qrymain.next else qrymain.Prior;
        end;

      end;
  end;
end;

procedure TProcProgressReportGUI.actPrintSerialnumberExecute(Sender: TObject);
var
  strSQL:String;
begin
  inherited;
  strSQL:= companyInfoSQL+'~|||~'+
          '{SN}Select ' +quotedstr(Qrymainpqavalue.AsString)+' as serialnumber , ' +
          quotedstr(QrymainSerialNumber.AsString)+' as ERPserialnumber , ' +
          quotedstr(getProduct(qrymainProductId.asInteger))+' as Productname  ,'+
          quotedstr(qrymainUnitOfMeasure.asString)+' as UOM , '+
          Floattostr(Qrymainqty_3.asFloat) + ' as SchdtoBuild,'+
          Floattostr(Qrymainqty_4.asFloat) + ' as BuiltintoStock,'+
          Floattostr(Qrymainqty_1.asFloat) + ' as SchdtoUse,'+
          Floattostr(Qrymainqty_2.asFloat) + ' as Used';
          clog(strsql);

  ReportSQLSupplied := True;
  PrintTemplateReport('SerialNumber Barcode', strSQL, not(devmode) , 1 , nil );
end;

procedure TProcProgressReportGUI.actPrintSerialnumberUpdate(Sender: TObject);
begin
  inherited;
  actPrintSerialnumber.enabled := sametext(trim(qrymainPQAType.AsString ), 'Serial Number') and (Trim(qrymainpqavalue.AsString)<> '') and (qrymainproductID.AsInteger<> 0);
end;

Procedure TProcProgressReportGUI.AftershowPArtsForm(Sender: TObject);
begin
  if not(Sender is TfrmParts) then exit;
  try
    TfrmParts(Sender).Pagecontrol.activepage := TfrmParts(Sender).TabSerial;
    TfrmParts(Sender).OnTabSerial(TfrmParts(Sender).Pagecontrol);
    if not TfrmParts(Sender).qryProductClass.active then TfrmParts(Sender).qryProductClass.open;
    if TfrmParts(Sender).qryProductClass.locate('classId' , GetClassIDforSale(QrymainsaleId.asInteger), []) then begin
      if not TfrmParts(Sender).QrySerialno.active then TfrmParts(Sender).QrySerialno.open;
      TfrmParts(Sender).grpFilters.itemindex :=0;
      TfrmParts(Sender).QrySerialno.first;
    end;
  except

  end;
end;
Procedure TProcProgressReportGUI.MakeQrymain;
var
  ctr:Integer;
begin
  closedb(qrymain);
  qrymain.SQl.clear;
  qrymain.SQl.add('Select ');
  qrymain.SQl.add('T.ID                           as ID,');
  qrymain.SQl.add('T.Seqno                        as Seqno,');
  qrymain.SQl.add('T.saleID                       as SaleID, ');
  qrymain.SQl.add('T.salelineID                   as salelineID, ');
  qrymain.SQl.add('convert(T.Partname, char(255)) as Partname,');
  qrymain.SQl.add('T.ParentId                     as ParentId, ');
  qrymain.SQl.add('T.Sequencedown                 as Sequencedown, ');
  qrymain.SQl.add('T.ProcTreeID                   as ProcTreeID,');
  qrymain.SQl.add('T.productId                    as productId, ');
  qrymain.SQl.add('T.UnitOfMeasure                as UnitOfMeasure, ');
  qrymain.SQl.add('T.batch                        as batch, ');
  qrymain.SQl.add('T.Quantity                     as Quantity, ');
  qrymain.SQl.add('T.totalQty                     as totalQty, ');
  qrymain.SQl.add('T.ManufactureUOMQty            as ManufactureUOMQty, ');
  qrymain.SQl.add('T.ManufactureduomQty           as ManufactureduomQty, ');
  qrymain.SQl.add('T.ProcessStep                  as ProcessStep, ');
  qrymain.SQl.add('T.ProcessStepid                as ProcessStepID, ');
  qrymain.SQl.add('T.ProcessStepofEmp             as ProcessStepofEmp, ');
  qrymain.SQl.add('T.tobeManufacturinguomQty      as tobeManufacturinguomQty, ');
  qrymain.SQl.add('T.ManufacturingUOMQty          as ManufacturingUOMQty,  ');
  qrymain.SQl.add('T.ProcTreePartId               as ProcTreePartId, ');
  qrymain.SQl.add('T.tobeManufactureduomQty       as tobeManufactureduomQty, ');
  qrymain.SQl.add('T.PPGID                        as PPGID, ');
  qrymain.SQl.add('ProcessEmployeeId              as ProcessEmployeeId, ');
  for ctr:= 1 to 4 do qrymain.SQl.add('qty_'    + trim(inttostr(ctr))+' as qty_'+ trim(inttostr(ctr))+',');
  qrymain.SQl.add('if(Buildstatus ="H", "On Hold",if(Buildstatus ="B", "In Progress",if(Buildstatus ="W", "Wastage",if(Buildstatus ="D", "Done",Buildstatus))))  as BuildStatus, ');
  qrymain.SQl.add('Buildstatus  as bBuildStatus, ');
  qrymain.SQl.add('EmployeeName                   as EmployeeName,');
  qrymain.SQl.add('if(PQAType ="Batch", "Batch",if(PQAType ="SN", "Serial Number",if(PQAType ="Bin", "Bin Location",PQAType)))                   as PQAType, ');
  qrymain.SQl.add('PQAValue                       as PQAValue ');
  qrymain.SQl.add('from ' +tablename +' T ');
  qrymain.SQl.add(' Order by SequenceDown , ID');
  clog(qrymain.SQL.Text);
end;
procedure TProcProgressReportGUI.MakeTemplateSQL;
begin
  inherited;
  ReportSQLSupplied := True;
  TemplateSQL := companyInfoSQL+'~|||~'+ '{Details}'+Qrymain.sql.text;
end;

procedure TProcProgressReportGUI.Printreport;
begin
  chkAdvancedPrinting.Checked := true;
  cmdPrint.Click;
end;

procedure TProcProgressReportGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainSerialNumber.asString := '';
  if sametext(Qrymainpqatype.asString , 'Serial Number') and (qryMainPQAValue.asString <> '') then
    //if (Qrymainqty_4.asfloat >0) and (Qrymainqty_2.asfloat =0) and (QrymainparentID.asInteger <>0) then
      qryMainSerialNumber.asString := Barcode_Prefix_PQASN +'-' + inttostr(qryMainproductId.asInteger) +'-' + trim(qryMainPQAValue.asString);
  if sametext(Qrymainpqatype.asString , 'Batch') and (qryMainPQAValue.asString <> '') then
    qryMainSerialNumber.asString := Barcode_Prefix_PQABATCH +'-' + inttostr(qryMainproductId.asInteger) +'-' + trim(qryMainPQAValue.asString);
end;

procedure TProcProgressReportGUI.cboProcessClick(Sender: TObject);
begin
  inherited;
  chkfilterlistClick(chkfilterlist);
end;

procedure TProcProgressReportGUI.chkshowIdClick(Sender: TObject);
begin
  inherited;
  if chkshowId.checked then
        AddfieldtoGrid(QrymainproductId.fieldname , 0)
  else RemoveFieldfromGrid(QrymainproductId.fieldname);
end;

procedure TProcProgressReportGUI.CopyParamsto(Sender: TObject);
begin
  inherited;
  if (sender is TProcProgressAllocationReportGUI) then begin
    TProcProgressAllocationReportGUI(Sender).SaleLineID := SaleLineID;
    TProcProgressAllocationReportGUI(Sender).Left := Self.left;
    TProcProgressAllocationReportGUI(Sender).top := Self.top;
  end;
end;

function TProcProgressReportGUI.ExpressDetailListName: String;
begin
  REsult := 'TProcProgressAllocationReportGUI';
end;

procedure TProcProgressReportGUI.FormCreate(Sender: TObject);
begin
  cboProcess.text := '';
  TableName := GetUserTemporaryTableName('ProcProgress');
  MakeQryMain;
  inherited;
  DisableSortoncolumtitleclick:= TRue;
  SearchMode:= smFullList;
  fiSaleLineId :=0;
  HaveDateRangeSelection := False;
  ClientWidth := 1200;
  EmployeeId := Appenv.Employee.EmployeeID;
  fiProcessEmployeeId := 0;
end;


procedure TProcProgressReportGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('Options.showId')     then chkshowId.checked      :=  GuiPrefs.Node['Options.showId'].AsBoolean;
  if GuiPrefs.Node.Exists('Options.filterlist') then chkfilterlist.checked  :=  GuiPrefs.Node['Options.filterlist'].AsBoolean;
end;

procedure TProcProgressReportGUI.RefreshQuery;
var
  Qry :TERPQuery;
  Mainqry:TERPQuery;
//  ctr:Integer;
  fiSaleID:Integer;
begin
DoShowProgressbar(10 , WAITMSG);
try
  With ScriptMain do begin

    SQL.clear;
    SQL.Add('/*1*/Drop table if exists '+ tablename +';');

    SQL.Add('/*2*/CREATE TABLE '+ tablename +' ( ' +
            ' ID                      INT(11) NOT NULL AUTO_INCREMENT, ' +
            ' Seqno                   INT(1) NULL Default 0 , ' +
            ' SaleId                  INT(11) Default 0 , ' +
            ' SaleLineId              INT(11) NULL Default 0 , ' +
            ' Partname                VARCHAR(255) DEFAULT NULL, ' +
            ' ParentId                INT(11) DEFAULT NULL, ' +
            ' Sequencedown            INT(11) Default 0 , ' +
            ' ProcTreeID              INT(11) Default 0 , ' +
            ' productId               INT(11) Default 0 , ' +
            ' UnitOfMeasure           VARCHAR(255) DEFAULT NULL, ' +
            ' batch                   ENUM("F","T") CHARACTER SET latin1 DEFAULT "F", ' +
            ' Quantity                DOUBLE NULL Default 0 , ' +
            ' totalQty                DOUBLE NULL Default 0 , ' +
            ' ManufactureUOMQty       DOUBLE DEFAULT NULL, ' +
            ' ManufactureduomQty      DOUBLE DEFAULT NULL, ' +
            ' tobeManufactureduomQty  DOUBLE DEFAULT NULL, ' +
            ' ManufacturingUOMQty     DOUBLE DEFAULT NULL, ' +
            ' ProcTreePartId          INT(11) Default 0 , ' +
            ' tobeManufacturinguomQty DOUBLE DEFAULT NULL, ' +
            ' PQAValue                VARCHAR(255) DEFAULT NULL, ' +
            ' PQAType                 VARCHAR(10) DEFAULT NULL, ' +
            ' BuildStatus             VARCHAR(1) DEFAULT NULL, ' +
            ' Employeename            VARCHAR(100) DEFAULT NULL, ' +
            ' ProcessStep             VARCHAR(100) DEFAULT NULL, ' +
            ' ProcessStepid           INT(11) DEFAULT NULL, ' +
            ' ProcessStepofEmp        ENUM("T","F") DEFAULT "F", ' +
            ' PPGEmployeeId           INT(11) DEFAULT NULL, ' +
            ' PPGID                   INT(11) DEFAULT NULL, ' +
            ' qty_1                   DOUBLE DEFAULT NULL, ' +
            ' qty_2                   DOUBLE DEFAULT NULL, ' +
            ' qty_3                   DOUBLE DEFAULT NULL, ' +
            ' qty_4                   DOUBLE DEFAULT NULL, ' +
            ' ProcessEmployeeId       INT(11) Default 0 , ' +
            ' PRIMARY KEY (ID), ' +
            ' KEY ProcTreePartId (ProcTreePartId), ' +
            ' KEY mult1 (ProcTreePartId,Sequencedown,PQAType,PQAValue), ' +
            ' KEY mult2 (BuildStatus,ProcTreePartId,Sequencedown,PQAType,PQAValue) ) ENGINE=MyIsam AUTO_INCREMENT=12301 DEFAULT CHARSET=utf8;');

//    SQL.Add('/*2*/Create table '+ tablename +' '+
    SQL.Add('/*2*/insert into  '+ tablename +' (Seqno , SaleId, SaleLineId ,Partname ,ParentId ,Sequencedown ,ProcTreeID ,productId ,UnitOfMeasure ,batch ,'+
                ' Quantity ,totalQty ,ManufactureUOMQty ,ManufactureduomQty ,tobeManufactureduomQty ,ManufacturingUOMQty ,ProcTreePartId ,tobeManufacturinguomQty ) '+
                ' select  1 as Seqno, SL.saleId as SaleId, SL.saleLineId as SaleLineId, ' +
                                                ' Convert(TreeNodeCaption(PT.Level, PT.caption ),char(255))  Partname , PT.ParentId, PT.Sequencedown, PTP.ProcTreeID , PTP.productId , PTP.UnitOfMeasure , P.batch , PT.Quantity, ' +
                                                ' PT.totalQty, ' +
                                                ' PTP.ManufactureUOMQty , ' +
                                                ' PTP.ManufactureduomQty , ' +
                                                ' PTP.ManufactureUOMQty - PT.ManufactureduomQty  tobeManufactureduomQty, ' +
                                                ' PTP.ManufacturingUOMQty ,  ' +
                                                ' PTP.ProcTreePartId  , '+
                                                ' (PT.TotalQty / PT.TreePartUOMMultiplier) - PT.ManufacturingUOMQty tobeManufacturinguomQty  ' +
                                                ' from tblsaleslines SL  ' +
                                                ' inner join tblproctree PT on PT.masterId = SL.saleLineId and PT.mastertype <> "mtProduct" ' +
                                                ' Left join tblProctreePart PTP on PT.ProcTreeID = PTP.ProcTreeID ' +
                                                ' Left join tblparts P on PTP.productId = P.partsId   ' +
                                                ' where Sl.salelineId =  ' + inttostr(SaleLineID)+
                                                ' Order by sequencedown ;');

    {Schd to Use }
    SQL.Add('/*16*/ drop table if exists ' + tablename +'1;' +NL+
                  ' create table ' + tablename +'1  '+
                                ' Select distinct 0 as seqno, ' +inttostr(fisaleId)+' as SAleID,T.ProductID,  T.ParentID, T.ProcTreePartId ,T.SequenceDown,  pqad.pqatype , pqad.value as PQAValue, pqad.qty  '+
                                ' from  '+ tablename +' T  '+
                                ' inner join tblpqa pqa on T.ProcTreePartId = PQa.TranslineId   and pqa.transtype = "TProcTreePart"  and pqa.Alloctype = "OUT" '+
                                ' inner join tblpqadetails pqad on pqa.pqaid = pqad.pqaid '+
                                ' Where T.Seqno = 1 ' +
                                ' order by ProcTreePartId;' +NL+
                                'ALTER TABLE  '+ tablename +'1  	add index mult1 (ProcTreePartId,SequenceDown,PQAType,PQAValue);'+NL+
                  ' insert ignore into ' + tablename +' ( SaleId, seqno,ProductID,ParentID,ProcTreePartId,SequenceDown,PQAValue,PQAType,qty_1) ' +
                                  ' Select  T2.SAleID, T2.seqno, T2.ProductID,T2.ParentID, T2.ProcTreePartId, T2.SequenceDown, T2.PQAValue, T2.PQAType, T2.qty '+
                                  ' From ' + tablename +'1 T2 Left join ' + tablename +' T1  on T1.ProcTreePartId = T2.ProcTreePartId and ' +
                                                                                              ' T1.SequenceDown   = T2.SequenceDown and ' +
                                                                                              ' T1.PQAType        = T2.PQAType and ' +
                                                                                              ' T1.PQAValue       = T2.PQAValue ' +
                                    ' where ifnull(t2.qty,0)<> 0 and ifnull(t1.ID,0) =0;' +NL+
                  ' Update ' + tablename +'1 T2 inner join ' + tablename +' T1  on T1.ProcTreePartId = T2.ProcTreePartId and ' +
                                                                                              ' T1.SequenceDown   = T2.SequenceDown and ' +
                                                                                              ' T1.PQAType        = T2.PQAType and ' +
                                                                                              ' T1.PQAValue       = T2.PQAValue ' +
                                    ' Set T1.qty_1 = t2.qty where ifnull(t2.qty,0)<> 0 ;');
        {OUT - using resource }
        SQL.Add('/*17*/ drop table if exists ' + tablename +'1;' +NL+
                  '  create table ' + tablename +'1  '+
                                ' Select distinct  0 as seqno, ' +inttostr(fisaleId)+' as SAleID,PP.EmployeeId , /*PPIn.EmployeeId ,  */T.ProductID,  T.ParentID,  T.ProcTreePartId ,T.SequenceDown,  pqad.pqatype , '+
                                ' pqad.value as PQAValue, sum(pqad.qty) qty, E.employeeName , PP.BuildStatus , PP.ProcProgressID as PPGID/*, PPIn.BuildStatus , PPIn.ProcProgressID as PPGID*/'+
                                ' from  '+ tablename +' T  '+
                                ' inner join tblprocprogress PP on T.ProcTreePartId = PP.ProcTreePartId and PP.alloctype ="OUT" '+
                                //' inner join tblprocprogress PPIn on PP.InProcProgressId = PPIn.ProcProgressID ' +
                                ' inner join tblemployees E on PP.employeeId = E.employeeId '+
                                ' inner join tblpqa pqa on PP.ProcProgressId = PQa.TranslineId   and pqa.transtype = ' +quotedstr(TProcProgressOUT.classname)+'  and PQA.alloctype ="OUT"' +
                                ' inner join tblpqadetails pqad on pqa.pqaid = pqad.pqaid /*and pqad.pqatype ="BATCH"  */'+
                                ' Where T.Seqno = 1 ' +
                                ' group by T.ProcTreePartId,  pqad.pqatype , pqad.value, PP.BuildStatus  /* , PPin.BuildStatus */order by ProcTreePartId;'  +NL+
                                'ALTER TABLE  '+ tablename +'1  	add index mult2 (Buildstatus,ProcTreePartId,SequenceDown,PQAType,PQAValue);'+NL+


                  ' insert ignore into ' + tablename +' ( SaleId, seqno,ProductID,ParentID,ProcTreePartId,SequenceDown,PQAValue,PQAType,qty_2, BuildStatus /*, PPGID, Employeename , PPGEmployeeId*/) ' +
                                  ' Select T2.SAleID, T2.seqno,T2.ProductID,T2.ParentID, T2.ProcTreePartId, T2.SequenceDown, T2.PQAValue, T2.PQAType, T2.qty, T2.BuildStatus /*,T2.PPGID, T2.Employeename, t2.EmployeeId*/'+
                                  ' From ' + tablename +'1 T2 Left join ' + tablename +' T1  on ' +
                                  '  T1.Buildstatus = T2.Buildstatus and ' +
                                    ' T1.ProcTreePartId = T2.ProcTreePartId and ' +
                                    ' T1.SequenceDown   = T2.SequenceDown and ' +
                                    ' T1.PQAType        = T2.PQAType and ' +
                                    ' T1.PQAValue       = T2.PQAValue ' +
                                    ' where ifnull(t2.qty,0)<> 0 and ifnull(t1.ID,0) =0;'+NL+
                  ' update ' + tablename +'1 T2 inner  join ' + tablename +' T1  on ' +
                                  '  T1.Buildstatus = T2.Buildstatus and ' +
                                    ' T1.ProcTreePartId = T2.ProcTreePartId and ' +
                                    ' T1.SequenceDown   = T2.SequenceDown and ' +
                                    ' T1.PQAType        = T2.PQAType and ' +
                                    ' T1.PQAValue       = T2.PQAValue ' +
                                    '  Set T1.qty_2 = t2.qty  where ifnull(t2.qty,0)<> 0 ;');

        {Schd to Build - raw material}
        SQL.Add('/*18*/ drop table if exists ' + tablename +'1;' +NL+
                  '  create table ' + tablename +'1  '+
                                ' Select distinct  0 as seqno, ' +inttostr(fisaleId)+' as SAleID,T.ProductID,  T.ParentID,  T.ProcTreePartId ,T.SequenceDown,  pqad.pqatype , pqad.value as PQAValue, pqad.qty from  '+ tablename +' T  '+
                                ' inner join tblpqa pqa on T.ProcTreePartId = PQa.TranslineId   and pqa.transtype = "TProcTreePart"  and pqa.Alloctype = "IN" '+
                                ' inner join tblpqadetails pqad on pqa.pqaid = pqad.pqaid '+
                                ' Where T.Seqno = 1 ' +
                                ' order by ProcTreePartId; '  +NL+
                                'ALTER TABLE  '+ tablename +'1  	add index mult1 (ProcTreePartId,SequenceDown,PQAType,PQAValue);'+NL+
                  ' insert ignore into ' + tablename +' ( SaleId, seqno,ProductID,ParentID,ProcTreePartId,SequenceDown,PQAValue,PQAType,qty_3) ' +
                                  ' Select T2.SAleID, T2.seqno, T2.ProductID,T2.ParentID, T2.ProcTreePartId, T2.SequenceDown, T2.PQAValue, T2.PQAType, T2.qty '+
                                  ' From ' + tablename +'1 T2 Left join ' + tablename +' T1  on ' +
                                    ' T1.ProcTreePartId = T2.ProcTreePartId and ' +
                                    ' T1.SequenceDown   = T2.SequenceDown and ' +
                                    ' T1.PQAType        = T2.PQAType and ' +
                                    ' T1.PQAValue       = T2.PQAValue ' +
                                    ' where ifnull(t2.qty,0)<> 0 and ifnull(t1.ID,0) =0;'+NL+
                  ' update ' + tablename +'1 T2 inner  join ' + tablename +' T1  on ' +
                                    ' T1.ProcTreePartId = T2.ProcTreePartId and ' +
                                    ' T1.SequenceDown   = T2.SequenceDown and ' +
                                    ' T1.PQAType        = T2.PQAType and ' +
                                    ' T1.PQAValue       = T2.PQAValue ' +
                                    ' set T1.Qty_3 = T2.qty where ifnull(t2.qty,0)<> 0 ;');

        {Built into Stock - sub / final product}
        SQL.Add('/*19*/ drop table if exists ' + tablename +'1;' +NL+
                  '  create table ' + tablename +'1  '+
                                ' Select distinct  0 as seqno, ' +inttostr(fisaleId)+' as SAleID,T.ProductID,  T.ParentID,  T.ProcTreePartId ,T.SequenceDown,  pqad.pqatype , '+
                                ' pqad.value as PQAValue, PP.EmployeeId ,  PP.BuildStatus, sum(pqad.qty) qty  , E.employeeName , PP.ProcProgressID  as PPGID   '+
                                ' from  '+ tablename +' T  '+
                                ' inner join tblprocprogress PP on T.ProcTreePartId = PP.ProcTreePartId and PP.alloctype ="IN" '+
                                ' inner join tblemployees E on PP.employeeId = E.employeeId '+
                                ' inner join tblpqa pqa on PP.ProcProgressId = PQa.TranslineId   and pqa.transtype = ' +quotedstr(TProcProgressIn.classname)+'  and PQA.alloctype ="IN"' +
                                ' inner join tblpqadetails pqad on pqa.pqaid = pqad.pqaid /*and pqad.pqatype ="BATCH" */ '+
                                ' Where T.Seqno = 1 ' +
                                ' group by T.ProcTreePartId,  pqad.pqatype , pqad.value , pp.BuildStatus order by ProcTreePartId;' +NL+

                                'ALTER TABLE  '+ tablename +'1  	add index mult2 (Buildstatus,ProcTreePartId,SequenceDown,PQAType,PQAValue);'+NL+

                  ' insert ignore into ' + tablename +' ( SaleId, seqno,ProductID,ParentID,ProcTreePartId,SequenceDown,PQAValue,PQAType,qty_4, PPGID, BuildStatus , Employeename , PPGEmployeeId) ' +
                                  ' Select T2.SAleID, T2.seqno, T2.ProductID,T2.ParentID, T2.ProcTreePartId, T2.SequenceDown, T2.PQAValue, T2.PQAType, T2.qty, T2.PPGID, T2.BuildStatus ,T2.Employeename, t2.EmployeeId'+
                                  ' From ' + tablename +'1 T2 Left join ' + tablename +' T1  on ' +
                                  '  T1.Buildstatus = T2.Buildstatus and ' +
                                    ' T1.ProcTreePartId = T2.ProcTreePartId and ' +
                                    ' T1.SequenceDown   = T2.SequenceDown and ' +
                                    ' T1.PQAType        = T2.PQAType and ' +
                                    ' T1.PQAValue       = T2.PQAValue ' +
                                    ' where ifnull(t2.qty,0)<> 0 and ifnull(t1.ID,0) =0;'+NL+
                  ' update ' + tablename +'1 T2 Left join ' + tablename +' T1  on ' +
                                  '  T1.Buildstatus = T2.Buildstatus and ' +
                                    ' T1.ProcTreePartId = T2.ProcTreePartId and ' +
                                    ' T1.SequenceDown   = T2.SequenceDown and ' +
                                    ' T1.PQAType        = T2.PQAType and ' +
                                    ' T1.PQAValue       = T2.PQAValue ' +
                                    ' Set T1.Qty_4 = t2.qty,T1.PPGID =T2.PPGID,  T1.PPGEmployeeId = t2.EmployeeId where ifnull(t2.qty,0)<> 0 ;');

        SQL.Add('/*20*/ drop table if exists ' + tablename +'1;' );
        //SQL.Add('/*21*/ALTER TABLE  '+ tablename +'  	ADD COLUMN ProcessEmployeeId INT(11) NULL DEFAULT 0;');
        //SQL.Add('/*22*/Update '+ tablename +'  T inner join tblprocprogress PPg on T.PPGId = PPg.ProcProgressID	Set ProcessEmployeeId = PPg.employeeId where ifnull(T.PPGID,0)<>0;');
        SQL.Add('/*22*/Update '+ tablename +'  T  Set ProcessEmployeeId = PPGEmployeeId;');
        SQL.Add('/*23*/Update '+ tablename +'  T inner join tblparts P on T.ProductId = P.partsId 	Set T.Partname  = P.partname where T.partname is null or T.partname ="";');

        SQL.Add('/*24*/update  '+ tablename +'  T inner join tblprocprogress PPg on T.ppgId = PPg.ProcProgressID '+
                ' inner join tblemployees E on PPg.EmployeeId = E.EmployeeID '+
                ' Set T.employeename = E.EmployeeName '+
                ' where ifnull(T.employeename ,"") ="" and ifnull(T.ppgId ,0)<> 0;');

    doStepProgressbar;
    clog(SQL.text);
    doStepProgressbar;
    Execute;
  end;

(*  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  Mainqry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    closedb(Mainqry);
    Mainqry.SQL.Text := 'Select * from ' + tablename;
    opendb(Mainqry);
    fiSaleID := Mainqry.fieldbyname('SaleID').asInteger;




    {TProcTreePart Qty}
    for ctr := 1 to 4 do begin
      doStepProgressbar;
        closedb(Qry);
        if ctr =1 then Qry.SQL.Text := 'Select distinct T.ProductID,  T.ParentID, T.ProcTreePartId ,T.SequenceDown,  pqad.pqatype , pqad.value as PQAValue, pqad.qty  '+
                                ' from  '+ tablename +' T  '+
                                ' inner join tblpqa pqa on T.ProcTreePartId = PQa.TranslineId   and pqa.transtype = "TProcTreePart"  and pqa.Alloctype = "OUT" '+
                                ' inner join tblpqadetails pqad on pqa.pqaid = pqad.pqaid '+
                                ' Where T.Seqno = 1 ' +
                                ' order by ProcTreePartId'

        else if ctr =2 then Qry.SQL.Text := 'Select distinct PPIn.EmployeeId ,  T.ProductID,  T.ParentID,  T.ProcTreePartId ,T.SequenceDown,  pqad.pqatype , pqad.value as PQAValue, sum(pqad.qty) qty, E.employeeName , PPIn.BuildStatus , PPIn.ProcProgressID as PPGID'+
                                ' from  '+ tablename +' T  '+
                                ' inner join tblprocprogress PP on T.ProcTreePartId = PP.ProcTreePartId and PP.alloctype ="OUT" '+
                                ' inner join tblprocprogress PPIn on PP.InProcProgressId = PPIn.ProcProgressID ' +
                                ' inner join tblemployees E on PP.employeeId = E.employeeId '+
                                ' inner join tblpqa pqa on PP.ProcProgressId = PQa.TranslineId   and pqa.transtype = ' +quotedstr(TProcProgressOUT.classname)+'  and PQA.alloctype ="OUT"' +
                                ' inner join tblpqadetails pqad on pqa.pqaid = pqad.pqaid /*and pqad.pqatype ="BATCH"  */'+
                                ' Where T.Seqno = 1 ' +
                                ' group by T.ProcTreePartId,  pqad.pqatype , pqad.value  , PPin.BuildStatus order by ProcTreePartId'

        else if ctr =3 then Qry.SQL.Text := 'Select distinct T.ProductID,  T.ParentID,  T.ProcTreePartId ,T.SequenceDown,  pqad.pqatype , pqad.value as PQAValue, pqad.qty from  '+ tablename +' T  '+
                                ' inner join tblpqa pqa on T.ProcTreePartId = PQa.TranslineId   and pqa.transtype = "TProcTreePart"  and pqa.Alloctype = "IN" '+
                                ' inner join tblpqadetails pqad on pqa.pqaid = pqad.pqaid /*and pqad.pqatype ="BATCH"  */'+
                                ' Where T.Seqno = 1 ' +
                                ' order by ProcTreePartId'

        else if ctr =4 then Qry.SQL.Text := 'Select distinct T.ProductID,  T.ParentID,  T.ProcTreePartId ,T.SequenceDown,  pqad.pqatype , pqad.value as PQAValue, PP.EmployeeId ,  PP.BuildStatus, sum(pqad.qty) qty  , E.employeeName /*, PP.ProcProgressID  as PPGID */ from  '+ tablename +' T  '+
                                ' inner join tblprocprogress PP on T.ProcTreePartId = PP.ProcTreePartId and PP.alloctype ="IN" '+
                                ' inner join tblemployees E on PP.employeeId = E.employeeId '+
                                ' inner join tblpqa pqa on PP.ProcProgressId = PQa.TranslineId   and pqa.transtype = ' +quotedstr(TProcProgressIn.classname)+'  and PQA.alloctype ="IN"' +
                                ' inner join tblpqadetails pqad on pqa.pqaid = pqad.pqaid /*and pqad.pqatype ="BATCH" */ '+
                                ' Where T.Seqno = 1 ' +
                                ' group by T.ProcTreePartId,  pqad.pqatype , pqad.value , pp.BuildStatus order by ProcTreePartId';


        logtext(Qry.SQL.Text);
        opendb(Qry);
        if Qry.RecordCount >0 then begin
          Qry.First;
          while Qry.Eof = false do begin
            if  Qry.FieldByName('qty').asfloat <> 0 then begin
                if ((Qry.Findfield('BuildStatus') <> nil) and
                  (Mainqry.Locate('ProcTreePartId;SequenceDown;PQAType;PQAValue;BuildStatus' , vararrayof([Qry.FieldByName('ProcTreePartId').AsInteger , Qry.FieldByName('SequenceDown').AsInteger ,Qry.FieldByName('PQAType').asString,Qry.FieldByName('PQAValue').asString , Qry.FieldByName('BuildStatus').asString]), []) = false)) Or
                  ((Qry.Findfield('BuildStatus') = nil) and
                  (Mainqry.Locate('ProcTreePartId;SequenceDown;PQAType;PQAValue' , vararrayof([Qry.FieldByName('ProcTreePartId').AsInteger , Qry.FieldByName('SequenceDown').AsInteger ,Qry.FieldByName('PQAType').asString,Qry.FieldByName('PQAValue').asString]), []) = false )) then begin
                  Mainqry.append;
                  Mainqry.fieldbyname('SaleID').asInteger := fisaleId;
                  Mainqry.fieldbyname('seqno').asInteger := 0;
                  Mainqry.fieldbyname('ProductID').AsInteger :=Qry.FieldByName('ProductID').AsInteger ;
                  //Mainqry.fieldbyname('Partname').asString :=Qry.FieldByName('Partname').asSTring ;
                  Mainqry.fieldbyname('ParentID').AsInteger :=Qry.FieldByName('ParentID').AsInteger ;
                  Mainqry.fieldbyname('ProcTreePartId').AsInteger :=Qry.FieldByName('ProcTreePartId').AsInteger ;
                  Mainqry.fieldbyname('SequenceDown').AsInteger :=Qry.FieldByName('SequenceDown').AsInteger ;
                  Mainqry.fieldbyname('PQAValue').asSTring :=Qry.FieldByName('PQAValue').asString;
                  Mainqry.fieldbyname('PQAType').asSTring :=Qry.FieldByName('PQAType').asString;

                  if Qry.Findfield('PPGID') <> nil then
                    Mainqry.fieldbyname('PPGID').asInteger :=Qry.FieldByName('PPGID').asInteger;

                  if Qry.Findfield('BuildStatus') <> nil then
                    Mainqry.fieldbyname('BuildStatus').asSTring :=Qry.FieldByName('BuildStatus').asString;
                  if Qry.Findfield('Employeename') <> nil then
                    Mainqry.fieldbyname('Employeename').asSTring :=Qry.FieldByName('Employeename').asString;
                  if Qry.findfield('employeeId') <> nil then
                    Mainqry.fieldbyname('PPGEmployeeId').asInteger := Qry.Fieldbyname('employeeId').asInteger;
                end;
                EditDb(Mainqry);
                Mainqry.fieldbyname('qty_'+ trim(inttostr(ctr))).asfloat      := Qry.FieldByName('qty').asfloat;
                PostDb(Mainqry);
            end;
            doStepProgressbar(inttostr(Qry.recno)+' of ' + inttostr(Qry.recordcount));
            Qry.Next;
          end;
        end;
    end;
    With scriptmain do begin
      SQL.clear;
      SQL.Add('/*13*/update '+ tablename +'  	T  '+
              ' inner join tblproctreePart PTP on PTP.proctreepartId = T.proctreePartId '+
              ' inner join tblproctree PT on PT.proctreeId = PTP.proctreeId  '+
              ' inner join tblprocesspart PP on PT.proctreeId = PP.proctreeId   '+
              ' inner join tblprocessstep Ps on Ps.Id = PP.ProcessStepID  '+
              ' Set T.ProcessStepofEmp = "F", T.ProcessStep = PS.Description , T.ProcessStepid = PS.ID ;');
      if fiEmployeeId <> 0 then begin
          SQL.Add('/*14*/update '+ tablename +'  	T  '+
                  ' inner join tblemployeeprocesssteps EPS on T.ProcessStepid = EPS.ProcessStepID and EPS.EmployeeId = ' + inttostr(fiEmployeeId)+' Set ProcessStepofEmp ="T";');
      end;
      //if ProcessEmployeeId <> 0 then begin
         SQL.Add('/*14*/ALTER TABLE  '+ tablename +'  	ADD COLUMN ProcessEmployeeId INT(11) NOT NULL DEFAULT 0;');
         SQL.Add('/*15*/Update '+ tablename +'  T inner join tblprocprogress PPg on T.PPGId = PPg.ProcProgressID	Set ProcessEmployeeId = PPg.employeeId where ifnull(T.PPGID,0)<>0;');
         SQL.Add('/*15*/Update '+ tablename +'  T inner join tblparts P on T.ProductId = P.partsId 	Set T.Partname  = P.partname where T.partname is null or T.partname ="";');
      //end;
      dostepprogressbar;
      logtext(SQL.text);
      Execute;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;*)
  inherited;
finally
  DohideProgressbar;
end;

end;
procedure TProcProgressReportGUI.SetEmployeeId(const Value: Integer);
begin
  fiEmployeeId := Value;
  lblEmployee.Caption :=GetEmployeeName(Value);
end;

procedure TProcProgressReportGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainParentId.fieldname);
  RemoveFieldfromGrid(QrymainSequencedown.fieldname);
  RemoveFieldfromGrid(QrymainProcTreeID.fieldname);
  RemoveFieldfromGrid(QrymainSaleLineId.fieldname);
  RemoveFieldfromGrid(QrymainId.fieldname);
  RemoveFieldfromGrid(QrymainProctreePArtID.fieldname);
  RemoveFieldfromGrid(qryMainseqno.fieldname);
  RemoveFieldfromGrid(qryMainProcessStepid.fieldname);
  RemoveFieldfromGrid(qryMainProcessStepofEmp.fieldname);
  RemoveFieldfromGrid(qryMainbBuildStatus.fieldname);
  RemoveFieldfromGrid(qryMainPPGID.fieldname);
end;

procedure TProcProgressReportGUI.WriteGuiPrefExtra;
begin
  Sizemode := 'N';
  inherited;
  GuiPrefs.Node['Options.showId'].AsBoolean := chkshowId.checked ;
  GuiPrefs.Node['Options.filterlist'].AsBoolean := chkfilterlist.checked ;
  GuiPrefs.Node['Options.SelectedProcesssteps'+trim(inttostr(employeeId))].asString := SelectedProcesssteps;
end;
procedure TProcProgressReportGUI.chkfilterlistClick(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  if chkfilterlist.checked = false then GroupfilterString := ''
  else begin
    GroupfilterString :=  ' ProcessStepId = 0';
    for ctr:= 0 to cboProcess.Items.Count -1 do begin
      if cboProcess.Checked[ctr] then begin
        if GroupfilterString <> '' then GroupfilterString := GroupfilterString +' OR ';
        GroupfilterString := GroupfilterString + ' ProcessStepId = ' + inttostr(ProcessStepId (cboProcess.items[ctr]));
      end;
    end;
  end;
  inherited grpFiltersclick(nil);
end;

procedure TProcProgressReportGUI.qryMainAfterOpen(DataSet: TDataSet);
var
  qry :TERPQuery;
  fs:String;
begin
  inherited;
  edtSaleID.text := inttostr(qryMainsaleID.asInteger);
  qryMainsaleID.Alignment := taLeftJustify;
  fs:= SelectedProcesssteps;
  try
      cboProcess.Items.Clear;
      qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
      try
        cboProcess.itemindex  := -1;
        Qry.SQL.Text := 'Select distinct ProcessStep , ProcessStepofEmp from  '+ tablename +' where ifnull(ProcessStep , "")<> "" Order by ProcessStep ;';
        Qry.open;
        if Qry.recordcount =0 then exit;
        Qry.first;
        While Qry.Eof = False do begin
          cboProcess.Items.add(Qry.fieldbyname('ProcessStep').AsString);
          cboProcess.Checked[cboProcess.Items.count-1]:=Qry.fieldbyname('ProcessStepofEmp').asBoolean;
          if Qry.fieldbyname('ProcessStepofEmp').asBoolean then if cboProcess.itemindex = -1 then cboProcess.itemindex :=cboProcess.Items.count-1;
          Qry.Next;
        end;
        chkfilterlistClick(chkfilterlist);
      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
      end;
  finally
    SelectedProcesssteps := fs;
  end;
end;
function TProcProgressReportGUI.getSelectedProcesssteps: String;
var
  ctr:Integer;
begin
  Result := '';
  for ctr := 0 to cboProcess.Items.count-1 do
    if cboProcess.checked[ctr] then begin
      if result <> '' then result := result +',';
      result := result + inttostr(getProcessStep(cboProcess.Items[ctr]));
    end;

end;
procedure TProcProgressReportGUI.SetSelectedProcesssteps(const Value: String);
var
  ctr:Integer;
  st:TStringlist;
  fs:String;
  fi:Integer;
begin
  if value = '' then exit;
  for ctr := 0 to cboProcess.items.count-1 do    cboProcess.checked[ctr]:= False;

  st:= tstringlist.create;
  try
    st.commatext := Value;
    for ctr := 0 to st.Count-1 do begin
      fs:= getProcessStep(strtoint(st[ctr]));
      if fs<> '' then begin
        fi := cboProcess.items.IndexOf(fs) ;
        if fi >=0 then cboProcess.checked[fi]:= True;
      end;
    end;
  finally
    freeandnil(st);
  end;

  chkfilterlistClick(nil);
end;
function TProcProgressReportGUI.ShowCurrentUserOnly: Boolean;
begin
  REsult := False;
end;

procedure TProcProgressReportGUI.FormShow(Sender: TObject);
begin
  inherited;
  //set this pref after refresh when the form is opened
  if GuiPrefs.Node.Exists('Options.SelectedProcesssteps'+trim(inttostr(employeeId))) then SelectedProcesssteps :=  GuiPrefs.Node['Options.SelectedProcesssteps'+trim(inttostr(employeeId))].asString;
end;

function TProcProgressReportGUI.GetReportTypeID: integer;
begin
  Result :=  TemplateTypeID('Process Progress Report');
end;

initialization
  RegisterClassOnce(TProcProgressReportGUI);

end.
