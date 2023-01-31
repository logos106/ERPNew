unit ManifestAllocationList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, wwcheckbox, 
  MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog, wwdblook,
  kbmMemTable, Shader, DAScript, MyScript, BusObjManifest, BusObjSales, busobjbase, customInputBox,
  wwclearbuttongroup, wwradiogroup;

type
  TManifestAllocationListGUI = class(TBaseListingGUI)
    Button1: TDNMSpeedButton;
    qryMainSaleID: TAutoIncField;
    qryMainInvoiceNo: TWideStringField;
    qryMainPickupFrom: TWideStringField;
    qryMainShipTo: TWideStringField;
    qryMainToCity: TWideStringField;
    qryMainToState: TWideStringField;
    qryMainToPostcode: TWideStringField;
    qryMainAddToManifest: TWideStringField;
    EnterManifestNumber: TCustomInputBox;
    qryMainIsSalesOrder: TWideStringField;
    chkAddToManifest: TwwCheckBox;
    qryMainSaleGlobalRef: TWideStringField;
    QryClients: TERPQuery;
    QryClientsclientID: TIntegerField;
    QryClientsFromCity: TWideStringField;
    QryClientsFromState: TWideStringField;
    QryClientsFromPostcode: TWideStringField;
    qryMainclientID: TIntegerField;
    qryMainFromState: TWideStringField;
    qryMainFromPostCode: TWideStringField;
    qryMainFromCity: TWideStringField;
    qryMainShipDate: TDateField;
    qryMainShipVia: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure chkAddToManifestClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
    procedure qryMainAddToManifestChange(Sender: TField);
  private
    TempTableName: string;
    ManID:Integer;
    ManifestObj :TManifest;
    fbSelectingRecord:Boolean;
    procedure PopulateTempTable;
    procedure AddManifestDetail(ID: integer);
    procedure OpenManifest(ID: integer);
    Procedure selectManifestID;
    procedure OnSelectManifestID(Sender: TWWDBGRid);
    procedure AddManifestDetailcallback(const Sender: TBusObj; var Abort: Boolean);
    function AnyselectedtoManifest: Boolean;
  protected
    procedure RefreshQuery; override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); override;
    procedure SetGridColumns; Override;
  public
  end;

implementation

uses FastFuncs,ComObj, CommonDbLib, frmManifest, DateUtils,
  CommonLib, Forms, AppEnvironment, CommonFormLib, tcConst, MySQLConst, LogLib;

{$R *.dfm}

{ TManifestAllocationListGUI }

procedure TManifestAllocationListGUI.RefreshQuery;
begin
  closedb(Qrymain);
  PopulateTempTable;
  inherited;
end;
Procedure TManifestAllocationListGUI.selectManifestID;
begin
  OpenERPListFormSingleselectModal('TManifestListGUI' , OnSelectManifestID , nil);
end;
procedure TManifestAllocationListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainclientId.fieldname);
  RemoveFieldfromGrid(QrymainToCity.fieldname);
  RemoveFieldfromGrid(QrymainToState.fieldname);
  RemoveFieldfromGrid(QrymainToPostcode.fieldname);
  //RemoveFieldfromGrid(QrymainManifestId.fieldname);
end;

procedure TManifestAllocationListGUI.OnSelectManifestID(Sender :TWWDBGRid);
begin
  if Sender.DataSource.DataSet.FindField('ManifestID') <> nil then
    ManID :=Sender.DataSource.DataSet.FindField('ManifestID').AsInteger;
end;
procedure TManifestAllocationListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := '(UsedOnManifest<>' + QuotedStr('T') + ')';
      end;
    1: 
      begin
        GroupFilterString := '(UsedOnManifest=' + QuotedStr('T') + ')';
      end;
  end;
  inherited;
end;

procedure TManifestAllocationListGUI.FormCreate(Sender: TObject);
begin
  TempTableName := commondbLib.CreateUserTemporaryTable('tmp_ManifestAllocation' , '');
//  qryMain.SQL.Text:= 'select * from ' + TempTableName;
  qryMain.SQL.Clear;
  qryMain.SQL.Add('select *');
  qryMain.SQL.Add('from ' + TempTableName);
  fbSelectingRecord:=False;
  inherited;
end;

procedure TManifestAllocationListGUI.FormDestroy(Sender: TObject);
begin
  inherited;
  DestroyUserTemporaryTable(TempTableName);
end;

procedure TManifestAllocationListGUI.grdMainDblClick(Sender: TObject);
begin
  if grdMain.GetActiveField <> qryMainAddToManifest then begin
    if qryMain.FieldByName('IsSalesOrder').AsBoolean then begin
      SubsequentID := Chr(95) + 'SO';
    end else begin
      SubsequentID := Chr(95) + 'INV';
    end;
    inherited;
  end;
