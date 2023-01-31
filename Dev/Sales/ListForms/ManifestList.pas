unit ManifestList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog, kbmMemTable, 
  wwdblook, Shader, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TManifestListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainManifestID: TIntegerField;
    qryMainManifestNo: TIntegerField;
    qryMainDespatchDate: TDateField;
    qryMainOwnerName: TWideStringField;
    qryMainDriver: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainNotes: TWideStringField;
    qryMainVehicle: TWideStringField;
    qryMainTrailer: TWideStringField;
    qryMainFromCity: TWideStringField;
    qryMainFromState: TWideStringField;
    qryMainFromPostcode: TWideStringField;
    qryMainToCity: TWideStringField;
    qryMainToState: TWideStringField;
    qryMainToPostcode: TWideStringField;
    qryMainRoute: TWideStringField;
    qryMainDistanceKm: TIntegerField;
    qryMainCompleted: TWideStringField;
    qryMainSOID: TIntegerField;
    qryMainINVID: TIntegerField;
    btnDetail: TDNMSpeedButton;
    qryMainPartname: TWideStringField;
    qryMainPREFEREDSUPP: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure btnDetailClick(Sender: TObject);
  private
    fiSaleId:Integer;
    procedure SetSaleId(const Value: Integer);
    function SaleLineIDs(const Value: Integer): String;
    procedure BeforeShowDetail(Sender: TObject);
  protected
    procedure RefreshQuery; override;
    procedure SetGridColumns; override;
  public
    Property SaleId :Integer read fiSaleId write SetSaleId;
  end;

implementation

uses
  ManifestAllocationList, CommonLib, Forms, CommonDbLib, tcDataUtils,
  CommonFormLib, ManifestDetailList;

{$R *.dfm}

procedure TManifestListGUI.RefreshQuery;
begin
  if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('txtfrom').AsDate := 0;
    qryMain.Params.ParamByName('txtto').AsDate := MaxDateTime;
  end
  else begin
    qryMain.Params.ParamByName('txtfrom').AsDate := dtFrom.DateTime;
    qryMain.Params.ParamByName('txtto').AsDate := dtTo.DateTime;
  end;
  inherited;
end;

procedure TManifestListGUI.SetGridColumns;
begin
  inherited;
(*  RemoveFieldfromGrid(qrymainsalelineid.fieldname);
  RemoveFieldfromGrid(qrymaininvoicelineId.fieldname);*)
  RemoveFieldfromGrid(qryMainGlobalRef.fieldname);
  RemoveFieldfromGrid(qryMainManifestID.fieldname);
end;
Function TManifestListGUI.SaleLineIDs(Const Value:Integer):String;
begin
  With tempMyquery do try
    SQL.add('Select SaleLineId from tblsaleslines where saleId =' + inttostr(Value)+''); // all its lines
    SQL.add('union all');
    SQL.add('Select SaleLineId from tblsaleslines where saleId in (select SaleId from tblsales where SalesOrderGlobalRef in (Select globalref from tblsales where saleid = ' + inttostr(Value)+'))'); // when invoice all its original Sales orders's lines
    SQL.add('union all');
    SQL.add('Select SaleLineId from tblsaleslines where saleId in (Select SaleId from tblsales where globalref in (select SalesOrderGlobalRef from tblsales where saleId = ' + inttostr(Value)+'))'); // if converted sales order then all its invoices lines
    open;
    REsult := GroupConcat('SaleLineId');
  finally
    closenFree;
  end;
  if result = '' then result := '0';
end;
procedure TManifestListGUI.SetSaleId(const Value: Integer);
var
  s:String;
