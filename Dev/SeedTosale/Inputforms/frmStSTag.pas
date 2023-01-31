unit frmStSTag;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmStSInputBase, SelectionDialog, Menus, ExtCtrls, Shader,
  DNMSpeedButton, DNMPanel, StdCtrls,BusObjBase , BusObjSeedToSale, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, frmStSMain, DBCtrls, wwdblook, Mask,
  wwdbedit, Wwdbspin, wwclearbuttongroup, wwradiogroup, ProgressDialog, ImgList,
  AdvMenus, DataState, AppEvnts, wwdbdatetimepicker;

type
  TfmStSTag = class(TfmStSInputBase)
    dsststags: TDataSource;
    qryStSStrains: TERPQuery;
    optStSPhase: TwwRadioGroup;
    qryStSStrainsID: TIntegerField;
    qryStSStrainsStrainName: TWideStringField;
    cboStrainName: TwwDBLookupCombo;
    Label1: TLabel;
    Label3: TLabel;
    wwDBLookupCombo1: TwwDBEdit;
    Label4: TLabel;
    edtPlantcount: TwwDBSpinEdit;
    Label5: TLabel;
    Label6: TLabel;
    dtUsedOn: TwwDBDateTimePicker;
    QryClass: TERPQuery;
    QryClassClassName: TWideStringField;
    QryClassClassID: TIntegerField;
    QryBin: TERPQuery;
    QryBinbinId: TIntegerField;
    QryBinbin: TWideStringField;
    btnHistory: TDNMSpeedButton;
    btnTagActivity: TDNMSpeedButton;
    Label8: TLabel;
    optSourcetype: TwwRadioGroup;
    pnlbin: TDNMPanel;
    lblbin: TLabel;
    cbobin: TwwDBLookupCombo;
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    //procedure qryStSTagProductBeforeOpen(DataSet: TDataSet);
    procedure QryBinBeforeOpen(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnHistoryClick(Sender: TObject);
    procedure btnTagActivityClick(Sender: TObject);
    procedure cbobinEnter(Sender: TObject);
    procedure optStSPhaseExit(Sender: TObject);
  private
    fsCreateForPhase: String;
    fsstsTag:String;
    procedure setCreateForPhase(const Value: String);
    procedure MakeQries;
    procedure initStsTagGrowthHistory(Sender: TObject);
    procedure AssignDefaultBin;
    procedure RefreshbinQty;
  Protected
    procedure SetStSTagObj(const Value: TStSTags);Override;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string); override;
  public
    Property CreateForPhase :String read fsCreateForPhase write setCreateForPhase;
    Property stsTag :String read fsstsTag write fsstsTag;
    constructor Create(Aowner:TComponent;aMyDAcDataconnection : TMyDAcDataconnection;aStSTag:String);Overload;
  end;


implementation

uses BusObjConst, CommonDbLib, CommonLib, LogLib, BusObjSimpleTypes,
  FormFactory, AppEnvironment, BusObjStock, CommonFormLib, StsTagGrowthHistory,
  StsTagActivityLog, tcDataUtils;

{$R *.dfm}

{ TfmStSTag }

procedure TfmStSTag.btnCloseClick(Sender: TObject);
var
  saveoption:Word;
begin
  inherited;
  if Accessmanager.accesslevel >=5 then begin
    //Modalresult := mrOk;
    CloseIt(True);
    Exit;
  end;
  saveoption:= MessageDlgXP_vista('Do you wish To Save The changes? ', mtConfirmation, [mbYes, mbNo,mbCancel], 0);
  if saveoption = mrCancel then exit;
  if saveoption = mrno then begin
    fStSTagObj.CancelDB;
    //RollbackNestedTransaction;
    //Modalresult := mrCancel;
    CloseIt(False);
  end else begin
    btnCompletedClick(nil);
  end;
end;

