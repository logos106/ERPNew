unit PQAMissingtype;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TPQAMissingtypeGui = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainPQAID: TIntegerField;
    qryMainTransLineID: TIntegerField;
    qryMainTransType: TWideStringField;
    qryMainTransDate: TDateTimeField;
    qryMainAlloctype: TWideStringField;
    qryMainIsBO: TWideStringField;
    qryMainQty: TFloatField;
    qryMainUOMQty: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainUOMMultiplier: TFloatField;
    qryMainUOMID: TIntegerField;
    qryMainDepartmentID: TIntegerField;
    qryMainProductID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainTransID: TLargeintField;
    qryMainReserved: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainMatrixRef: TWideMemoField;
    btnupdate: TDNMSpeedButton;
    procedure grdMainDblClick(Sender: TObject);override;
    procedure btnupdateClick(Sender: TObject);
  private
    fiTransLineId: Integer;
    fiTransId: Integer;
    fsTranstype: STring;
    { Private declarations }
  public
    Property TransId :Integer read fiTransId write fiTransId;
    Property TransLineId :Integer read fiTransLineId write fiTransLineId;
    Property Transtype :STring read fsTranstype write fsTranstype;
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonLib, busobjOrders, CommonDbLib, BusObjSales, BusobjCash, busobjPOS;

{$R *.dfm}
{ TPQAMissingtypeGui }

procedure TPQAMissingtypeGui.btnupdateClick(Sender: TObject);
var
  st:TStringList;
  ftrtype:String;
  s:string;
begin
  inherited;
  if Transtype = 'Purchase' then ftrtype := TPurchaseOrderLine.classname
  else with tempMyquery do try
    SQL.add('Select isinvoice, issalesorder, iscashsale, isrefund , ispoS  from tblsales where saleId = ' +inttostr(transID));
    open;
         if fieldbyname('isinvoice').asBoolean    then ftrtype := TInvoiceLine.classname
    else if fieldbyname('issalesorder').asBoolean then ftrtype := TSalesOrderLine.classname
    else if fieldbyname('iscashsale').asBoolean   then ftrtype := TCashSaleLine.classname
    else if fieldbyname('isrefund').asBoolean     then ftrtype := TRefundSaleLine.Classname
    else if fieldbyname('ispoS').asBoolean        then ftrtype := TPOSLine.classname
    else exit;
  finally
    closenfree;
  end;

  if ftrtype<> '' then begin
    st:= TStringlist.create;
    try
      st.add('insert ignore into erpfix_pqa_fixed '+
              ' (`GlobalRef`, `PQAID`, `TransLineID`, `TransType`, `TransDate`, `Alloctype`, `IsBO`, `Qty`, `UOMQty`, `UOM`, `UOMMultiplier`, `UOMID`, `DepartmentID`, `ProductID`, `ProductName`, `Active`, `TransID`, `Reserved`, `msTimeStamp`, `MatrixRef`)'+
              ' Select `GlobalRef`, `PQAID`, `TransLineID`, `TransType`, `TransDate`, `Alloctype`, `IsBO`, `Qty`, `UOMQty`, `UOM`, `UOMMultiplier`, `UOMID`, `DepartmentID`, `ProductID`, `ProductName`, `Active`, `TransID`, `Reserved`, `msTimeStamp`, `MatrixRef` '+
              ' from tblPQa where PQAId = ' +inttostr(QrymainPQAId.asInteger)+';');
       s:= 'update tblpqa set transtype = ' +Quotedstr(ftrtype) ;
       if transtype = 'Purchase' then s:= s +', Alloctype = "IN" ' else s:= s +', Alloctype = "OUT" ';
       s:= s +' where PQAId = ' + inttostr(Qrymainpqaid.asInteger);
       st.add(s);
       if MessageDlgXP_Vista('Do You wish to chnage this pqa to ' + ftrtype+'?', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
        ExecuteSQL(st.text);
        RefreshQuery;
       end;
    finally
      freeandnil(st);
    end;
  end;
end;

procedure TPQAMissingtypeGui.grdMainDblClick(Sender: TObject);
begin
//  inherited;
  btnupdate.Click;
end;

procedure TPQAMissingtypeGui.RefreshQuery;
begin
  closedb(Qrymain);
  Qrymain.Parambyname('TransId').asInteger := TransId;
  Qrymain.Parambyname('TranslineId').asInteger := TranslineId;
  inherited;
end;

initialization
  RegisterClassOnce(TPQAMissingtypeGui);

end.

