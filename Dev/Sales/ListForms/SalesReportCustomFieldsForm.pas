unit SalesReportCustomFieldsForm;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 07/06/05  1.00.01 IJB  Changed anchors of chkBasedOnShipped and its label for
                        correct positioning when form maximised.
 18/07/05  1.00.02 BJ   Warranty ends on and Warranty period fields are added to
                        this report. The caption of the field is changed based
                        on the preference.
}
interface
{$I ERP.inc}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  Mask, wwdbedit, DBCtrls, wwDialog, Wwlocate,
  SelectionDialog, DNMPanel, Math, MemDS, DBAccess, MyAccess,ERPdbComponents, wwdblook,
  wwcheckbox, wwdbdatetimepicker,  Shader,
  kbmMemTable, ProgressDialog, DAScript, MyScript;

type
  TSalesReportCustomFieldsGUI = class(TBaseListingGUI)
    Panel4: TPanel;
    lblClassTitle: TLabel;
    Label4: TLabel;
    chkAllClass: TwwCheckBox;
    cboClass: TwwDBLookupCombo;
    cboClassQry: TERPQuery;
    chkBaseOnShipped: TCheckBox;
    Label46: TLabel;
    btnProductList: TDNMSpeedButton;

    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormShow(Sender: TObject);
    procedure chkAllClassClick(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure FormCreate(Sender: TObject);
    procedure chkBaseOnShippedClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MyScriptError(Sender: TObject; E: Exception; SQL: String; var Action: TErrorAction);
    procedure btnProductListClick(Sender: TObject);
  private
    Procedure initform(Sender:TObject);
    procedure MakeQry;
  protected
    fsTablename :String;

    procedure onBeforeExecute(Sender: TObject; var SQL: string;      var Omit: Boolean);
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    Procedure SetQrymainSQL;Virtual;

    procedure MakeQrySQL(SQLList:TStringList);virtual;
    function salesreportcustomfieldname:String ; virtual;
    //Procedure initFCFields; override;
  public
    { Public declarations }
  end;

implementation

uses
    SalesReportForm, tcConst, CommonLib, AppEnvironment, CommonFormLib,
  CommonDbLib;

{$R *.dfm}

procedure TSalesReportCustomFieldsGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:GroupFilterString := 'Deleted <> ' + QuotedStr('T');
    1:GroupFilterString := 'Deleted = ' + QuotedStr('T');
  end;
  inherited;
end;

procedure TSalesReportCustomFieldsGUI.RefreshQuery;
begin
    MakeQry;
      doshowProgressbar(3, WAITMSG);
      DoStepProgressbar;
      try
        inherited;
        DoHideProgressbar;
      Except on E:Exception do begin
        DoHideProgressbar;
         {$IFDEF DevMode}
            CommonLib.MessageDlgXP_Vista(E.Message+chr(13) +chr(13) +'Report is too Big to Open. Please Change the Filter and Refresh', mtInformation,[mbok], 0);
         {$ELSE}
           CommonLib.MessageDlgXP_Vista('Report is too Big to Open. Please Change the Filter and Refresh', mtInformation,[mbok], 0);
         {$ENDIF}
      end;
    end;
    if Qrymain.findfield('Productname')<> nil then    Qrymain.FieldByName('ProductName').DisplayLabel     := AppEnv.DefaultClass.PartColumn;
    PopulateFilterCombo;
    cboFilter.ItemIndex := 0;
end;

procedure TSalesReportCustomFieldsGUI.FormShow(Sender: TObject);
begin
  grdMain.ShowHint := true;

  if not cboClassQry.Active then begin
    cboClassQry.Open;
    cboClassQry.Locate('ClassName', AppEnv.DefaultClass.DefaultClassName, [loCaseInsensitive]);
    cboClass.LookupValue := AppEnv.DefaultClass.DefaultClassName;
  end;
  inherited;


  grdMain.columnbyName('Product Name').DisplayLabel := AppEnv.DefaultClass.PartColumn;
end;

procedure TSalesReportCustomFieldsGUI.initform(Sender: TObject);
begin
  if not(Sender is TSalesReportGUI) then exit;
  TSalesReportGUI(Sender).Dtfrom.Date := Dtfrom.date;
  TSalesReportGUI(Sender).Dtto.Date := DtTo.Date;
  TSalesReportGUI(Sender).chkAllClass.checked := chkAllClass.checked;
  TSalesReportGUI(Sender).cboClass.Text:= cboClass.text;
  TSalesReportGUI(Sender).fbDateRangeSupplied:= True;
end;

procedure TSalesReportCustomFieldsGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;

  if chkAllClass.Checked then begin
    lblClassTitle.Enabled := false;
    cboClass.Enabled      := false;
  end else begin
    lblClassTitle.Enabled := true;
    cboClass.Enabled      := true;
  end;
  RefreshQuery;
end;


procedure TSalesReportCustomFieldsGUI.btnProductListClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TSalesReportGUI' , initform);
  self.close;
end;

procedure TSalesReportCustomFieldsGUI.cboClassCloseUp(Sender: TObject;
        LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;

procedure TSalesReportCustomFieldsGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := true;
  fsTablename := commondbLib.CreateUserTemporaryTable('tmp_salesreport' , salesreportcustomfieldname);
  SetQrymainSQL;
  inherited;
  ShowChartViewOnPopup := True;
  showFCFooters := true;
  cboClassQry.Connection := CommonDbLib.GetSharedMyDacConnection;
  AddCalccolumn('Shipped',False);
end;

procedure TSalesReportCustomFieldsGUI.chkBaseOnShippedClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TSalesReportCustomFieldsGUI.MakeQry;
var
  SQLList :TStringList;
begin
    OpenDb(cboClassQry);
    if not chkAllClass.Checked then  cboClassQry.Locate('ClassName' , cboClass.text , []);
    if Qrymain.active then Qrymain.close;
    SQLList :=TStringList.Create;
    Try
       MakeQrySQL(SQLList);
       DoshowProgressbar(8, WAITMSG);
       try
          ExecuteSQL(SQLList.text,nil, onBeforeExecute);
       finally
          DoHideProgressbar;
       end;
    finally
       Freeandnil(SQLList);
    end;
end;
procedure TSalesReportCustomFieldsGUI.MakeQrySQL(SQLList: TStringList);
begin

end;

procedure TSalesReportCustomFieldsGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(fstablename);
  inherited;
end;

procedure TSalesReportCustomFieldsGUI.MyScriptError(Sender: TObject; E: Exception; SQL: String; var Action: TErrorAction);
begin
  Action := eaContinue;
end;

procedure TSalesReportCustomFieldsGUI.onBeforeExecute(Sender: TObject; var SQL: string;
  var Omit: Boolean);
begin
  inherited;
  DoStepProgressbar;
end;


procedure TSalesReportCustomFieldsGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;
function TSalesReportCustomFieldsGUI.salesreportcustomfieldname: String;
begin
  result := Self.Classname;
end;

procedure TSalesReportCustomFieldsGUI.SetQrymainSQL;
begin
end;

(*Qrymain design time SQL for backup
=============================
Select
ID as ID ,
 SALELINEID as  SALELINEID ,
 SALEID as  SALEID ,
 PRODUCTID as  PRODUCTID ,
 EMPLOYEEID as  EMPLOYEEID ,
 CLIENTID as  CLIENTID ,
 CLASSID as  CLASSID ,

 SALEDATE as  SALEDATE ,
 TIMEOFSALE as  TIMEOFSALE ,
 TRANSACTIONTYPE as  TRANSACTIONTYPE ,
 CUSTOMERNAME as  CUSTOMERNAME ,
 GLOBALREF as  GLOBALREF ,
 CUSTOMERTYPE as  CUSTOMERTYPE ,
 MEMO as  MEMO ,
 COMMENTS as  COMMENTS ,
 ORIGINALNO as  ORIGINALNO ,
 INVOICENUMBER as  INVOICENUMBER ,
 PONUMBER as  PONUMBER ,
 TOTALAMOUNTEX as  TOTALAMOUNTEX ,
 TOTALTAX as  TOTALTAX ,
 TOTALAMOUNTINC as  TOTALAMOUNTINC ,
 EMPLOYEENAME as  EMPLOYEENAME ,
 CONSIGNMENTNOTE as  CONSIGNMENTNOTE ,
 CLASSNAME as  CLASSNAME ,
 PRODUCTTYPE as  PRODUCTTYPE ,
 MANUFACTURER as  MANUFACTURER ,
 TYPE as  TYPE ,
 DEPARTMENT as  DEPARTMENT ,
 PRODUCTNAME as  PRODUCTNAME ,
 PRODUCTDESCRIPTION as  PRODUCTDESCRIPTION ,
 ITEMPRICEEX as  ITEMPRICEEX ,
 ITEMPRICEINC as  ITEMPRICEINC ,
 ITEMCOSTEX as  ITEMCOSTEX ,
 LINECOSTINC as  LINECOSTINC ,
 LINECOSTEX as  LINECOSTEX ,
 TAXCODE as  TAXCODE ,
 LINETAX as  LINETAX ,
 SHIPPED as  SHIPPED ,
 LINETOTALEX as  LINETOTALEX ,
 LINETOTALINC as  LINETOTALINC ,
 PREFEREDSUPPLIER as  PREFEREDSUPPLIER ,
 DELETED as  DELETED ,

 UNITOFMEASURESALELINES as  UNITOFMEASURESALELINES ,
 UNITOFMEASURESHIPPED as  UNITOFMEASURESHIPPED ,
 TILL as  TILL ,
 AREA as  AREA ,
 SHIPDATE as  SHIPDATE ,
 SOURCE as  SOURCE ,
 POSSOURCE as  POSSOURCE ,
 WARRANTYENDSON as  WARRANTYENDSON ,
 WARRANTYPERIOD as  WARRANTYPERIOD ,
 GROSSPROFIT as  GROSSPROFIT ,
 PERCENTPROFIT as  PERCENTPROFIT ,
 POSPOSTCODE as  POSPOSTCODE ,
 LINESHIPDATE as  LINESHIPDATE ,
 DISCOUNTPERCENT as  DISCOUNTPERCENT ,
 DISCOUNTS as  DISCOUNTS ,
 MARKUP as  MARKUP ,
 MARKUPPERCENTAGE as  MARKUPPERCENTAGE ,
 RUNNAME as  RUNNAME ,
 ATTRIB1SALERATE as  ATTRIB1SALERATE ,
 ATTRIB1SALE as  ATTRIB1SALE ,
 ATTRIB2SALE as  ATTRIB2SALE ,
 CUSTFLD1 as  CUSTFLD1 ,
 CUSTFLD2 as  CUSTFLD2 ,
 CUSTFLD3 as  CUSTFLD3 ,
 CUSTFLD4 as  CUSTFLD4 ,
 CUSTFLD5 as  CUSTFLD5 ,
 CUSTFLD6 as  CUSTFLD6 ,
 CUSTFLD7 as  CUSTFLD7 ,
 CUSTFLD8 as  CUSTFLD8 ,
 CUSTFLD9 as  CUSTFLD9 ,
 CUSTFLD10 as  CUSTFLD10 ,
 CUSTFLD11 as  CUSTFLD11 ,
 CUSTFLD12 as  CUSTFLD12 ,
 CUSTFLD13 as  CUSTFLD13 ,
 CUSTFLD14 as  CUSTFLD14 ,
 CUSTFLD15 as  CUSTFLD15 ,
 SALESLINESCUSTFIELD1 as  SALESLINESCUSTFIELD1 ,
 SALESLINESCUSTFIELD2 as  SALESLINESCUSTFIELD2 ,
 SALESLINESCUSTFIELD3 as  SALESLINESCUSTFIELD3 ,
 SALESLINESCUSTFIELD4 as  SALESLINESCUSTFIELD4 ,
 SALESLINESCUSTFIELD5 as  SALESLINESCUSTFIELD5 ,
 SALESLINESCUSTFIELD6 as  SALESLINESCUSTFIELD6 ,
 SALESLINESCUSTFIELD7 as  SALESLINESCUSTFIELD7 ,
 SALESLINESCUSTFIELD8 as  SALESLINESCUSTFIELD8 ,
 SALESLINESCUSTFIELD9 as  SALESLINESCUSTFIELD9 ,
 SALESLINESCUSTFIELD10 as  SALESLINESCUSTFIELD10 ,

 PARTSCUSTFLD1 as  PARTSCUSTFLD1 ,
 PARTSCUSTFLD2 as  PARTSCUSTFLD2 ,
 PARTSCUSTFLD3 as  PARTSCUSTFLD3 ,
 PARTSCUSTFLD4 as  PARTSCUSTFLD4 ,
 PARTSCUSTFLD5 as  PARTSCUSTFLD5 ,
 PARTSCUSTFLD6 as  PARTSCUSTFLD6 ,
 PARTSCUSTFLD7 as  PARTSCUSTFLD7 ,
 PARTSCUSTFLD8 as  PARTSCUSTFLD8 ,
 PARTSCUSTFLD9 as  PARTSCUSTFLD9 ,
 PARTSCUSTFLD10 as  PARTSCUSTFLD10 ,
 PARTSCUSTFLD11 as  PARTSCUSTFLD11 ,
 PARTSCUSTFLD12 as  PARTSCUSTFLD12 ,
 PARTSCUSTFLD13 as  PARTSCUSTFLD13 ,
 PARTSCUSTFLD14 as  PARTSCUSTFLD14 ,
 PARTSCUSTFLD15 as  PARTSCUSTFLD15 ,
 PARTSCUSTDATE1 as  PARTSCUSTDATE1 ,
 PARTSCUSTDATE2 as  PARTSCUSTDATE2
 from tmp_salesreport
*)



end.





