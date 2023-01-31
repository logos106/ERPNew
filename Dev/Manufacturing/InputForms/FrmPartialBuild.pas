unit FrmPartialBuild;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, DBCtrls, Mask, wwdbedit, ActnList, DNMAction,BusObjBase, ProcProgressLib,
  AdvReflectionImage;

type
  TFmPartialBuild = class(TBaseInputGUI)
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    DNMPanel1: TDNMPanel;
    pnlButtons: TDNMPanel;
    qryMain: TERPQuery;
    dsMain: TDataSource;
    grdMain: TwwDBGrid;
    btnGrid: TwwIButton;
    qryMainsaleId: TIntegerField;
    qryMainconverted: TWideStringField;
    qryMainproductNAme: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainisProduct: TWideStringField;
    qryMainparttype: TWideStringField;
    qryMainCaption: TWideStringField;
    qryMainHasChildern: TWideStringField;
    qryMainManufactureUOMQty: TFloatField;
    qryMainFromStockUOMQty: TFloatField;
    qryMainOnOrderUOMQty: TFloatField;
    qryMainproctreeId: TIntegerField;
    qryMainManufacturedUOMQty: TFloatField;
    qryMainManufacturingUOMQty: TFloatField;
    splMultiSelectList: TSplitter;
    pnlDetails: TDNMPanel;
    qryMainCanBuild: TWideStringField;
    pnlQty: TDNMPanel;
    lblQtytoBeinvoiced: TLabel;
    edtUOMQty: TEdit;
    DBText1: TDBText;
    qryMainPTcaption: TWideStringField;
    Label1: TLabel;
    wwDBEdit1: TwwDBEdit;
    c: TActionList;
    actclose: TDNMAction;
    actSave: TDNMAction;
    actAllocate: TDNMAction;
    qryMainIsroot: TWideStringField;
    qryMainIsInternalOrder: TWideStringField;
    qryMainToBeBuilt: TFloatField;
    lblTimerMsg: TLabel;
    TitleLabel: TLabel;
    qryMainSaleLineID: TIntegerField;
    pnlChooseRpt: TDNMPanel;
    chkChooseRpt: TCheckBox;
    AdvReflectionImage1: TAdvReflectionImage;
    qryMaindescription: TWideStringField;
    qryMainProcessstep: TWideStringField;
    chkPrintReport: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure edtUOMQtyEnter(Sender: TObject);
    procedure qryMainAfterScroll(DataSet: TDataSet);
    procedure actcloseExecute(Sender: TObject);
    procedure actAllocateExecute(Sender: TObject);
    procedure actSaveUpdate(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    fiSaleLineId: Integer;
    fiProcTreeID: Integer;
    fiEmployeeID: Integer;
    procedure ReadGuiprefs; virtual;
    Procedure SaveGuiprefs; virtual;
    procedure SetSaleLineID(const Value: Integer);
    procedure SetProcTreeID(const Value: Integer);
    Procedure Makebuttons;
    Procedure RefreshQuery;
    function TobuildQty :Double;
    procedure DoOnItemSelect;
    procedure Clearselection;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string); override;
    procedure PrintProgressBuild(aProcProgID: integer);
    procedure MakeQrymain;
    procedure CheckGridWidth;
  Protected
    function GetReportTypeID: integer;Override;
  public
    Property SaleLineID:Integer read fiSaleLineId write SetSaleLineID;
    Property ProcTreeID:Integer read fiProcTreeID write SetProcTreeID;
    Property EmployeeID:Integer read fiEmployeeID write fiEmployeeID;

  end;


implementation

uses CommonDbLib, tcConst, ButtonsLib, CommonLib, ImageDLLLib , AdvGlowButton,
  LogLib,  tcDataUtils,
  frmBOMAllocation, Barcodeconst, types, BusobjProctree(*,
  busobjSalesorderInvoice*), BusObjSales , dateutils, AppEnvironment,
  BusObjBOMSalesOrder, BusObjConst, CommonFormLib, ProductQtyLib, PQALib;

{$R *.dfm}

