unit frmHirePlanner;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, Planner, {DBPlanner,} ComCtrls, DNMSpeedButton,
  Shader, DNMPanel, ConTnrs, HireClasses, frmHireGroups;

type

//  THireLineList = class;
//  THireLineRec = class;
  TfmHirePlanner = class(TBaseInputGUI)
    pnlTop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlButton: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    dtStart: TDateTimePicker;
    rgPeriod: TRadioGroup;
    btnPrev: TButton;
    btnNext: TButton;
    planHire: TPlanner;
    rgMode: TRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure dtStartChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rgPeriodClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure planHireItemText(Sender: TObject; PlannerItem: TPlannerItem;
      var Text: string);
    procedure planHireItemMoving(Sender: TObject; Item: TPlannerItem;
      DeltaBegin, DeltaPos: Integer; var Allow: Boolean);
    procedure planHireItemSizing(Sender: TObject; Item: TPlannerItem;
      DeltaBegin, DeltaEnd: Integer; var Allow: Boolean);
    procedure planHireItemDelete(Sender: TObject; Item: TPlannerItem);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdCloseClick(Sender: TObject);
    procedure planHireItemDblClick(Sender: TObject; Item: TPlannerItem);
    procedure rgModeClick(Sender: TObject);
    procedure planHirePlannerMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    fHireID: integer;
    HireLineList: THireLineList;
    ClientId: integer;
    ClientName: string;
    fItemSizing: boolean;
    procedure LoadAssets;
    procedure LoadItems;
    function PosForAssetId(aAssetId: integer): integer;
    function AssetIdForPos(aPosId: integer): integer;
    function AssetDescForPos(aPosId: integer): string;
    procedure UpdateTimeFrame;
    procedure SetPlannerMode;
    function SaveData: boolean;
    procedure UpdateLinked(SelectedRec: THireLineRec);
    function PosByLineId(ALineId : integer) : integer;
    function PosByAssetNameSummary(const aAssetName : string) : integer;
    function PosByAssetId(AAssetId : integer) : integer;
    function PosForAssetIdFixLineId(aAssetId : integer; aHireLineId : integer) : integer;
    function ItemExists(aHireLineId : integer; AAssetId : integer) : boolean;
    procedure SetHireID(const Value: integer);
    procedure ProcessMultiple(PlannerItem: TPlannerItem);
    procedure Times(var dtFrom, dtTo : TDateTime);
    function ExtraDetails : boolean;
    function Details : boolean;
    function Summary : boolean;
    procedure Reload;
    procedure LoadAssetsSummary(qry : TERPQuery);
    property ItemSizing : boolean read fItemSizing write fItemSizing;
  public
    property HireID: integer read fHireID write SetHireID;
  end;



//var
//  fmHirePlanner: TfmHirePlanner;

implementation

uses
 DNMExceptions, DateUtils, DbSharedObjectsObj, MySQLConst, CommonLib,
 frmHireCustomerSelect, BusObjHire, BusObjBase, CommonFormLib, AppEnvironment,
 BusObjFixedAsset;

{$R *.dfm}

const
  // Modes
  csExtraDetails = 0;
  csDetails = 1;
  csSummary = 2;

function TfmHirePlanner.AssetDescForPos(aPosId: integer): string;
begin
  result := planHire.Header.Captions[aPosId+1];
end;

function TfmHirePlanner.AssetIdForPos(aPosId: integer): integer;
begin
//  result := Integer(planHire.Header.Captions.Objects[aPosId+1]);
  if TPlannerSet(planHire.Header.Captions.Objects[aPosId + 1]).Count = 1 then
    Result := TPlannerSet(planHire.Header.Captions.Objects[aPosId + 1])[0]
  else
    Result := -1;
end;



procedure TfmHirePlanner.btnNextClick(Sender: TObject);
begin
  inherited;
  if rgPeriod.ItemIndex = 2 then
    dtStart.Date := IncMonth(dtStart.Date, 1)
  else
    dtStart.Date := IncDay(dtStart.Date, 1);
  UpdateTimeFrame;
//  LoadItems;
  Reload;
end;

procedure TfmHirePlanner.btnPrevClick(Sender: TObject);
begin
  inherited;
  if rgPeriod.ItemIndex = 2 then
    dtStart.Date := IncMonth(dtStart.Date, -1)
  else
    dtStart.Date := IncDay(dtStart.Date, -1);
  UpdateTimeFrame;
//  LoadItems;
  Reload;
end;

procedure TfmHirePlanner.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmHirePlanner.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if SaveData then begin
    CommitTransaction;
//    if HireId > 0 then
//      OpenERPForm('TfmHire',HireID);
    Close;
  end;
end;

function TfmHirePlanner.Details: boolean;
begin
  Result := rgMode.ItemIndex = csDetails;
end;

procedure TfmHirePlanner.dtStartChange(Sender: TObject);
begin
  inherited;
  UpdateTimeFrame;
  LoadItems;
end;

function TfmHirePlanner.ExtraDetails: boolean;
begin
  Result := rgMode.ItemIndex = csExtraDetails;
end;

procedure TfmHirePlanner.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmHirePlanner.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  CanClose := false;
  if HireLineList.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveData then begin
            CommitTransaction;
            CanClose := true;
            if HireID > 0 then
              OpenERPForm('TfmHire',HireID);
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
    if HireID > 0 then
      OpenERPForm('TfmHire',HireID);
  end;
end;

procedure TfmHirePlanner.FormCreate(Sender: TObject);
begin
  inherited;
  HireLineList := THireLineList.Create;
  fHireID := 0;
  ClientId := 0;
  ClientName := '';
end;

procedure TfmHirePlanner.FormDestroy(Sender: TObject);
begin
  inherited;
  HireLineList.Free;
end;

procedure TfmHirePlanner.FormShow(Sender: TObject);
var
  qry: TERPQuery;
begin
  DisableForm;
  try
    try
    (*@@@@
      if HireId = 0 then
      begin
        rgMode.Enabled := false;
      end;
    *)
      inherited;
      OpenQueries();

      RollbackTransaction;

      BeginTransaction;

      if HireId > 0 then begin
        qry := DbSharedObj.GetQuery(MyConnection);
        try
          qry.SQL.Add('select tblHire.HireID,');
          qry.SQL.Add('tblHire.CustomerName,');
          qry.SQL.Add('Cast((select Min(ifnull(tblhirelines.ActualHireFrom,tblhirelines.HireFrom)) from tblhirelines where tblhirelines.HireID = tblhire.HireID and tblhirelines.Deleted = "F") as DateTime) as FirstDate');
          qry.SQL.Add('from tblHire');
          qry.SQL.Add('where HireID = ' + IntToStr(HireID));
          qry.Open;
          planHire.Caption.Title := '<b>#'+qry.FieldByName('HireId').AsString + ' ' + qry.FieldByName('CustomerName').AsString +'</b>';
          if not qry.FieldByName('FirstDate').ISNull then
            dtStart.DateTime := Trunc(qry.FieldByName('FirstDate').AsDateTime)
          else
            dtStart.DateTime := Date;
          rgPeriod.ItemIndex := 1;
        finally
          DbSharedObj.ReleaseObj(qry);
        end;
      end
      else begin
        dtStart.DateTime := Date;
      end;

      WindowState := wsMaximized;

      SetPlannerMode;
      LoadAssets;
      LoadItems;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

function TfmHirePlanner.ItemExists(aHireLineId: integer; AAssetId : integer): boolean;
var
  idx : integer;
begin
  for idx := 0 to planHire.Items.Count - 1 do
    if (planHire.Items[idx].ID = aHireLineId) and
    TPlannerSet(planHire.Header.Captions.Objects[planHire.Items[idx].ItemPos+1]).Exists(AAssetId) then
    begin
      Result := true;
      exit;
    end;
  Result := false;

end;

