unit StsTagGrowthHistory;

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
  TStsTagGrowthHistoryGUI = class(TBaseListingGUI)

    btnShowcount: TDNMSpeedButton;
    qryMainImmatureRow: TLargeintField;
    qryMainVegetativeRow: TLargeintField;
    qryMainFloweringRow: TLargeintField;
    qryMainimmatureId: TIntegerField;
    qryMainimmatureStsTag: TWideStringField;
    qryMainimmatureStSPhase: TWideStringField;
    qryMainimmatureDept: TWideStringField;
    qryMainimmatureSourcetype: TWideStringField;
    qryMainimmatureUsedOn: TDateTimeField;
    qryMainimmaturePlantCount: TIntegerField;
    qryMainimmatureChangedCount: TIntegerField;
    qryMainimmatureWastedCount: TIntegerField;
    qryMainimmatureDestroycount: TIntegerField;
    qryMainimmatureTransferedCount: TIntegerField;
    qryMainimmatureUsedCount: TIntegerField;
    qryMainVegetativeId: TIntegerField;
    qryMainVegetativeStsTag: TWideStringField;
    qryMainVegetativeStSPhase: TWideStringField;
    qryMainVegetativeDept: TWideStringField;
    qryMainVegetativeSourcetype: TWideStringField;
    qryMainVegetativeUsedOn: TDateTimeField;
    qryMainVegetativePlantCount: TIntegerField;
    qryMainVegetativeChangedCount: TIntegerField;
    qryMainVegetativeWastedCount: TIntegerField;
    qryMainVegetativeDestroycount: TIntegerField;
    qryMainVegetativeTransferedCount: TIntegerField;
    qryMainVegetativeUsedCount: TIntegerField;
    qryMainFloweringId: TIntegerField;
    qryMainFloweringStsTag: TWideStringField;
    qryMainFloweringStSPhase: TWideStringField;
    qryMainFloweringDept: TWideStringField;
    qryMainFloweringSourcetype: TWideStringField;
    qryMainFloweringUsedOn: TDateTimeField;
    qryMainFloweringPlantCount: TIntegerField;
    qryMainFloweringChangedCount: TIntegerField;
    qryMainFloweringWastedCount: TIntegerField;
    qryMainFloweringDestroycount: TIntegerField;
    qryMainFloweringTransferedCount: TIntegerField;
    qryMainFloweringUsedCount: TIntegerField;
    qryMainHarvestingId: TIntegerField;
    qryMainHarvestingStsTag: TWideStringField;
    qryMainHarvestingStSPhase: TWideStringField;
    qryMainHarvestingDept: TWideStringField;
    qryMainHarvestingSourcetype: TWideStringField;
    qryMainHarvestingUsedOn: TDateTimeField;
    qryMainHarvestingPlantCount: TIntegerField;
    qryMainHarvestingChangedCount: TIntegerField;
    qryMainHarvestingWastedCount: TIntegerField;
    qryMainHarvestingDestroycount: TIntegerField;
    qryMainHarvestingTransferedCount: TIntegerField;
    qryMainHarvestingUsedCount: TIntegerField;
    qryMainimmatureCount: TLargeintField;
    qryMainVegetativeCount: TLargeintField;
    qryMainFloweringCount: TLargeintField;
    qryMainHarvestingCount: TLargeintField;
    pnlHistoryOfTagDesc: TDNMPanel;
    lblHistoryOfTagDesc: TLabel;
    lblHistoryOfTag: TLabel;
    btnTagActivity: TDNMSpeedButton;
    qryMainHarvestingRow: TIntegerField;
    qryMainHarvestWeight: TFloatField;
    qryMainHarvestUOM: TWideStringField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnTagActivityClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);
    procedure actRefreshQryExecute(Sender: TObject);
  private
    fiHistoryOfTagId: Integer;
    fsTablename :String;
    Procedure Showcolumns;
    function ISImmatureField(Field: TField): Boolean;
    function ISVegetativeField(Field: TField): Boolean;
    function ISFloweringField(Field: TField): Boolean;
    function ISHarvestingField(Field: TField): Boolean;
    Procedure MakeQrymain;
    Procedure PopulateData;
    procedure HighlightHistoryOfTag(Field: TField; AFont: TFont;
      ABrush: TBrush);
    procedure SetHistoryOfTagId(const Value: Integer);
    procedure OpenTag(const TagID: Integer);
    procedure initStsTagGrowthHistory(Sender: TObject);
    function StsGrowthhistorySQL(SQLNO:Integer): String;
  Protected
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Procedure RefreshQuery;Override;
    Property HistoryOfTagId :Integer read fiHistoryOfTagId write SetHistoryOfTagId;
  end;

implementation

uses CommonLib, TempTableUtils, CommonDbLib, LogLib, BusObjSeedToSale,
  CommonFormLib, MySQLConst, StsTagActivityLog, GuiPrefsObj, tcConst, StSConst;

{$R *.dfm}

{ TStsTagGrowthHistoryGUI }

(*procedure TStsTagGrowthHistoryGUI.btnShowcountClick(Sender: TObject);
begin
  inherited;
  if sametext(btnShowcount.caption, 'Show Count') then btnShowcount.caption := 'Hide Count' else btnShowcount.caption := 'Show Count';
  Showcolumns;
end;*)

procedure TStsTagGrowthHistoryGUI.actRefreshQryExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TStsTagGrowthHistoryGUI.btnTagActivityClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormModal('TStsTagActivityLogGUI', nil, initStsTagGrowthHistory, nil, false);
end;
procedure TStsTagGrowthHistoryGUI.initStsTagGrowthHistory(Sender: TObject);
begin
  if sender is TStsTagActivityLogGUI then begin
    TStsTagActivityLogGUI(Sender).HistoryOfTagId := HistoryOfTagId;
  end;
end;

procedure TStsTagGrowthHistoryGUI.FormCreate(Sender: TObject);
begin
  MakeQrymain;
  inherited;
  //HaveDateRangeSelection:= false;
  HistoryOfTagId := 0;
  DisableSortoncolumtitleclick:= TRue;
end;
procedure TStsTagGrowthHistoryGUI.FormDestroy(Sender: TObject);
begin
  TempTableUtils.DestroyUserTemporaryTable(GetSharedMydacConnection, fstablename);
  inherited;
end;

procedure TStsTagGrowthHistoryGUI.FormShow(Sender: TObject);
begin
  inherited;
  //Showcolumns;
end;

Function TStsTagGrowthHistoryGUI.ISImmatureField(Field: TField):Boolean;
begin
  Result := sametext(Field.fieldname , qrymainimmatureId.fieldname              ) or
            sametext(Field.fieldname , qrymainimmatureStsTag.fieldname          ) or
            sametext(Field.fieldname , qrymainimmatureStSPhase.fieldname        ) or
            sametext(Field.fieldname , qrymainimmatureDept.fieldname            ) or
            sametext(Field.fieldname , qrymainimmatureSourcetype.fieldname      ) or
            sametext(Field.fieldname , qrymainimmatureUsedOn.fieldname          ) or
            sametext(Field.fieldname , qrymainimmaturePlantCount.fieldname      ) or
            sametext(Field.fieldname , qrymainimmatureChangedCount.fieldname    ) or
            sametext(Field.fieldname , qrymainimmatureWastedCount.fieldname     ) or
            sametext(Field.fieldname , qrymainimmatureDestroycount.fieldname    ) or
            sametext(Field.fieldname , qrymainimmatureTransferedCount.fieldname ) or
            sametext(Field.fieldname , qrymainimmatureUsedCount.fieldname       ) or
            sametext(Field.fieldname , qrymainimmatureCount.fieldname           ) ;

end;
Function TStsTagGrowthHistoryGUI.ISVegetativeField(Field: TField):Boolean;
begin
  Result := sametext(Field.fieldname , qrymainVegetativeId.fieldname            ) or
            sametext(Field.fieldname , qrymainVegetativeStsTag.fieldname        ) or
            sametext(Field.fieldname , qrymainVegetativeStSPhase.fieldname      ) or
            sametext(Field.fieldname , qrymainVegetativeDept.fieldname          ) or
            sametext(Field.fieldname , qrymainVegetativeSourcetype.fieldname    ) or
            sametext(Field.fieldname , qrymainVegetativeUsedOn.fieldname        ) or
            sametext(Field.fieldname , qrymainVegetativePlantCount.fieldname    ) or
            sametext(Field.fieldname , qrymainVegetativeChangedCount.fieldname  ) or
            sametext(Field.fieldname , qrymainVegetativeWastedCount.fieldname   ) or
            sametext(Field.fieldname , qrymainVegetativeDestroycount.fieldname  ) or
            sametext(Field.fieldname , qrymainVegetativeTransferedCount.fieldname) or
            sametext(Field.fieldname , qrymainVegetativeUsedCount.fieldname     ) or
            sametext(Field.fieldname , qrymainVegetativeCount.fieldname         );
end;

Function TStsTagGrowthHistoryGUI.ISFloweringField(Field: TField):Boolean;
begin
  Result := sametext(Field.fieldname , qrymainFloweringId.fieldname             ) or
            sametext(Field.fieldname , qrymainFloweringStsTag.fieldname         ) or
            sametext(Field.fieldname , qrymainFloweringStSPhase.fieldname       ) or
            sametext(Field.fieldname , qrymainFloweringDept.fieldname           ) or
            sametext(Field.fieldname , qrymainFloweringSourcetype.fieldname     ) or
            sametext(Field.fieldname , qrymainFloweringUsedOn.fieldname         ) or
            sametext(Field.fieldname , qrymainFloweringPlantCount.fieldname     ) or
            sametext(Field.fieldname , qrymainFloweringChangedCount.fieldname   ) or
            sametext(Field.fieldname , qrymainFloweringWastedCount.fieldname    ) or
            sametext(Field.fieldname , qrymainFloweringDestroycount.fieldname   ) or
            sametext(Field.fieldname , qrymainFloweringTransferedCount.fieldname) or
            sametext(Field.fieldname , qrymainFloweringUsedCount.fieldname      ) or
            sametext(Field.fieldname , qrymainFloweringCount.fieldname          );
end;
Function TStsTagGrowthHistoryGUI.ISHarvestingField(Field: TField):Boolean;
begin
  REsult := sametext(Field.fieldname , qrymainHarvestingId.fieldname            ) or
            sametext(Field.fieldname , qrymainHarvestingStsTag.fieldname        ) or
            sametext(Field.fieldname , qrymainHarvestingStSPhase.fieldname      ) or
            sametext(Field.fieldname , qrymainHarvestingDept.fieldname          ) or
            sametext(Field.fieldname , qrymainHarvestingSourcetype.fieldname    ) or
            sametext(Field.fieldname , qrymainHarvestingUsedOn.fieldname        ) or
            sametext(Field.fieldname , qrymainHarvestingPlantCount.fieldname    ) or
            sametext(Field.fieldname , qrymainHarvestingChangedCount.fieldname  ) or
            sametext(Field.fieldname , qrymainHarvestingWastedCount.fieldname   ) or
            sametext(Field.fieldname , qrymainHarvestingDestroycount.fieldname  ) or
            sametext(Field.fieldname , qrymainHarvestingTransferedCount.fieldname) or
            sametext(Field.fieldname , qrymainHarvestingUsedCount.fieldname     ) or
            sametext(Field.fieldname , qrymainHarvestingCount.fieldname         );
end;
procedure TStsTagGrowthHistoryGUI.HighlightHistoryOfTag(Field: TField; AFont: TFont;ABrush: TBrush);
begin
  if Sametext(Field.fieldname , qrymainimmatureStsTag.fieldname) or
     Sametext(Field.fieldname , qrymainVegetativeStsTag.fieldname) or
     Sametext(Field.fieldname , qrymainFloweringStsTag.fieldname) or
     Sametext(Field.fieldname , qrymainHarvestingStsTag.fieldname)  then begin
     DohighlightCell(AFont, ABrush);
  end;
