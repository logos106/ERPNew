unit ManifestDetailList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TManifestDetailListGUI = class(TBaseListingGUI)
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
    qryMainDistancekm: TIntegerField;
    qryMainCompleted: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    btnSummary: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSummaryClick(Sender: TObject);
  private
    fiSaleId: Integer;
    procedure MakeQuery;
    procedure SetSaleId(const Value: Integer);
    function SaleLineIDs(const Value: Integer): String;
    procedure BeforeShowSummary(Sender: TObject);
  protected
    procedure RefreshQuery; override;
    procedure ApplyQueryFilter; override;
  public
    Property SaleId :Integer read fiSaleId write SetSaleId;
  end;

var
  ManifestDetailListGUI: TManifestDetailListGUI;

implementation

uses
  CommonDbLib, tcDataUtils, CommonFormLib, ManifestList, LogLib,
  DbSharedObjectsObj;

{$R *.dfm}

{ TManifestDetailListGUI }

procedure TManifestDetailListGUI.ApplyQueryFilter;
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:  GroupFilterString := 'Completed = ' + QuotedStr('F');
    1:  GroupFilterString := 'Completed = ' + QuotedStr('T');
  end;
  inherited;
end;

procedure TManifestDetailListGUI.BeforeShowSummary(Sender: TObject);
begin
  TManifestListGUI(Sender).dtFrom.DateTime := self.dtFrom.DateTime;
  TManifestListGUI(Sender).dtTo.DateTime := self.dtTo.DateTime;
  TManifestListGUI(Sender).chkIgnoreDates.Checked := self.chkIgnoreDates.Checked;
  TManifestListGUI(Sender).grpFilters.ItemIndex := self.grpFilters.ItemIndex;
  TManifestListGUI(Sender).SaleId := self.SaleId;
end;

procedure TManifestDetailListGUI.btnSummaryClick(Sender: TObject);
begin
  inherited;
  OpenERpListForm(TManifestListGUI.ClassName, BeforeShowSummary);
  Self.Close;
end;

procedure TManifestDetailListGUI.FormCreate(Sender: TObject);
begin
  MakeQuery;
  inherited;
  fiSaleId := 0;
end;

procedure TManifestDetailListGUI.MakeQuery;
var
  s: string;
  ctr:Integer;