end;
procedure TManifestAllocationListGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  if fbSelectingRecord then exit;
  fbSelectingRecord:= True;
  try
    editdb(Qrymain);
    QrymainAddToManifest.AsBoolean := Selecting;
    PostDB(Qrymain);
  finally
    fbSelectingRecord:=False;
  end;
end;

procedure TManifestAllocationListGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer);
var
  s:STring;

  function SalesObj: TSales;
  begin
    if Qrymainissalesorder.asBoolean then result := TSalesorder.Create(Self)
    else result := TInvoice.Create(Self);
  end;
begin
  if IterateProcNo = 1 then begin
    if QrymainAddToManifest.AsBoolean then begin
       With SalesObj do try
        Connection := ManifestObj.Connection;
        Load(qryMainSaleID.AsInteger);
        if Manifestobj.userlock.lock('tblsales' , ID, 'Add to Manifest') = False then begin
          s:= ManifestObj.userlock.LockMessage;
          s:= replaceStr(s ,'Unable to update data.' ,  XMLNodeName +' # ' + inttostr(ID) +' cannot be added to Manifest.');
          MessageDlgXP_Vista(s, mtWarning, [mbOK], 0);
          exit;
        end;
        Lines.iterateRecords(AddManifestDetailcallback);
        UsedOnManifest := True;
        PostDB;
       finally
         Free;
       end;
    end;
  end;
end;
Function TManifestAllocationListGUI.AnyselectedtoManifest:Boolean;
begin
  result:= false;
  if Qrymain.RecordCount = 0 then exit;
  if grdmain.SelectedList.Count =0 then Exit;
  result := True;
end;
procedure TManifestAllocationListGUI.cmdNewClick(Sender: TObject);
begin
  if not(AnyselectedtoManifest) then begin
    MessageDlgXP_vista('Please choose the sales records to be added by selecting ''Add To Manifest'' checkbox in the list', mtWarning, [mbOK], 0);
    exit;
  end;

  ManifestObj := TManifest.CreateWithNewConn(Self);
  try
    ManifestObj.Load(0);
    ManifestObj.Connection.BeginTransaction;
    try
      ManifestObj.New;
      ManifestObj.DespatchDate:= now;
      ManifestObj.PostDB;
      ManID:= ManifestObj.ID;
      IterateProcNo := 1;
      IterateRecords(True , WAITMSG);
      if ManifestObj.Lines.Count =0 then begin
        ManifestObj.Connection.RollbackTransaction;
        Exit;
      end;
      ManifestObj.Connection.CommitTransaction;
    Except
      on E:Exception do begin
        MessageDlgXP_vista('Failed to create a new Manifest record' + NL +  E.Message, mtWarning, [mbOK], 0);
        ManifestObj.Connection.RollbackTransaction;
        Exit;
      end;
    end;
  finally
    Freeandnil(ManifestObj);
  end;
  OpenManifest(ManID);
    RefreshQuery;
end;

procedure TManifestAllocationListGUI.Button1Click(Sender: TObject);
begin
  if not(AnyselectedtoManifest) then begin
    MessageDlgXP_vista('Please choose the sales records to be added by selecting ''Add To Manifest'' checkbox in the list', mtWarning, [mbOK], 0);
    exit;
  end;
    inherited;
    ManID:= 0;
    SelectManifestID;
    if ManID =0 then exit;
    AddManifestDetail(ManID);
    OpenManifest(ManID);
    RefreshQuery;
end;
procedure TManifestAllocationListGUI.AddManifestDetailcallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TSalesLine) then exit;
  if TSalesLine(Sender).Manifestline.Count>0 then exit;

  ManifestObj.Lines.New;
  if sender is TSalesorderline then
  begin
    ManifestObj.Lines.SaleLineID    := TSalesLine(Sender).ID;
    ManifestObj.Lines.InvoiceId := TSalesLine(Sender).SaleId;
  end
  else
  begin
    ManifestObj.Lines.InvoiceLineID := TInvoiceLine(Sender).ID;
    ManifestObj.Lines.InvoiceId := TInvoiceLine(Sender).SaleId;
  end;
  ManifestObj.Lines.ETA:= incday(ManifestObj.DespatchDate, AppEnv.CompanyPrefs.ManifestDaysAfterDespatchDate);
  ManifestObj.Lines.Pageno := 1;

  ManifestObj.Lines.PostDB;