procedure TFmPartialBuild.ReadGuiprefs;
begin
  if GuiPrefs.Node.Exists('Options.FormWidth') then
       Width :=  GuiPrefs.Node['Options.FormWidth'].asInteger
  else Width :=  1100;
  if GuiPrefs.Node.Exists('Options.formheight') then
       Height :=  GuiPrefs.Node['Options.formheight'].asInteger
  else Height :=  570;
  if GuiPrefs.Node.Exists('Options.gridWidth') then
       grdmain.Width :=  GuiPrefs.Node['Options.gridWidth'].asInteger;
  if GuiPrefs.Node.Exists('Options.chkPrintReport') then
       chkPrintReport.checked :=  GuiPrefs.Node['Options.chkPrintReport'].asBoolean
  else chkPrintReport.checked :=  true;
  CheckGridWidth;
end;

procedure TFmPartialBuild.RefreshQuery;
begin
  Closedb(qrymain);
  openqueries;
end;

procedure TFmPartialBuild.SaveGuiprefs;
begin
  GuiPrefs.Node['Options.FormWidth'].asInteger := Width;
  GuiPrefs.Node['Options.formheight'].asInteger := Height;
  GuiPrefs.Node['Options.gridWidth'].asInteger := grdmain.Width;
  GuiPrefs.Node['Options.chkPrintReport'].asBoolean := chkPrintReport.checked;
end;

procedure TFmPartialBuild.edtUOMQtyEnter(Sender: TObject);
begin
  inherited;
  DoOnItemSelect;
end;
procedure TFmPartialBuild.DoOnItemSelect;
begin
  if qrymainHasChildern.asBoolean =False then begin
    TimerMsg(lblTimerMsg , Quotedstr(trim(qrymainptCaption.asString)) +' is a Raw Material. Not to be Built');
    Setcontrolfocus(grdMain);
    Exit;
  end;

  if qrymainToBeBuilt.asFloat =0 then begin
    TimerMsg(lblTimerMsg , Quotedstr(trim(qrymainptCaption.asString))  +' is Built Completely');
    Setcontrolfocus(grdMain);
    Exit;
  end;

end;

procedure TFmPartialBuild.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
  SaveGuiprefs;
end;

procedure TFmPartialBuild.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := true;
  inherited;
  makeQrymain;
end;

procedure TFmPartialBuild.FormResize(Sender: TObject);
begin
  inherited;
  CheckGridWidth;
end;
procedure TFmPartialBuild.FormShow(Sender: TObject);
begin
  inherited;
  RefreshQuery;
  ReadGuiprefs;
  Makebuttons;
  Setcontrolfocus(edtUOMQty);
  BorderStyle := bsSizeable; // make the form reSizeable - so that user can make it wider
  lblTimerMsg.Caption := '';
end;

procedure TFmPartialBuild.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qryMainCanbuild.asBoolean then begin
    Abrush.color := GridColhighLightGreen;
    Afont.color := clBlack;
  end;
end;

procedure TFmPartialBuild.Makebuttons;
var
  fino, fiWidth , fiheight , fiTop :Integer;


  Procedure NewFooterButton(aaction : TDNMAction; fbDefault , fbcancel:Boolean; aModalREsult : Integer);
  begin
    with TERPMainSwitchButton.create(Self) do begin
      UseLargeIcon := False;
      font.size := 9;
      Parent := pnlButtons;
      Width := fiWidth;
      top := fitop;
      Anchors := [akBottom];
      action := aaction ;
      ParentFont := TRue;
      TabOrder := fino-1;
      picture := nil;
      Layout := AdvGlowButton.blGlyphLeft;
      Default := fbDefault;
      Height := fiheight;
      Left := btnLeft(3,width ,fino, pnlButtons) ;
      font.Style := font.Style  + [fsBold];
      dnmaction := aAction ;
      Cancel := fbcancel;
      Layout := AdvGlowButton.blGlyphTop;
      Wordwrap := True;
      ModalResult := aModalREsult;
      onclick := aAction.onexecute;
    end;
    fino := fino +1;
  end;
begin  fino := 1;
  fiWidth   :=100;
  fiheight  := 79;
  fiTop     := trunc((pnlButtons.height - fiheight)/2);

  NewFooterButton(actsave        ,true ,False,mrNone);
  NewFooterButton(actAllocate    ,false,false ,mrnone );
  NewFooterButton(actclose       ,false,TRue ,mrCancel);