end;
procedure TStsTagGrowthHistoryGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  AFont.color := clblack;
  if ISImmatureField(Field) then
     if qrymainimmatureID.asInteger =0 then else begin
        ABrush.color := $00AAFFAA;
        if qryMainImmatureRow.asInteger   > 1 then AFont.color := ABrush.color
        else if (HistoryOfTagId<>0) and (HistoryOfTagId = qrymainimmatureID.asInteger) then HighlightHistoryOfTag(Field,Afont, ABrush);
     end;

  if ISVegetativeField(Field) then
     if qrymainVegetativeID.asInteger =0 then else begin
        ABrush.color := $0035FF35;
        if qryMainVegetativeRow.asInteger > 1 then AFont.color := ABrush.color
        else if (HistoryOfTagId<>0) and (HistoryOfTagId = qrymainVegetativeID.asInteger) then HighlightHistoryOfTag(Field,Afont, ABrush);
     end;

  if ISFloweringField(Field) then
     if qrymainFloweringID.asInteger =0 then else begin
        ABrush.color := clGreen;
        if qryMainFloweringRow.asInteger  > 1 then AFont.color := ABrush.color
        else if (HistoryOfTagId<>0) and (HistoryOfTagId = qrymainFloweringID.asInteger) then HighlightHistoryOfTag(Field,Afont, ABrush);
     end;

  if ISHarvestingField(Field) then
     if qrymainHarvestingID.asInteger =0 then else begin
        ABrush.color := $0077BBFF;
(*        if qryMainHarvestingRow.asInteger > 1 then AFont.color := ABrush.color
        else if (HistoryOfTagId<>0) and (HistoryOfTagId = qrymainHarvestingID.asInteger) then HighlightHistoryOfTag(Field,Afont, ABrush);*)
     end;

  if field is TLargeintField then
    if TLargeintField(Field).asInteger = 0 then
      Afont.color := ABrush.color;

  if field is TDateTimeField then
    if TDateTimeField(Field).asDatetime <= 1 then
      Afont.color := ABrush.color;
end;
procedure TStsTagGrowthHistoryGUI.OpenTag(Const TagID:Integer);
begin
  if fsModal in Self.FormState then
       OpenERPFormModal('TfmStSTag', TagID)
  else OpenERPForm('TfmStSTag', TagID);
end;
procedure TStsTagGrowthHistoryGUI.grdMainDblClick(Sender: TObject);
var
  Field :Tfield;
begin
  Field := ActiveField;
  if not(Assigned(Field)) then exit;

  if ISImmatureField(Field) and (qrymainimmatureID.asInteger <> 0) then begin
      OpenTag(qrymainimmatureID.asInteger);
      Exit;
  end;
  if ISVegetativeField(Field) and (qrymainVegetativeID.asInteger <> 0) then begin
      OpenTag(qrymainVegetativeID.asInteger);
      Exit;
  end;
  if ISFloweringField(Field) and (qrymainFloweringID.asInteger  <> 0) then begin
      OpenTag(qrymainFloweringID.asInteger);
      Exit;
  end;
  if ISHarvestingField(Field) and (qrymainHarvestingID.asInteger <> 0) then begin
      OpenTag(qrymainHarvestingID.asInteger);
      Exit;
  end;
  inherited;
end;

procedure TStsTagGrowthHistoryGUI.grpFiltersClick(Sender: TObject);
begin
  //inherited;
  Showcolumns;
end;

procedure TStsTagGrowthHistoryGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainimmatureCount.asInteger := qrymainimmaturePlantCount.asInteger -
                                    qrymainimmatureChangedCount.asInteger -
                                    qrymainimmatureWastedCount.asInteger -
                                    qrymainimmatureDestroycount.asInteger -
                                    qrymainimmatureTransferedCount.asInteger -
                                    qrymainimmatureUsedCount.asInteger;


  qryMainVegetativeCount.asInteger := qryMainVegetativePlantCount.asInteger -
                                      qrymainVegetativeChangedCount.asInteger -
                                      qrymainVegetativeWastedCount.asInteger -
                                      qrymainVegetativeDestroycount.asInteger -
                                      qrymainVegetativeTransferedCount.asInteger -
                                      qrymainVegetativeUsedCount.asInteger;

  qryMainFloweringCount.asInteger := qrymainFloweringPlantCount.asInteger -
                                    qrymainFloweringChangedCount.asInteger -
                                    qrymainFloweringWastedCount.asInteger -
                                    qrymainFloweringDestroycount.asInteger -
                                    qrymainFloweringTransferedCount.asInteger -
                                    qrymainFloweringUsedCount.asInteger -
                                    QrymainHarvestingPlantCount.asInteger;

  qryMainHarvestingCount.asInteger := qrymainHarvestingPlantCount.asInteger -
                                    qrymainHarvestingChangedCount.asInteger -
                                    qrymainHarvestingWastedCount.asInteger -
                                    qrymainHarvestingDestroycount.asInteger -
                                    qrymainHarvestingTransferedCount.asInteger -
                                    qrymainHarvestingUsedCount.asInteger ;

end;

procedure TStsTagGrowthHistoryGUI.Showcolumns;
(*var
  Hidecount:Boolean;*)
begin
  //Hidecount:= not(sametext(btnShowcount.caption, 'Hide Count'));
  grdmain.selected.clear;
  grdmain.selected.Add(SelectedText(QrymainimmatureStsTag.fieldname		        ,	QrymainimmatureStsTag.DisplayLabel		    ,	QrymainimmatureStsTag.DisplayWidth		    ,'Immature'	));
  grdmain.selected.Add(SelectedText(QrymainimmatureStSPhase.fieldname	        ,	QrymainimmatureStSPhase.DisplayLabel	    ,	QrymainimmatureStSPhase.DisplayWidth	    ,'Immature'	));
  if grpFilters.itemindex >0 then  grdmain.selected.Add(SelectedText(QrymainimmatureDept.fieldname	            ,	QrymainimmatureDept.DisplayLabel	        ,	QrymainimmatureDept.DisplayWidth	        ,'Immature'	));
  if grpFilters.itemindex >0 then  grdmain.selected.Add(SelectedText(QrymainimmatureSourcetype.fieldname        ,	QrymainimmatureSourcetype.DisplayLabel	  ,	QrymainimmatureSourcetype.DisplayWidth    ,'Immature'	));
  if grpFilters.itemindex >0 then  grdmain.selected.Add(SelectedText(QrymainimmatureUsedOn.fieldname		        ,	QrymainimmatureUsedOn.DisplayLabel		    ,	QrymainimmatureUsedOn.DisplayWidth		    ,'Immature'	));
  //if not Hidecount then begin
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainimmaturePlantCount.fieldname     , qryMainimmaturePlantCount.DisplayLabel    , qryMainimmaturePlantCount.DisplayWidth    , 'Immature Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainimmatureChangedCount.fieldname   , qryMainimmatureChangedCount.DisplayLabel  , qryMainimmatureChangedCount.DisplayWidth  , 'Immature Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainimmatureWastedCount.fieldname    , qryMainimmatureWastedCount.DisplayLabel   , qryMainimmatureWastedCount.DisplayWidth   , 'Immature Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainimmatureDestroycount.fieldname   , qryMainimmatureDestroycount.DisplayLabel  , qryMainimmatureDestroycount.DisplayWidth  , 'Immature Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainimmatureTransferedCount.fieldname, qryMainimmatureTransferedCount.DisplayLabel  , qryMainimmatureTransferedCount.DisplayWidth  , 'Immature Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainimmatureUsedCount.fieldname      , qryMainimmatureUsedCount.DisplayLabel     , qryMainimmatureUsedCount.DisplayWidth     , 'Immature Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(QrymainimmatureCount.fieldname		      ,	'Current'		                              ,	QrymainimmatureCount.DisplayWidth		      , 'Immature Count'	));
  //end else begin
  if grpFilters.itemindex =1 then  grdmain.selected.Add(SelectedText(QrymainimmatureCount.fieldname		      ,	QrymainimmatureCount.DisplayLabel		      ,	QrymainimmatureCount.DisplayWidth		      ,'Immature'	));
  //end;
  grdmain.selected.Add(SelectedText(QrymainVegetativeStsTag.fieldname	        ,	QrymainVegetativeStsTag.DisplayLabel	    ,	QrymainVegetativeStsTag.DisplayWidth	    ,'Vegetative'	));
  //grdmain.selected.Add(SelectedText(QrymainVegetativeStSPhase.fieldname       ,  QrymainVegetativeStSPhase.DisplayLabel   ,	QrymainVegetativeStSPhase.DisplayWidth    ,'Vegetative'	));
  if grpFilters.itemindex >0 then  grdmain.selected.Add(SelectedText(QrymainVegetativeDept.fieldname           ,  QrymainVegetativeDept.DisplayLabel       ,	QrymainVegetativeDept.DisplayWidth        ,'Vegetative'	));
  if grpFilters.itemindex >0 then  grdmain.selected.Add(SelectedText(QrymainVegetativeSourcetype.fieldname     ,  QrymainVegetativeSourcetype.DisplayLabel ,	QrymainVegetativeSourcetype.DisplayWidth  ,'Vegetative'	));
  if grpFilters.itemindex >0 then  grdmain.selected.Add(SelectedText(QrymainVegetativeUsedOn.fieldname	        ,	QrymainVegetativeUsedOn.DisplayLabel	    ,	QrymainVegetativeUsedOn.DisplayWidth	    ,'Vegetative'	));
  //if not Hidecount then begin
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainVegetativePlantCount.fieldname   , qryMainVegetativePlantCount.DisplayLabel  , qryMainVegetativePlantCount.DisplayWidth  ,'Vegetative Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainVegetativeChangedCount.fieldname , qryMainVegetativeChangedCount.DisplayLabel, qryMainVegetativeChangedCount.DisplayWidth,'Vegetative Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainVegetativeWastedCount.fieldname  , qryMainVegetativeWastedCount.DisplayLabel , qryMainVegetativeWastedCount.DisplayWidth ,'Vegetative Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainVegetativeDestroycount.fieldname , qryMainVegetativeDestroycount.DisplayLabel, qryMainVegetativeDestroycount.DisplayWidth,'Vegetative Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainVegetativeTransferedCount.fieldname , qryMainVegetativeTransferedCount.DisplayLabel, qryMainVegetativeTransferedCount.DisplayWidth,'Vegetative Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainVegetativeUsedCount.fieldname    , qryMainVegetativeUsedCount.DisplayLabel   , qryMainVegetativeUsedCount.DisplayWidth   ,'Vegetative Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(QrymainVegetativeCount.fieldname	      ,	'Current'		                              ,	QrymainVegetativeCount.DisplayWidth	      ,'Vegetative Count'	));
  //end else begin
  if grpFilters.itemindex =1 then  grdmain.selected.Add(SelectedText(QrymainVegetativeCount.fieldname	      ,	QrymainVegetativeCount.DisplayLabel	      ,	QrymainVegetativeCount.DisplayWidth	      ,'Vegetative'	));
  //end;
  grdmain.selected.Add(SelectedText(QrymainFloweringStsTag.fieldname	        ,	QrymainFloweringStsTag.DisplayLabel		    ,	QrymainFloweringStsTag.DisplayWidth		    ,'Flowering'	));
  //grdmain.selected.Add(SelectedText(QrymainFloweringStSPhase.fieldname        ,	QrymainFloweringStSPhase.DisplayLabel	    ,	QrymainFloweringStSPhase.DisplayWidth	    ,'Flowering'	));
  if grpFilters.itemindex >0 then  grdmain.selected.Add(SelectedText(QrymainFloweringDept.fieldname            ,	QrymainFloweringDept.DisplayLabel	        ,	QrymainFloweringDept.DisplayWidth	        ,'Flowering'	));
  if grpFilters.itemindex >0 then  grdmain.selected.Add(SelectedText(QrymainFloweringSourcetype.fieldname      ,	QrymainFloweringSourcetype.DisplayLabel	  ,	QrymainFloweringSourcetype.DisplayWidth	  ,'Flowering'	));
  if grpFilters.itemindex >0 then  grdmain.selected.Add(SelectedText(QrymainFloweringUsedOn.fieldname	        ,	QrymainFloweringUsedOn.DisplayLabel		    ,	QrymainFloweringUsedOn.DisplayWidth		    ,'Flowering'	));
  //if not Hidecount then begin
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainFloweringPlantCount.fieldname    , qryMainFloweringPlantCount.DisplayLabel   , qryMainFloweringPlantCount.DisplayWidth   ,'Flowering Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainFloweringChangedCount.fieldname  , qryMainFloweringChangedCount.DisplayLabel , qryMainFloweringChangedCount.DisplayWidth ,'Flowering Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainFloweringWastedCount.fieldname   , qryMainFloweringWastedCount.DisplayLabel  , qryMainFloweringWastedCount.DisplayWidth  ,'Flowering Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainFloweringDestroycount.fieldname  , qryMainFloweringDestroycount.DisplayLabel , qryMainFloweringDestroycount.DisplayWidth ,'Flowering Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainFloweringTransferedCount.fieldname , qryMainFloweringTransferedCount.DisplayLabel , qryMainFloweringTransferedCount.DisplayWidth ,'Flowering Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainFloweringUsedCount.fieldname       , qryMainFloweringUsedCount.DisplayLabel    , qryMainFloweringUsedCount.DisplayWidth    , 'Flowering Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(QrymainHarvestingPlantCount.fieldname     , QrymainHarvestingPlantCount.DisplayLabel  , QrymainHarvestingPlantCount.DisplayWidth  , 'Flowering Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(QrymainFloweringCount.fieldname	        ,	'Current'		                              ,	QrymainFloweringCount.DisplayWidth		    ,'Flowering Count'	));
  //end else begin
  if grpFilters.itemindex =1 then  grdmain.selected.Add(SelectedText(QrymainFloweringCount.fieldname	        ,	QrymainFloweringCount.DisplayLabel		    ,	QrymainFloweringCount.DisplayWidth		    ,'Flowering'	));
  //end;
  grdmain.selected.Add(SelectedText(QrymainHarvestingStsTag.fieldname	        ,	QrymainHarvestingStsTag.DisplayLabel	    ,	QrymainHarvestingStsTag.DisplayWidth	    ,'Harvesting'	));
  //grdmain.selected.Add(SelectedText(QrymainHarvestingStSPhase.fieldname       ,	QrymainHarvestingStSPhase.DisplayLabel    ,	QrymainHarvestingStSPhase.DisplayWidth    ,'Harvesting'	));
  if grpFilters.itemindex >0  then  grdmain.selected.Add(SelectedText(QrymainHarvestingDept.fieldname          ,	QrymainHarvestingDept.DisplayLabel        ,	QrymainHarvestingDept.DisplayWidth        ,'Harvesting'	));
  if grpFilters.itemindex >0  then  grdmain.selected.Add(SelectedText(QrymainHarvestingSourcetype.fieldname    ,	QrymainHarvestingSourcetype.DisplayLabel  ,	QrymainHarvestingSourcetype.DisplayWidth  ,'Harvesting'	));
  if grpFilters.itemindex >0  then  grdmain.selected.Add(SelectedText(QrymainHarvestingUsedOn.fieldname	      ,	QrymainHarvestingUsedOn.DisplayLabel	    ,	QrymainHarvestingUsedOn.DisplayWidth	    ,'Harvesting'	));
  if grpFilters.itemindex >=1 then  grdmain.selected.Add(SelectedText(QrymainHarvestWeight.fieldname           , QrymainHarvestWeight.DisplayLabel         , QrymainHarvestWeight.DisplayWidth         ,'Harvesting' ));
  if grpFilters.itemindex >=1 then  grdmain.selected.Add(SelectedText(QrymainHarvestUOM.fieldname              , QrymainHarvestUOM.DisplayLabel            , QrymainHarvestUOM.DisplayWidth            ,'Harvesting' ));
  //if not Hidecount then begin
  (*if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainHarvestingPlantCount.fieldname   , qryMainHarvestingPlantCount.DisplayLabel  , qryMainHarvestingPlantCount.DisplayWidth  ,'Harvesting Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainHarvestingChangedCount.fieldname , qryMainHarvestingChangedCount.DisplayLabel, qryMainHarvestingChangedCount.DisplayWidth,'Harvesting Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainHarvestingWastedCount.fieldname  , qryMainHarvestingWastedCount.DisplayLabel , qryMainHarvestingWastedCount.DisplayWidth ,'Harvesting Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainHarvestingDestroycount.fieldname , qryMainHarvestingDestroycount.DisplayLabel, qryMainHarvestingDestroycount.DisplayWidth,'Harvesting Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainHarvestingTransferedCount.fieldname , qryMainHarvestingTransferedCount.DisplayLabel, qryMainHarvestingTransferedCount.DisplayWidth,'Harvesting Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(qryMainHarvestingUsedCount.fieldname    , qryMainHarvestingUsedCount.DisplayLabel   , qryMainHarvestingUsedCount.DisplayWidth   ,'Harvesting Count' ));
  if grpFilters.itemindex >1 then  grdmain.selected.Add(SelectedText(QrymainHarvestingCount.fieldname	      ,	'Current'		                              ,	QrymainHarvestingCount.DisplayWidth	      ,'Harvesting Count'	));*)
  //end else begin
  //if grpFilters.itemindex =1 then  grdmain.selected.Add(SelectedText(QrymainHarvestingCount.fieldname	      ,	QrymainHarvestingCount.DisplayLabel	      ,	QrymainHarvestingCount.DisplayWidth	      ,'Harvesting'	));
  //end;
  grdmain.Applyselected;
  TwwDbGridGuiElement(GuiPrefs.DbGridElement[grdMain]).UpdateGridSelected(grdMain.Selected.Text);
  GuiPrefs.SavePrefs;
end;

procedure TStsTagGrowthHistoryGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
(*  if GuiPrefs.Node.Exists('Options.Hidecolumns') then
    if not(GuiPrefs.Node['Options.Hidecolumns'].asBoolean) then
        btnShowcount.caption := 'Hide Count' else btnShowcount.caption := 'Show Count';*)

end;

procedure TStsTagGrowthHistoryGUI.WriteGuiPrefExtra;
begin
  inherited;
(*  GuiPrefs.Node['Options.Hidecolumns'].asBoolean := not(sametext(btnShowcount.caption ,'Hide Count'));*)

end;

procedure TStsTagGrowthHistoryGUI.RefreshQuery;
begin
  PopulateData;
  inherited;
end;
procedure TStsTagGrowthHistoryGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainimmatureId.Fieldname);
  RemoveFieldfromGrid(qryMainVegetativeId.Fieldname);
  RemoveFieldfromGrid(qryMainFloweringId.Fieldname);
  RemoveFieldfromGrid(qryMainHarvestingId.Fieldname);
  RemoveFieldfromGrid(qryMainimmatureRow.Fieldname);
  RemoveFieldfromGrid(qryMainVegetativeRow.Fieldname);
  RemoveFieldfromGrid(qryMainFloweringRow.Fieldname);
  RemoveFieldfromGrid(qryMainHarvestingRow.Fieldname);
