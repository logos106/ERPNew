unit StsTagActivityLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TStsTagActivityLogGUI = class(TBaseListingGUI)
    pnlHistoryOfTagDesc: TDNMPanel;
    lblHistoryOfTagDesc: TLabel;
    lblHistoryOfTag: TLabel;
    qryMainTagID: TIntegerField;
    qryMainTag: TWideStringField;
    qryMainTagUsedOn: TDateTimeField;
    qryMainTagChanged: TWideStringField;
    qryMainAction: TWideStringField;
    qryMainActionDate: TDateTimeField;
    qryMainNewTag: TWideStringField;
    qryMainNewPhaseQtyPerTag: TIntegerField;
    qryMainNewPhaseNoOfTags: TIntegerField;
    qryMainNewPhaseCreated: TDateTimeField;
    qryMainNewPhase: TWideStringField;
    qryMainTagPhase: TWideStringField;
    qryMainActionDescription: TWideStringField;
    btnHistory: TDNMSpeedButton;
    qryMainTagActionCtr: TLargeintField;
    qryMainPhaseTagCtr: TLargeintField;
    qryMainActionctr: TLargeintField;
    qryMainPlantcount: TIntegerField;
    qryMainChangedCount: TIntegerField;
    qryMainWastedCount: TIntegerField;
    qryMainDestroycount: TIntegerField;
    qryMainTransferedCount: TIntegerField;
    qryMainUsedCount: TIntegerField;
    qryMainActivecount: TLargeintField;
    procedure FormCreate(Sender: TObject);
    procedure btnHistoryClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    fiHistoryOfTagId: Integer;
    procedure SetHistoryOfTagId(const Value: Integer);
    Procedure MakeQrymain;
    procedure initStsTagGrowthHistory(Sender: TObject);
    function StsNewPhasefield(Field: TField): Boolean;
    function StsTAgfield(Field: TField): Boolean;
    function StsActionfield(Field: TField): Boolean;
  Protected
    procedure SetGridColumns; Override;
  public
     Property HistoryOfTagId :Integer read fiHistoryOfTagId write SetHistoryOfTagId;
     Procedure RefreshQuery;Override;
  end;


implementation

uses CommonDbLib, CommonLib, BusObjSeedToSale, StsTagGrowthHistory,
  CommonFormLib;

{$R *.dfm}
{ TStsTagActivityLogGUI }

procedure TStsTagActivityLogGUI.btnHistoryClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormModal('TStsTagGrowthHistoryGUI', nil, initStsTagGrowthHistory, nil, false);
end;
procedure TStsTagActivityLogGUI.initStsTagGrowthHistory(Sender: TObject);
begin
  if sender is TStsTagGrowthHistoryGUI then begin
    TStsTagGrowthHistoryGUI(Sender).HistoryOfTagId := HistoryOfTagId;
  end;
end;

procedure TStsTagActivityLogGUI.FormCreate(Sender: TObject);
begin
  MakeQrymain;
  inherited;
  DisableSortoncolumtitleclick:= TRue;
  HistoryOfTagId :=0;
end;
Function TStsTagActivityLogGUI.StsTAgfield(Field: TField):Boolean;
begin
  Result :=   sametext(field.fieldname ,qrymainTagID.fieldname        ) or
              sametext(field.fieldname ,qrymainTag.fieldname          ) or
              sametext(field.fieldname ,qrymainTagPhase.fieldname     ) or
              sametext(field.fieldname ,qrymainTagUsedOn.fieldname    ) or
              sametext(field.fieldname ,qrymainTagChanged.fieldname   ) or
              sametext(field.fieldname ,qryMainPlantcount.fieldname   ) or
              sametext(field.fieldname ,qryMainChangedCount.fieldname ) or
              sametext(field.fieldname ,qryMainWastedCount.fieldname  ) or
              sametext(field.fieldname ,qryMainDestroycount.fieldname ) or
              sametext(field.fieldname ,qryMainTransferedCount.fieldname ) or
              sametext(field.fieldname ,qryMainUsedCount.fieldname ) or
              sametext(field.fieldname ,qryMainActivecount.fieldname  ) ;
end;
Function TStsTagActivityLogGUI.StsNewPhasefield(Field: TField):Boolean;
begin
  Result :=   sametext(field.fieldname ,qrymainNewPhaseQtyPerTag.fieldname ) or
              sametext(field.fieldname ,qrymainNewPhaseNoOfTags.fieldname ) or
              sametext(field.fieldname ,qrymainNewPhaseCreated.fieldname ) or
              sametext(field.fieldname ,qrymainNewPhase.fieldname ) ;
end;
Function TStsTagActivityLogGUI.StsActionfield(Field: TField):Boolean;
begin
  Result :=   sametext(field.fieldname ,qrymainAction.fieldname ) or
              sametext(field.fieldname ,qrymainActionDate.fieldname ) or
              sametext(field.fieldname ,qrymainActionDescription.fieldname ) ;
end;
procedure TStsTagActivityLogGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qryMainTagActionCtr.asInteger >1 then begin
    if StsTAgfield(Field) then begin
      DoHide(Field,State, Afont, aBrush);
    end;
  end;
  if qryMainPhaseTagCtr.asInteger >1 then begin
    if StsNewPhasefield(Field) then begin
      DoHide(Field,State, Afont, aBrush);
    end;
  end;
  if qryMainActionctr.asInteger >1 then begin
    if StsActionfield(Field) then begin
      DoHide(Field,State, Afont, aBrush);
    end;
  end;
  if (field is TIntegerField) then
    if TIntegerField(Field).value =0 then
      DoHide(Field,State, Afont, aBrush);

  if (field is TLargeintField) then
    if TLargeintField(Field).value =0 then
      DoHide(Field,State, Afont, aBrush);