procedure TfmStSTag.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if Accessmanager.accesslevel >=5 then begin
    //Modalresult := mrOk;
    CloseIt(False);
    Exit;
  end;
  if fStSTagObj.UsedOn =0 then begin
    MessageDlgXP_Vista('Please Provide the Date', mtWarning, [mbOK], 0);
    Setcontrolfocus(dtUsedOn);
    Exit;
  end;
  if Appenv.companyPrefs.StSUsesBins then begin
     if fStSTagObj.binid =0 then begin
          MessageDlgXP_Vista('Please Choose the Bin', mtWarning, [mbOK], 0);
          Setcontrolfocus(cbobin);
          Exit;
     end;
  end;
  fStSTagObj.PostDB;
(*  fStSTagObj.UseTag;
  fStSTagObj.MakePlant(fStSTagObj.Plantcount);
  if not fStSTagObj.Save then exit;*)
  if not fStSTagObj.UseTagnMakePlant then exit;
(*  fStSTagObj.StSTagPhases.New;
  fStSTagObj.StSTagPhases.QtyPerTag := fStSTagObj.Plantcount;
  fStSTagObj.StSTagPhases.NoOfTags := 1;
  fStSTagObj.StSTagPhases.PhaseProductID := fStSTagObj.StSProductID;
  fStSTagObj.StSTagPhases.TagChanged := False;
  fStSTagObj.StSTagPhases.PhaseCreatedOn := fStSTagObj.UsedOn;
  fStSTagObj.StSTagPhases.SMLineID := fStSTagObj.TagProduct_SMLineId;
  fStSTagObj.StSTagPhases.StSPhase := fStSTagObj.StSPhase;
  fStSTagObj.StSTagPhases.PostDB;*)
  //commitNestedTransaction;
  //Modalresult := mrOk;
  StSTagID := fStSTagObj.ID;
  CloseIt(true);
end;

procedure TfmStSTag.btnHistoryClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormModal('TStsTagGrowthHistoryGUI', nil, initStsTagGrowthHistory, nil, false);
end;
procedure TfmStSTag.btnTagActivityClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormModal('TStsTagActivityLogGUI', nil, initStsTagGrowthHistory, nil, false);
end;

procedure TfmStSTag.initStsTagGrowthHistory(Sender: TObject);
begin
  if sender is TStsTagGrowthHistoryGUI then begin
    TStsTagGrowthHistoryGUI(Sender).HistoryOfTagId := fStSTagObj.ID;
  end else   if sender is TStsTagActivityLogGUI then begin
    TStsTagActivityLogGUI(Sender).HistoryOfTagId := fStSTagObj.ID;
  end;
end;
procedure TfmStSTag.cbobinEnter(Sender: TObject);
begin
  inherited;
  RefreshbinQty;
end;

constructor TfmStSTag.Create(Aowner: TComponent;aMyDAcDataconnection: TMyDAcDataconnection; aStSTag: String);
begin
  Create(Aowner, aMyDAcDataconnection);
  StSTag := aStSTag;
end;

procedure TfmStSTag.DoBusinessObjectEvent(const Sender: TDatasetBusObj;
  const EventType, Value: string);
begin
  inherited;
  if (EventType = BusObjEvent_Change) And (value =  BusObjEvent_StSTAgClassChanged) and (Sender is TStSTags) then begin
    if not QryClass.Locate('ClassId', TStSTags(sender).DeptId, []) then begin
      QryClass.First;
      TStSTags(sender).Dept   := QryClass.fieldbyname('ClassName').asString;
      TStSTags(sender).DeptId := QryClass.fieldbyname('ClassID').asInteger;
    end;
  end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventVal_StsPhaseChanged) then begin
    AssignDefaultBin;
  end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventVal_DeptChanged) then begin
    AssignDefaultBin;
  end;
end;

procedure TfmStSTag.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;

procedure TfmStSTag.FormCreate(Sender: TObject);
begin
  inherited;
  MakeQries;
  cbobin.visible := true;
  lblbin.visible := true;
  pnlbin.visible := Appenv.companyPrefs.StSUsesBins;
end;
procedure TfmStSTag.MakeQries;
    function StSPackageTagProductID:Integer;
    begin
      Result := TProduct.IDToggle(Appenv.companyprefs.StSPackageTagProduct);
    end;
    function StSPlantTagProductID:Integer;
    begin
      Result := TProduct.IDToggle(Appenv.companyprefs.StSPlantTagProduct);
    end;