end;

procedure TStsTagGrowthHistoryGUI.SetHistoryOfTagId(const Value: Integer);
begin
  fiHistoryOfTagId := Value;
  pnlHistoryOfTagDesc.Visible := Value <> 0;
  btnTagActivity.Visible := Value <> 0;
  lblHistoryOfTag.caption := quotedstr(TStSTags.IDToggle(Value));
  HaveDateRangeSelection:= (Value = 0);
end;

procedure TStsTagGrowthHistoryGUI.MakeQrymain;
begin
  fsTablename := commondbLib.GetUserTemporaryTableName('StSGH' );
  Qrymain.sql.clear;
  Qrymain.sql.add('Select');
  Qrymain.sql.add('*');
  Qrymain.sql.add('from ' + fstablename );
end;

function TStsTagGrowthHistoryGUI.StsGrowthhistorySQL(SQLNO:Integer):String;
Function dateFromSQL:String;
begin
  result := Quotedstr(FormatDateTime(MysqlDateTimeFormat , FilterDateFrom));
end;
Function dateToSQL:String;
begin
  result := Quotedstr(FormatDateTime(MysqlDateTimeFormat , FilterDateTo));
end;
begin
if SQLNO = 1 then
  result := ' SELECT ' +NL+
                '                    if(STS1.StSPhase="I", STS1.ID            , if(STS2.StSPhase="I", STS2.ID           , if(STS3.StSPhase="I", STS3.ID             , if(STS4.StSPhase="I", STS4.ID             ' (* +', if(STS5.StSPhase="I", STS5.ID , 0)' *)           +',0)))) AS immatureId, ' +NL+
                '                    if(STS1.StSPhase="V", STS1.ID            , if(STS2.StSPhase="V", STS2.ID           , if(STS3.StSPhase="V", STS3.ID             , if(STS4.StSPhase="V", STS4.ID             ' (* +', if(STS5.StSPhase="V", STS5.ID , 0)' *)           +',0)))) AS VegetativeId, ' +NL+
                '                    if(STS1.StSPhase="F", STS1.ID            , if(STS2.StSPhase="F", STS2.ID           , if(STS3.StSPhase="F", STS3.ID             , if(STS4.StSPhase="F", STS4.ID             ' (* +', if(STS5.StSPhase="F", STS5.ID , 0)' *)           +',0)))) AS FloweringId, ' +NL+
//                '                    if(STS1.StSPhase="H", STS1.ID            , if(STS2.StSPhase="H", STS2.ID           , if(STS3.StSPhase="H", STS3.ID             , if(STS4.StSPhase="H", STS4.ID             ' (* +', if(STS5.StSPhase="H", STS5.ID , 0)' *)           +',0)))) AS HarvestingId, ' +NL+NL+

                '                    if(STS1.StSPhase="I", STS1.Dept          , if(STS2.StSPhase="I", STS2.Dept         , if(STS3.StSPhase="I", STS3.Dept           , if(STS4.StSPhase="I", STS4.Dept           ' (* +', if(STS5.StSPhase="I", STS5.Dept, "")' *)         +',"")))) AS immatureDept, ' +NL+
                '                    if(STS1.StSPhase="V", STS1.Dept          , if(STS2.StSPhase="V", STS2.Dept         , if(STS3.StSPhase="V", STS3.Dept           , if(STS4.StSPhase="V", STS4.Dept           ' (* +', if(STS5.StSPhase="V", STS5.Dept, "")' *)         +',"")))) AS VegetativeDept, ' +NL+
                '                    if(STS1.StSPhase="F", STS1.Dept          , if(STS2.StSPhase="F", STS2.Dept         , if(STS3.StSPhase="F", STS3.Dept           , if(STS4.StSPhase="F", STS4.Dept           ' (* +', if(STS5.StSPhase="F", STS5.Dept, "")' *)         +',"")))) AS FloweringDept, ' +NL+
//                '                    if(STS1.StSPhase="H", STS1.Dept          , if(STS2.StSPhase="H", STS2.Dept         , if(STS3.StSPhase="H", STS3.Dept           , if(STS4.StSPhase="H", STS4.Dept           ' (* +', if(STS5.StSPhase="H", STS5.Dept, "")' *)         +',"")))) AS HarvestingDept, ' +NL+NL+

                '                    if(STS1.StSPhase="I", STS1.Sourcetype    , if(STS2.StSPhase="I", STS2.Sourcetype   , if(STS3.StSPhase="I", STS3.Sourcetype     , if(STS4.StSPhase="I", STS4.Sourcetype     ' (* +', if(STS5.StSPhase="I", STS5.Sourcetype, "")' *)         +',"")))) AS immatureSourcetype, ' +NL+
                '                    if(STS1.StSPhase="V", STS1.Sourcetype    , if(STS2.StSPhase="V", STS2.Sourcetype   , if(STS3.StSPhase="V", STS3.Sourcetype     , if(STS4.StSPhase="V", STS4.Sourcetype     ' (* +', if(STS5.StSPhase="V", STS5.Sourcetype, "")' *)         +',"")))) AS VegetativeSourcetype, ' +NL+
                '                    if(STS1.StSPhase="F", STS1.Sourcetype    , if(STS2.StSPhase="F", STS2.Sourcetype   , if(STS3.StSPhase="F", STS3.Sourcetype     , if(STS4.StSPhase="F", STS4.Sourcetype     ' (* +', if(STS5.StSPhase="F", STS5.Sourcetype, "")' *)         +',"")))) AS FloweringSourcetype, ' +NL+
