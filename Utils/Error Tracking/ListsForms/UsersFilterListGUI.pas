unit UsersFilterListGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, MemDS, DBAccess, MyAccess, ActnList, Menus,
  StdCtrls, Buttons, wwdblook, wwdbdatetimepicker, DNMPanel, Grids,
  Wwdbigrd, Wwdbgrid, ExtCtrls, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, DNMSpeedButton, Shader;

type
  TUsersFilterList = class(TBaseListingGUI)
    grdMainIButton: TwwIButton;
    procedure FormDestroy(Sender: TObject);
    procedure grdMainIButtonClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

var
  UsersFilterList: TUsersFilterList;

implementation
   Uses UserInfoObj,FuncLib;
{$R *.dfm}

procedure TUsersFilterList.FormDestroy(Sender: TObject);
begin
  inherited;
  UsersFilterList := nil;
end;

procedure TUsersFilterList.grdMainIButtonClick(Sender: TObject);
begin
  inherited;
  FuncLib.DeleteRecord(qryListData);
end;

procedure TUsersFilterList.RefreshQuery;
begin
  qryListData.Params.ParamByName('xID').asInteger := UserInfo.UserID;
  inherited;
end;

procedure TUsersFilterList.cmdPrintClick(Sender: TObject);
begin
  ReportName:='Users Filter List';
  Preview:=True;
  Dataset:=qryListData;
  inherited;

end;

end.
