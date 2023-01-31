unit frmPadGuiTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  AdvSmoothButton, Keyboard, AdvSmoothExpanderPanel, AdvSmoothTouchKeyBoard,
  AdvSmoothPanel, AdvSmoothLabel, AdvSmoothListBox, AdvSmoothComboBox,
  AdvSmoothStatusIndicator, AdvSmoothTabPager, AdvSmoothToggleButton, StdCtrls,
  AdvSmoothEdit, AdvSmoothEditButton, AdvSmoothDatePicker,
  DBAdvSmoothDatePicker, Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid;

type
  TfmPadGuiTest = class(TBaseInputGUI)
    AdvSmoothButton1: TAdvSmoothButton;
    AdvSmoothPanel1: TAdvSmoothPanel;
    AdvSmoothExpanderPanel1: TAdvSmoothExpanderPanel;
    AdvSmoothToggleButton1: TAdvSmoothToggleButton;
    AdvSmoothTabPager1: TAdvSmoothTabPager;
    AdvSmoothTabPager11: TAdvSmoothTabPage;
    AdvSmoothTabPager12: TAdvSmoothTabPage;
    AdvSmoothTabPager13: TAdvSmoothTabPage;
    AdvSmoothStatusIndicator1: TAdvSmoothStatusIndicator;
    AdvSmoothComboBox1: TAdvSmoothComboBox;
    AdvSmoothLabel1: TAdvSmoothLabel;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvSmoothDatePicker1: TAdvSmoothDatePicker;
    DBAdvGrid1: TDBAdvGrid;
    DBAdvSmoothDatePicker1: TDBAdvSmoothDatePicker;
    TouchKeyboard1: TTouchKeyboard;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPadGuiTest: TfmPadGuiTest;

implementation

{$R *.dfm}

initialization
  RegisterClass(TfmPadGuiTest)

end.
