unit ColesORDRSPExpressList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ColesSaleslistExpress, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TColesORDRSPExpressListGUI = class(TColesSaleslistExpressGUI)
    procedure cmdNewClick(Sender: TObject);
  protected
    function GetRefObjectType: string; virtual;
  end;

implementation

uses
  CommonLib, FormFactory, BusobjExternalXRef, StrUtils;

{$R *.dfm}

{ TColesORDRSPExpressListGUI }

procedure TColesORDRSPExpressListGUI.cmdNewClick(Sender: TObject);
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
        if LRef.SynchState = 'Done' then
        begin
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

function TColesORDRSPExpressListGUI.GetRefObjectType: string;
begin
  Result := 'DESADV';
end;

initialization
  RegisterClassOnce(TColesORDRSPExpressListGUI);

end.
