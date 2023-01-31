unit StSUsedTags;

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
  TStSUsedTagsGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainStsTag: TWideStringField;
    qryMainDept: TWideStringField;
    qryMainUsedOn: TDateTimeField;
    qryMainStrainname: TWideStringField;
    qryMainPlantcount: TIntegerField;
    qryMainChangedCount: TIntegerField;
    qryMainWastedCount: TIntegerField;
    qryMainDestroycount: TIntegerField;
    qryMainUsedCount: TIntegerField;
    qryMainTransferedCount: TIntegerField;
    qryMainHarvestcount: TIntegerField;
    qryMainStSPhasedesc: TWideStringField;
    qryMainStSPhase: TWideStringField;
    qryMainActivecount: TLargeintField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
  private
    fsExcludeTags: String;
    procedure MakeQrymain;
    procedure SetExcludeTags(const Value: String);
  Protected
    procedure SetGridColumns; Override;
  public
    procedure ShowFloweringTags;
    Property ExcludeTags :String read fsExcludeTags write SetExcludeTags;
  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TStSUsedTagsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  MakeQrymain;
  fsExcludeTags:= '';
  HaveDateRangeSelection := False;
end;

procedure TStSUsedTagsGUI.SetExcludeTags(const Value: String);
begin
  fsExcludeTags := Value;
  MakeQrymain;
end;

procedure TStSUsedTagsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainID.fieldname);
  RemoveFieldfromGrid(qryMainStsPhase.fieldname);
end;

procedure TStSUsedTagsGUI.ShowFloweringTags;
begin
  grpFilters.itemindex := 2;
  grpFilters.Enabled := False;
  ListMsg('This is the List of Active Tag in Flowering Phase that can be Selected for Harvest');
end;
procedure TStSUsedTagsGUI.MakeQrymain;
begin
      Qrymain.Sql.Clear;
      Qrymain.Sql.add('SELECT');
      Qrymain.Sql.add('Id               AS ID,');
      Qrymain.Sql.add('StsTag           AS StsTag,');
      Qrymain.Sql.add('Dept             AS Dept,');
      Qrymain.Sql.add('UsedOn           AS UsedOn,');
      Qrymain.Sql.add('Strainname       AS Strainname,');
      Qrymain.Sql.add('Plantcount       AS Plantcount,');
      Qrymain.Sql.add('ChangedCount     AS ChangedCount,');
      Qrymain.Sql.add('WastedCount      AS WastedCount,');
      Qrymain.Sql.add('Destroycount     AS Destroycount,');
      Qrymain.Sql.add('UsedCount        AS UsedCount,');
      Qrymain.Sql.add('TransferedCount  AS TransferedCount,');
      Qrymain.Sql.add('Harvestcount     AS Harvestcount,');
      Qrymain.Sql.add('Plantcount - (ChangedCount +WastedCount+Destroycount+Harvestcount+TransferedCount+UsedCount) AS Activecount,');
      Qrymain.Sql.add('StsPhaseCodetoDesc(StSPhase) AS StSPhasedesc,');
      Qrymain.Sql.add('StSPhase         AS StSPhase');
      Qrymain.Sql.add(' FROM tblStsTags');
      if ExcludeTags <> '' then Qrymain.Sql.add(' Where not(id in (' + ExcludeTags +'))');
      Qrymain.Sql.add(' ORDER BY Strainname , StsTag');
      RefreshOrignalSQL;

end;
procedure TStSUsedTagsGUI.grpFiltersClick(Sender: TObject);
begin
  GroupfilterString:= '';
  case grpfilters.itemindex of
    0: GroupfilterString := qryMainStSPhase.fieldname +'=' +quotedstr('I')+' and ActiveCount>0';
    1: GroupfilterString := qryMainStSPhase.fieldname +'=' +quotedstr('V')+' and ActiveCount>0';
    2: GroupfilterString := qryMainStSPhase.fieldname +'=' +quotedstr('F')+' and ActiveCount>0';
    3: GroupfilterString := qryMainStSPhase.fieldname +'=' +quotedstr('F')+' and Harvestcount>0';
    4: GroupfilterString := qryMainStSPhase.fieldname +'=' +quotedstr('P');
  end;
  inherited;

end;
initialization
  RegisterClassOnce(TStSUsedTagsGUI);

end.
