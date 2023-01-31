unit frmSalesShippingDetailWalmart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmSalesShippingDetail, StdCtrls, ExtCtrls, DBCtrls, DB,
  ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, AdvMenus,
  DataState, AppEvnts, SelectionDialog, Menus, DNMSpeedButton, Shader,
  wwdbdatetimepicker, wwdblook, Mask, wwdbedit, DNMPanel;

type
  TfmSalesShippingDetailWalmart = class(TfmSalesShippingDetail)
    Label14: TLabel;
    wwDBEdit10: TwwDBEdit;
    Label16: TLabel;
    wwDBEdit11: TwwDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    Label15: TLabel;
    wwDBEdit4: TwwDBEdit;
    Label17: TLabel;
    wwDBEdit12: TwwDBEdit;
    Label12: TLabel;
    wwDBEdit2: TwwDBEdit;
    Label18: TLabel;
    wwDBEdit3: TwwDBEdit;
    Label11: TLabel;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
