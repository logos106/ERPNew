unit QtySQLs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, StdCtrls, Menus;

type
  TQtySQLsGUI = class(TBaseForm)
    Memo1: TMemo;
    Button1: TButton;
    edtPartsId: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  QtySQLsGUI: TQtySQLsGUI;

implementation

uses pqalib, ProductQtyLib, CommonLib;

{$R *.dfm}

procedure TQtySQLsGUI.Button1Click(Sender: TObject);
begin
  inherited;
  Memo1.Lines.clear;
  Memo1.Lines.Add('Select');
  Memo1.Lines.Add(SQL4QtyField(tOnBuild)+' as tOnBuild, ');
  Memo1.Lines.Add(SQL4QtyField(tBuilding)+' as tBuilding,');
  Memo1.Lines.Add(SQL4QtyField(tInStock)+' as tInStock,');
  Memo1.Lines.Add(SQL4QtyField(tStockQty)+' as tStockQty,');
  Memo1.Lines.Add(SQL4QtyField(tAvailable)+' as tAvailable,');
  Memo1.Lines.Add(SQL4QtyField(tSO)+' as tSO,');
  Memo1.Lines.Add(SQL4QtyField(tInvBO)+' as tInvBO,');
  Memo1.Lines.Add(SQL4QtyField(tPOBO)+' as tPOBO,');
  Memo1.Lines.Add(SQL4QtyField(tSOBO)+' as tSOBO,');
  Memo1.Lines.Add(SQL4QtyField(tTransQty)+' as tTransQty,');
  Memo1.Lines.Add(SQL4QtyField(tInStockMovement)+' as tInStockMovement,');
  Memo1.Lines.Add(SQL4QtyField(tOUTs)+' as tOUTs,');
  Memo1.Lines.Add(SQL4QtyField(tINs)+' as tINs,');
  Memo1.Lines.Add('from tblPQa PQA');
  if edtPartsId.text <> '' then Memo1.Lines.Add('where PQA.ProductId = ' +edtPartsId.text);
  Memo1.Lines.Add('Order by Transdate');
end;

procedure TQtySQLsGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

initialization
  RegisterClassOnce(TQtySQLsGUI);

end.