//                '                    if(STS1.StSPhase="H", STS1.Sourcetype    , if(STS2.StSPhase="H", STS2.Sourcetype   , if(STS3.StSPhase="H", STS3.Sourcetype     , if(STS4.StSPhase="H", STS4.Sourcetype     ' (* +', if(STS5.StSPhase="H", STS5.Sourcetype, "")' *)         +',"")))) AS HarvestingSourcetype, ' +NL+NL+


                '                    if(STS1.StSPhase="I", STS1.StsTag        , if(STS2.StSPhase="I", STS2.StsTag       , if(STS3.StSPhase="I", STS3.StsTag         , if(STS4.StSPhase="I", STS4.StsTag         ' (* +', if(STS5.StSPhase="I", STS5.StsTag, "")' *)       +',"")))) AS immatureStsTag, ' +NL+
                '                    if(STS1.StSPhase="V", STS1.StsTag        , if(STS2.StSPhase="V", STS2.StsTag       , if(STS3.StSPhase="V", STS3.StsTag         , if(STS4.StSPhase="V", STS4.StsTag         ' (* +', if(STS5.StSPhase="V", STS5.StsTag, "")' *)       +',"")))) AS VegetativeStsTag, ' + NL+
                '                    if(STS1.StSPhase="F", STS1.StsTag        , if(STS2.StSPhase="F", STS2.StsTag       , if(STS3.StSPhase="F", STS3.StsTag         , if(STS4.StSPhase="F", STS4.StsTag         ' (* +', if(STS5.StSPhase="F", STS5.StsTag, "")' *)       +',"")))) AS FloweringStsTag, ' +NL+
//                '                    if(STS1.StSPhase="H", STS1.StsTag        , if(STS2.StSPhase="H", STS2.StsTag       , if(STS3.StSPhase="H", STS3.StsTag         , if(STS4.StSPhase="H", STS4.StsTag         ' (* +', if(STS5.StSPhase="H", STS5.StsTag, "")' *)       +',"")))) AS HarvestingStsTag, ' +NL+NL+

                ' StsPhaseCodetoDesc(if(STS1.StSPhase="I", STS1.StSPhase      , if(STS2.StSPhase="I", STS2.StSPhase     , if(STS3.StSPhase="I", STS3.StSPhase       , if(STS4.StSPhase="I", STS4.StSPhase       ' (* +', if(STS5.StSPhase="I", STS5.StSPhase, "")' *)     +',""))))) AS immatureStSPhase, ' +NL+
                ' StsPhaseCodetoDesc(if(STS1.StSPhase="V", STS1.StSPhase      , if(STS2.StSPhase="V", STS2.StSPhase     , if(STS3.StSPhase="V", STS3.StSPhase       , if(STS4.StSPhase="V", STS4.StSPhase       ' (* +', if(STS5.StSPhase="V", STS5.StSPhase, "")' *)     +',""))))) AS VegetativeStSPhase, ' +NL+
                ' StsPhaseCodetoDesc(if(STS1.StSPhase="F", STS1.StSPhase      , if(STS2.StSPhase="F", STS2.StSPhase     , if(STS3.StSPhase="F", STS3.StSPhase       , if(STS4.StSPhase="F", STS4.StSPhase       ' (* +', if(STS5.StSPhase="F", STS5.StSPhase, "")' *)     +',""))))) AS FloweringStSPhase, ' +NL+
//                ' StsPhaseCodetoDesc(if(STS1.StSPhase="H", STS1.StSPhase      , if(STS2.StSPhase="H", STS2.StSPhase     , if(STS3.StSPhase="H", STS3.StSPhase       , if(STS4.StSPhase="H", STS4.StSPhase       ' (* +', if(STS5.StSPhase="H", STS5.StSPhase, "")' *)     +',""))))) AS HarvestingStSPhase, ' +NL+NL+

                '            convert(if(STS1.StSPhase="I", STS1.UsedOn        , if(STS2.StSPhase="I", STS2.UsedOn       , if(STS3.StSPhase="I", STS3.UsedOn         , if(STS4.StSPhase="I", STS4.UsedOn         ' (* +', if(STS5.StSPhase="I", STS5.UsedOn , Null)' *)    +', Null)))), DATETIME) AS immatureUsedOn, ' +NL+
                '            convert(if(STS1.StSPhase="V", STS1.UsedOn        , if(STS2.StSPhase="V", STS2.UsedOn       , if(STS3.StSPhase="V", STS3.UsedOn         , if(STS4.StSPhase="V", STS4.UsedOn         ' (* +', if(STS5.StSPhase="V", STS5.UsedOn , Null)' *)    +', Null)))), DATETIME) AS VegetativeUsedOn, ' +NL+
                '            convert(if(STS1.StSPhase="F", STS1.UsedOn        , if(STS2.StSPhase="F", STS2.UsedOn       , if(STS3.StSPhase="F", STS3.UsedOn         , if(STS4.StSPhase="F", STS4.UsedOn         ' (* +', if(STS5.StSPhase="F", STS5.UsedOn , Null)' *)    +', Null)))), DATETIME) AS FloweringUsedOn, ' +NL+
//                '            convert(if(STS1.StSPhase="H", STS1.UsedOn        , if(STS2.StSPhase="H", STS2.UsedOn       , if(STS3.StSPhase="H", STS3.UsedOn         , if(STS4.StSPhase="H", STS4.UsedOn         ' (* +', if(STS5.StSPhase="H", STS5.UsedOn , Null)' *)    +', Null)))), DATETIME) AS HarvestingUsedOn, ' +  NL+NL+

                '                    if(STS1.StSPhase="I", STS1.PlantCount    , if(STS2.StSPhase="I", STS2.PlantCount   , if(STS3.StSPhase="I", STS3.PlantCount     , if(STS4.StSPhase="I", STS4.PlantCount     ' (* +', if(STS5.StSPhase="I", STS5.PlantCount , 0)' *)   +',0)))) AS immaturePlantCount, ' +NL+
                '                    if(STS1.StSPhase="V", STS1.PlantCount    , if(STS2.StSPhase="V", STS2.PlantCount   , if(STS3.StSPhase="V", STS3.PlantCount     , if(STS4.StSPhase="V", STS4.PlantCount     ' (* +', if(STS5.StSPhase="V", STS5.PlantCount , 0)' *)   +',0)))) AS VegetativePlantCount, ' +NL+
                '                    if(STS1.StSPhase="F", STS1.PlantCount    , if(STS2.StSPhase="F", STS2.PlantCount   , if(STS3.StSPhase="F", STS3.PlantCount     , if(STS4.StSPhase="F", STS4.PlantCount     ' (* +', if(STS5.StSPhase="F", STS5.PlantCount , 0)' *)   +',0)))) AS FloweringPlantCount, ' +NL+
//                '                    if(STS1.StSPhase="H", STS1.PlantCount    , if(STS2.StSPhase="H", STS2.PlantCount   , if(STS3.StSPhase="H", STS3.PlantCount     , if(STS4.StSPhase="H", STS4.PlantCount     ' (* +', if(STS5.StSPhase="H", STS5.PlantCount , 0)' *)   +',0)))) AS HarvestingPlantCount, ' +NL+NL+

                '                    if(STS1.StSPhase="I", STS1.ChangedCount  , if(STS2.StSPhase="I", STS2.ChangedCount  , if(STS3.StSPhase="I", STS3.ChangedCount  , if(STS4.StSPhase="I", STS4.ChangedCount   ' (* +', if(STS5.StSPhase="I", STS5.ChangedCount , 0)' *) +',0)))) AS immatureChangedCount, ' +NL+
                '                    if(STS1.StSPhase="V", STS1.ChangedCount  , if(STS2.StSPhase="V", STS2.ChangedCount  , if(STS3.StSPhase="V", STS3.ChangedCount  , if(STS4.StSPhase="V", STS4.ChangedCount   ' (* +', if(STS5.StSPhase="V", STS5.ChangedCount , 0)' *) +',0)))) AS VegetativeChangedCount, ' +NL+
                '                    if(STS1.StSPhase="F", STS1.ChangedCount  , if(STS2.StSPhase="F", STS2.ChangedCount  , if(STS3.StSPhase="F", STS3.ChangedCount  , if(STS4.StSPhase="F", STS4.ChangedCount   ' (* +', if(STS5.StSPhase="F", STS5.ChangedCount , 0)' *) +',0)))) AS FloweringChangedCount, ' +NL+
//                '                    if(STS1.StSPhase="H", STS1.ChangedCount  , if(STS2.StSPhase="H", STS2.ChangedCount  , if(STS3.StSPhase="H", STS3.ChangedCount  , if(STS4.StSPhase="H", STS4.ChangedCount   ' (* +', if(STS5.StSPhase="H", STS5.ChangedCount , 0)' *) +',0)))) AS HarvestingChangedCount, ' +NL+NL+

                '                    if(STS1.StSPhase="I", STS1.WastedCount   , if(STS2.StSPhase="I", STS2.WastedCount   , if(STS3.StSPhase="I", STS3.WastedCount   , if(STS4.StSPhase="I", STS4.WastedCount    ' (* +', if(STS5.StSPhase="I", STS5.WastedCount , 0)' *)  +',0)))) AS immatureWastedCount, ' +NL+
                '                    if(STS1.StSPhase="V", STS1.WastedCount   , if(STS2.StSPhase="V", STS2.WastedCount   , if(STS3.StSPhase="V", STS3.WastedCount   , if(STS4.StSPhase="V", STS4.WastedCount    ' (* +', if(STS5.StSPhase="V", STS5.WastedCount , 0)' *)  +',0)))) AS VegetativeWastedCount, ' +NL+
                '                    if(STS1.StSPhase="F", STS1.WastedCount   , if(STS2.StSPhase="F", STS2.WastedCount   , if(STS3.StSPhase="F", STS3.WastedCount   , if(STS4.StSPhase="F", STS4.WastedCount    ' (* +', if(STS5.StSPhase="F", STS5.WastedCount , 0)' *)  +',0)))) AS FloweringWastedCount, ' +NL+
//                '                    if(STS1.StSPhase="H", STS1.WastedCount   , if(STS2.StSPhase="H", STS2.WastedCount   , if(STS3.StSPhase="H", STS3.WastedCount   , if(STS4.StSPhase="H", STS4.WastedCount    ' (* +', if(STS5.StSPhase="H", STS5.WastedCount , 0)' *)  +',0)))) AS HarvestingWastedCount, ' +NL+NL+

                '                    if(STS1.StSPhase="I", STS1.Destroycount  , if(STS2.StSPhase="I", STS2.Destroycount  , if(STS3.StSPhase="I", STS3.Destroycount  , if(STS4.StSPhase="I", STS4.Destroycount   ' (* +', if(STS5.StSPhase="I", STS5.Destroycount , 0)' *) +',0)))) AS immatureDestroycount, ' +NL+
                '                    if(STS1.StSPhase="V", STS1.Destroycount  , if(STS2.StSPhase="V", STS2.Destroycount  , if(STS3.StSPhase="V", STS3.Destroycount  , if(STS4.StSPhase="V", STS4.Destroycount   ' (* +', if(STS5.StSPhase="V", STS5.Destroycount , 0)' *) +',0)))) AS VegetativeDestroycount, ' +NL+
                '                    if(STS1.StSPhase="F", STS1.Destroycount  , if(STS2.StSPhase="F", STS2.Destroycount  , if(STS3.StSPhase="F", STS3.Destroycount  , if(STS4.StSPhase="F", STS4.Destroycount   ' (* +', if(STS5.StSPhase="F", STS5.Destroycount , 0)' *) +',0)))) AS FloweringDestroycount, ' +NL+
