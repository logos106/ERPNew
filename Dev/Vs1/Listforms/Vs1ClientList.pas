unit Vs1ClientList;

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
  TVs1ClientListGUI = class(TBaseListingGUI)
    qryMainid: TIntegerField;
    qryMainClientName: TWideStringField;
    qryMainSoftwareReleaseType: TWideStringField;
    qryMainvs1ClientName: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainRegistrationDate: TDateField;
    procedure FormCreate(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
  public
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TVs1ClientListGUI }

procedure TVs1ClientListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TVs1ClientListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainid.fieldname);
  RemoveFieldfromGrid(qryMainSoftwareReleaseType.fieldname);
end;

initialization
  RegisterClass(TVs1ClientListGUI);

end.