procedure TfmHirePlanner.LoadAssets;
const
(*
  csSummaryQryTop = 'select'#13#10+
                 'FA.AssetId, FA.AssetName, FA.AssetCode,'#13#10+
                 'HLA.HireLineId,'#13#10+
                 'HL.HireId'#13#10+
                 'from tblFixedAssets FA'#13#10+
                 'left join tblAssetHire AH on AH.AssetId=FA.AssetId'#13#10+
                 'left join tblHireLineAsset HLA on HLA.AssetId = FA.AssetId'#13#10+
                 'left join tblHireLines HL on HL.HireLineId = HLA.HireLineId'#13#10+
                 'where'#13#10;
  csSummaryQryMiddle = '(HL.HireId=%d or HL.HireId is null) and'#13#10;
  csSummaryQryBottom = 'AH.Active="T" order by AssetName';
  *)
  (*
  csQry =  'select FA.AssetID,FA.AssetName,FA.AssetCode,HL.HireId,HL.HireLineId'#13#10 +
           'from tblHireLines HL inner join tblHireLineAsset HLA on HLA.HireLineID=HL.HireLineId'#13#10 +
           'inner join tblFixedAssets FA ON FA.AssetId = HLA.AssetId where HL.HireId=%d'#13#10 +
           'union all'#13#10 +
           'select distinct(FA.AssetID),FA.AssetName,FA.AssetCode,NULL as HireId, NULL as HireLineId'#13#10 +
           'from tblFixedAssets FA'#13#10 +
           'inner join tblHireLineAsset HLA on HLA.AssetId=FA.AssetId'#13#10+
           'inner join tblAssetHire AH on AH.AssetId=FA.AssetId'#13#10+
           ' left join tblHireLines HL on HL.AssetId = FA.AssetId'#13#10+
           'where HL.HireId <> %d or HL.HireId is null'#13#10+
           'order by assetname, assetcode';
*)
  csQryPlan =
           'select distinct FA.AssetID,FA.AssetName,FA.AssetCode,NULL as HireId, NULL as HireLineId'#13#10 +
           'from tblFixedAssets FA'#13#10 +
           'inner join tblAssetHire AH on AH.AssetId=FA.AssetId'#13#10 +
           'left join tblHireLines HL on HL.AssetId = FA.AssetId'#13#10 +
           'order by assetname, assetcode';

  csQry =  'select distinct(FA.AssetID), FA.AssetName,FA.AssetCode,HL.HireId,HL.HireLineId'#13#10 +
           'from tblHireLines HL inner join tblHireLineAsset HLA on HLA.HireLineID=HL.HireLineId'#13#10 +
           'inner join tblFixedAssets FA ON FA.AssetId = HLA.AssetId'#13#10 +
           'where HL.HireId=%d'#13#10 +
           'union'#13#10 +
           'select'#13#10 +
           'distinct(FA.AssetID),'#13#10 +
           'FA.AssetName,'#13#10 +
           'FA.AssetCode,'#13#10 +
           'NULL as HireId, NULL as HireLineId'#13#10 +
           'from tblFixedAssets FA'#13#10 +
           'inner join tblAssetHire AH on AH.AssetId=FA.AssetId'#13#10 +
           ' left join tblHireLines HL on HL.AssetId = FA.AssetId'#13#10 +
           '  where (HL.HireId <> %d or HL.Hireid is null)'#13#10 +
           '  and AH.Active="T"'#13#10+
           '  and FA.AssetId not in'#13#10 +
           '(select FA.AssetID'#13#10 +
           'from tblHireLines HL inner join tblHireLineAsset HLA on HLA.HireLineID=HL.HireLineId'#13#10 +
           'inner join tblFixedAssets FA ON FA.AssetId = HLA.AssetId'#13#10 +
           'where HL.HireId=%d) order by AssetName, AssetCode';
var
  qry: TERPQuery;
  idx : integer;
  lSet : TPlannerSet;