//                '                    if(STS1.StSPhase="H", STS1.Destroycount  , if(STS2.StSPhase="H", STS2.Destroycount  , if(STS3.StSPhase="H", STS3.Destroycount  , if(STS4.StSPhase="H", STS4.Destroycount   ' (* +', if(STS5.StSPhase="H", STS5.Destroycount , 0)' *) +',0)))) AS HarvestingDestroycount, ' +NL+NL+

                '                    if(STS1.StSPhase="I",STS1.TransferedCount, if(STS2.StSPhase="I",STS2.TransferedCount, if(STS3.StSPhase="I",STS3.TransferedCount, if(STS4.StSPhase="I",STS4.TransferedCount ' (* +',if(STS5.StSPhase="I",STS5.TransferedCount, 0)' *) +',0)))) AS immatureTransferedCount,' +NL+
                '                    if(STS1.StSPhase="V",STS1.TransferedCount, if(STS2.StSPhase="V",STS2.TransferedCount, if(STS3.StSPhase="V",STS3.TransferedCount, if(STS4.StSPhase="V",STS4.TransferedCount ' (* +',if(STS5.StSPhase="V",STS5.TransferedCount, 0)' *) +',0)))) AS VegetativeTransferedCount,' +NL+
                '                    if(STS1.StSPhase="F",STS1.TransferedCount, if(STS2.StSPhase="F",STS2.TransferedCount, if(STS3.StSPhase="F",STS3.TransferedCount, if(STS4.StSPhase="F",STS4.TransferedCount ' (* +',if(STS5.StSPhase="F",STS5.TransferedCount, 0)' *) +',0)))) AS FloweringTransferedCount,' +NL+
//                '                    if(STS1.StSPhase="H",STS1.TransferedCount, if(STS2.StSPhase="H",STS2.TransferedCount, if(STS3.StSPhase="H",STS3.TransferedCount, if(STS4.StSPhase="H",STS4.TransferedCount ' (* +',if(STS5.StSPhase="H",STS5.TransferedCount, 0)' *) +',0)))) AS HarvestingTransferedCount,' +NL+NL+

                '                    if(STS1.StSPhase="I", STS1.UsedCount     , if(STS2.StSPhase="I", STS2.UsedCount     , if(STS3.StSPhase="I", STS3.UsedCount     , if(STS4.StSPhase="I", STS4.UsedCount      ' (* +', if(STS5.StSPhase="I", STS5.UsedCount , 0)' *)    +',0)))) AS immatureUsedCount, ' +NL+
                '                    if(STS1.StSPhase="V", STS1.UsedCount     , if(STS2.StSPhase="V", STS2.UsedCount     , if(STS3.StSPhase="V", STS3.UsedCount     , if(STS4.StSPhase="V", STS4.UsedCount      ' (* +', if(STS5.StSPhase="V", STS5.UsedCount , 0)' *)    +',0)))) AS VegetativeUsedCount, ' +NL+
                '                    if(STS1.StSPhase="F", STS1.UsedCount     , if(STS2.StSPhase="F", STS2.UsedCount     , if(STS3.StSPhase="F", STS3.UsedCount     , if(STS4.StSPhase="F", STS4.UsedCount      ' (* +', if(STS5.StSPhase="F", STS5.UsedCount , 0)' *)    +',0)))) AS FloweringUsedCount ' +NL+
//                '                    if(STS1.StSPhase="H", STS1.UsedCount     , if(STS2.StSPhase="H", STS2.UsedCount     , if(STS3.StSPhase="H", STS3.UsedCount     , if(STS4.StSPhase="H", STS4.UsedCount      ' (* +', if(STS5.StSPhase="H", STS5.UsedCount , 0)' *)    +',0)))) AS HarvestingUsedCount ' +NL+NL+

                '  FROM tblststags STS1 ' +NL+
                '  LEFT JOIN tblststags STS2 ON STS1.Id = STS2.SourceTagID  ' +(*' AND STS2.StSPhase="V" ' + *) ' AND   STS1.DeptID = STS2.DeptID AND STS1.StsPhase <> STS2.StsPhase '+ NL+
                '  LEFT JOIN tblststags STS3 ON STS2.Id = STS3.SourceTagID  ' +(* ' AND STS3.StSPhase="F" ' +*) ' AND   STS2.DeptID = STS3.DeptID AND STS2.StsPhase <> STS3.StsPhase '+ NL+
                '  LEFT JOIN tblststags STS4 ON STS3.Id = STS4.SourceTagID  ' +(* ' AND STS4.StSPhase="H" ' +*) ' AND   STS3.DeptID = STS4.DeptID AND STS3.StsPhase <> STS4.StsPhase '+ NL+
                (*'  LEFT JOIN tblststags STS5 ON STS4.Id = STS5.SourceTagID  AND STS4.StSPhase="P" ' +*)
                '  WHERE  ((IFNULL(STS1.SourceTagID,0) =0) OR (STS1.StSPhase="I") ) ' +NL+
                iif(HistoryOfTagId<> 0, ' And (STS1.Id = ' + inttostr(HistoryOfTagId) +' OR '+
                                          'STS2.Id = ' + inttostr(HistoryOfTagId) +' OR '+
                                          'STS3.Id = ' + inttostr(HistoryOfTagId) +' OR '+
                                          'STS4.Id = ' + inttostr(HistoryOfTagId) +(*' OR '+
                                          'STS5.Id = ' + inttostr(HistoryOfTagId) +*)')'+NL,'')+
                ' Having ((immatureUsedOn between '+ dateFromSQL+' and '+DateToSQL+')  '+
                ' OR (VegetativeUsedOn between '+ dateFromSQL+' and '+DateToSQL+') '+
                //' OR (HarvestingUsedOn between '+ dateFromSQL+' and '+DateToSQL+') '+
                ' OR (FloweringUsedOn between '+ dateFromSQL+' and '+DateToSQL+')) ';

        if SQLNO = 2 then
                Result := ' SELECT ' +NL+
                '                    if(STS1.StSPhase="I", STS1.ID            , '+'if(STS2.StSPhase="I", STS2.ID           , '+'if(STS3.StSPhase="I", STS3.ID             , '+'if(STS4.StSPhase="I", STS4.ID             , '+'if(STS5.StSPhase="I", STS5.ID           , '+'if(STS6.StSPhase="I", STS6.ID           , '+'if(STS7.StSPhase="I", STS7.ID           , '+'if(STS8.StSPhase="I", STS8.ID , 0)))))))) AS immatureId, ' +NL+
                '                    if(STS1.StSPhase="V", STS1.ID            , '+'if(STS2.StSPhase="V", STS2.ID           , '+'if(STS3.StSPhase="V", STS3.ID             , '+'if(STS4.StSPhase="V", STS4.ID             , '+'if(STS5.StSPhase="V", STS5.ID           , '+'if(STS6.StSPhase="V", STS6.ID           , '+'if(STS7.StSPhase="V", STS7.ID           , '+'if(STS8.StSPhase="V", STS8.ID , 0)))))))) AS VegetativeId, ' +NL+
                '                    if(STS1.StSPhase="F", STS1.ID            , '+'if(STS2.StSPhase="F", STS2.ID           , '+'if(STS3.StSPhase="F", STS3.ID             , '+'if(STS4.StSPhase="F", STS4.ID             , '+'if(STS5.StSPhase="F", STS5.ID           , '+'if(STS6.StSPhase="F", STS6.ID           , '+'if(STS7.StSPhase="F", STS7.ID           , '+'if(STS8.StSPhase="F", STS8.ID , 0)))))))) AS FloweringId, ' +NL+
//                '                    if(STS1.StSPhase="H", STS1.ID            , '+'if(STS2.StSPhase="H", STS2.ID           , '+'if(STS3.StSPhase="H", STS3.ID             , '+'if(STS4.StSPhase="H", STS4.ID             , '+'if(STS5.StSPhase="H", STS5.ID           , '+'if(STS6.StSPhase="H", STS6.ID           , '+'if(STS7.StSPhase="H", STS7.ID           , '+'if(STS8.StSPhase="H", STS8.ID , 0)))))))) AS HarvestingId, ' +NL+NL+

                '                    if(STS1.StSPhase="I", STS1.Dept          , '+'if(STS2.StSPhase="I", STS2.Dept         , '+'if(STS3.StSPhase="I", STS3.Dept           , '+'if(STS4.StSPhase="I", STS4.Dept           , '+'if(STS5.StSPhase="I", STS5.Dept         , '+'if(STS6.StSPhase="I", STS6.Dept         , '+'if(STS7.StSPhase="I", STS7.Dept         , '+'if(STS8.StSPhase="I", STS8.Dept, "")))))))) AS immatureDept, ' +NL+
                '                    if(STS1.StSPhase="V", STS1.Dept          , '+'if(STS2.StSPhase="V", STS2.Dept         , '+'if(STS3.StSPhase="V", STS3.Dept           , '+'if(STS4.StSPhase="V", STS4.Dept           , '+'if(STS5.StSPhase="V", STS5.Dept         , '+'if(STS6.StSPhase="V", STS6.Dept         , '+'if(STS7.StSPhase="V", STS7.Dept         , '+'if(STS8.StSPhase="V", STS8.Dept, "")))))))) AS VegetativeDept, ' +NL+
                '                    if(STS1.StSPhase="F", STS1.Dept          , '+'if(STS2.StSPhase="F", STS2.Dept         , '+'if(STS3.StSPhase="F", STS3.Dept           , '+'if(STS4.StSPhase="F", STS4.Dept           , '+'if(STS5.StSPhase="F", STS5.Dept         , '+'if(STS6.StSPhase="F", STS6.Dept         , '+'if(STS7.StSPhase="F", STS7.Dept         , '+'if(STS8.StSPhase="F", STS8.Dept, "")))))))) AS FloweringDept, ' +NL+
//                '                    if(STS1.StSPhase="H", STS1.Dept          , '+'if(STS2.StSPhase="H", STS2.Dept         , '+'if(STS3.StSPhase="H", STS3.Dept           , '+'if(STS4.StSPhase="H", STS4.Dept           , '+'if(STS5.StSPhase="H", STS5.Dept         , '+'if(STS6.StSPhase="H", STS6.Dept         , '+'if(STS7.StSPhase="H", STS7.Dept         , '+'if(STS8.StSPhase="H", STS8.Dept, "")))))))) AS HarvestingDept, ' +NL+NL+

                '                    if(STS1.StSPhase="I", STS1.Sourcetype          , '+'if(STS2.StSPhase="I", STS2.Sourcetype         , '+'if(STS3.StSPhase="I", STS3.Sourcetype           , '+'if(STS4.StSPhase="I", STS4.Sourcetype           , '+'if(STS5.StSPhase="I", STS5.Sourcetype         , '+'if(STS6.StSPhase="I", STS6.Sourcetype         , '+'if(STS7.StSPhase="I", STS7.Sourcetype         , '+'if(STS8.StSPhase="I", STS8.Sourcetype, "")))))))) AS immatureSourcetype, ' +NL+
                '                    if(STS1.StSPhase="V", STS1.Sourcetype          , '+'if(STS2.StSPhase="V", STS2.Sourcetype         , '+'if(STS3.StSPhase="V", STS3.Sourcetype           , '+'if(STS4.StSPhase="V", STS4.Sourcetype           , '+'if(STS5.StSPhase="V", STS5.Sourcetype         , '+'if(STS6.StSPhase="V", STS6.Sourcetype         , '+'if(STS7.StSPhase="V", STS7.Sourcetype         , '+'if(STS8.StSPhase="V", STS8.Sourcetype, "")))))))) AS VegetativeSourcetype, ' +NL+
                '                    if(STS1.StSPhase="F", STS1.Sourcetype          , '+'if(STS2.StSPhase="F", STS2.Sourcetype         , '+'if(STS3.StSPhase="F", STS3.Sourcetype           , '+'if(STS4.StSPhase="F", STS4.Sourcetype           , '+'if(STS5.StSPhase="F", STS5.Sourcetype         , '+'if(STS6.StSPhase="F", STS6.Sourcetype         , '+'if(STS7.StSPhase="F", STS7.Sourcetype         , '+'if(STS8.StSPhase="F", STS8.Sourcetype, "")))))))) AS FloweringSourcetype, ' +NL+
