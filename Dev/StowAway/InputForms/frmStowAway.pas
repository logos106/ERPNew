unit frmStowAway;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, DNMSpeedButton, Shader, ExtCtrls, DNMPanel,
  ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus,
  AdvMenus, DataState, SelectionDialog, AppEvnts, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwcheckbox, Mask, wwdbedit, wwdbdatetimepicker, wwdblook,
  DBCtrls, BusobjStowAway, BusObjBase;

type
  TfmStowAway = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel2: TDNMPanel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    QryprocStowAway: TERPQuery;
    dsprocStowAway: TDataSource;
    DNMPanel4: TDNMPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    edtUOMQty: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    wwCheckBox1: TwwCheckBox;
    qryUnitOfMeasure: TERPQuery;
    qryUnitOfMeasureUnitID: TIntegerField;
    qryUnitOfMeasureUnitName: TWideStringField;
    qryUnitOfMeasureUnitDescription: TWideStringField;
    qryUnitOfMeasureMultiplier: TFloatField;
    qryUnitOfMeasureBaseUnitName: TWideStringField;
    DNMPanel3: TDNMPanel;
    QryprocStowawayLines: TERPQuery;
    dsprocStowawayLines: TDataSource;
    QryProcTreeStow: TERPQuery;
    dsProcTreeStow: TDataSource;
    pnlDetails: TDNMPanel;
    QryprocStowawayLinesID: TIntegerField;
    QryprocStowawayLinesGlobalRef: TWideStringField;
    QryprocStowawayLinesStowAwayID: TIntegerField;
    QryprocStowawayLinesQty: TFloatField;
    QryprocStowawayLinesUOMID: TIntegerField;
    QryprocStowawayLinesUOM: TWideStringField;
    QryprocStowawayLinesUOMMult: TFloatField;
    QryprocStowawayLinesUOMQty: TFloatField;
    QryprocStowawayLinesmstimeStamp: TDateTimeField;
    QryprocStowawayLinesmsUpdateSiteCode: TWideStringField;
    QryprocStowAwayID: TIntegerField;
    QryprocStowAwayGlobalRef: TWideStringField;
    QryprocStowAwayProctreeStowId: TIntegerField;
    QryprocStowAwayEmployeeID: TIntegerField;
    QryprocStowAwayEmployeeName: TWideStringField;
    QryprocStowAwayStowAwayDate: TDateTimeField;
    QryprocStowAwayQty: TFloatField;
    QryprocStowAwayUOMID: TIntegerField;
    QryprocStowAwayUOMMult: TFloatField;
    QryprocStowAwayUOM: TWideStringField;
    QryprocStowAwayUOMQty: TFloatField;
    QryprocStowAwaymsTimeStamp: TDateTimeField;
    QryprocStowAwaymsUpdateSitecode: TWideStringField;
    QryProcTreeStowID: TIntegerField;
    QryProcTreeStowGlobalRef: TWideStringField;
    QryProcTreeStowProcTreeId: TIntegerField;
    QryProcTreeStowDateCreated: TDateTimeField;
    QryProcTreeStowTotalStowedQty: TFloatField;
    QryProcTreeStowExtraQtyToCustomer: TFloatField;
    QryProcTreeStowExtraQtytoStore: TFloatField;
    QryProcTreeStowmsTimeStamp: TDateTimeField;
    QryProcTreeStowmsUpdateSiteCode: TWideStringField;
    Qryproctree: TERPQuery;
    dsproctree: TDataSource;
    QryproctreeproctreeId: TIntegerField;
    QryproctreeManufactureQty: TFloatField;
    QryproctreeManufactureUOMQty: TFloatField;
    QryproctreeTreePartUOM: TWideStringField;
    QryproctreeTreePartUOMID: TLargeintField;
    QryproctreeTreePartUOMMultiplier: TFloatField;
    Qryproctreeisinternalorder: TWideStringField;
    QryproctreeUOM: TWideStringField;
    btnNew: TDNMSpeedButton;
    QryprocStowAwayDeleted: TWideStringField;
    QryprocStowawayLinesDeleted: TWideStringField;
    cboEmployeeLookup: TERPQuery;
    QryprocStowawayLinesProctreeStowId: TIntegerField;
    grdmain: TwwDBGrid;
    wwIButton1: TwwIButton;
    cboEmployee: TwwDBLookupCombo;
    cboUnitOfMeasure: TwwDBLookupCombo;
    Label4: TLabel;
    lblExtraforcustomer: TLabel;
    edtExtraforcustomer: TwwDBEdit;
    Label6: TLabel;
    wwDBEdit4: TwwDBEdit;
    Bevel2: TBevel;
    Label2: TLabel;
    lblDefaultUOM: TLabel;
    QryprocStowAwayCUOM: TStringField;
    lblLinesMsg: TLabel;
    grdLines: TwwDBGrid;
    btnDeleteGridLine: TwwIButton;
    btnPrint: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdmainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure wwIButton1Click(Sender: TObject);
    procedure btnDeleteGridLineClick(Sender: TObject);
    procedure grdmainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure QryproctreeAfterOpen(DataSet: TDataSet);
    procedure QryprocStowAwayCalcFields(DataSet: TDataSet);
    procedure grdmainEnter(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
  private
    fiProctreeId: Integer;
    ProctreeStow :TProctreeStow;
    fiStowAwayID: Integer;

    procedure Showlines;
    procedure ShowStowAwayDetails;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;

  public
    Property ProctreeId :Integer read fiProctreeId Write fiProctreeId;
    Property StowAwayID :Integer read fiStowAwayID write fiStowAwayID;
    Class Function DoStow(fProctreeID:Integer; var Msg:String):boolean;
  end;


implementation

uses CommonLib, BusObjConst, CommonDbLib,  tcConst, tcDataUtils, AppEnvironment;

{$R *.dfm}

procedure TfmStowAway.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmStowAway.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if not ProctreeStow.save then exit;
  ProctreeStow.Connection.CommitTransaction;
  ProctreeStow.Dirty:= False;
  Self.close;
end;

procedure TfmStowAway.btnDeleteClick(Sender: TObject);
begin
  inherited;
  ProctreeStow.StowAways.Lines.Deleted := True;
  ProctreeStow.StowAways.Lines.PostDb;
end;

procedure TfmStowAway.btnDeleteGridLineClick(Sender: TObject);
begin
  inherited;
  ProctreeStow.StowAways.Lines.deleted := true;
  ProctreeStow.StowAways.Lines.postDB;
end;

procedure TfmStowAway.btnNewClick(Sender: TObject);
begin
  inherited;
  try
    ProctreeStow.StowAways.postDB;
    if ProctreeStow.StowAways.ID <>0 then
      if not ProctreeStow.StowAways.ValidateData then exit;
    ProctreeStow.StowAways.PostDB;

    SetcontrolFocus(grdmain);
    ProctreeStow.StowAways.New;
    ProctreeStow.StowAways.PostDB;

    ShowLines;
    SetcontrolFocus(grdLines);
    grdLines.SetActiveField('UOM');
  finally
    ProctreeStow.StowAways.Resultstatus.Clear;
  end;
end;
procedure TfmStowAway.btnPrintClick(Sender: TObject);
var
  strSQL:String;
begin
  inherited;
  strSQL := '~|||~where PT.proctreeId = ' + inttostr(ProctreeID);
  ReportToPrint :=tcdatautils.GetDefaultReport(GetReportTypeIDForTypeName('Stow Away'));
  if ReportToPrint = '' then ReportToPrint := 'Stow Away';
  fbReportSQLSupplied := False;
  PrintTemplateReport(ReportToPrint , StrSQL , False , 1);

  (*'{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, '+
            ' CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO '+
            ' ~|||~{details}Select s.sAleId, S.CustomerName , S.saleDate, '+
            ' SL.productname, SL.UnitofMeasureQtySold , SL.UnitofMeasureShipped , SL.UnitofMeasureBackorder, '+
            ' concat(SL.UnitofMeasureSaleLines , " (" , SL.UnitofMeasureMultiplier , ")") SaleSUOM, '+
            ' PT.caption , '+
            ' Convert(TreeNodeCaption(PT.Level, PT.caption ) ,char(255)) as Linecaption, '+
            ' concat(PT.treepartuom  , " (" , PT.treepartuommultiplier , ")") as uomdetail, '+
            ' PT.ManufactureUOMQty , PT.FromStockUOMQty , Pt.OnOrderUOMQty , '+
            ' PS.ID stowAwayID, '+
            ' PS.EmployeeName , '+
            ' PS.StowAwayDate , '+
            ' PS.UOMQty stowedQty, '+
            ' concat(PSL.UOM , " (" , PSL.UOMMult, ")") as StowedUOM , '+
            ' PSL.UOMQty, '+
            ' PSL.Qty, '+
            ' PTS.ExtraQtyToCustomer, PTS.ExtraQtytoStore '+
            ' from '+
            ' tblsales S '+
            ' inner join tblsaleslines SL on S.SaleId = SL.saleID '+
            ' inner join tblProcTree PT on PT.masterID = Sl.saleLineId and PT.mastertype <> "mtProduct" and parentId =0 '+
            ' Left join  (tblproctreestow PTS  inner join tblprocstowaway PS on PTS.id = PS.ProctreeStowId   '+
            ' inner join tblprocstowawaylines PSL on PS.ID = PSL.StowAwayID and ifnull(PSL.Qty,0)<> 0)on PT.proctreeId = PTS.proctreeId';*)

end;

Procedure TfmStowAway.Showlines;
begin
  if grdLines.visible = False then
    grdLines.visible := True;
  if lblLinesMsg.Visible then
    lblLinesMsg.Visible := False;
end;
procedure TfmStowAway.DoBusinessObjectEvent(const Sender: TDatasetBusObj;  const EventType, Value: string);
begin
    inherited ;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
           if Sender is TProctreeStow       then TProctreeStow(Sender).Dataset      := QryProcTreeStow
      else if Sender is Tprocstowaway       then Tprocstowaway(Sender).Dataset      := QryprocStowAway
      else if Sender is Tprocstowawaylines  then Tprocstowawaylines(Sender).Dataset := QryprocStowawayLines;
    end else if  (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_StowedQty) then begin
      grdmain.Columnbyname('UOMQty').FooterValue := FloatToStrf(divzer(ProctreeStow.TotalStowedQty , ProctreeStow.proctree.TreePartUOMMultiplier), ffGeneral, 15,2);
      grdmain.Columnbyname('cUOM').FooterValue := 'Total Finished';
    end else if  (Eventtype = BusObjEvent_Change) and (Value = BusObjEvent_OnDataIDChange) then begin
      if Screen.ActiveControl =grdmain then begin
        grdmain.UnselectAll;
        grdmain.SelectRecord;
      end;
    end;
end;

class Function TfmStowAway.DoStow(fProctreeID: Integer; var Msg:String):Boolean;
begin
  REsult:= False;
  with TEmpMyQuery do try
    SQl.Add('select PT.ProcTreeId , PT.ParentId, PT.TreeRootId , PT.ManufactureQty, partsId');
    SQL.add('from tblproctree PT where proctreeId =  ' +inttostr(fProctreeId));
    open;
    if recordcount =0 then begin
        Msg:= 'Tree node not found';
        exit;
    end;
    if (Fieldbyname('ParentID').AsInteger <>0) or
       (fieldbyname('TReerootID').AsInteger <> fieldbyname('ProctreeID').AsInteger) then begin
        Msg:= 'Tree node is not a Root node';
        exit;
    end;

    if fieldbyname('ManufactureQty').asFloat =0 then begin
        Msg:= 'Tree node is not Manufacturing anything ';
        exit;
    end;
    if fieldbyname('partsId').AsInteger =0 then begin
        Msg:= 'Tree node is not a product node ';
        exit;
    end;
    with TfmStowAway.Create(Application) do begin
      ProctreeId := fProctreeId;
      Showmodal;
      Result:= True;
    end;
  finally
    closenFree;
  end;
end;

procedure TfmStowAway.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;

procedure TfmStowAway.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  CanClose := false;
  if ProctreeStow.dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if ProctreeStow.Save then begin
            ProctreeStow.connection.CommitTransaction;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          ProctreeStow.connection.RollbackTransaction;
          ProctreeStow.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          btnClose.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;
end;

procedure TfmStowAway.FormCreate(Sender: TObject);
begin
  inherited;
  fbTabSettingEnabled := false;
  fiProctreeId:= 0;
  fiStowAwayID:= 0;
  ProctreeStow :=TProctreeStow.Create(Self);
  ProctreeStow.Connection := TMyDacDataConnection.Create(ProctreeStow);
  ProctreeStow.Connection.Connection := self.MyConnection;
  ProctreeStow.BusObjEvent := DoBusinessObjectEvent;
  lblDefaultUOM.Caption := ' as ' + AppEnv.DefaultClass.DefaultUOM;
  lblLinesMsg.Caption := 'Please Select a Record in'+NL+'''Finished Quantities'''+NL+'to Add/Edit/View the'+NL+'''Stow Away'''+NL+'details ''.';
  Setcontrolfocus(btnClose);
end;

procedure TfmStowAway.FormDestroy(Sender: TObject);
begin
  FreeandNil(ProctreeStow);
  inherited;

end;

procedure TfmStowAway.FormShow(Sender: TObject);
begin
  inherited;
  ProctreeStow.connection.begintransaction;
  ProctreeStow.LoadSelect('ProctreeId = ' + inttostr(ProctreeID));

  if ProctreeStow.count =0 then begin
    ProctreeStow.New;
    ProctreeStow.ProctreeId := ProctreeId;
    ProctreeStow.PostDB;
    ProctreeStow.Proctree;
  end;
  ProctreeStow.Proctree;
  if ProctreeStow.stowaways.Count =0 then begin
    ProctreeStow.stowaways.New;
    ProctreeStow.stowaways.PostDB;
  end;
  ProctreeStow.stowaways.Lines;
  qryUnitOfMeasure.ParamByName('xPartID').AsInteger :=ProctreeStow.Proctree.PartsId;
  Qryproctree.parambyname('ProctreeId').asInteger := ProctreeId;
  openQueries;
  if StowAwayID <> 0 then
    ProctreeStow.stowaways.Locate(ProctreeStow.stowaways.IDFieldName, StowAwayID , []);

  grdmain.Columnbyname('UOMQty').FooterValue := FloatToStrf(divzer(ProctreeStow.TotalStowedQty , ProctreeStow.proctree.TreePartUOMMultiplier), ffGeneral, 15,2);
  grdmain.Columnbyname('cUOM').FooterValue := 'Total Finished';
end;

procedure TfmStowAway.grdmainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if SameTExt(Field.fieldname, 'uom') or Sametext(Field.fieldname, 'uomQty') then
    Afont.color := clgray;
end;

procedure TfmStowAway.grdmainEnter(Sender: TObject);
begin
  inherited;
  ShowStowAwayDetails;
end;

procedure TfmStowAway.grdmainMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  ShowStowAwayDetails;
end;
procedure TfmStowAway.ShowStowAwayDetails;
begin
  inherited;
  try
    ProctreeStow.stowaways.PostDB;
    if ProctreeStow.stowaways.ID=0 then exit;
    if ProctreeStow.stowaways.Validateentryfields then begin
      Showlines;
      if ProctreeStow.stowaways.Lines.count =0 then ProctreeStow.stowaways.Lines.New;
    end;
  finally
    ProctreeStow.StowAways.Resultstatus.Clear;
  end;
end;

procedure TfmStowAway.QryprocStowAwayCalcFields(DataSet: TDataSet);
begin
  inherited;
  QryprocStowAwayCUOM.AsString := trim(QryprocStowAwayUOM.AsString )+' (' + FloatToStr(QryprocStowAwayUOMMult.AsFloat) +')';
end;

procedure TfmStowAway.QryproctreeAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if QryproctreeIsInternalOrder.AsBoolean then begin
    lblExtraforcustomer.Enabled := False;
    edtExtraforcustomer.Enabled := False;
  end;
end;

procedure TfmStowAway.wwIButton1Click(Sender: TObject);
begin
  inherited;
  ProctreeStow.stowaways.Deleted := True;
  ProctreeStow.stowaways.PostDB;
end;

initialization
  RegisterClassOnce(TfmStowAway);

end.


