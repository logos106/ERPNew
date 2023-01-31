unit frmAvailableQty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess, SelectionDialog, AppEvnts, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid,
  MemDS, StdCtrls, Shader, DNMPanel;

type
  TBaseInputGUI1 = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    edPartName: TEdit;
    qryQtys: TMyQuery;
    qryQtysClassName: TStringField;
    qryQtyscalcAvail: TFloatField;
    qryQtysInvoiceBOQty: TFloatField;
    qryQtysSalesOrdersQty: TFloatField;
    qryQtysInStockQty: TFloatField;
    qryQtysOnOrderQty: TFloatField;
    qryQtysProductID: TIntegerField;
    qryQtysProductName: TStringField;
    qryQtysProductGroup: TStringField;
    qryQtysClassID: TIntegerField;
    qryQtysID: TAutoIncField;
    DSQtys: TDataSource;
    grdPartQtyLines: TwwDBGrid;
    DNMPanel2: TDNMPanel;
    Label3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BaseInputGUI1: TBaseInputGUI1;

implementation

{$R *.dfm}

end.