//                '                    if(STS1.StSPhase="H", STS1.Sourcetype          , '+'if(STS2.StSPhase="H", STS2.Sourcetype         , '+'if(STS3.StSPhase="H", STS3.Sourcetype           , '+'if(STS4.StSPhase="H", STS4.Sourcetype           , '+'if(STS5.StSPhase="H", STS5.Sourcetype         , '+'if(STS6.StSPhase="H", STS6.Sourcetype         , '+'if(STS7.StSPhase="H", STS7.Sourcetype         , '+'if(STS8.StSPhase="H", STS8.Sourcetype, "")))))))) AS HarvestingSourcetype, ' +NL+NL+

                '                    if(STS1.StSPhase="I", STS1.StsTag        , '+'if(STS2.StSPhase="I", STS2.StsTag       , '+'if(STS3.StSPhase="I", STS3.StsTag         , '+'if(STS4.StSPhase="I", STS4.StsTag         , '+'if(STS5.StSPhase="I", STS5.StsTag       , '+'if(STS6.StSPhase="I", STS6.StsTag       , '+'if(STS7.StSPhase="I", STS7.StsTag       , '+'if(STS8.StSPhase="I", STS8.StsTag, "")))))))) AS immatureStsTag, ' +NL+
                '                    if(STS1.StSPhase="V", STS1.StsTag        , '+'if(STS2.StSPhase="V", STS2.StsTag       , '+'if(STS3.StSPhase="V", STS3.StsTag         , '+'if(STS4.StSPhase="V", STS4.StsTag         , '+'if(STS5.StSPhase="V", STS5.StsTag       , '+'if(STS6.StSPhase="V", STS6.StsTag       , '+'if(STS7.StSPhase="V", STS7.StsTag       , '+'if(STS8.StSPhase="V", STS8.StsTag, "")))))))) AS VegetativeStsTag, ' + NL+
                '                    if(STS1.StSPhase="F", STS1.StsTag        , '+'if(STS2.StSPhase="F", STS2.StsTag       , '+'if(STS3.StSPhase="F", STS3.StsTag         , '+'if(STS4.StSPhase="F", STS4.StsTag         , '+'if(STS5.StSPhase="F", STS5.StsTag       , '+'if(STS6.StSPhase="F", STS6.StsTag       , '+'if(STS7.StSPhase="F", STS7.StsTag       , '+'if(STS8.StSPhase="F", STS8.StsTag, "")))))))) AS FloweringStsTag, ' +NL+
//                '                    if(STS1.StSPhase="H", STS1.StsTag        , '+'if(STS2.StSPhase="H", STS2.StsTag       , '+'if(STS3.StSPhase="H", STS3.StsTag         , '+'if(STS4.StSPhase="H", STS4.StsTag         , '+'if(STS5.StSPhase="H", STS5.StsTag       , '+'if(STS6.StSPhase="H", STS6.StsTag       , '+'if(STS7.StSPhase="H", STS7.StsTag       , '+'if(STS8.StSPhase="H", STS8.StsTag, "")))))))) AS HarvestingStsTag, ' +NL+NL+

                ' StsPhaseCodetoDesc(if(STS1.StSPhase="I", STS1.StSPhase      , '+'if(STS2.StSPhase="I", STS2.StSPhase     , '+'if(STS3.StSPhase="I", STS3.StSPhase       , '+'if(STS4.StSPhase="I", STS4.StSPhase       , '+'if(STS5.StSPhase="I", STS5.StSPhase     , '+'if(STS6.StSPhase="I", STS6.StSPhase     , '+'if(STS7.StSPhase="I", STS7.StSPhase     , '+'if(STS8.StSPhase="I", STS8.StSPhase, ""))))))))) AS immatureStSPhase, ' +NL+
                ' StsPhaseCodetoDesc(if(STS1.StSPhase="V", STS1.StSPhase      , '+'if(STS2.StSPhase="V", STS2.StSPhase     , '+'if(STS3.StSPhase="V", STS3.StSPhase       , '+'if(STS4.StSPhase="V", STS4.StSPhase       , '+'if(STS5.StSPhase="V", STS5.StSPhase     , '+'if(STS6.StSPhase="V", STS6.StSPhase     , '+'if(STS7.StSPhase="V", STS7.StSPhase     , '+'if(STS8.StSPhase="V", STS8.StSPhase, ""))))))))) AS VegetativeStSPhase, ' +NL+
                ' StsPhaseCodetoDesc(if(STS1.StSPhase="F", STS1.StSPhase      , '+'if(STS2.StSPhase="F", STS2.StSPhase     , '+'if(STS3.StSPhase="F", STS3.StSPhase       , '+'if(STS4.StSPhase="F", STS4.StSPhase       , '+'if(STS5.StSPhase="F", STS5.StSPhase     , '+'if(STS6.StSPhase="F", STS6.StSPhase     , '+'if(STS7.StSPhase="F", STS7.StSPhase     , '+'if(STS8.StSPhase="F", STS8.StSPhase, ""))))))))) AS FloweringStSPhase, ' +NL+
//                ' StsPhaseCodetoDesc(if(STS1.StSPhase="H", STS1.StSPhase      , '+'if(STS2.StSPhase="H", STS2.StSPhase     , '+'if(STS3.StSPhase="H", STS3.StSPhase       , '+'if(STS4.StSPhase="H", STS4.StSPhase       , '+'if(STS5.StSPhase="H", STS5.StSPhase     , '+'if(STS6.StSPhase="H", STS6.StSPhase     , '+'if(STS7.StSPhase="H", STS7.StSPhase     , '+'if(STS8.StSPhase="H", STS8.StSPhase, ""))))))))) AS HarvestingStSPhase, ' +NL+NL+

                '            convert(if(STS1.StSPhase="I", STS1.UsedOn        , '+'if(STS2.StSPhase="I", STS2.UsedOn       , '+'if(STS3.StSPhase="I", STS3.UsedOn         , '+'if(STS4.StSPhase="I", STS4.UsedOn         , '+'if(STS5.StSPhase="I", STS5.UsedOn       , '+'if(STS6.StSPhase="I", STS6.UsedOn       , '+'if(STS7.StSPhase="I", STS7.UsedOn       , '+'if(STS8.StSPhase="I", STS8.UsedOn , Null)))))))) ,DATETIME) AS immatureUsedOn, ' +NL+
                '            convert(if(STS1.StSPhase="V", STS1.UsedOn        , '+'if(STS2.StSPhase="V", STS2.UsedOn       , '+'if(STS3.StSPhase="V", STS3.UsedOn         , '+'if(STS4.StSPhase="V", STS4.UsedOn         , '+'if(STS5.StSPhase="V", STS5.UsedOn       , '+'if(STS6.StSPhase="V", STS6.UsedOn       , '+'if(STS7.StSPhase="V", STS7.UsedOn       , '+'if(STS8.StSPhase="V", STS8.UsedOn , Null)))))))) ,DATETIME) AS VegetativeUsedOn, ' +NL+
                '            convert(if(STS1.StSPhase="F", STS1.UsedOn        , '+'if(STS2.StSPhase="F", STS2.UsedOn       , '+'if(STS3.StSPhase="F", STS3.UsedOn         , '+'if(STS4.StSPhase="F", STS4.UsedOn         , '+'if(STS5.StSPhase="F", STS5.UsedOn       , '+'if(STS6.StSPhase="F", STS6.UsedOn       , '+'if(STS7.StSPhase="F", STS7.UsedOn       , '+'if(STS8.StSPhase="F", STS8.UsedOn , Null)))))))) ,DATETIME) AS FloweringUsedOn, ' +NL+
//                '            convert(if(STS1.StSPhase="H", STS1.UsedOn        , '+'if(STS2.StSPhase="H", STS2.UsedOn       , '+'if(STS3.StSPhase="H", STS3.UsedOn         , '+'if(STS4.StSPhase="H", STS4.UsedOn         , '+'if(STS5.StSPhase="H", STS5.UsedOn       , '+'if(STS6.StSPhase="H", STS6.UsedOn       , '+'if(STS7.StSPhase="H", STS7.UsedOn       , '+'if(STS8.StSPhase="H", STS8.UsedOn , Null)))))))) ,DATETIME) AS HarvestingUsedOn, ' +  NL+NL+

                '                    if(STS1.StSPhase="I", STS1.PlantCount    , '+'if(STS2.StSPhase="I", STS2.PlantCount   , '+'if(STS3.StSPhase="I", STS3.PlantCount     , '+'if(STS4.StSPhase="I", STS4.PlantCount     , '+'if(STS5.StSPhase="I", STS5.PlantCount   , '+'if(STS6.StSPhase="I", STS6.PlantCount   , '+'if(STS7.StSPhase="I", STS7.PlantCount   , '+'if(STS8.StSPhase="I", STS8.PlantCount , 0)))))))) AS immaturePlantCount, ' +NL+
                '                    if(STS1.StSPhase="V", STS1.PlantCount    , '+'if(STS2.StSPhase="V", STS2.PlantCount   , '+'if(STS3.StSPhase="V", STS3.PlantCount     , '+'if(STS4.StSPhase="V", STS4.PlantCount     , '+'if(STS5.StSPhase="V", STS5.PlantCount   , '+'if(STS6.StSPhase="V", STS6.PlantCount   , '+'if(STS7.StSPhase="V", STS7.PlantCount   , '+'if(STS8.StSPhase="V", STS8.PlantCount , 0)))))))) AS VegetativePlantCount, ' +NL+
                '                    if(STS1.StSPhase="F", STS1.PlantCount    , '+'if(STS2.StSPhase="F", STS2.PlantCount   , '+'if(STS3.StSPhase="F", STS3.PlantCount     , '+'if(STS4.StSPhase="F", STS4.PlantCount     , '+'if(STS5.StSPhase="F", STS5.PlantCount   , '+'if(STS6.StSPhase="F", STS6.PlantCount   , '+'if(STS7.StSPhase="F", STS7.PlantCount   , '+'if(STS8.StSPhase="F", STS8.PlantCount , 0)))))))) AS FloweringPlantCount, ' +NL+
//                '                    if(STS1.StSPhase="H", STS1.PlantCount    , '+'if(STS2.StSPhase="H", STS2.PlantCount   , '+'if(STS3.StSPhase="H", STS3.PlantCount     , '+'if(STS4.StSPhase="H", STS4.PlantCount     , '+'if(STS5.StSPhase="H", STS5.PlantCount   , '+'if(STS6.StSPhase="H", STS6.PlantCount   , '+'if(STS7.StSPhase="H", STS7.PlantCount   , '+'if(STS8.StSPhase="H", STS8.PlantCount , 0)))))))) AS HarvestingPlantCount, ' +NL+NL+

                '                    if(STS1.StSPhase="I", STS1.ChangedCount  , '+'if(STS2.StSPhase="I", STS2.ChangedCount  , '+'if(STS3.StSPhase="I", STS3.ChangedCount  , '+'if(STS4.StSPhase="I", STS4.ChangedCount   , '+'if(STS5.StSPhase="I", STS5.ChangedCount , '+'if(STS6.StSPhase="I", STS6.ChangedCount , '+'if(STS7.StSPhase="I", STS7.ChangedCount , '+'if(STS8.StSPhase="I", STS8.ChangedCount , 0)))))))) AS immatureChangedCount, ' +NL+
                '                    if(STS1.StSPhase="V", STS1.ChangedCount  , '+'if(STS2.StSPhase="V", STS2.ChangedCount  , '+'if(STS3.StSPhase="V", STS3.ChangedCount  , '+'if(STS4.StSPhase="V", STS4.ChangedCount   , '+'if(STS5.StSPhase="V", STS5.ChangedCount , '+'if(STS6.StSPhase="V", STS6.ChangedCount , '+'if(STS7.StSPhase="V", STS7.ChangedCount , '+'if(STS8.StSPhase="V", STS8.ChangedCount , 0)))))))) AS VegetativeChangedCount, ' +NL+
                '                    if(STS1.StSPhase="F", STS1.ChangedCount  , '+'if(STS2.StSPhase="F", STS2.ChangedCount  , '+'if(STS3.StSPhase="F", STS3.ChangedCount  , '+'if(STS4.StSPhase="F", STS4.ChangedCount   , '+'if(STS5.StSPhase="F", STS5.ChangedCount , '+'if(STS6.StSPhase="F", STS6.ChangedCount , '+'if(STS7.StSPhase="F", STS7.ChangedCount , '+'if(STS8.StSPhase="F", STS8.ChangedCount , 0)))))))) AS FloweringChangedCount, ' +NL+
