unit WooCommerceListBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel,ERPEDIListBase;

type
  TWooCommerceListBaseGUI = class(TERPEDIListBaseGUI)
    pnlExtraButtons: TDNMPanel;
    lblExporttoWalmart: TLabel;
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    chkShowProduct: TwwCheckBox;
    btnSynchOrders: TDNMSpeedButton;
  private
  Protected
    procedure Alignbuttons; Override;
  public
    Procedure OpenPreferance;Override;
  end;

implementation

uses LogLib, LogDialog, Preferences;

{$R *.dfm}

{ TWooCommerceListBaseGUI }

procedure TWooCommerceListBaseGUI.Alignbuttons;
var
  ctr:Integer;
begin
  Inherited;
  Alignbuttons(pnlExtraButtons);
  setlength(buttons,0);
  for ctr := 0 to pnlExtraButtons.ControlCount - 1 do begin
    if pnlExtraButtons.Controls[ctr] is TDnmspeedbutton then begin
      if TDnmspeedbutton(pnlExtraButtons.Controls[ctr]).Visible then begin
        Setlength(Buttons , length(Buttons)+1);
        Buttons[high(Buttons)] := TDnmspeedbutton(pnlExtraButtons.Controls[ctr]).Name;
      end;
    end;
  end;
  Centralisebuttons(pnlExtraButtons);

  Alignbuttons(FooterPanel);
  initFooterPanelButtons;
  Centralisebuttons(FooterPanel);
end;


procedure TWooCommerceListBaseGUI.OpenPreferance;
begin
  inherited;
  OpenPrefform('EDI and Integration' ,  'chkWooCommerce_AutocheckforOrdersinList', 0 , True, 'WooCommerce' , 'pnlWooCommerceOptions' ,
                    'Changes made here will not take affect unless the Application is Restarted.');
end;

end.
