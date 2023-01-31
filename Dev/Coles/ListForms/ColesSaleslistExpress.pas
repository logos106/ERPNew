unit ColesSaleslistExpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesorderListExpress, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TColesSaleslistExpressGUI = class(TSalesorderListExpressGUI)
    qryMainrefid: TIntegerField;
    qryMainSynchState: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
  protected
    function GetRefObjectType: string; virtual;
  end;

implementation

uses
  CommonLib, FormFactory, BusobjExternalXRef, StrUtils;

{$R *.dfm}

{ TSalesorderListExpressGUI1 }

procedure TColesSaleslistExpressGUI.cmdNewClick(Sender: TObject);
var
  i: integer;
  LBM: TBookmark;
  j: integer;
  LRef: TExternalXRef;
  LMessage: string;
  LNewRef: TExternalXRef;
begin
  if grdMain.SelectedList.Count > 0 then
  begin
    LBM := grdMain.DataSource.DataSet.Bookmark;
    LRef := TExternalXRef.Create(nil);
    LNewRef := TExternalXRef.Create(nil);
    try
      for i := 0 to grdMain.SelectedList.Count - 1 do
      begin
        grdMain.DataSource.DataSet.GoToBookmark(grdMain.SelectedList.Items[i]);
        LRef.Load(grdMain.DataSource.DataSet.FieldByName('refid').AsInteger);
        if LRef.IsStarted(LRef.ExternalType, LRef.ObjectType, LRef.ExternalId, LRef.ERPID) then
        begin
          LRef.Complete(LRef.ExternalType, LRef.ObjectType, LRef.ERPID, LRef.ExternalID, LMessage);
          LNewRef.New;
          LNewRef.ExternalType := LRef.ExternalType;
          LNewRef.ObjectType := GetRefObjectType;
          LNewRef.ERPID := LRef.ERPID;
          LNewRef.ExternalID := LRef.ExternalID;
          LNewRef.PostDB;
        end;
      end;
    finally
      LRef.Free;
      LNewRef.Free;
      grdMain.DataSource.DataSet.GoToBookmark(LBM);
    end;
  end;
end;

function TColesSaleslistExpressGUI.GetRefObjectType: string;
begin
  Result := 'ORDRSP';
end;

procedure TColesSaleslistExpressGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: GroupFilterString := 'SynchState = "Started"';
    1: GroupFilterString := 'SynchState = "Done"';
  end;
  ApplyQueryFilter;
end;

initialization
  RegisterClassOnce(TColesSaleslistExpressGUI);

end.