//                '                    if(STS1.StSPhase="H", STS1.ChangedCount  , '+'if(STS2.StSPhase="H", STS2.ChangedCount  , '+'if(STS3.StSPhase="H", STS3.ChangedCount  , '+'if(STS4.StSPhase="H", STS4.ChangedCount   , '+'if(STS5.StSPhase="H", STS5.ChangedCount , '+'if(STS6.StSPhase="H", STS6.ChangedCount , '+'if(STS7.StSPhase="H", STS7.ChangedCount , '+'if(STS8.StSPhase="H", STS8.ChangedCount , 0)))))))) AS HarvestingChangedCount, ' +NL+NL+

                '                    if(STS1.StSPhase="I", STS1.WastedCount   , '+'if(STS2.StSPhase="I", STS2.WastedCount   , '+'if(STS3.StSPhase="I", STS3.WastedCount   , '+'if(STS4.StSPhase="I", STS4.WastedCount    , '+'if(STS5.StSPhase="I", STS5.WastedCount  , '+'if(STS6.StSPhase="I", STS6.WastedCount  , '+'if(STS7.StSPhase="I", STS7.WastedCount  , '+'if(STS8.StSPhase="I", STS8.WastedCount , 0)))))))) AS immatureWastedCount, ' +NL+
                '                    if(STS1.StSPhase="V", STS1.WastedCount   , '+'if(STS2.StSPhase="V", STS2.WastedCount   , '+'if(STS3.StSPhase="V", STS3.WastedCount   , '+'if(STS4.StSPhase="V", STS4.WastedCount    , '+'if(STS5.StSPhase="V", STS5.WastedCount  , '+'if(STS6.StSPhase="V", STS6.WastedCount  , '+'if(STS7.StSPhase="V", STS7.WastedCount  , '+'if(STS8.StSPhase="V", STS8.WastedCount , 0)))))))) AS VegetativeWastedCount, ' +NL+
                '                    if(STS1.StSPhase="F", STS1.WastedCount   , '+'if(STS2.StSPhase="F", STS2.WastedCount   , '+'if(STS3.StSPhase="F", STS3.WastedCount   , '+'if(STS4.StSPhase="F", STS4.WastedCount    , '+'if(STS5.StSPhase="F", STS5.WastedCount  , '+'if(STS6.StSPhase="F", STS6.WastedCount  , '+'if(STS7.StSPhase="F", STS7.WastedCount  , '+'if(STS8.StSPhase="F", STS8.WastedCount , 0)))))))) AS FloweringWastedCount, ' +NL+
//                '                    if(STS1.StSPhase="H", STS1.WastedCount   , '+'if(STS2.StSPhase="H", STS2.WastedCount   , '+'if(STS3.StSPhase="H", STS3.WastedCount   , '+'if(STS4.StSPhase="H", STS4.WastedCount    , '+'if(STS5.StSPhase="H", STS5.WastedCount  , '+'if(STS6.StSPhase="H", STS6.WastedCount  , '+'if(STS7.StSPhase="H", STS7.WastedCount  , '+'if(STS8.StSPhase="H", STS8.WastedCount , 0)))))))) AS HarvestingWastedCount, ' +NL+NL+

                '                    if(STS1.StSPhase="I", STS1.Destroycount  , '+'if(STS2.StSPhase="I", STS2.Destroycount  , '+'if(STS3.StSPhase="I", STS3.Destroycount  , '+'if(STS4.StSPhase="I", STS4.Destroycount   , '+'if(STS5.StSPhase="I", STS5.Destroycount , '+'if(STS6.StSPhase="I", STS6.Destroycount , '+'if(STS7.StSPhase="I", STS7.Destroycount , '+'if(STS8.StSPhase="I", STS8.Destroycount , 0)))))))) AS immatureDestroycount, ' +NL+
                '                    if(STS1.StSPhase="V", STS1.Destroycount  , '+'if(STS2.StSPhase="V", STS2.Destroycount  , '+'if(STS3.StSPhase="V", STS3.Destroycount  , '+'if(STS4.StSPhase="V", STS4.Destroycount   , '+'if(STS5.StSPhase="V", STS5.Destroycount , '+'if(STS6.StSPhase="V", STS6.Destroycount , '+'if(STS7.StSPhase="V", STS7.Destroycount , '+'if(STS8.StSPhase="V", STS8.Destroycount , 0)))))))) AS VegetativeDestroycount, ' +NL+
                '                    if(STS1.StSPhase="F", STS1.Destroycount  , '+'if(STS2.StSPhase="F", STS2.Destroycount  , '+'if(STS3.StSPhase="F", STS3.Destroycount  , '+'if(STS4.StSPhase="F", STS4.Destroycount   , '+'if(STS5.StSPhase="F", STS5.Destroycount , '+'if(STS6.StSPhase="F", STS6.Destroycount , '+'if(STS7.StSPhase="F", STS7.Destroycount , '+'if(STS8.StSPhase="F", STS8.Destroycount , 0)))))))) AS FloweringDestroycount, ' +NL+
//                '                    if(STS1.StSPhase="H", STS1.Destroycount  , '+'if(STS2.StSPhase="H", STS2.Destroycount  , '+'if(STS3.StSPhase="H", STS3.Destroycount  , '+'if(STS4.StSPhase="H", STS4.Destroycount   , '+'if(STS5.StSPhase="H", STS5.Destroycount , '+'if(STS6.StSPhase="H", STS6.Destroycount , '+'if(STS7.StSPhase="H", STS7.Destroycount , '+'if(STS8.StSPhase="H", STS8.Destroycount , 0)))))))) AS HarvestingDestroycount, ' +NL+NL+

                '                    if(STS1.StSPhase="I",STS1.TransferedCount, '+'if(STS2.StSPhase="I",STS2.TransferedCount, '+'if(STS3.StSPhase="I",STS3.TransferedCount, '+'if(STS4.StSPhase="I",STS4.TransferedCount , '+'if(STS5.StSPhase="I",STS5.TransferedCount, '+'if(STS6.StSPhase="I",STS6.TransferedCount, '+'if(STS7.StSPhase="I",STS7.TransferedCount, '+'if(STS8.StSPhase="I",STS8.TransferedCount, 0)))))))) AS immatureTransferedCount,' +NL+
                '                    if(STS1.StSPhase="V",STS1.TransferedCount, '+'if(STS2.StSPhase="V",STS2.TransferedCount, '+'if(STS3.StSPhase="V",STS3.TransferedCount, '+'if(STS4.StSPhase="V",STS4.TransferedCount , '+'if(STS5.StSPhase="V",STS5.TransferedCount, '+'if(STS6.StSPhase="V",STS6.TransferedCount, '+'if(STS7.StSPhase="V",STS7.TransferedCount, '+'if(STS8.StSPhase="V",STS8.TransferedCount, 0)))))))) AS VegetativeTransferedCount,' +NL+
                '                    if(STS1.StSPhase="F",STS1.TransferedCount, '+'if(STS2.StSPhase="F",STS2.TransferedCount, '+'if(STS3.StSPhase="F",STS3.TransferedCount, '+'if(STS4.StSPhase="F",STS4.TransferedCount , '+'if(STS5.StSPhase="F",STS5.TransferedCount, '+'if(STS6.StSPhase="F",STS6.TransferedCount, '+'if(STS7.StSPhase="F",STS7.TransferedCount, '+'if(STS8.StSPhase="F",STS8.TransferedCount, 0)))))))) AS FloweringTransferedCount,' +NL+
//                '                    if(STS1.StSPhase="H",STS1.TransferedCount, '+'if(STS2.StSPhase="H",STS2.TransferedCount, '+'if(STS3.StSPhase="H",STS3.TransferedCount, '+'if(STS4.StSPhase="H",STS4.TransferedCount , '+'if(STS5.StSPhase="H",STS5.TransferedCount, '+'if(STS6.StSPhase="H",STS6.TransferedCount, '+'if(STS7.StSPhase="H",STS7.TransferedCount, '+'if(STS8.StSPhase="H",STS8.TransferedCount, 0)))))))) AS HarvestingTransferedCount,' +NL+NL+

                '                    if(STS1.StSPhase="I", STS1.UsedCount     , '+'if(STS2.StSPhase="I", STS2.UsedCount     , '+'if(STS3.StSPhase="I", STS3.UsedCount     , '+'if(STS4.StSPhase="I", STS4.UsedCount      , '+'if(STS5.StSPhase="I", STS5.UsedCount    , '+'if(STS6.StSPhase="I", STS6.UsedCount    , '+'if(STS7.StSPhase="I", STS7.UsedCount    , '+'if(STS8.StSPhase="I", STS8.UsedCount , 0)))))))) AS immatureUsedCount, ' +NL+
                '                    if(STS1.StSPhase="V", STS1.UsedCount     , '+'if(STS2.StSPhase="V", STS2.UsedCount     , '+'if(STS3.StSPhase="V", STS3.UsedCount     , '+'if(STS4.StSPhase="V", STS4.UsedCount      , '+'if(STS5.StSPhase="V", STS5.UsedCount    , '+'if(STS6.StSPhase="V", STS6.UsedCount    , '+'if(STS7.StSPhase="V", STS7.UsedCount    , '+'if(STS8.StSPhase="V", STS8.UsedCount , 0)))))))) AS VegetativeUsedCount, ' +NL+
                '                    if(STS1.StSPhase="F", STS1.UsedCount     , '+'if(STS2.StSPhase="F", STS2.UsedCount     , '+'if(STS3.StSPhase="F", STS3.UsedCount     , '+'if(STS4.StSPhase="F", STS4.UsedCount      , '+'if(STS5.StSPhase="F", STS5.UsedCount    , '+'if(STS6.StSPhase="F", STS6.UsedCount    , '+'if(STS7.StSPhase="F", STS7.UsedCount    , '+'if(STS8.StSPhase="F", STS8.UsedCount , 0)))))))) AS FloweringUsedCount ' +NL+
//                '                    if(STS1.StSPhase="H", STS1.UsedCount     , '+'if(STS2.StSPhase="H", STS2.UsedCount     , '+'if(STS3.StSPhase="H", STS3.UsedCount     , '+'if(STS4.StSPhase="H", STS4.UsedCount      , '+'if(STS5.StSPhase="H", STS5.UsedCount    , '+'if(STS6.StSPhase="H", STS6.UsedCount    , '+'if(STS7.StSPhase="H", STS7.UsedCount    , '+'if(STS8.StSPhase="H", STS8.UsedCount , 0)))))))) AS HarvestingUsedCount ' +NL+NL+


              '  FROM tblststags STS1 ' +NL+
              '    LEFT JOIN tblststags STS2 ON STS1.Id = STS2.SourceTagID   AND   STS1.DeptID = STS2.DeptID AND STS1.StsPhase <> STS2.StsPhase ' +NL+
              '    LEFT JOIN tblststags STS3 ON STS2.Id = STS3.SourceTagID   AND   STS2.DeptID = STS3.DeptID AND STS2.StsPhase <> STS3.StsPhase ' +NL+
              '    LEFT JOIN tblststags STS4 ON STS3.Id = STS4.SourceTagID   AND   STS3.DeptID = STS4.DeptID AND STS3.StsPhase <> STS4.StsPhase ' +NL+

              '    Inner JOIN tblststags STS5 ON STS1.SourceTagID = STS5.ID  AND STS1.StsPhase = STS5.StsPhase ' +NL+
              '    LEFT JOIN tblststags STS6 ON STS5.SourceTagID= STS6.ID   AND   STS5.DeptID = STS6.DeptID AND STS5.StsPhase <> STS6.StsPhase ' +NL+
              '    LEFT JOIN tblststags STS7 ON STS6.SourceTagID = STS7.ID   AND   STS6.DeptID = STS7.DeptID AND STS6.StsPhase <> STS7.StsPhase ' +NL+
              '    LEFT JOIN tblststags STS8 ON STS7.SourceTagID = STS8.ID   AND   STS7.DeptID = STS8.DeptID AND STS7.StsPhase <> STS8.StsPhase ' +NL+


              '      WHERE STS1.Sourcetype = '+quotedstr(STS_SOURCE_TYPE_TransferTo) +NL+

                iif(HistoryOfTagId<> 0, ' And (STS1.Id = ' + inttostr(HistoryOfTagId) +' OR '+
                                          'STS2.Id = ' + inttostr(HistoryOfTagId) +' OR '+
                                          'STS3.Id = ' + inttostr(HistoryOfTagId) +' OR '+
                                          'STS4.Id = ' + inttostr(HistoryOfTagId) +' OR '+
                                          'STS5.Id = ' + inttostr(HistoryOfTagId) +' OR '+
                                          'STS6.Id = ' + inttostr(HistoryOfTagId) +' OR '+
                                          'STS7.Id = ' + inttostr(HistoryOfTagId) +' OR '+
                                          'STS8.Id = ' + inttostr(HistoryOfTagId) +')'+NL,'')+
                ' Having ((immatureUsedOn between '+ dateFromSQL+' and '+DateToSQL+')  '+
                ' OR (VegetativeUsedOn between '+ dateFromSQL+' and '+DateToSQL+') '+
                //' OR (HarvestingUsedOn between '+ dateFromSQL+' and '+DateToSQL+') '+
                ' OR (FloweringUsedOn between '+ dateFromSQL+' and '+DateToSQL+')) ';

