unit MarketingcontactListForLead;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MarketingContactList, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox;

type
  TMarketingcontactListForLeadGUI = class(TMarketingContactListGUI)
    procedure FormCreate(Sender: TObject);
  private
  Protected
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}


procedure TMarketingcontactListForLeadGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ExcludeMCwithLead:= True;
end;

initialization
  RegisterClassOnce(TMarketingcontactListForLeadGUI);

end.

