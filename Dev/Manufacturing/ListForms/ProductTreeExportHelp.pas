unit ProductTreeExportHelp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TProductTreeExportHelpGUI = class(TBaseListingGUI)
    qryMainName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainForeignKey: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TProductTreeExportHelpGUI.FormCreate(Sender: TObject);
begin
  NonSearchMode := true;
  inherited;

end;

initialization
  RegisterClassOnce(TProductTreeExportHelpGUI);

end.