end;
procedure TStsTagGrowthHistoryGUI.PopulateData;
Function fieldlist:String;
begin
  REsult := 'immatureId             ,'+'VegetativeId             ,'+'FloweringId              ,'(*+'HarvestingId,'             *) + NL+
          '  immatureDept           ,'+'VegetativeDept           ,'+'FloweringDept            ,'(*+'HarvestingDept,'           *) + NL+
          '  immatureSourcetype     ,'+'VegetativeSourcetype     ,'+'FloweringSourcetype      ,'(*+'HarvestingSourcetype,'     *) + NL+
          '  immatureStsTag         ,'+'VegetativeStsTag         ,'+'FloweringStsTag          ,'(*+'HarvestingStsTag,'         *) + NL+
          '  immatureStSPhase       ,'+'VegetativeStSPhase       ,'+'FloweringStSPhase        ,'(*+'HarvestingStSPhase,'       *) + NL+
          '  immatureUsedOn         ,'+'VegetativeUsedOn         ,'+'FloweringUsedOn          ,'(*+'HarvestingUsedOn,'         *) + NL+
          '  immaturePlantCount     ,'+'VegetativePlantCount     ,'+'FloweringPlantCount      ,'(*+'HarvestingPlantCount,'     *) + NL+
          '  immatureChangedCount   ,'+'VegetativeChangedCount   ,'+'FloweringChangedCount    ,'(*+'HarvestingChangedCount,'   *) + NL+
          '  immatureWastedCount    ,'+'VegetativeWastedCount    ,'+'FloweringWastedCount     ,'(*+'HarvestingWastedCount,'    *) + NL+
          '  immatureDestroycount   ,'+'VegetativeDestroycount   ,'+'FloweringDestroycount    ,'(*+'HarvestingDestroycount,'   *) + NL+
          '  immatureTransferedCount,'+'VegetativeTransferedCount,'+'FloweringTransferedCount ,'(*+'HarvestingTransferedCount,'*) + NL+
          '  immatureUsedCount      ,'+'VegetativeUsedCount      ,'+'FloweringUsedCount       '(*+',HarvestingUsedCount '*) ;
end;
begin
  With Scriptmain do begin
    SQL.add('Drop table if exists ' + fsTablename+'11;');
    SQL.add('Create table '+ fstablename +'11  ( `ID`                          INT(11) NOT NULL AUTO_INCREMENT,'+
                                              ' `immatureId`                  INT(11)       DEFAULT NULL,'+
                                              ' `VegetativeId`                INT(11)       DEFAULT NULL,'+
                                              ' `FloweringId`                 INT(11)       DEFAULT NULL,'+
                                              ' `HarvestingId`                INT(11)       DEFAULT NULL,'+

                                              ' `immatureDept`                VARCHAR(255)  DEFAULT NULL,'+
                                              ' `VegetativeDept`              VARCHAR(255)  DEFAULT NULL,'+
                                              ' `FloweringDept`               VARCHAR(255)  DEFAULT NULL,'+
                                              ' `HarvestingDept`              VARCHAR(255)  DEFAULT NULL,'+

                                              ' `immatureSourcetype`          VARCHAR(255)  DEFAULT NULL,'+
                                              ' `VegetativeSourcetype`        VARCHAR(255)  DEFAULT NULL,'+
                                              ' `FloweringSourcetype`         VARCHAR(255)  DEFAULT NULL,'+
                                              ' `HarvestingSourcetype`        VARCHAR(255)  DEFAULT NULL,'+

                                              ' `immatureStsTag`              VARCHAR(255)  DEFAULT NULL,'+
                                              ' `VegetativeStsTag`            VARCHAR(255)  DEFAULT NULL,'+
                                              ' `FloweringStsTag`             VARCHAR(255)  DEFAULT NULL,'+
                                              ' `HarvestingStsTag`            VARCHAR(255)  DEFAULT NULL,'+

                                              ' `immatureStSPhase`            VARCHAR(50)   DEFAULT NULL,'+
                                              ' `VegetativeStSPhase`          VARCHAR(50)   DEFAULT NULL,'+
                                              ' `FloweringStSPhase`           VARCHAR(50)   DEFAULT NULL,'+
                                              ' `HarvestingStSPhase`          VARCHAR(50)   DEFAULT NULL,'+

                                              ' `immatureUsedOn`              DATETIME      DEFAULT NULL,'+
                                              ' `VegetativeUsedOn`            DATETIME      DEFAULT NULL,'+
                                              ' `FloweringUsedOn`             DATETIME      DEFAULT NULL,'+
                                              ' `HarvestingUsedOn`            DATETIME      DEFAULT NULL,'+

                                              ' `immaturePlantCount`          INT(11)       DEFAULT NULL,'+
                                              ' `VegetativePlantCount`        INT(11)       DEFAULT NULL,'+
                                              ' `FloweringPlantCount`         INT(11)       DEFAULT NULL,'+
                                              ' `HarvestingPlantCount`        INT(11)       DEFAULT NULL,'+

                                              ' `immatureChangedCount`        INT(11)       DEFAULT NULL,'+
                                              ' `VegetativeChangedCount`      INT(11)       DEFAULT NULL,'+
                                              ' `FloweringChangedCount`       INT(11)       DEFAULT NULL,'+
                                              ' `HarvestingChangedCount`      INT(11)       DEFAULT NULL,'+

                                              ' `immatureWastedCount`         INT(11)       DEFAULT NULL,'+
                                              ' `VegetativeWastedCount`       INT(11)       DEFAULT NULL,'+
                                              ' `FloweringWastedCount`        INT(11)       DEFAULT NULL,'+
                                              ' `HarvestingWastedCount`       INT(11)       DEFAULT NULL,'+

                                              ' `immatureDestroycount`        INT(11)       DEFAULT NULL,'+
                                              ' `VegetativeDestroycount`      INT(11)       DEFAULT NULL,'+
                                              ' `FloweringDestroycount`       INT(11)       DEFAULT NULL,'+
                                              ' `HarvestingDestroycount`      INT(11)       DEFAULT NULL,'+

                                              ' `immatureTransferedCount`     INT(11)       DEFAULT NULL,'+
                                              ' `VegetativeTransferedCount`   INT(11)       DEFAULT NULL,'+
                                              ' `FloweringTransferedCount`    INT(11)       DEFAULT NULL,'+
                                              ' `HarvestingTransferedCount`   INT(11)       DEFAULT NULL,'+

                                              ' `immatureUsedCount`           INT(11)       DEFAULT NULL,'+
                                              ' `VegetativeUsedCount`         INT(11)       DEFAULT NULL,'+
                                              ' `FloweringUsedCount`          INT(11)       DEFAULT NULL,'+
                                              ' `HarvestingUsedCount`         INT(11)       DEFAULT NULL,'+
                                              '   PRIMARY KEY (`ID`) ) ENGINE=MyISAM DEFAULT CHARSET=UTF8;');
      SQL.add('insert ignore into '+ fstablename +'11 ('+fieldlist+') '+ StsGrowthhistorySQL(1) +' ;');

      SQL.add('insert ignore into '+ fstablename +'11 ('+fieldlist+') '+  StsGrowthhistorySQL(2) +' ;');
      SQL.add('Drop table if exists ' + fsTablename+'1;');
      SQL.add('Create table '+ fstablename +'1 like '+ fstablename +'11;');
      SQL.add('insert ignore into '+ fstablename +'1 ('+fieldlist+') '+
                ' Select '+fieldlist+' from '+ fstablename +'11 ' +
                ' ORDER BY immatureStsTag, VegetativeStsTag, FloweringStsTag'+(*', HarvestingStsTag'+*)' ;'(*+',STS5.StsTag'+*) );
    SQL.add('Drop table if exists ' + fsTablename+';');
    SQL.add('Create table '+ fstablename +' SELECT ' +
                ' @ImmatureRow  :=if(details.immatureId   = 0,0 , '+'if(@immatureId   <> details.immatureId  ,  @ImmatureRow  := 1 ,  @ImmatureRow  +1)) ImmatureRow  , ' +
                ' @VegetativeRow:=if(details.VegetativeId = 0,0 , '+'if(@VegetativeId <> details.VegetativeId,  @VegetativeRow:= 1 ,  @VegetativeRow+1)) VegetativeRow, ' +
                ' @FloweringRow :=if(details.FloweringId  = 0,0 , '+'if(@FloweringId  <> details.FloweringId ,  @FloweringRow := 1 ,  @FloweringRow +1)) FloweringRow , ' +
                ' 0 AS HarvestingRow, ' + //' @HarvestingRow:=if(details.HarvestingId = 0,0 , '+'if(@HarvestingId <> details.HarvestingId,  @HarvestingRow:= 1 ,  @HarvestingRow+1)) HarvestingRow, ' +
                ' @immatureId   := details.immatureId   , ' +
                ' @VegetativeId := details.VegetativeId , ' +
                ' @FloweringId  := details.FloweringId  , ' +
                //' @HarvestingId := details.HarvestingId , ' +
                ' Details.* ' +
                ' from  (SELECT @ImmatureRow  :=-1) r1 , ' +
                '       (SELECT @immatureId   :=-1) s1, ' +
                '       (SELECT @VegetativeRow:=-1) r2 , ' +
                '       (SELECT @VegetativeId :=-1) s2, ' +
                '       (SELECT @FloweringRow :=-1) r3 , ' +
                '       (SELECT @FloweringId  :=-1) s3, ' +
                //'       (SELECT @HarvestingRow:=-1) r4 , ' +
                //'       (SELECT @HarvestingId :=-1) s4, ' +
                '       (Select * from '+ fstablename +'1) as Details;');
    SQL.add('Drop table if exists ' + fsTablename+'1;');
    SQL.add('Drop table if exists ' + fsTablename+'11;');
    SQL.add('Alter Table  ' + fsTablename+' Add column HarvestWeight DOUBLE DEFAULT Null ;');
    SQL.add('Alter Table  ' + fsTablename+' Add column HarvestUOM varchar(255) DEFAULT null;');
    SQL.add('Update '+ fstablename +' T inner join tblststags Tag on TAG.ID = T.FloweringId ' +
                                      ' inner join tblststag_actions TagA on TAG.Id = TagA.TagId '+
                                      ' inner join tblstsharvestlines HL on HL.StSActionID = TagA.Id  and T.FloweringStsTag = HL.StsTag '+
                                      ' inner join tblStSHarvest H on HL.HarvestID = H.ID ' +
                                      ' inner join tblclass C on C.classid  = H.DeptID '+
                  ' Set T.HarvestingDept = C.classname, '+
                  ' T.HarvestingSourcetype = ' + quotedstr(STS_SOURCE_TYPE_New_Growth_Phase)+','+
                  ' T.HarvestingStsTag = HL.StSTag,'+
                  ' T.HarvestingStSPhase = "H",'+
                  ' T.HarvestingUsedOn = H.HarvestDate , '+
                  ' T.HarvestingPlantCount =TAG.Harvestcount , '+
                  ' T.HarvestWeight = HL.UOMQty  , '+
                  ' T.HarvestUOM = H.UOM;');

    cLog(SQL.Text);
    ExecutewithProgress(False);

  end;
end;

initialization
    RegisterClassOnce(TStsTagGrowthHistoryGUI);

end.