end;

procedure TStsTagActivityLogGUI.MakeQrymain;
begin
  closedb(qrymain);
  Qrymain.sql.clear;
  Qrymain.sql.Add('SELECT');
  Qrymain.sql.Add(' @TagActionCtr:=if(@STSID <> STS.ID,  @TagActionCtr:= 1 ,  @TagActionCtr+1) TagActionCtr ,');
  Qrymain.sql.Add(' @STSID := STS.ID,');
  Qrymain.sql.Add('STS.ID as TagID,');
  Qrymain.sql.Add('STS.StsTag as Tag,');
  Qrymain.sql.Add('SeedToSalePhase(STS.stsphase) as TagPhase,');
  Qrymain.sql.Add('STS.UsedOn as TagUsedOn,');
  Qrymain.sql.Add('STS.Plantcount as Plantcount,');
  Qrymain.sql.Add('STS.ChangedCount as ChangedCount,');
  Qrymain.sql.Add('STS.WastedCount as WastedCount,');
  Qrymain.sql.Add('STS.Destroycount as Destroycount,');
  Qrymain.sql.Add('STS.TransferedCount as TransferedCount,');
  Qrymain.sql.Add('STS.UsedCount as UsedCount,');
  Qrymain.sql.Add('STS.Plantcount-STS.ChangedCount-STS.WastedCount-STS.Destroycount-STS.TransferedCount-STS.UsedCount AS Activecount,');
  Qrymain.sql.Add('@Actionctr:=if(ifnull(STSA.ID,0)=0 OR  @STSAID <> ifnull(STSA.ID,0),  @Actionctr:= 1 ,  @Actionctr+1) Actionctr ,');
  Qrymain.sql.Add('@STSAID := ifnull(STSA.ID,0),');
  Qrymain.sql.Add('STSA.StatusAction as  Action,');
  Qrymain.sql.Add('STSA.StatusDate as ActionDate,');
  Qrymain.sql.Add('STSA.Description as ActionDescription,');
  Qrymain.sql.Add('STSAS.StsTag as NewTag,');

  Qrymain.sql.Add('@PhaseTagCtr:=if(ifnull(STSP.ID,0)=0 OR  @STSPID <> ifnull(STSP.ID,0),  @PhaseTagCtr:= 1 ,  @PhaseTagCtr+1) PhaseTagCtr ,');
  Qrymain.sql.Add('@STSPID := ifnull(STSP.ID,0),');
  Qrymain.sql.Add('STSP.Tagchanged as TagChanged,');
  Qrymain.sql.Add('STSP.QtyPerTag as NewPhaseQtyPerTag,');
  Qrymain.sql.Add('STSP.NoofTags as NewPhaseNoOfTags,');
  Qrymain.sql.Add('STSP.PhaseCreatedOn as NewPhaseCreated,');
  Qrymain.sql.Add('SeedToSalePhase(STSP.StsPhase) as NewPhase');

  Qrymain.sql.Add('FROM ');
  Qrymain.sql.Add(' (SELECT @TagActionCtr:=-1) r1 ,');
  Qrymain.sql.Add(' (SELECT @PhaseTagCtr:=-1) r2 ,');
  Qrymain.sql.Add(' (SELECT @Actionctr:=-1) r3 ,');
  Qrymain.sql.Add(' (SELECT @STSID:=0) s1,');
  Qrymain.sql.Add(' (SELECT @STSPID:=0) s2,');
  Qrymain.sql.Add(' (SELECT @STSAID:=0) s3,');
  Qrymain.sql.Add('tblststags STS');
  Qrymain.sql.Add('LEFT JOIN tblststag_actions STSA ON STS.Id = STSA.TagID');
  Qrymain.sql.Add('LEFT JOIN tblststags STSAS     ON STSA.ID = STSAS.StSActionID');
  Qrymain.sql.Add('LEFT JOIN tblststagphases STSP ON STSP.ID = STSAS.StSTagPhaseID');
  if fiHistoryOfTagId <> 0 then
       Qrymain.sql.Add('where  STS.ID = ' + inttostr(HistoryOfTagId))
  else Qrymain.sql.Add('where ((STS.UsedOn between :Datefrom and :DateTo) '+
                        ' Or   (STSA.StatusDate between :Datefrom and :DateTo) '+
                        ' Or   (STSP.PhaseCreatedOn between :Datefrom and :DateTo)) ');
  try
    RefreshOrignalSQL;
  Except
  end;
end;

procedure TStsTagActivityLogGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;

end;

procedure TStsTagActivityLogGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainTagID.fieldname);
  RemoveFieldfromGrid(qryMainTagActionCtr.fieldname);
  RemoveFieldfromGrid(qryMainPhaseTagCtr.fieldname);
  RemoveFieldfromGrid(qryMainActionctr.fieldname);
end;

procedure TStsTagActivityLogGUI.SetHistoryOfTagId(const Value: Integer);
begin
  fiHistoryOfTagId            := Value;
  pnlHistoryOfTagDesc.Visible := Value <> 0;
  btnHistory.Visible          := Value <> 0;
  lblHistoryOfTag.caption     := quotedstr(TStSTags.IDToggle(Value));
  HaveDateRangeSelection      := (Value = 0);
  MakeQrymain;
end;

initialization
    RegisterClassOnce(TStsTagActivityLogGUI);

end.
