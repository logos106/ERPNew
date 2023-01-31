unit TransRecList;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 30/09/05  1.00.01 IJB  Added RegisterClass to initialization section.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, ProgressDialog,  wwdblook, Shader,
  kbmMemTable;

type
  TTransRecListGUI = class(TBaseListingGUI)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fsDblClickType: string;
  public
    { Public declarations }
    property DblClickType: string read fsDblClickType write fsDblClickType;
  end;

implementation

uses CommonLib;

{$R *.dfm}

{ TTransRecListGUI }


procedure TTransRecListGUI.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
end;

initialization
  RegisterClassOnce(TTransRecListGUI);
end.
