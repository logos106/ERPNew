unit UserListGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, MemDS, DBAccess, MyAccess, ActnList, Menus,
  StdCtrls, Buttons, wwdbdatetimepicker, DNMPanel, Grids, Wwdbigrd,
  Wwdbgrid, ExtCtrls, CustomInputBox, wwdblook, wwclearbuttongroup,
  wwradiogroup, DNMSpeedButton, Shader;

type
  TUsersList = class(TBaseListingGUI)
    procedure FormDestroy(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UsersList: TUsersList;

implementation

  Uses UserGUI;
  
{$R *.dfm}

procedure TUsersList.FormDestroy(Sender: TObject);
begin
  inherited;
  UsersList := nil;
end;

procedure TUsersList.cmdPrintClick(Sender: TObject);
begin
  inherited;
  ReportName:='User List';
  Preview:=True;
  Dataset:=qryListData;
  inherited;
end;

procedure TUsersList.cmdNewClick(Sender: TObject);
begin
  inherited;
  with TUser.Instance do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

end.