begin
  Qrymain.DisableControls;
  try
    CloseDB(Qrymain);
    Qrymain.SQL.Clear;
    for ctr := 1 to 2 do begin
      if Qrymain.SQL.count >0 then Qrymain.SQL.add('union');
      Qrymain.SQL.Add('select');
      Qrymain.SQL.Add('M.GlobalRef    AS GlobalRef,');
      Qrymain.SQL.Add('M.ManifestID   AS ManifestID,');
      Qrymain.SQL.Add('M.ManifestID   AS ManifestNo,');
      Qrymain.SQL.Add('M.DespatchDate AS DespatchDate,');
      Qrymain.SQL.Add('M.OwnerName    AS OwnerName,');
      Qrymain.SQL.Add('M.Driver       AS Driver,');
      Qrymain.SQL.Add('M.Phone        AS Phone,');
      Qrymain.SQL.Add('M.VehicleName  AS Vehicle,');
      Qrymain.SQL.Add('M.Trailer      AS Trailer,');
      Qrymain.SQL.Add('M.FromCity     AS FromCity,');
      Qrymain.SQL.Add('M.FromState    AS FromState,');
      Qrymain.SQL.Add('M.FromPostcode AS FromPostcode,');
      Qrymain.SQL.Add('M.ToCity       AS ToCity,');
      Qrymain.SQL.Add('M.ToState      AS ToState,');
      Qrymain.SQL.Add('M.ToPostcode   AS ToPostcode,');
      Qrymain.SQL.Add('MR.RouteDesc   AS Route,');
      Qrymain.SQL.Add('MR.Distance    AS Distancekm,');
      Qrymain.SQL.Add('M.Completed    AS Completed,');
      Qrymain.SQL.Add('SL.ProductName AS ProductName,');
      Qrymain.SQL.Add('SUBSTRING(M.Notes,1,255) AS Notes,');
      Qrymain.SQL.Add('Left(SUBSTRING_INDEX(P.Productgroup,"^",1),255) AS FirstColumn,');
      Qrymain.SQL.Add('Left(substring(substring_index(P.Productgroup,"^",2),char_length(substring_index(P.Productgroup,"^",1))+1),255) AS SecondColumn,');
      Qrymain.SQL.Add('Left(substring(substring_index(P.Productgroup,"^",2),char_length(substring_index(P.Productgroup,"^",1))+2),255) AS ThirdColumn');
      Qrymain.SQL.Add('from tblmanifest M');
      Qrymain.SQL.Add('inner join  tblmanifestlines ML on M.ManifestID = ML.ManifestID');
           if ctr = 1 then Qrymain.SQL.Add('inner join tblsaleslines SL on ML.SaleLineID    = SL.SaleLineID ')
      else if ctr = 2 then Qrymain.SQL.Add('inner join tblsaleslines SL On ML.InvoiceLineID = SL.SaleLineID');
      if fiSaleId <> 0 then begin
        s :=SaleLineIDs(fiSaleId);
        if s<> '' then
               if ctr = 1 then Qrymain.SQL.Add(' and (ML.salelineID in (' +s +'))' )
          else if ctr = 2 then Qrymain.SQL.Add(' and (ML.InvoiceLineID in (' +s +'))' );
      end;
      Qrymain.SQL.Add('inner join tblparts P on SL.ProductID = P.PARTSID');

      Qrymain.SQL.Add('Left Join tblmanifestroutes MR ON MR.ManifestRouteID = M.ManifestRouteID');
      Qrymain.SQL.Add('Where M.DespatchDate Between :DateFrom AND :DateTo');

    end;
    Qrymain.SQL.Add('Order By ManifestID Desc;');
    clog(qrymain.SQL.Text);
    RefreshOrignalSQL(False);
  finally
    qrymain.EnableControls;
  end;
end;

procedure TManifestDetailListGUI.RefreshQuery;
begin
  if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('DateFrom').AsDate := 0;
    qryMain.Params.ParamByName('DateTo').AsDate := MaxDateTime;
  end
  else begin
    qryMain.Params.ParamByName('DateFrom').AsDate := dtFrom.DateTime;
    qryMain.Params.ParamByName('DateTo').AsDate := dtTo.DateTime;
  end;
  inherited;
end;

function TManifestDetailListGUI.SaleLineIDs(const Value: Integer): String;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    With Qry do begin
      SQL.add('Select SaleLineId from tblsaleslines where saleId =' + inttostr(Value)+''); // all its lines
      SQL.add('union all');
      SQL.add('Select SaleLineId from tblsaleslines where saleId in (select SaleId from tblsales where SalesOrderGlobalRef in (Select globalref from tblsales where saleid = ' + inttostr(Value)+'))'); // when invoice all its original Sales orders's lines
      SQL.add('union all');
      SQL.add('Select SaleLineId from tblsaleslines where saleId in (Select SaleId from tblsales where globalref in (select SalesOrderGlobalRef from tblsales where saleId = ' + inttostr(Value)+'))'); // if converted sales order then all its invoices lines
      open;
      REsult := GroupConcat('SaleLineId');
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
  if result = '' then result := '0';
end;

procedure TManifestDetailListGUI.SetSaleId(const Value: Integer);
begin
  fiSaleId := Value;
  MakeQuery;
  if fiSaleId <> 0 then
        Self.Caption := 'Manifest List of ' + tcDataUtils.saletype(fiSaleId)+' #' + inttostr(fiSaleId);
end;

initialization
  RegisterClass(TManifestDetailListGUI);

end.
