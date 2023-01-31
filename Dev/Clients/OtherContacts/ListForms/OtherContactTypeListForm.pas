unit OtherContactTypeListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar,
  SelectionDialog, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS, wwDialog, Wwlocate,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable;

type
  TOtherContactTypeListGUI = class(TBaseListingGUI)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  OtherContactTypeListGUI: TOtherContactTypeListGUI;

implementation

uses CommonLib;

{$R *.dfm}

procedure TOtherContactTypeListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  OtherContactTypeListGUI := nil;
end;
initialization
  RegisterClassOnce(TOtherContactTypeListGUI);

end.
