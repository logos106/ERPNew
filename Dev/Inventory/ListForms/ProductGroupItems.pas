unit ProductGroupItems;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TProductGroupItemsGUI = class(TBaseListingGUI)
    qryMainGroupname: TWideStringField;
    qryMainGroupValue: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    SelectedGroups:TStringList;
  end;

implementation

uses CommonLib, AppEnvironment, ProductQtyLib;

{$R *.dfm}
procedure TProductGroupItemsGUI.FormCreate(Sender: TObject);
begin
  SelectedGroups:=TStringList.create;
  Qrymain.SQL.Clear;
  Qrymain.SQL.add('Select distinct 1 Details, ');
  Qrymain.SQL.add(Quotedstr(AppEnv.DefaultClass.FirstColumn) +' as Groupname, ');
  Qrymain.SQL.add(Firstcolumn +' as GroupValue ');
  Qrymain.SQL.add(' from tblParts P');
  Qrymain.SQL.add(' Union All');
  Qrymain.SQL.add('Select distinct 2 Details, ');
  Qrymain.SQL.add(Quotedstr(AppEnv.DefaultClass.SecondColumn) +' as Groupname, ');
  Qrymain.SQL.add(Secondcolumn +' as GroupValue ');
  Qrymain.SQL.add(' from tblParts P');
  Qrymain.SQL.add(' Union All');
  Qrymain.SQL.add('Select distinct 3 Details, ');
  Qrymain.SQL.add(Quotedstr(AppEnv.DefaultClass.ThirdColumn) +' as Groupname, ');
  Qrymain.SQL.add(ThirdColumn +' as GroupValue ');
  Qrymain.SQL.add(' from tblParts P');
  inherited;
end;

procedure TProductGroupItemsGUI.FormDestroy(Sender: TObject);
begin
  Freeandnil(SelectedGroups);
  inherited;
end;

procedure TProductGroupItemsGUI.FormShow(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  grdMain.unselectAll;
  for ctr := 0 to SelectedGroups.count-1 do begin
    if Qrymain.Locate('GroupValue' ,SelectedGroups[ctr],[]) then
      grdMain.SelectRecord;
  end;
end;

initialization
  RegisterClassOnce(TProductGroupItemsGUI);

end.