//  dtFrom, dtTo : TDateTime;
//  sFrom, sTo : string;
begin
  planHire.Header.Captions.Clear;
  planHire.Header.Captions.AddObject('Items',nil);
  qry := DbSharedObj.GetQuery(MyConnection);
  try
    if Summary then
    begin
      LoadAssetsSummary(qry);
      Exit;
    end;

    qry.SQL.Text := Format(csQry, [HireId, HireId, HireId]);
    qry.Open;
    while not qry.Eof do
    begin
        if ExtraDetails then
        begin
          lSet := TPlannerSet.Create(0, qry.FieldByName('AssetName').AsString); //qry.FieldByName('HireLineId').asInteger);
          lSet.Add(qry.FieldByName('AssetID').AsInteger);
          planHire.Header.Captions.AddObject(qry.FieldByName('AssetName').AsString + #13#10 +
            qry.FieldByName('AssetCode').AsString, lSet);
        end
        else
        begin
          if qry.FieldByName('HireLineId').isNull then
          begin // Free item
            lSet := TPlannerSet.Create(0, qry.FieldByName('AssetName').AsString);
            lSet.Add(qry.FieldByName('AssetID').AsInteger);
            planHire.Header.Captions.AddObject(qry.FieldByName('AssetName').AsString + #13#10 +
                qry.FieldByName('AssetCode').AsString, lSet);
          end
          else
          begin
              idx := PosByLineId(qry.FieldByName('HireLineId').AsInteger);
              if idx = -1 then
              begin
                lSet := TPlannerSet.Create(qry.FieldByName('HireLineId').asInteger, qry.FieldByName('AssetName').AsString);
                lSet.Add(qry.FieldByName('AssetID').AsInteger);
                planHire.Header.Captions.AddObject(qry.FieldByName('AssetName').AsString + #13#10 + qry.FieldByName('AssetCode').AsString, lSet)
              end
              else
              begin
                lSet := TPlannerSet(planHire.Header.Captions.Objects[idx]);
                lSet.Add(qry.FieldByName('AssetId').AsInteger);
                planHire.Header.Captions[idx] := qry.FieldByName('AssetName').AsString + #13#10'(' + IntToStr(lSet.Count) + ' Items)';
              end;
          end;
        end;
        qry.Next;
      end;
    qry.Close;
    qry.SQL.Clear;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
  planHire.Positions := planHire.Header.Captions.Count -1;
end;

procedure TfmHirePlanner.LoadAssetsSummary(qry: TERPQuery);
const
  csSummary =
  (*
           'select FA.AssetId, FA.AssetName, FA.AssetCode, HL.HireId, HL.HireLineId'#13#10 +
           'from tblFixedAssets FA'#13#10 +
           'inner join tblAssetHire AH on AH.AssetId = FA.AssetId'#13#10 +
           'left join tblHireLines HL on HL.AssetId = AH.AssetId'#13#10 +
           'left join tblHireLineasset HLA on hla.HireLineId = hl.HireLineId'#13#10+
           'where  HL.Deleted = "F" and ('#13#10 +
           '  (ifnull(HL.ActualHireFrom,HL.HireFrom) >= "%s" and ifnull(HL.ActualHireFrom,HL.HireFrom) <= "%s")'#13#10 +
           '  or (ifnull(HL.ActualHireTo,HL.HireTo) >= "%s" and ifnull(HL.ActualHireTo,HL.HireTo) <= "%s")'#13#10 +
           '  or (ifnull(HL.ActualHireFrom,HL.HireFrom) <"%s" and ifnull(HL.ActualHireTo,HL.HireTo) > "%s")'#13#10 +
           '  or (HL.ActualHireFrom is null and HL.HireFrom is null) or (HL.ActualHireTo is null and HL.HireTo is null)'#13#10 +
           '  ) union all'#13#10 +
           '   select FA.AssetId, FA.AssetName, FA.AssetCode, NULL as HireId, NULL as HireLineId'#13#10 +
           '   from tblFixedAssets FA'#13#10 +
           '   inner join tblAssetHire AH on AH.AssetId = FA.AssetId'#13#10 +
           '   where FA.AssetId not in'#13#10 +
           '   (select FA.AssetId'#13#10 +
           'from tblFixedAssets FA'#13#10 +
           'inner join tblAssetHire AH on AH.AssetId = FA.AssetId'#13#10 +
           'left join tblHireLines HL on HL.AssetId = AH.AssetId'#13#10 +
           'left join tblHireLineasset HLA on hla.HireLineId = hl.HireLineId'#13#10+
           'where HL.Deleted = "F" and ('#13#10 +
           '  (ifnull(HL.ActualHireFrom,HL.HireFrom) >= "%s" and ifnull(HL.ActualHireFrom,HL.HireFrom) <= "%s")'#13#10 +
           '  or (ifnull(HL.ActualHireTo,HL.HireTo) >= "%s" and ifnull(HL.ActualHireTo,HL.HireTo) <= "%s")'#13#10 +
           '  or (ifnull(HL.ActualHireFrom,HL.HireFrom) <"%s" and ifnull(HL.ActualHireTo,HL.HireTo) > "%s")'#13#10 +
           '  or (HL.ActualHireFrom is null and HL.HireFrom is null) or (HL.ActualHireTo is null and HL.HireTo is null)'#13#10 +
           '  )   )';
*)
           'Select TT.* from ('#13#10+
           'select FA.AssetId, FA.AssetCode, FA.AssetName, HL.HireId, HL.HireLineId'#13#10 +
           ',HL.HireFrom'#13#10+
           'from tblHireLineAsset HLA'#13#10 +
           'inner join tblHireLines HL on HLA.HireLineId=HL.HireLineId'#13#10 +
           'inner join tblFixedAssets FA on FA.AssetId = HLA.AssetId'#13#10 +
           'where'#13#10 +
           'HL.Deleted = "F" and'#13#10 +
           '('#13#10 +
           '  (ifnull(HL.ActualHireFrom,HL.HireFrom) >= "%s" and ifnull(HL.ActualHireFrom,HL.HireFrom) <= "%s")'#13#10 +
           '   or (ifnull(HL.ActualHireTo,HL.HireTo) >= "%s" and ifnull(HL.ActualHireTo,HL.HireTo) <= "%s")'#13#10 +
           '   or (ifnull(HL.ActualHireFrom,HL.HireFrom) <"%s" and ifnull(HL.ActualHireTo,HL.HireTo) > "%s")'#13#10 +
           '   or (HL.ActualHireFrom is null and HL.HireFrom is null) or (HL.ActualHireTo is null and HL.HireTo is null)'#13#10 +
           '   )'#13#10 +
           'union all'#13#10 +
           'Select distinct(FA.AssetId), FA.AssetCode, FA.AssetName, null as HireId, NULL as HirelineId'#13#10 +
           ',0'#13#10+
           'from tblFixedAssets FA'#13#10 +
           'inner join tblAssetHire HLA on HLA.AssetId=FA.AssetId'#13#10 +
           'where FA.assetId not in'#13#10 +
           '('#13#10 +
           'select FA.AssetId'#13#10 +
           'from tblHireLineAsset HLA'#13#10 +
           'inner join tblHireLines HL on HLA.HireLineId=HL.HireLineId'#13#10 +
           'inner join tblFixedAssets FA on FA.AssetId = HLA.AssetId'#13#10 +
           'where'#13#10 +
           'HL.Deleted = "F" and'#13#10 +
           '('#13#10 +
           '  (ifnull(HL.ActualHireFrom,HL.HireFrom) >= "%s" and ifnull(HL.ActualHireFrom,HL.HireFrom) <= "%s")'#13#10 +
           '   or (ifnull(HL.ActualHireTo,HL.HireTo) >= "%s" and ifnull(HL.ActualHireTo,HL.HireTo) <= "%s")'#13#10 +
           '   or (ifnull(HL.ActualHireFrom,HL.HireFrom) <"%s" and ifnull(HL.ActualHireTo,HL.HireTo) > "%s")'#13#10 +
           '   or (HL.ActualHireFrom is null and HL.HireFrom is null) or (HL.ActualHireTo is null and HL.HireTo is null)'#13#10 +
           '   )'#13#10 +
           ')'#13#10+
           ') TT'#13#10+
//           ' group by AssetId'#13#10+
           'order by AssetName, AssetId, HireId'; // HireFrom, AssetId, HireId';
var
  idx : integer;
  lSet : TPlannerSet;
  dtFrom, dtTo : TDateTime;
  sFrom, sTo : string;
begin
  planHire.Header.Captions.Clear;
  planHire.Header.Captions.AddObject('Items',nil);

    Times(dtFrom, dtTo);
    sFrom := FormatDateTime(MysqlDateTimeFormat,dtFrom);
    sTo := FormatDateTime(MysqlDateTimeFormat,dtTo);
    qry.SQL.Text := Format(csSummary, [sFrom, sTo,sFrom, sTo,sTo, sFrom,sFrom, sTo,sFrom, sTo,sTo, sFrom]);

    qry.Open;
    while not qry.Eof do
    begin
      if qry.FieldByName('HireLineId').isNull then
      begin // Free item
        idx := PosByAssetNameSummary(qry.FieldByName('AssetName').AsString);
        if idx = -1 then
        begin
          lSet := TPlannerSet.Create(0, qry.FieldByName('AssetName').AsString);
          lSet.Add(qry.FieldByName('AssetID').AsInteger);
          planHire.Header.Captions.AddObject(qry.FieldByName('AssetName').AsString + #13#10 +
                          qry.FieldByName('AssetCode').AsString, lSet)
        end
        else
        begin
          lSet := TPlannerSet(planHire.Header.Captions.Objects[idx]);
          lSet.Add(qry.FieldByName('AssetId').AsInteger);
          planHire.Header.Captions[idx] := qry.FieldByName('AssetName').AsString + #13#10'(' + IntToStr(lSet.Count) + ' Items)';
        end;
      end
      else
      begin
        idx := PosByAssetId(qry.FieldByName('AssetId').AsInteger);
        if idx = -1 then
        begin  // Asset not in the grid - check for HireLine
          idx := PosByLineId(qry.FieldByName('HireLineId').AsInteger);
          if (idx = -1) then //or (TPlannerSet(planHire.Header.Captions.Objects[idx]).Linked) then
          begin
            lSet := TPlannerSet.Create(qry.FieldByName('HireLineId').asInteger, qry.FieldByName('AssetName').AsString);
            lSet.Add(qry.FieldByName('AssetID').AsInteger);
            planHire.Header.Captions.AddObject(qry.FieldByName('AssetName').AsString + #13#10 + qry.FieldByName('AssetCode').AsString, lSet)
          end
          else
          begin
            lSet := TPlannerSet(planHire.Header.Captions.Objects[idx]);
            lSet.Add(qry.FieldByName('AssetId').AsInteger);
            planHire.Header.Captions[idx] := qry.FieldByName('AssetName').AsString + #13#10'(' + IntToStr(lSet.Count) + ' Items)';
          end;
        end
        else
          TPlannerSet(planHire.Header.Captions.Objects[idx]).Linked := true;
      end;
      qry.Next;
    end;
    qry.Close;
    qry.SQL.Clear;
  planHire.Positions := planHire.Header.Captions.Count -1;
end;

procedure TfmHirePlanner.LoadItems;
var
  qry: TERPQuery;
  item: TPlannerItem;
  dtFrom, dtTo: TDateTime;
//  lPos : integer;
begin
  planHire.Items.Clear;
  Times(dtFrom, dtTo);
  HireLineList.Clear;
  qry := DbSharedObj.GetQuery(MyConnection);
  try

    qry.SQL.Add('select'); // distinct');
    qry.SQL.Add('tblhirelines.HireID,');
    qry.SQL.Add('tblhirelines.HireLineID,');
    qry.SQL.Add('tblhirelineasset.AssetId,');
    qry.SQL.Add('tblhirelineasset.AssetName,');
    qry.SQL.Add('tblhire.CustomerName,');
    qry.SQL.Add('tblhire.ShiptoAddress,');
    qry.SQL.Add('tblhirelines.HireFrom,');
    qry.SQL.Add('tblhirelines.HireTo,');
    qry.SQL.Add('tblhirelines.ActualHireFrom,');
    qry.SQL.Add('tblhirelines.ActualHireTo,');
//    qry.SQL.Add('tblhirelines.AssetId,');
    qry.SQL.Add('ifnull(tblhirelines.ActualHireFrom,tblhirelines.HireFrom) as HireOut,');
    qry.SQL.Add('ifnull(tblhirelines.ActualHireTo,tblhirelines.HireTo) as HireIn');
    qry.SQL.Add('from tblhirelines');
    qry.SQL.Add('inner join tblhire on tblhirelines.HireId = tblhire.HireID and tblhire.Deleted = "F" and tblHire.Converted = "F"');
    qry.SQL.Add('inner join tblhirelineasset on tblhirelineasset.HireLineID = tblhirelines.HireLineID');
    qry.SQL.Add('where tblhirelines.Deleted = "F"');
    qry.SQL.Add('and (ifnull(tblhirelines.ActualHireFrom,tblhirelines.HireFrom) >= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,dtFrom)) +
      ' and ifnull(tblhirelines.ActualHireFrom,tblhirelines.HireFrom) <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,dtTo)));
    qry.SQL.Add('or ifnull(tblhirelines.ActualHireTo,tblhirelines.HireTo) >= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,dtFrom)) +
      ' and ifnull(tblhirelines.ActualHireTo,tblhirelines.HireTo) <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,dtTo)));
    qry.SQL.Add('or ifnull(tblhirelines.ActualHireFrom,tblhirelines.HireFrom) <' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,dtFrom)) +
      ' and ifnull(tblhirelines.ActualHireTo,tblhirelines.HireTo) > ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,dtTo)) + ')');
    qry.Open;
    while not qry.Eof do begin
      // Details mode - HireLineId was not set, need to fix
      if ExtraDetails then
        PosForAssetIdFixLineId(qry.FieldByName('AssetId').asInteger, qry.FieldByName('HireLineId').asInteger);
//      if ((Details or Summary) and ((qry.FieldByName('Hireid').AsInteger <> HireId) or not (ItemExists(qry.FieldByName('HireLineId').asInteger)))) or
      if (Details  and ((qry.FieldByName('Hireid').AsInteger <> HireId) or not (ItemExists(qry.FieldByName('HireLineId').asInteger,qry.FieldByName('AssetId').AsInteger)))) or
         (Summary and not (ItemExists(qry.FieldByName('HireLineId').asInteger, qry.FieldByName('AssetId').AsInteger))) or
//         (Summary and (PosByLineId(qry.FieldByName('HireLineId').asInteger) = -1)) or
         (ExtraDetails) then // and (lPos < 0)) then
      begin
        item := planHire.Items.Add;
        item.Shape := psRounded;
        item.CaptionType := Planner.ctText;
        item.ID := qry.FieldByName('HireLineId').AsInteger;
        item.CaptionText := '#' + qry.FieldByName('HireId').AsString + ' ' + qry.FieldByName('CustomerName').AsString;
        item.Text.Text := qry.FieldByName('ShipToAddress').AsString;
        item.ItemStartTime := qry.FieldByName('HireOut').AsDateTime;
        if qry.FieldByName('HireOut').AsDateTime < dtFrom then
          item.ItemStartTime := 0; //Trunc(item.ItemStartTime);
        item.ItemEndTime := qry.FieldByName('HireIn').AsDateTime;
        item.ItemPos := PosForAssetId(qry.FieldByName('AssetId').AsInteger);

        item.ItemObject := HireLineList.AddData(qry);
        if THireLineRec(item.ItemObject).HireId = HireID then begin
          { show items for currently selected hire in a different colour, also on their own layer }
          item.Color := clSkyBlue;
          item.Layer := 4
        end
        else if (rgMode.ItemIndex = 1) then
          HireLineList.AddData(qry)  // Add to the list, but do not display - to allow sizing
        else begin
          item.Layer := 2;
        end;
      end;
      qry.Next;
    end;

  finally
    DbSharedObj.ReleaseObj(qry);
  end;

end;

procedure TfmHirePlanner.planHireItemDblClick(Sender: TObject;
  Item: TPlannerItem);
begin
  inherited;
  if (HireId = 0) and (ClientId = 0) then begin
    HireId :=  THireLineRec(Item.ItemObject).HireId;
    Close;
  end;
end;

procedure TfmHirePlanner.planHireItemDelete(Sender: TObject;
  Item: TPlannerItem);
var
  idx : integer;
  rec : THireLineRec;
begin
  inherited;
  if not Assigned(Item) or not assigned(Item.ItemObject) then
    exit;
  if THireLineRec(Item.ItemObject).HireId <> HireId then begin
    CommonLib.MessageDlgXP_Vista('You can only Delete Items for the Selected Hire',mtInformation,[mbOk],0);
    exit;
  end;
  Rec := THireLineRec(Item.ItemObject);
//  Rec.Deleted := true;
  planHire.FreeItem(Item);

  if Rec.HireLineId <> 0 then  // exists in db
    Rec.Deleted:= true
  else
  begin
    idx := HireLineList.IndexOf(Rec);
    if idx >= 0 then
    begin
      HireLineList.Delete(idx);
      if not HireLineList.OwnsObjects  then
        Rec.Free;
//      Item.ItemObject := nil;
    end;
  end;
  ItemSizing := true;   // To avoid re-creation in the MouseUp!!!
  // ???
  SaveData;
  LoadItems;
end;

procedure TfmHirePlanner.planHireItemMoving(Sender: TObject; Item: TPlannerItem;
  DeltaBegin, DeltaPos: Integer; var Allow: Boolean);
begin
  inherited;
  Allow := true;
  ItemSizing := true;
  if THireLineRec(Item.ItemObject).HireId <> HireId then begin
    CommonLib.MessageDlgXP_Vista('You can only Edit Items for the Selected Hire',mtInformation,[mbOk],0);
    Allow := false;
    exit;
  end;
  THireLineRec(Item.ItemObject).Dirty := true;
  case rgPeriod.ItemIndex of
    0,

    1: begin
         if THireLineRec(Item.ItemObject).ActualHireFrom > 0 then
           THireLineRec(Item.ItemObject).ActualHireFrom := THireLineRec(Item.ItemObject).ActualHireFrom + (DeltaBegin * (planHire.Display.DisplayUnit * OneMinute))
         else
           THireLineRec(Item.ItemObject).HireFrom := THireLineRec(Item.ItemObject).HireFrom + (DeltaBegin * (planHire.Display.DisplayUnit * OneMinute));

         if THireLineRec(Item.ItemObject).ActualHireTo > 0 then
           THireLineRec(Item.ItemObject).ActualHireTo := THireLineRec(Item.ItemObject).ActualHireTo + (DeltaBegin * (planHire.Display.DisplayUnit * OneMinute))
         else
           THireLineRec(Item.ItemObject).HireTo := THireLineRec(Item.ItemObject).HireTo + (DeltaBegin * (planHire.Display.DisplayUnit * OneMinute));
       end;
    2: begin
         if THireLineRec(Item.ItemObject).ActualHireFrom > 0 then
           THireLineRec(Item.ItemObject).ActualHireFrom := THireLineRec(Item.ItemObject).ActualHireFrom + DeltaBegin
         else
           THireLineRec(Item.ItemObject).HireFrom := THireLineRec(Item.ItemObject).HireFrom + DeltaBegin;

         if THireLineRec(Item.ItemObject).ActualHireTo > 0 then
           THireLineRec(Item.ItemObject).ActualHireTo := THireLineRec(Item.ItemObject).ActualHireTo + DeltaBegin
         else
           THireLineRec(Item.ItemObject).HireTo := THireLineRec(Item.ItemObject).HireTo + DeltaBegin;
       end;
  end;
  UpdateLinked(THireLineRec(Item.ItemObject));
end;

procedure TfmHirePlanner.planHireItemSizing(Sender: TObject; Item: TPlannerItem;
  DeltaBegin, DeltaEnd: Integer; var Allow: Boolean);
begin
  inherited;
  Allow := true;
  if THireLineRec(Item.ItemObject).HireId <> HireId then begin
    CommonLib.MessageDlgXP_Vista('You can only Edit Items for the Selected Hire',mtInformation,[mbOk],0);
    Allow := false;
    exit;
  end;
//  memo1.Lines.Add('Delta: '+ IntToStr(DeltaBegin) + ' ' +IntToStr(DeltaEnd));
  ItemSizing := true;  // will be reset in MouseUp
  THireLineRec(Item.ItemObject).Dirty := true;
  case rgPeriod.ItemIndex of
    0,

    1: begin
         if THireLineRec(Item.ItemObject).ActualHireFrom > 0 then
           THireLineRec(Item.ItemObject).ActualHireFrom := THireLineRec(Item.ItemObject).ActualHireFrom + (DeltaBegin * (planHire.Display.DisplayUnit * OneMinute))
         else
           THireLineRec(Item.ItemObject).HireFrom := THireLineRec(Item.ItemObject).HireFrom + (DeltaBegin * (planHire.Display.DisplayUnit * OneMinute));

         if THireLineRec(Item.ItemObject).ActualHireTo > 0 then
           THireLineRec(Item.ItemObject).ActualHireTo := THireLineRec(Item.ItemObject).ActualHireTo + (DeltaEnd * (planHire.Display.DisplayUnit * OneMinute))
         else
           THireLineRec(Item.ItemObject).HireTo := THireLineRec(Item.ItemObject).HireTo + (DeltaEnd * (planHire.Display.DisplayUnit * OneMinute));
       end;
    2: begin
         if THireLineRec(Item.ItemObject).ActualHireFrom > 0 then
           THireLineRec(Item.ItemObject).ActualHireFrom := THireLineRec(Item.ItemObject).ActualHireFrom + DeltaBegin
         else
           THireLineRec(Item.ItemObject).HireFrom := THireLineRec(Item.ItemObject).HireFrom + DeltaBegin;

         if THireLineRec(Item.ItemObject).ActualHireTo > 0 then
           THireLineRec(Item.ItemObject).ActualHireTo := THireLineRec(Item.ItemObject).ActualHireTo + DeltaEnd
         else
           THireLineRec(Item.ItemObject).HireTo := THireLineRec(Item.ItemObject).HireTo + DeltaEnd;
       end;
  end;
  UpdateLinked(THireLineRec(Item.ItemObject));
end;

procedure TfmHirePlanner.planHireItemText(Sender: TObject;
  PlannerItem: TPlannerItem; var Text: string);
var
  rec: THireLineRec;
  existingForId,
  existingRec: THireLineRec;
  SetTime: boolean;
  idx : integer;
  lAsset,
  lPos : integer;
begin
  inherited;
  if self.IsFlag('GetClient') then exit;
  self.AddFlag('GetClient');
  try
    SetTime := true;
    if PlannerItem.CaptionText = '' then begin
      { this is a new item }
      if (PlannerItem.ItemEndTime - PlannerItem.ItemStartTime) < (31 * OneMinute) then begin
        planHire.Items.Delete(PlannerItem.Index);
        exit;
      end;

      if (HireId = 0) and (ClientId = 0) then begin
        { who is this for .. }
        ClientId := GetHireCustomerId(ClientName);
        if ClientId = 0 then begin
          ClientName := '';
          planHire.Items.Delete(PlannerItem.Index);
          exit;
        end;
      end;


      if not assigned(PlannerItem.ItemObject) and (PlannerItem.CaptionText <> '') then
      begin
        planHire.Items.Delete(PlannerItem.Index);
        exit;
      end;

      idx := self.AssetIdForPos(PlannerItem.ItemPos);

      if idx < 0 then
      begin
        if assigned(planHire.Header.Captions.Objects[PlannerItem.ItemPos + 1]) and
          (TPlannerSet(planHire.Header.Captions.Objects[PlannerItem.ItemPos + 1]).Count > 1) then
          ProcessMultiple(PlannerItem)
        else
          planHire.Items.Delete(PlannerItem.Index);
        exit;
      end;

      existingRec := HireLineList.ItemForHireAssetName(HireId, TFixedAssets.AssetNameForId(AssetIdForPos(PlannerItem.ItemPos)));
      existingForId := HireLineList.ItemForHireAssetId(HireId, idx);
      if assigned(existingForId) and not(ExistingForId.Deleted) then
      begin
        if MessageDlgXP_Vista('This Item Has Already Been Used In The Hire.'#13#10 +
          'Would You Like To Hire Another Item Of ' + existingForId.AssetName + '?', mtWarning, [mbYes,mbNo], 0) = mrNo then
        begin
          planHire.FreeItem(PlannerItem);
          exit;
        end;
      end;

      lPos := -1;
      lAsset := -1;
      if assigned(existingForId) and not (existingForId.deleted) then
      begin
        lAsset := -1;
        // Need to find free line
        for idx := 0 to  planHire.Header.Captions.Count - 1 do
          if not assigned(planHire.Header.Captions.Objects[idx]) then
            continue
          else if not SameText(existingForId.AssetName, TPlannerSet(planHire.Header.Captions.Objects[idx]).AssetName) then
            continue
          else
          begin
            Rec := HireLineList.ItemForHireAssetId(HireId, TPlannerSet(planHire.Header.Captions.Objects[idx]).Items[0]);
            if Assigned(Rec) and not (Rec.Deleted) then
              Continue;
            // Found empty
            lPos := idx;
            lAsset := TPlannerSet(planHire.Header.Captions.Objects[idx]).Items[0];
            Break;
          end;
        if lPos < 0 then
        begin
          MessageDlgXP_Vista('No Free ' + existingForId.AssetName + ' Assets Found. Cannot Add Asset To Hire', mtWarning, [mbOk], 0);
          PlanHire.FreeItem(PlannerItem);
          Exit;
        end
        else
        begin
          existingForId := HireLineList.ItemForHireAssetId(HireId, lAsset);
        end;
      end;

      if assigned(ExistingForId) then
      begin
        rec := ExistingForId;
        rec.Deleted := false;
      end
      else
        rec := THireLineRec.Create;
      PlannerItem.ItemObject := rec;
      if not assigned(existingForId) then
        rec.HireLineId := 0;

      rec.Dirty := true;
      rec.HireId := HireId;
      if lPos >= 0 then
      begin
        PlannerItem.ItemPos := lPos - 1;
        Rec.AssetId := lAsset;
      end
      else
      begin
        rec.AssetId := self.AssetIdForPos(PlannerItem.ItemPos);
      end;
      rec.AssetName := TFixedAssets.AssetNameForId(rec.AssetId);
      if Assigned(existingRec) then
      begin
        if (lPos = -1) then
          idx := AskForHireGroup(HireLineList, Rec, ExistingRec);
        if ((lPos = - 1) and (idx = 0)) or
            (lPos >= 0) then
          begin
            rec.HireLineId := existingRec.HireLineId;
            SetTime := false;
            rec.HireFrom := existingRec.HireFrom;
            rec.HireTo := existingRec.HireTo;
            rec.ActualHireFrom := existingRec.ActualHireFrom;
            rec.ActualHireTo := existingRec.ActualHireTo;

            if (rec.ActualHireFrom > 0) and (rec.ActualHireTo > 0) then begin
              PlannerItem.ItemStartTime := rec.ActualHireFrom;
              PlannerItem.ItemEndTime := rec.ActualHireTo;
            end
            else begin
              PlannerItem.ItemStartTime := rec.HireFrom;
              PlannerItem.ItemEndTime := rec.HireTo;
            end;
          end
          else if (lPos = -1) and (idx = -1) then
          begin
            Rec.Free;
            planHire.Items.Delete(PlannerItem.Index);
            exit;
          end
          else if (lPos = -1) then
          begin
            // do not want to add to existing - create new
            SetTime := true;
          end;
      end;

      if SetTime then begin
        if rgPeriod.ItemIndex = 2 then begin
          { Month view .. so set day and start times to default .. }
          PlannerItem.ItemStartTime := Trunc(PlannerItem.ItemStartTime) + Frac(AppEnv.CompanyPrefs.StartOfDay);
          PlannerItem.ItemEndTime := Trunc(PlannerItem.ItemEndTime) + Frac(AppEnv.CompanyPrefs.EndOfDay);
        end;
        if Trunc(PlannerItem.ItemStartTime) = 0 then begin
          rec.HireFrom := dtStart.DateTime + Frac(PlannerItem.ItemStartTime);
          rec.HireTo := dtStart.DateTime + Frac(PlannerItem.ItemEndTime);
        end
        else begin
          rec.HireFrom := PlannerItem.ItemStartTime;
          rec.HireTo := PlannerItem.ItemEndTime;
        end;
      end;
      if HireId > 0 then
        PlannerItem.CaptionText := '#' + IntToStr(HireId)
      else
        PlannerItem.CaptionText := ClientName;
      PlannerItem.Text.Text := 'New Line for Item: ' + AssetDescForPos(PlannerItem.ItemPos);
      { show items for currently selected hire in a different colour, also on their own layer }
      PlannerItem.Color := clSkyBlue;
      PlannerItem.Layer := 4;

      if HireLineList.Overlapped(Rec) then
      begin
        MessageDlgXP_Vista('Asset Is Already In Use For The Set Time, or'#13#10'Cannot Find Free Asset For The Set Time.', mtWarning, [mbOk], 0);
        planHire.Items.Delete(PlannerItem.Index);
        Rec.Free;
      end
      else
      begin
        if not assigned(ExistingForId) then
          self.HireLineList.Add(rec);
        (*
        SaveData;   // !!!
        LoadItems;
        *)
        rgModeClick(self);
      end;
    end;
  finally
    self.RemoveFlag('GetClient');
  end;
end;

procedure TfmHirePlanner.planHirePlannerMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  point : TPoint;
  item : TPlannerItem;
begin
  inherited;
  point := planHire.XYToCell(X,Y);
  if (Point.X < 0) or (point.Y < 0) then
    exit;
  item := planHire.CellToItem(point.X, point.y);
  (*
  if (Details) and not (ItemSizing) then
  begin
    if (TPlannerSet(planHire.Header.Captions.Objects[point.y + 1]).Count > 1) and (not assigned(Item)) then
    begin
      MessageDlgXP_Vista('You Cannot Add Lines In Summary Mode For Summary Lines', mtWarning, [mbOk], 0);
      exit;
    end;
  end;
  *)
  if not Assigned(item) and not(ItemSizing) then
  begin
    planHire.CreateItemAtSelection;
(*    item := planHire.CreateItemAtSelection;
    idx := AssetIdForPos(Item.ItemPos);
    Rec := HireLineList.ItemForHireAssetId(HireId, idx);
//    if assigned(rec) then
//      Rec.Deleted := false;
*)
  end;
  ItemSizing := false;
end;

function TfmHirePlanner.PosByAssetId(AAssetId: integer): integer;
var
  idx : integer;
begin
  Result := -1;
  for idx := 0 to planHire.Header.Captions.Count - 1 do
    if assigned(planHire.Header.Captions.Objects[idx]) and
       TPlannerSet(planHire.Header.Captions.Objects[idx]).Exists(AAssetId) then
    begin
      Result := idx;// it is called from assets - no minus 1!! - 1;  // Need to be one less???
      exit;
    end;

end;

function TfmHirePlanner.PosByAssetNameSummary(
  const aAssetName: string): integer;
var
  idx : integer;
begin
  Result := -1;
  // Looking for the caption with AAssetName and not assigned to HireLine
  for idx := 0 to planHire.Header.Captions.Count - 1 do
    if assigned(planHire.Header.Captions.Objects[idx]) and
       SameText(TPlannerSet(planHire.Header.Captions.Objects[idx]).AssetName, AAssetName) and
       (TPlannerSet(planHire.Header.Captions.Objects[idx]).HireLineId = 0) then
    begin
      Result := idx;// it is called from assets - no minus 1!! - 1;  // Need to be one less???
      exit;
    end;
end;

function TfmHirePlanner.PosByLineId(ALineId: integer): integer;
var
  idx : integer;
begin
  for idx := 0 to planHire.Header.Captions.Count - 1 do
    if (assigned(planHire.Header.Captions.Objects[idx])) and
       (TPlannerSet(planHire.Header.Captions.Objects[idx]).HireLineId = aLineId) and
       not (TPlannerSet(planHire.Header.Captions.Objects[idx]).Linked)
       then
    begin
      Result := idx;
      exit;
    end;
  Result := -1;
end;

function TfmHirePlanner.PosForAssetId(aAssetId: integer): integer;
var
  idx : integer;
begin
//  result := planHire.Header.Captions.IndexOfObject(TObject(aAssetId)) - 1;
  for idx := 0 to planHire.Header.Captions.Count - 1 do
    if assigned(planHire.Header.Captions.Objects[idx]) and TPlannerSet(planHire.Header.Captions.Objects[idx]).Exists(aAssetId) then
    begin
      Result := idx - 1;  // Need to be one less???
      exit;
    end;
  Result := -1;
end;

function TfmHirePlanner.PosForAssetIdFixLineId(aAssetId,
  aHireLineId: integer): integer;
var
  idx : integer;
begin
//  result := planHire.Header.Captions.IndexOfObject(TObject(aAssetId)) - 1;
  for idx := 0 to planHire.Header.Captions.Count - 1 do
    if assigned(planHire.Header.Captions.Objects[idx]) and TPlannerSet(planHire.Header.Captions.Objects[idx]).Exists(aAssetId) then
    begin
      Result := idx;
      TPlannerSet(planHire.Header.Captions.Objects[idx]).HireLineId := aHireLineId;
      exit;
    end;
  Result := -1;
end;

procedure TfmHirePlanner.ProcessMultiple(PlannerItem: TPlannerItem);
var
  wSet,
  lSet : TPlannerSet;
  lPos : integer;
  j,
  idx : integer;
  useExisting : boolean;
  Item : TPlannerItem;
  ExistingRec,
  Rec : THireLineRec;
  found,
  lSearchNew : boolean;

begin
  wSet := nil;
  lSet := TPlannerSet(planHire.Header.Captions.Objects[PlannerItem.ItemPos + 1]);
  lSearchNew := false;
  for idx := 0 to planHire.Items.Count - 1 do
  begin
    if planHire.Items[idx].ItemPos = PlannerItem.ItemPos then
      if assigned(planHire.Items[idx].ItemObject) and
        lSet.Exists(THireLineRec(planHire.Items[idx].ItemObject).AssetId) then
      begin
      (*
        if MessageDlgXP_Vista('Some of Items Selected Are Already In Use For The Set Time.'#13#10+
         'Do You Want To Hire Other Items Of The Same Product?', mtWarning, [mbYes, mbNo], 0) = mrNo then
         *)
        if MessageDlgXP_Vista('Some of Items Selected Are Already On Hire.'#13#10+
         'Do You Want To Hire Other Items Of The Same Product?', mtWarning, [mbYes, mbNo], 0) = mrNo then
        begin
          planHire.Items.Delete(PlannerItem.Index);
          Exit;
        end
        else
          lSearchNew := true;
          break;
      end
      else if not assigned(planHire.Items[idx].ItemObject) then
      begin
        lSearchNew := false;
        break;
      end;
  end;

  useExisting := false;
  existingRec := HireLineList.ItemForHireAssetName(HireId, lSet.AssetName);
  if assigned(existingRec) then
  begin
    try
      Rec := THireLineRec.Create;
      Rec.AssetName := lSet.AssetName;
      Rec.HireId := HireId;
      idx := AskForHireGroup(HireLineList, Rec, ExistingRec);
      if idx < 0 then
      begin
        planHire.Items.Delete(PlannerItem.Index);
        Exit;
      end
      else
        useExisting := idx = 0;
    finally
      FreeAndNil(rec);
    end;

  end;

  found := false;
  lPos := 0;
  if Summary then
  begin
    if lSearchNew then
    begin  // Need to find Count free items
      for idx := 0 to planHire.Header.Captions.Count - 1 do
      begin
        wSet := TPlannerSet(planHire.Header.Captions.Objects[idx]);
        if assigned(wSet) and
           SameText(wSet.AssetName, lSet.AssetName) and
           (wSet.HireLineId = 0) and (wSet.Count >= lSet.Count) then
        begin
          found := true;
          lPos := idx - 1;
          Break;
        end;
      end;
    end;
  end
  else
  begin
    Found := false;
    wSet := TPlannerSet.Create(0, lSet.AssetName);
    for idx := 0 to planHire.Header.Captions.Count - 1 do
    begin
      if assigned(planHire.Header.Captions.Objects[idx]) and
         SameText(TPlannerSet(planHire.Header.Captions.Objects[idx]).AssetName, lSet.AssetName) and
         (TPlannerSet(planHire.Header.Captions.Objects[idx]).HireLineId=0) then
         begin
           for j:= 0 to TPlannerSet(planHire.Header.Captions.Objects[idx]).Count - 1 do
           begin
             wSet.Add(TPlannerSet(planHire.Header.Captions.Objects[idx])[j]);
             if wSet.Count = lSet.Count then
               break;
           end;
        end;

        if wSet.Count = lSet.Count then
        begin
          Found := true;
          break;
        end;
    end;
    if not Found  then
    begin
      MessageDlgXP_Vista('Cannot Find ' + IntToStr(lSet.Count) + ' Free Items of ' + lSet.AssetName,
                         mtWarning, [mbOk], 0);
      planHire.Items.Delete(plannerItem.Index);
      exit;
    end;
  end;

  for idx := 0 to lSet.Count - 1 do
  begin
    item := planHire.CreateItem;
    rec := THireLineRec.Create;
    Item.ItemObject := rec;
    rec.Dirty := true;
    rec.HireId := HireId;
    if Summary then
      Item.ItemPos := lPos;
    if Found then
      Rec.AssetId := wSet[idx]
    else
      Rec.AssetId := lSet[idx];
    if UseExisting then
    begin
      rec.HireLineId := existingRec.HireLineId;
      rec.HireFrom := existingRec.HireFrom;
      rec.HireTo := existingRec.HireTo;
      rec.ActualHireFrom := existingRec.ActualHireFrom;
      rec.ActualHireTo := existingRec.ActualHireTo;

      if (rec.ActualHireFrom > 0) and (rec.ActualHireTo > 0) then
      begin
        Item.ItemStartTime := rec.ActualHireFrom;
        Item.ItemEndTime := rec.ActualHireTo;
      end
      else
      begin
        Item.ItemStartTime := rec.HireFrom;
        Item.ItemEndTime := rec.HireTo;
      end;
    end
    else
    begin
      if rgPeriod.ItemIndex = 2 then begin
        { Month view .. so set day and start times to default .. }
        Item.ItemStartTime := Trunc(PlannerItem.ItemStartTime) + Frac(AppEnv.CompanyPrefs.StartOfDay);
        Item.ItemEndTime := Trunc(PlannerItem.ItemEndTime) + Frac(AppEnv.CompanyPrefs.EndOfDay);
      end;
      if Trunc(PlannerItem.ItemStartTime) = 0 then begin
        rec.HireFrom := dtStart.DateTime + Frac(PlannerItem.ItemStartTime);
        rec.HireTo := dtStart.DateTime + Frac(PlannerItem.ItemEndTime);
      end
      else
      begin
        rec.HireFrom := PlannerItem.ItemStartTime;
        rec.HireTo := PlannerItem.ItemEndTime;
      end;

    end;
    self.HireLineList.Add(rec);
    end;
  if Details and Found then
    wSet.Free;
  rgModeClick(self);
end;

procedure TfmHirePlanner.Reload;
begin
  planHire.Items.BeginUpdate;
  try
    LoadAssets;
    LoadItems;
  finally
    planHire.Items.EndUpdate;
  end;
end;

procedure TfmHirePlanner.rgModeClick(Sender: TObject);
begin
  inherited;
  if SaveData then
  begin
    LoadAssets;
    LoadItems;
  end;
end;

procedure TfmHirePlanner.rgPeriodClick(Sender: TObject);
begin
  inherited;
//  if fsShowing in FormState then
//    exit;
  SetPlannerMode;
  UpdateTimeFrame;
  if fsShowing in FormState then
    exit;
  LoadItems;
end;

function TfmHirePlanner.SaveData: boolean;
var
  Hire: THire;
  x: integer;
  rec: THireLineRec;
begin
  result := true;
  if (HireId = 0) and (ClientId = 0) then exit;

  Hire := THire.Create(nil);
  try
    Hire.Connection := TMyDacDataConnection.Create(Hire);
    Hire.Connection.Connection := MyConnection;
    Hire.Load(HireId);
    if HireId = 0 then begin
      Hire.New;
      Hire.CustomerID := ClientId;
    end;
    for x := 0 to HireLineList.Count -1 do begin
      rec := HireLineList.Item[x];
      if (rec.HireId <> HireID) then
        Continue;
      if (rec.HireLineId = 0) and (not rec.Deleted) then begin
        { we don't have an id so new entry .. }
        { do we already have a line for this asset .. }
        (*
        if Hire.HireLines.Locate('AssetName',rec.AssetName,[loCaseInsensitive]) then begin
          { add to existing line }
          Hire.HireLines.AssetLines.New;
          Hire.HireLines.AssetLines.AssetId := rec.AssetId;
          Hire.HireLines.AssetLines.PostDb;
        end
        else begin
          { crete a new line }
          Hire.HireLines.New;
          Hire.HireLines.AssetId := rec.AssetId;

          if Hire.HireLines.HireFrom <> rec.HireFrom then
            Hire.HireLines.HireFrom := rec.HireFrom;
          if Hire.HireLines.HireTo <> rec.HireTo then
            Hire.HireLines.HireTo := rec.HireTo;

          if Hire.HireLines.ActualHireFrom <> rec.ActualHireFrom then
            Hire.HireLines.ActualHireFrom := rec.ActualHireFrom;
          if Hire.HireLines.ActualHireTo <> rec.ActualHireTo then
            Hire.HireLines.ActualHireTo := rec.ActualHireTo;
          Hire.HireLines.PostDb;

          { .. then add the asset }

          Hire.HireLines.AssetLines.New;
          Hire.HireLines.AssetLines.AssetId := rec.AssetId;
          Hire.HireLines.AssetLines.PostDb;
        end;
        Hire.HireLines.HireQty := Hire.HireLines.AssetLines.Count;
        *)
        if Hire.HireLines.Locate('AssetId',rec.AssetId,[loCaseInsensitive]) then begin
          { add to existing line }
          Hire.HireLines.AssetLines.New;
          Hire.HireLines.AssetLines.AssetId := rec.AssetId;
          Hire.HireLines.AssetLines.PostDb;
        end
        else begin
          { crete a new line }
          Hire.HireLines.New;
          Hire.HireLines.Planner := true;
          Hire.HireLines.AssetId := rec.AssetId;

          if Hire.HireLines.HireFrom <> rec.HireFrom then
            Hire.HireLines.HireFrom := rec.HireFrom;
          if Hire.HireLines.HireTo <> rec.HireTo then
            Hire.HireLines.HireTo := rec.HireTo;

          if Hire.HireLines.ActualHireFrom <> rec.ActualHireFrom then
            Hire.HireLines.ActualHireFrom := rec.ActualHireFrom;
          if Hire.HireLines.ActualHireTo <> rec.ActualHireTo then
            Hire.HireLines.ActualHireTo := rec.ActualHireTo;

//          Hire.HireLines.AssetId := rec.AssetId;

          Hire.HireLines.PostDb;

          { .. then add the asset }
          if  (Hire.HireLines.AssetLines.Count = 0) or not (Hire.HireLines.AssetLines.Locate('AssetId', rec.AssetId, [])) then
          begin
            Hire.HireLines.AssetLines.New;
            Hire.HireLines.AssetLines.AssetId := rec.AssetId;
            Hire.HireLines.AssetLines.PostDb;
          end;
        end;
        Hire.HireLines.HireQty := Hire.HireLines.AssetLines.Count;
      end
      else begin
        if rec.Deleted then begin

          { a deleted record }
          if Hire.HireLines.Locate('HireLineId',rec.HireLineId,[]) then begin
            if Hire.HireLines.AssetLines.Locate('AssetID',rec.AssetId,[]) then begin
              Hire.HireLines.AssetLines.Delete;
              Hire.HireLines.HireQty := Hire.HireLines.AssetLines.Count;
            end;
          end;
        end
        else begin
          { not deleleted  }

          if Hire.HireLines.Locate('HireLineId',rec.HireLineId,[]) then begin

            { this could be a new line asset, so check }
            if not Hire.HireLines.AssetLines.Locate('AssetId',rec.AssetId,[]) then begin
              Hire.HireLines.AssetLines.New;
              Hire.HireLines.AssetLines.AssetId := rec.AssetId;
              Hire.HireLines.AssetLines.PostDb;
              Hire.HireLines.HireQty := Hire.HireLines.AssetLines.Count;
            end;

            { check / update times }
            if Hire.HireLines.HireFrom <> rec.HireFrom then
              Hire.HireLines.HireFrom := rec.HireFrom;
            if Hire.HireLines.HireTo <> rec.HireTo then
              Hire.HireLines.HireTo := rec.HireTo;

            if Hire.HireLines.ActualHireFrom <> rec.ActualHireFrom then
              Hire.HireLines.ActualHireFrom := rec.ActualHireFrom;
            if Hire.HireLines.ActualHireTo <> rec.ActualHireTo then
              Hire.HireLines.ActualHireTo := rec.ActualHireTo;
            Hire.HireLines.PostDb;
          end;
        end;
      end;
    end;
//@@@    Hire.SummaryMode := rgMode.ItemIndex = 1;
    result := Hire.Save;
    if Result then begin
      HireId := Hire.ID;
      HireLineList.Dirty := false;
    end;
  finally
    Hire.Free;
  end;

end;

procedure TfmHirePlanner.SetHireID(const Value: integer);
begin
  fHireID := Value;
  if Value <> 0 then
    rgMode.Enabled := true
  else
    rgMode.Enabled := false;
end;

procedure TfmHirePlanner.SetPlannerMode;
begin
  case rgPeriod.ItemIndex of
    0: begin
         planHire.Mode.PlannerType := Planner.plDay;
         planHire.Display.DisplayUnit := 30; // 30 min steps
         planHire.Display.DisplayEnd := 47; // 48 * 30 = full day
         planHire.Display.DisplayScale := 28;
         planHire.Display.DisplayText := 0;
         planHire.Sidebar.Width := 40;
         planHire.Sidebar.DateTimeFormat := FormatSettings.ShortDateFormat;
       end;
    1: begin
         planHire.Mode.PlannerType := Planner.plTimeLine;
         planHire.Display.DisplayUnit := 30; // 30 min steps
         planHire.Display.DisplayEnd := (14 * 48) - 1; // 14 days
         planHire.Display.DisplayScale := 12;
         planHire.Display.DisplayText := 2; // only display every second number .. ie hours
         planHire.Sidebar.Width := 40;
         planHire.Sidebar.DateTimeFormat := FormatSettings.ShortDateFormat;
       end;
    2: begin
         planHire.Mode.PlannerType := Planner.plMonth;
         planHire.Display.DisplayEnd := DaysInMonth(dtStart.DateTime) + DaysInMonth(IncMonth(dtStart.DateTime,1)); //   2 months
         planHire.Display.DisplayScale := 38;
         planHire.Display.DisplayText := 0;
         planHire.Sidebar.Width := 60;
         planHire.Sidebar.DateTimeFormat := 'dd/mm/yy'; //FormatSettings.ShortDateFormat;
       end;
  end;
end;

function TfmHirePlanner.Summary: boolean;
begin
  Result := rgMode.ItemIndex = csSummary;
end;

procedure TfmHirePlanner.Times(var dtFrom, dtTo: TDateTime);
begin
  case rgPeriod.ItemIndex of
    0: begin
         { day }
         dtFrom := dtStart.Date;
         dtTo := IncDay(dtStart.Date,1) - OneSecond;
       end;
    1: begin
         { week }
         dtFrom := dtStart.Date;
//         dtTo := IncDay(dtStart.Date,15) - OneSecond;
         dtTo := IncDay(dtStart.Date,2) - OneSecond;  // visible 3 days
       end;
    2: begin
         { month }
         dtFrom := StartOfTheMonth(dtStart.Date);
         dtTo := IncDay(dtFrom,DaysInMonth(dtStart.DateTime) + DaysInMonth(IncMonth(dtStart.DateTime,1))+1) - OneSecond;
       end
       else begin
         { week }
         dtFrom := dtStart.Date;
//         dtTo := IncDay(dtStart.Date,15) - OneSecond;
         dtTo := IncDay(dtStart.Date, 2) - OneSecond;  // 3 days visible
       end;
  end;
end;

procedure TfmHirePlanner.UpdateLinked(SelectedRec: THireLineRec);
var
  x: integer;
  rec: THireLineRec;
  item: TPlannerItem;
begin
  if rgMode.ItemIndex  = 0 then
  begin
    for x := 0 to planHire.Items.Count -1 do begin
      item := planHire.Items[x];
      rec := THireLineRec(item.ItemObject);

      if (rec.HireLineId > 0) and (SelectedRec.HireLineId > 0)  then begin
        if (rec.HireLineId <> SelectedRec.HireLineId) then
          continue;
      end
      else if not SameText(rec.AssetName, SelectedRec.AssetName) then
        continue;

      if SelectedRec.Deleted then begin
        if not rec.Deleted then begin
          rec.Deleted := true;
          rec.Dirty := true;
          planHire.Items.Delete(item.Index);
        end;
      end
      else begin
        if (rec.HireFrom <> SelectedRec.HireFrom) or (rec.HireTo <> SelectedRec.HireTo) or
          (rec.ActualHireFrom <> SelectedRec.ActualHireFrom) or (rec.ActualHireTo <> SelectedRec.ActualHireTo)  then begin
          rec.HireFrom := SelectedRec.HireFrom;
          rec.HireTo := SelectedRec.HireTo;
          rec.ActualHireFrom := SelectedRec.ActualHireFrom;
          rec.ActualHireTo := SelectedRec.ActualHireTo;
          rec.Dirty := true;
          if (rec.ActualHireFrom > 0) and (rec.ActualHireTo > 0) then begin
            item.ItemStartTime := rec.ActualHireFrom;
            item.ItemEndTime := rec.ActualHireTo;
          end
          else begin
            item.ItemStartTime := rec.HireFrom;
            item.ItemEndTime := rec.HireTo;
          end;
        end;
      end;
    end;
  end
  else  // Summary mode, resizing/moving
  begin
    for x := 0 to HireLineList.Count - 1 do
    begin
      if HireLineList.Item[x] = SelectedRec then
        continue;
      if HireLineList.Item[x].HireLineId = SelectedRec.HireLineId then
      begin
        rec := HireLineList.Item[x];
        rec.HireFrom := SelectedRec.HireFrom;
        rec.HireTo := SelectedRec.HireTo;
        rec.ActualHireFrom := SelectedRec.ActualHireFrom;
        rec.ActualHireTo := SelectedRec.ActualHireTo;
        rec.Dirty := true;
      end;
    end;
  end;
end;

procedure TfmHirePlanner.UpdateTimeFrame;
begin
  planHire.Mode.Year := YearOf(dtStart.DateTime);
  planHire.Mode.Month := MonthOf(dtStart.DateTime);
  planHire.Mode.PeriodStartYear := YearOf(dtStart.DateTime);
  planHire.Mode.PeriodStartMonth := MonthOf(dtStart.DateTime);
  planHire.Mode.PeriodStartDay := DayOf(dtStart.DateTime);
  planHire.Mode.TimeLineStart := dtStart.Date;
  planHire.Mode.WeekStart := DayOf(dtStart.DateTime);
end;


initialization
  RegisterClass(TfmHirePlanner);


end.