end;

procedure TFmPartialBuild.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if ProcTreeID <> 0 then qrymain.locate('ProcTreeID', ProcTreeID , []);
  GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainSaleLineID.fieldname);
  GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainHasChildern.fieldname);
  GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainsaleId.fieldname);
  GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainconverted.fieldname);
  GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainproductNAme.fieldname);
  GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainUOM.fieldname);
  GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainisProduct.fieldname);
  GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainparttype.fieldname);
  GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainproctreeId.fieldname);
  GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainCanBuild.fieldname);
  GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainPTcaption.fieldname);
  GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainIsroot.fieldname);
  GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainIsInternalOrder.fieldname);
end;

procedure TFmPartialBuild.qryMainAfterScroll(DataSet: TDataSet);
begin
  inherited;
  logtext(Floattostr(qrymainToBeBuilt.asFloat));
  DoOnItemSelect;

  if qrymainToBeBuilt.asFloat =0 then begin
    edtUOMQty.text := '';
    Exit;
  end;
  if qrymainToBeBuilt.asFloat >= 1 then begin
    edtUOMQty.text := '1';
  end else begin
    edtUOMQty.text := FloattostrF(qrymainToBeBuilt.asFloat , ffGeneral, 15,2);
  end;
  Setcontrolfocus(edtUOMQty);
end;

procedure TFmPartialBuild.qryMainBeforeOpen(DataSet: TDataSet);
var
  ctr:Integer;
begin
  inherited;
  qrymain.ParamByName('SaleLineID').asInteger := SaleLineId;
  for ctr := 0 to qrymain.fields.count -1 do
    if qrymain.fields[ctr] is TFloatfield then
      TFloatfield(qrymain.fields[ctr]).Displayformat := DOUBLE_FIELD_MASK_BLANK;
end;

procedure TFmPartialBuild.SetSaleLineID(const Value: Integer);
begin
  if fiSaleLineId = Value then exit;

  fiSaleLineId := Value;
  if Value <> 0 then fiProcTreeID := 0;
  if isformshown then begin
    closedb(Qrymain);
    Opendb(Qrymain);
  end;
end;
function TFmPartialBuild.TobuildQty: Double;
begin
  result := 0;
  if edtUOMQty.text = '' then exit;
  if isnumber(edtUOMQty.text) then
    result := StrTofloat(edtUOMQty.text);
end;

procedure TFmPartialBuild.SetProcTreeID(const Value: Integer);
begin
  if fiProcTreeID = Value then exit;

  fiProcTreeID := Value;
  SaleLineID := SaleLineIDofTree(fiProcTreeID);
end;
procedure TFmPartialBuild.actcloseExecute(Sender: TObject);
begin
  inherited;
//
end;
procedure TFmPartialBuild.Clearselection;
begin
  edtUOMQty.text := '';
  SetcontrolFocus(grdmain);
  RefreshQuery;
  //qryMainAfterScroll(qrymain);
end;
procedure TFmPartialBuild.actSaveExecute(Sender: TObject);
var
    BOMSAlesORderObj:TBOMSAlesORder;

    BatchnoFormat :TStringDynArray ;
    SNFormat:TStringDynArray;
    fiProcProgID :Integer;
  begin
    if devmode then begin
      SetLength(BatchnoFormat,2);
      BatchnoFormat[0] := Barcode_Prefix_PQABATCH;
      BatchnoFormat[1] := '[TransCount]';

      SetLength(SNFormat,9);
      SNFormat[0] := Barcode_Prefix_PQASN;
      SNFormat[1] := '[SID]';
      SNFormat[2] := '[SLID]';
      SNFormat[3] := '[PTID]';
      SNFormat[4] := '[ParentRef]';
      SNFormat[5] := '[Seqno]';
      SNFormat[6] := '[TransSeqno]';
      SNFormat[7] := '[Count]';
      SNFormat[8] := '[Transcount]';
    end else begin
      {should have company prefs for user to define this }
      SetLength(BatchnoFormat,0);
      SetLength(SNFormat,0);
    end;

  BOMSAlesORderObj := TBOMSAlesORder.Create(Self);
  BOMSAlesORderObj.connection := TMyDacDataconnection.Create(BOMSAlesORderObj);
  BOMSAlesORderObj.Connection.connection := qrymain.connection;
  BOMSAlesORderObj.BusObjEvent := DoBusinessObjectEvent;
  BOMSAlesORderObj.Load(QrymainsaleID.asInteger);

  if BOMSAlesORderObj.DoPartialbuild(qrymainSalelineID.asInteger, qrymainproctreeId.asInteger, TobuildQty, BatchnoFormat ,SNFormat , fiProcProgID) then begin
      if fiProcProgID <> 0 then
        PrintProgressbuild(fiProcProgID);
      ClearSelection;
  end;
  Setcontrolfocus(edtUOMQty);
  hideTimerMsg;