end;
procedure TManifestAllocationListGUI.AddManifestDetail(ID: integer);
begin
  ManifestObj := TManifest.CreateWithNewConn(Self);
  Try
    ManifestObj.Load(ManID);
    if ManifestObj.Count =0 then begin
      MessageDlgXP_Vista('Manifest # '+ inttostr(ManID)+' doesn''t exists. ', mtWarning, [mbOK], 0);
      Exit;
    end;
    ManifestObj.Connection.BeginTransaction;
    try
      IterateProcNo := 1;
      IterateRecords(True , WAITMSG);
      if ManifestObj.Lines.Count =0 then begin
        ManifestObj.Connection.RollbackTransaction;
        Exit;
      end;
      ManifestObj.Connection.CommitTransaction;
    Except
      on E:Exception do begin
        MessageDlgXP_Vista('Adding Sales To Manifest Failed.' +NL+ E.Message, mtWarning, [mbOK], 0);
        ManifestObj.Connection.RollbackTransaction;
      end;
    end;
  Finally
    Freeandnil(ManifestObj);
  End;
end;

(*procedure TManifestAllocationListGUI.AddManifestMaster(var ID: integer);
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    with qryTemp do begin
      Sql.Add('SELECT * FROM tblmanifest Where IsNull(ManifestID);');
      Active := true;
      Insert;
      FieldByName('DespatchDate').AsDateTime := Now;
      Post;
      ID := FieldByName('ManifestID').AsInteger;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;*)

(*procedure TManifestAllocationListGUI.FlagSaleAsUsedonManifest;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('UPDATE tblsales SET UsedOnManifest="T" WHERE SaleID=:ID;');
    qryMain.First;
    while not qryMain.Eof do begin
      qryTemp.ParamByName('ID').AsInteger := qryMainSaleID.AsInteger;
      qryTemp.Execute;
      qryMain.Next;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;*)

procedure TManifestAllocationListGUI.OpenManifest(ID: integer);
begin
  openERPForm('TManifestGUI' , ID);
end;

procedure TManifestAllocationListGUI.PopulateTempTable;
var
  ssql:String;
  fields:String;
  tmpfile:String;
  ctr:Integer;
begin

    ssql := '';
    for ctr:= 1 to 2 do begin
      if ((ctr=1) and  ((sametext(AppEnv.CompanyPrefs.ManifestType , 'SALESORDER')) or (sametext(AppEnv.CompanyPrefs.ManifestType , 'BOTH')))) Or
         ((ctr=2) and  ((sametext(AppEnv.CompanyPrefs.ManifestType , 'INVOICE')) or (sametext(AppEnv.CompanyPrefs.ManifestType , 'BOTH')))) then begin

        if ssql <> '' then ssql := ssql + nl+ ' union ' +nl;
        ssql := ssql + ' select Distinct '+
            ' NULL as ID,'+
            ' ClientID,'+
            ' S.SaleID as SaleID,'+
            ' S.GlobalRef as SaleGlobalRef,'+
            ' InvoiceDocNumber as InvoiceNo,'+
            ' replace(S.PickupFrom, "\r\n" , ", ") as "From", '+
            ' replace(ShipTo , "\r\n" , ", ") as "To", '+
            ' S.ShipDate as ShipDate,' +
            ' S.Shipping as ShipVia,'+
            ' S.IsSalesOrder as IsSalesOrder,'+

            ' space(100) as ToCity,'+
            ' space(100) as ToState,'+
            ' space(100) as ToPostcode,'+
            ' "F" as AddToManifest'+
            ' FROM tblSales S'+
            ' inner join tblsaleslines SL on S.saleId = Sl.saLeID'+ iif(ctr=1 , ' and S.ISSalesorder ="T"' , ' and   S.IsInvoice ="T" ') +
            ' Left join tblmanifestlines ML on '+ iif(ctr=1 , ' SL.salelineId = ML.saleLineID ' , 'SL.salelineId = ML.InvoiceLineID') +
            ' WHERE IsManifest="T" /*AND UsedOnManifest = "F" */and S.Converted = "F" and ifnull(ML.ManifestLineID,0)=0'+
            ' AND S.SaleDate BETWEEN ' +  Quotedstr(formatdatetime(MysqlDateTimeFormat , filterdateFrom))+' AND ' +  Quotedstr(formatdatetime(MysqlDateTimeFormat , filterdateto));
         end;
    end;
    if IsLimit0selection  then ssql := ssql + nl+ ' LIMIT 0';


      Fields :=  'ID , ClientID , SaleID , SaleGlobalRef, InvoiceNo, PickupFrom, ShipTo, ShipDate, ShipVia, IsSalesOrder, ToCity , ToState, ToPostCode , AddToManifest';
    ssql:= CreateTemporaryTableusingfile('tmp_ManifestAllocation' , ssql , fields , temptablename , tmpfile);
(*    ssql := ssql + 'Alter table ' + temptablename +' Add column ManifestID int(11);' +
          'update ' + temptablename +' T inner join   tblmanifestlines ML on T.SaleID = ML.SaleID Set T.ManifestId = ML.manifestID;';*)
    with SctMain do begin
      SQL.Clear;
      SQL.add('Truncate table '+ temptablename+';' );
      SQL.add(ssql);
      DoShowProgressbar(3, WAITMSG);
      try
        clog(sql.text);
        Execute;
      finally
        DoHideProgressbar;
      end;
    end;
    AppEnv.UtilsClient.DeleteServerFile(tmpfile);