begin
  fiSaleId := Value;
  Qrymain.DisableControls;
  try
    CloseDB(Qrymain);
    Qrymain.SQL.Clear;
    Qrymain.SQL.Add('SELECT distinct');
    Qrymain.SQL.Add('M.GlobalRef,');
    Qrymain.SQL.Add('M.ManifestID,');
    Qrymain.SQL.Add('M.ManifestID as ManifestNo ,');
    Qrymain.SQL.Add('M.DespatchDate,');
    Qrymain.SQL.Add('M.OwnerName,');
    Qrymain.SQL.Add('M.Driver,');
    Qrymain.SQL.Add('M.Phone,');
    Qrymain.SQL.Add('SUBSTRING(M.Notes,1,255) as Notes,');
    Qrymain.SQL.Add('M.VehicleName as Vehicle,');
    Qrymain.SQL.Add('M.Trailer,');
    Qrymain.SQL.Add('M.FromCity,');
    Qrymain.SQL.Add('M.FromState,');
    Qrymain.SQL.Add('M.FromPostcode,');
    Qrymain.SQL.Add('M.ToCity,');
    Qrymain.SQL.Add('M.ToState,');
    Qrymain.SQL.Add('M.ToPostcode,');
    Qrymain.SQL.Add('MR.RouteDesc as Route,');
    Qrymain.SQL.Add('MR.Distance as Distancekm,');
    Qrymain.SQL.Add('M.Completed  ,');
    Qrymain.SQL.Add('SOSL.SaleID as SOID,');
    Qrymain.SQL.Add('INVSL.SaleID as INVID,');
    Qrymain.SQL.Add('ifnull(SOSLP.Partname , INVSLP.Partname) as Partname,');
    Qrymain.SQL.Add('ifnull(SOSLP.PREFEREDSUPP , INVSLP.PREFEREDSUPP) as PREFEREDSUPP');
    Qrymain.SQL.Add('FROM tblmanifest M');
    Qrymain.SQL.Add('Inner join tblmanifestlines ML on M.ManifestID = ML.ManifestID');
    Qrymain.SQL.Add('Left join (tblsaleslines SOSL  inner join tblparts SOSLP  on SOSLP.PARTSID  = SOSL.productID ) on SOSL.saleLineid  = ML.saleLineID');
    Qrymain.SQL.Add('Left join (tblsaleslines INVSL inner join tblparts INVSLP on INVSLP.partsId = INVSL.productID) on INVSL.SaleLineID = ML.InvoiceLineID');
    Qrymain.SQL.Add('Left Join tblmanifestroutes MR ON MR.ManifestRouteID = M.ManifestRouteID');
    Qrymain.SQL.Add('Where M.DespatchDate Between  :txtfrom AND :txtto');
    if Value <> 0 then begin
      s:=SaleLineIDs(Value);
      if s<> '' then Qrymain.SQL.Add(' and ((ML.salelineID in (' +s +')) or (ML.invoiceLineId in (' + s +')))');
      Self.Caption := 'Manifest List of ' +saletype(Value)+' #' + inttostr(Value);
      //TitleLabel.Caption :='Manifest List of ' +saletype(Value)+' #' + inttostr(Value);
    end;
    Qrymain.SQL.Add('Order By ManifestID Desc;');
    RefreshOrignalSQL(False);
  finally
    qrymain.EnableControls;
  end;
end;

procedure TManifestListGUI.BeforeShowDetail(Sender: TObject);
begin
  TManifestDetailListGUI(Sender).dtFrom.DateTime := self.dtFrom.DateTime;
  TManifestDetailListGUI(Sender).dtTo.DateTime := self.dtTo.DateTime;
  TManifestDetailListGUI(Sender).chkIgnoreDates.Checked := self.chkIgnoreDates.Checked;
  TManifestDetailListGUI(Sender).grpFilters.ItemIndex := self.grpFilters.ItemIndex;
  TManifestDetailListGUI(Sender).SaleId := self.SaleId;
end;

procedure TManifestListGUI.btnDetailClick(Sender: TObject);
begin
  inherited;
  OpenERpListForm(TManifestDetailListGUI.ClassName, BeforeShowDetail);
  Self.Close;
end;

procedure TManifestListGUI.cmdNewClick(Sender: TObject);
var
  ManifestAllocationList: TManifestAllocationListGUI;
begin
  inherited;
  ManifestAllocationList := TManifestAllocationListGUI(GetComponentByClassName('TManifestAllocationListGUI'));
  if Assigned(ManifestAllocationList) then begin
    ManifestAllocationList.FormStyle := fsMDIChild;
    ManifestAllocationList.BringToFront;
  end;
end;

procedure TManifestListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:  GroupFilterString := 'Completed = ' + QuotedStr('F');
    1:  GroupFilterString := 'Completed = ' + QuotedStr('T');
  end;
  inherited;
end;

procedure TManifestListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if fbFormOpenedOk then begin
    grpFiltersClick(Sender);
  end;
  TitleLabel.Caption :='Manifest List';
end;

initialization
  RegisterClassOnce(TManifestListGUI);
end.