end;
function TFmPartialBuild.GetReportTypeID: integer;
begin
  Result := 158;
end;
Procedure TFmPartialBuild.PrintProgressBuild(aProcProgID:integer);
var
  fsReportSQL:String;
  fsReportname:String;
begin
  fsReportSQL:= '~|||~Where PPG.ProcProgressID = ' + inttostr(aProcProgID)+' ~|||~Where PPG.InProcProgressId = ' + inttostr(aProcProgID);
  fbReportSQLSupplied := False;
  if chkPrintReport.checked then begin
    fsReportname:= TemplateReportName[chkChooseRpt.checked,''];
    if fsReportname <> '' then
      PrintTemplateReport(fsReportname, fsReportSQL, not AppEnv.Employee.ShowPreview and not devmode, 1);
  end;
end;
procedure TFmPartialBuild.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     if (Sender is TBOMSAlesORder) and (eventtype = BusObjEvent_UserInfoMessage) then begin
        TimerMsg(lblTimerMsg , Value);
     end else if (Sender is TBOMSAlesORder) and (eventtype = BusObjEvent_UserWarningMessage) then begin
        TimerMsg(lblTimerMsg , Value);
     end else if (Sender is TBOMSAlesORder) and (eventtype = BusObjEvent_UserErrorMessage) then begin
        TimerMsg(lblTimerMsg , Value);
     end else inherited;

end;
procedure TFmPartialBuild.actSaveUpdate(Sender: TObject);
var
  fs:String;
begin
  inherited;
  if (qryMainIsroot.asBoolean) and  (not(qryMainIsInternalOrder.asBoolean)) then
       fs := 'MAKE INVOICE'
  else fs :='PLACE IN TO STOCK';
  lblQtytoBeinvoiced.caption:= fs;
  actsave.caption           := fs;
  TitleLabel.caption        := fs;
  self.caption              := fs;
  actSave.enabled := TobuildQty > 0;
end;

procedure TFmPartialBuild.actAllocateExecute(Sender: TObject);
begin
  inherited;
  TfmBOMAllocation.DoAllocation(qrymainSaleId.asInteger, qrymainSalelineID.asInteger, nil);
end;
Procedure TFmPartialBuild.CheckGridWidth;
begin
  if grdmain.Width > self.width - 275 then grdmain.Width := self.width - 275;
end;

