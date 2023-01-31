unit SalesStockQtyStatusBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , busobjsalebase,BaseListExpress,
  wwclearbuttongroup, wwradiogroup;

type
  TSalesStockQtyStatusBaseGUI = class(TBaseListExpressGUI)
    pnlallclasses: TDNMPanel;
    chkAllclasses: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure chkAllclassesClick(Sender: TObject);
  private
    fSalesBase: TSalesBase;
  Protected
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    Procedure CopyParamsto(Sender:TObject);Override;
  public
    Property SalesBaseObj : TSalesBase read fSalesBase write fSalesBase ;
  end;


implementation

uses AppEnvironment, tcConst;

{$R *.dfm}

procedure TSalesStockQtyStatusBaseGUI.chkAllclassesClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TSalesStockQtyStatusBaseGUI.CopyParamsto(Sender: TObject);
begin
  inherited;
  TSalesStockQtyStatusBaseGUI(sendeR).SalesBaseObj := SalesBaseObj;
  TSalesStockQtyStatusBaseGUI(sendeR).chkAllclasses.Checked:= chkAllclasses.Checked;

end;

procedure TSalesStockQtyStatusBaseGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
  showcontrolhint(pnlallclasses , 'When Checked Stock Qty of all ' + AppEnv.DefaultClass.ClassHeading +NL+
                                  'When Un-Checked Stock Qty of Products in the Sales '+ AppEnv.DefaultClass.ClassHeading);
  showcontrolhint(chkAllclasses , pnlallclasses.hint);

end;

procedure TSalesStockQtyStatusBaseGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  chkAllclasses.checked :=  GuiPrefs.Node['Options.Allclasses'].AsBoolean;
end;

procedure TSalesStockQtyStatusBaseGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.Allclasses'].AsBoolean := chkAllclasses.checked;
end;

end.