(*var
  cmd: TERPCommand;
  tmpFile, tmpFileMySQL: string;
begin
  tmpFile:= GetMySQLTempDir + TempTableName + '_';
  tmpFileMySQL:= StringReplace(tmpFile,'\','/',[rfReplaceAll]);
  tmpFileMySQL:= tmpFileMySQL + FormatDateTime('dd-mm-yy_hh-nn-ss-zzz',now) + '.tmp';
  try

    cmd:= TERPCommand.Create(nil);
    try
      cmd.Connection:= CommonDbLib.GetSharedMyDacConnection;
      cmd.SQL.Add('truncate ' + TempTableName);
      cmd.Execute;
      cmd.SQL.Clear;
      cmd.SQL.Add('select');
      cmd.SQL.Add('NULL as ID,');
      cmd.SQL.Add('ClientID,');
      cmd.SQL.Add('S.SaleID as SaleID,');
      cmd.SQL.Add('S.GlobalRef as SaleGlobalRef,');
      cmd.SQL.Add('InvoiceDocNumber as InvoiceNo,');
      cmd.SQL.Add('S.PickupFrom as "From",');
      cmd.SQL.Add('ShipTo as "To",');
      cmd.SQL.Add('S.IsSalesOrder as IsSalesOrder,');
      cmd.SQL.Add('ShipToAddress.City_sub as ToCity,');
      cmd.SQL.Add('ShipToAddress.state as ToState,');
      cmd.SQL.Add('ShipToAddress.PostCode as ToPostcode,');
      cmd.SQL.Add('"F" as AddToManifest');
      cmd.SQL.Add('FROM tblSales S');
      cmd.SQL.Add('Left join tblLocations as ShipToAddress on'); //  S.Shipto like concat("%" , ifnull(ShipToAddress.City_sub,"") , "%") and  S.Shipto like concat("%" , ifnull(ShipToAddress.State,"") , "%") and  S.Shipto like concat("%" , ifnull(ShipToAddress.Postcode,"") , "%")');
      cmd.SQL.Add('(not IsNull(ShipToAddress.City_sub) and S.Shipto like concat("%", ShipToAddress.City_sub, "%")) and');
      cmd.SQL.Add('(not IsNull(ShipToAddress.State) and S.Shipto like concat("%", ShipToAddress.State, "%")) and');
      cmd.SQL.Add('(not IsNull(ShipToAddress.Postcode) and  S.Shipto like concat("%", ShipToAddress.Postcode, "%"))');
      cmd.SQL.Add('WHERE IsManifest="T" AND UsedOnManifest = "F" and S.Converted = "F"');
      cmd.SQL.Add('AND S.SaleDate BETWEEN :txtFrom AND :txtTo');
      cmd.SQL.Add('INTO OUTFILE "' + tmpFileMySQL + '";');
      cmd.ParamByName('txtFrom').AsDate:= dtFrom.Date;
      cmd.ParamByName('txtTo').AsDate:= dtTo.Date;
      cmd.Execute;
      cmd.SQL.Clear;
      cmd.SQL.add('LOAD DATA INFILE "' + tmpFileMySQL + '" INTO TABLE ' + TempTableName + ';');
      cmd.Execute;
    finally

    end;

  finally
    AppEnv.UtilsClient.DeleteServerFile(tmpFileMySQL);
  end;*)

end;

procedure TManifestAllocationListGUI.qryMainAddToManifestChange(Sender: TField);
begin
  inherited;
  if fbSelectingRecord then exit;
  fbSelectingRecord:=True;
  Try
    if qryMainAddToManifest.AsBoolean then grdmain.SelectRecord
    else grdmain.UnselectRecord;
  Finally
    fbSelectingRecord:=False;
  End;
end;

(*function TManifestAllocationListGUI.IsManifest(ID: integer): boolean;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT ManifestID FROM tblmanifest Where ManifestID=' + IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := true;
    end else begin
      Result := false;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;*)

procedure TManifestAllocationListGUI.chkAddToManifestClick(Sender: TObject);
begin
  inherited;
  if not TwwCheckBox(Sender).DataSource.DataSet.Active then Exit;
  TwwCheckBox(Sender).DataSource.DataSet.Edit;
  if TwwCheckBox(Sender).Checked then TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString :=
      'T'
  else TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'F';
end;

procedure TManifestAllocationListGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('IsSalesOrder,ID,ClientID,SaleID');

end;

initialization
  RegisterClassOnce(TManifestAllocationListGUI);
end.
