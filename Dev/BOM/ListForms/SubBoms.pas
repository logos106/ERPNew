unit SubBoms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel, DNMAction;

type
  TSubBomGUI = class(TBaseListingGUI)
    qryMainproctreeId: TIntegerField;
    qryMaintreerootID: TIntegerField;
    qryMainpartsId: TIntegerField;
    qryMainBOMProduct: TWideStringField;
    qryMainSubProduct: TWideStringField;
    qryMainnodecaption: TWideStringField;
    qryMainIsLinked: TWideStringField;
    btnLink: TDNMSpeedButton;
    actLink: TDNMAction;
    qryMainSubPtProctreeId: TIntegerField;
    qryMainInheritFromID: TIntegerField;
    qryMaineditVersion: TIntegerField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure actLinkUpdate(Sender: TObject);
    procedure actLinkExecute(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TBaseListingGUI1 }

procedure TSubBomGUI.actLinkUpdate(Sender: TObject);
begin
  inherited;
   if grpFilters.itemindex =0 then begin
      actLink.enabled := true;
      actLink.caption := 'Un-Link';
   end else if grpFilters.itemindex =1 then begin
      actLink.enabled := true;
      actLink.caption := 'Link';
   end else if grpFilters.itemindex =2 then begin
      actLink.enabled := False;
      actLink.caption := 'Link / Un-Link';
   end;
   btnLink.caption := actLink.caption ;
end;

procedure TSubBomGUI.FormCreate(Sender: TObject);
begin
  inherited;
  EnableMultiSelect('');
  HaveDateRangeSelection := False;
end;

procedure TSubBomGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('IsLinked' , ['T','F','']);
  inherited;
  actLinkUpdate(actLink);

end;
procedure TSubBomGUI.actLinkExecute(Sender: TObject);
begin
  inherited;
  if UserLock.enabled = False then UserLock.enabled := True;
  ScriptMainInTrans;
  SctMain.SQL.clear;
  IterateProcno := 1;
  try
    IterateSelectedRecords;
  finally
    if SctMain.sql.count >0 then begin
      ExecutenCommit;
      RefreshQuery;
    end;
  end;
end;

procedure TSubBomGUI.IterateselectedRecordsCallback(var Abort: boolean;  SelIndex: Integer);
begin
  inherited;
  if IterateProcno = 1 then begin
      if UserLock.lock('tblparts', QrymainpartsId.asinteger) then begin
        if grpFilters.itemindex =1 then begin   // unlinked recor - link it
          SctMain.SQL.add('update tblProctree Set InheritFromID = ' + inttostr(qrymainSubPtProctreeId.asInteger) +','+
                           ' InheritFromeditVersion =' +inttostr(qryMaineditVersion.asInteger)+
                          ' where proctreeId = '+ inttostr(qrymainproctreeId.asInteger)+';');
        end else if grpFilters.itemindex =0 then begin // linked recor - unlink it
          SctMain.SQL.add('update tblProctree Set InheritFromID = 0 , InheritFromeditVersion =0 where proctreeId = '+ inttostr(qrymainproctreeId.asInteger)+';');
        end;
      end;
  end;

end;

procedure TSubBomGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainproctreeId.Fieldname);
  RemoveFieldfromGrid(QrymaintreerootID.Fieldname);
  RemoveFieldfromGrid(QrymainpartsId.Fieldname);
  RemoveFieldfromGrid(QrymainSubPtProctreeId.Fieldname);
  RemoveFieldfromGrid(QrymainInheritFromID.Fieldname);
  RemoveFieldfromGrid(qryMaineditVersion.Fieldname);
end;

initialization
  RegisterClassOnce(TSubBomGUI);

end.
