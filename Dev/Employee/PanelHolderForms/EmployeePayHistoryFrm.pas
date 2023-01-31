unit EmployeePayHistoryFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DNMPanel,BaseListingForm, frmBase, StdCtrls, Menus;

type
  TEmployeePayHistoryGUI = class(TfrmBaseGUI)
  private
  public
    KeyID:integer;
    ffrmList: TBaseListingGUI;
  end;

implementation

uses
  CommonLib;

{$R *.dfm}  

initialization
  RegisterClassOnce(TEmployeePayHistoryGUI);
end.