Procedure TFmPartialBuild.MakeQrymain;
begin
  Qrymain.SQL.clear;
  Qrymain.SQL.add('SELECT Distinct');
  Qrymain.SQL.add('S.saleId ,');
  Qrymain.SQL.add('SL.SaleLineID,');
  Qrymain.SQL.add('S.converted,');
  Qrymain.SQL.add('SL.productNAme,');
  Qrymain.SQL.add('concat(SL.UnitofMeasureSaleLines , "(", SL.UnitofMeasureMultiplier , ")") AS UOM,');
  Qrymain.SQL.add('if(IFNULL(P.partsID,0) =0 , "F" , "T") AS isProduct ,');
  Qrymain.SQL.add('PT.description, ');
  Qrymain.SQL.add('P.parttype ,');
  Qrymain.SQL.add('TreeNodeCaption(PT.Level, PT.Caption) as Caption,');
  Qrymain.SQL.add('if(IFNULL(PTC.ProctreeId,0) =0 , "F" , "T") AS HasChildern,');
  Qrymain.SQL.add('PT.ManufactureUOMQty ,');
  Qrymain.SQL.add('PT.FromStockUOMQty ,');
  Qrymain.SQL.add('PT.OnOrderUOMQty,');
  Qrymain.SQL.add('PT.proctreeId ,');
  Qrymain.SQL.add('PT.ManufacturedUOMQty ,');
  Qrymain.SQL.add('PT.ManufacturingUOMQty,');
  Qrymain.SQL.add('if (IFNULL(cPT.proctreeid,0)=0 OR IFNULL(Pt.partsID,0)=0 OR IFNULL(Pt.Treerootid,0) = Pt.proctreeid , "" , if(PT.SubBOMProcessOrder ="ASB" , "T", "F")) asb,');
  Qrymain.SQL.add('if (IFNULL(cPT.proctreeid,0)=0 OR IFNULL(Pt.partsID,0)=0 OR IFNULL(Pt.Treerootid,0) = Pt.proctreeid , "" , if(PT.SubBOMProcessOrder ="SB" , "T", "F")) sb,');
  Qrymain.SQL.add('if (IFNULL(cPT.proctreeid,0)=0 OR IFNULL(Pt.partsID,0)=0 OR IFNULL(Pt.Treerootid,0) = Pt.proctreeid , "" , if(PT.SubBOMProcessOrder ="BS" , "T", "F")) bs,');
  Qrymain.SQL.add('if (IFNULL(PTC.ProctreeId,0)<>0 AND IFNULL(P.partsID,0) <>0 AND IFNULL(PT.ManufactureUOMQty,0)- IFNULL(PT.ManufacturedUOMQty,0)>=1 ,"T","F") AS CanBuild,');
  Qrymain.SQL.add('convert(if (IFNULL(PTC.ProctreeId,0)<>0 AND IFNULL(P.partsID,0) <>0 ,IFNULL(PT.ManufactureUOMQty,0)- IFNULL(PT.ManufacturedUOMQty,0) ,0), Decimal) AS ToBeBuilt,');
  Qrymain.SQL.add('Pt.caption as Ptcaption,');
  Qrymain.SQL.add('if(IFNULL(PT.treeRootID,0) = IFNULL(PT.proctreeID,0),"T" , "F" ) AS Isroot,');
  Qrymain.SQL.add('S.IsInternalOrder,');
  Qrymain.SQL.add('(Select Round(' + ProductQtyLib.SQL4Qty( tAvailable ) + ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as AvailableQty from tblPQA as PQA where PQA.ProductID = P.partsID and PQA.departmentId =S.ClassID) as AvailableQty, ');
  Qrymain.SQL.add('(Select Round(' + ProductQtyLib.SQL4Qty( tInStock ) + ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as InStockQty from tblPQA as PQA where PQA.ProductID = P.partsID and PQA.departmentId =S.ClassID) as InStockQty, ');
  Qrymain.SQL.add('(SELECT PS.Description FROM   tblprocesspart PP INNER JOIN tblprocessstep PS ON PP.ProcessStepID = PS.ID where PT.ProctreeId = PP.ProctreeId  ORDER BY Seqno LIMIT 1)  AS Processstep');
  Qrymain.SQL.add('FROM tblSales S');
  Qrymain.SQL.add('inner join tblsaleslines SL  ON SL.SaleId = S.SaleID');
  Qrymain.SQL.add('INNER JOIN tblProctree PT ON SL.SaleLineID = PT.masterID AND PT.MasterType <> "mtProduct"');
  Qrymain.SQL.add('LEFT JOIN tblParts P ON P.partsId = PT.partsID');
  Qrymain.SQL.add('LEFT JOIN tblProcTree PTC ON PT.ProctreeID = PTC.parentID');
  Qrymain.SQL.add('LEFT JOIN tblproctree cPT  ON PT.proctreeId = cPT.parentId');
  Qrymain.SQL.add('Where (SL.SaleLineId = :SaleLineID )');
  Qrymain.SQL.add('ORDER BY PT.sequenceDown');

end;
initialization
  RegisterClassOnce(TFmPartialBuild);

end.