begin
  (*closedb(qryStSTagProduct);
  qryStSTagProduct.SQL.text := 'SELECT distinct pqa.productname, pqa.productID , pqa.uomid, pqa.uom , pqa.departmentid ' +
                               ' FROM tblpqadetails PQASN ' +
                               ' INNER JOIN tblpqa pqa ON pqasn.pqaid = pqa.pqaid  ' +
                               ' AND productId IN (' + inttostr(StSPackageTagProductID)+',' + inttostr(StSPlantTagProductID)+') ' +
                               ' WHERE PQASN.PQAType ="SN" ' +
                               ' AND pqasn.value = :StSTag ' ;*)
  //logtext(qryStSTagProduct.SQL.text );
end;
procedure TfmStSTag.optStSPhaseExit(Sender: TObject);
begin
  inherited;
  AssignDefaultBin;
end;

procedure TfmStSTag.FormShow(Sender: TObject);
begin
(*  if fStSTagObj =nil then
    fStSTagObj := TStSTags.StSTagrec(self, stsTag, MyDAcDataconnection,DoBusinessObjectEvent);*)
  StSTagObj; // Create and load the busobj
  dsststags.dataset := fStSTagObj.dataset;
  //if fStSTagObj.CleasSMCreated then begin
  if fStSTagObj.CleanStsPhase <> '' then begin
    Accessmanager.accesslevel := 5;
    Self.caption := 'Tag already Assigned, It is not Possible To Edit it';
    SetControlfocus(btnClose);
  end;
  inherited;
  OpenQueries;
  if (stsTag<> '') and (fStSTagObj.count =0) then begin
    fStSTagObj.New;
    fStSTagObj.StSTag := fsstsTag;
    (*if qryStSTagProduct.recordcount >0 then begin
      qryStSTagProduct.First;
      fStSTagObj.TagProductID:= qryStSTagProductproductID.asInteger;
      fStSTagObj.UOMID       := qryStSTagProductuomid.asInteger;
      fStSTagObj.Deptid      := qryStSTagProductdepartmentId.asinteger;
      AssignDefaultBin;
    end;*)
    fStSTagObj.PostDB;
  end;
end;
procedure TfmStSTag.AssignDefaultBin;
begin
      if Appenv.companyPrefs.StSUsesBins and (fStSTagObj.Deptid<>0) then begin
        if (fStSTagObj.BinId =0) and (fStSTagObj.StSProductID<>0) then fStSTagObj.BinId := DefaultBinId(fStSTagObj.Deptid ,fStSTagObj.StSProductID);
        if (fStSTagObj.BinId =0) then fStSTagObj.BinId := DefaultStsClassBinId(fStSTagObj.Deptid);
        RefreshbinQty;
      end;
end;
Procedure TfmStSTag.RefreshbinQty;
begin
  closedb(QryBin);
  opendb(QryBin);
end;
procedure TfmStSTag.QryBinBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  QryBin.parambyname('ClassID').asInteger := fStSTagObj.DeptID;
end;

(*procedure TfmStSTag.qryStSTagProductBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryStSTagProduct.Parambyname('StSTag').asString := fsStSTag;
end;*)


procedure TfmStSTag.setCreateForPhase(const Value: String);
begin
  fsCreateForPhase := Value;
  if value <> '' then begin
    optStSPhase.Value := Value;
    optStSPhase.Enabled := optStSPhase.Itemindex >=0;
  end;
end;

procedure TfmStSTag.SetStSTagObj(const Value: TStSTags);
begin
  inherited;
  dsststags.dataset := Value.dataset;
end;

(*procedure TfmStSTag.cboStsRoomsNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  Accept := False;
  If CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', MtConfirmation, [MbYes, MbNo], 0) = MrYes Then Begin
    If TfmSimpleTypes.DoSimpleTypesAddNew(SimpleTypes_StSRoom, NewValue) Then Begin
      Accept := True;
      LookupTable.Refresh;
    End;
  End;

end;*)
initialization
  RegisterClassOnce(TfmStSTag);
  with FormFact do begin
    RegisterMe(TfmStSTag, 'TStSTagsGUI_*=TagID');
  end;
end.
