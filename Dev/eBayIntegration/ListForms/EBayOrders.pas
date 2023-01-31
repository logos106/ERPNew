unit EBayOrders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg, ComCtrls, AdvProgr;

type
  TEBayOrdersGUI = class(TBaseListingGUI)
    qryMainOrderID: TWideStringField;
    qryMainCreatedtime: TDateTimeField;
    qryMainOrderStatus: TWideStringField;
    qryMainShippedtime: TDateTimeField;
    qryMainTotalcurcode: TWideStringField;
    qryMainTotalAmt: TFloatField;
    qryMainpaidAmt: TFloatField;
    qryMainEbayAccountname: TWideStringField;
    qryMainsalesorderID: TLargeintField;
    qryMainInvoiceID: TLargeintField;
    qryMainCustomerName: TWideStringField;
    pnlRequerytmr: TPanel;
    Shape1: TShape;
    lblhint: TLabel;
    lblcheckPref: TLabel;
    pbRequery: TAdvProgress;
    tmrcheckOrderstrack: TTimer;
    procedure grpFiltersClick(Sender: TObject);override;
    procedure grdMainDblClick(Sender: TObject);override;
    procedure lblcheckPrefClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrcheckOrderstrackTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    dtNextSynchtime:TDatetime;
    Procedure CheckEbaySynch;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib, tcConst, ConfigReaderLib, DbSharedObjectsObj, CommonDbLib,
  Preferences, AppEnvironment, LogLib;

{$R *.dfm}

{ TEBayOrdersGUI }



procedure TEBayOrdersGUI.FormCreate(Sender: TObject);
begin
  inherited;
  dtNextSynchtime := 0;
  pbRequery.max := 61;
  pbRequery.step := 1;
  pbRequery.Position := pbRequery.min;
  pbRequery.align := altop;
end;

procedure TEBayOrdersGUI.FormShow(Sender: TObject);
begin
  inherited;
  CheckEbaySynch;
end;

procedure TEBayOrdersGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := '';
  if sametext(activefieldname, qrymaininvoiceId.fieldname) and (qrymaininvoiceId.asInteger <> 0) then
    SubsequentID := Chr(95) + 'Invoice';
  if QrymainSalesorderID.AsInteger =0 then
    CommonLib.MessageDlgXP_Vista('No further information available on this column. ', mtInformation, [mbOK], 0)
  else inherited;
end;

procedure TEBayOrdersGUI.grpFiltersClick(Sender: TObject);
begin
  groupfilterString := '';
       if grpfilters.ItemIndex = 0 then groupfilterString := 'SalesOrderID <> 0'
  else if grpfilters.ItemIndex = 1 then groupfilterString := 'SalesOrderID = 0';
  inherited;

end;

procedure TEBayOrdersGUI.lblcheckPrefClick(Sender: TObject);
begin
  inherited;
      OpenPrefform('EDI and Integration' ,  'chkShowEbayonMainMenubyDefault', 0 , True, 'Ebay Integration' , 'pnlEBayInt' ,
                    'Changes made here will not take affect unless the Application is Restarted.');
end;

procedure TEBayOrdersGUI.RefreshQuery;
begin
  Qrymain.Parambyname('datefrom').AsDatetime := filterDateFrom;
  Qrymain.Parambyname('dateTo').AsDatetime := filterDateTo;
  Qrymain.Parambyname('CashCustomer').AsString :=CLIENT_CASH;
  inherited;
end;

procedure TEBayOrdersGUI.tmrcheckOrderstrackTimer(Sender: TObject);
begin
  inherited;
  pbRequery.Stepit;
  pnlRequerytmr.visible := true;
  if (screen.activeform = Self) then begin
    if now >= dtNextSynchtime then begin
          CheckEbaySynch;
          Showcontrolhint(pbRequery , lblhint.caption);
    end;
  end;
end;
procedure TEBayOrdersGUI.CheckEbaySynch;
var
  qry: TERPQuery;
  fs:String;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Qry.sql.text := 'Select * from ('+EbayConfigSQL+') EbayConfig ';
    Qry.sql.add(' where Databasename = ' + quotedstr(AppEnv.AppDb.Database)+' and active ="T"  and ifnull(NextSyncTime,0)>0');
    Qry.sql.add(' Order by NextSyncTime');
    Qry.open;
    clog(Qry.SQL.text);
    if Qry.recordcount =0 then begin
      fs:= 'This Database is not Configured for Ebay Synch';
      tmrcheckOrderstrack.enabled := False;
      pbRequery.visible :=False;
      lblhint.align := alclient;
      lblhint.Wordwrap := True;
    end else begin
      fs:= 'Next Synch is at ' +Formatdatetime(Shortdateformat +' hh:mm:ss am/pm' , Qry.fieldbyname('NextSyncTime').asdatetime);
      dtNextSynchtime :=Qry.fieldbyname('NextSyncTime').asdatetime;
      tmrcheckOrderstrack.Interval := 1000 * 10; // 10 seconds - progress bar
      tmrcheckOrderstrack.Enabled := TRue;
      pbRequery.visible :=TRue;
      lblhint.align := alnone;
      lblhint.Wordwrap := False;
      lblhint.top := pbRequery.top + pbRequery.height + 1;
      lblhint.left := 1;
      lblhint.width := lblcheckPref.left -1;
    end;
    lblhint.caption :=fs;
    lblhint.refresh;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
initialization
  RegisterClassOnce(TEBayOrdersGUI);

end.


