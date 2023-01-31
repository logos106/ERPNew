unit ProductsWithBlanknameList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TProductsWithBlanknameListGUI = class(TBaseListingGUI)
    qryMainPARTSID: TAutoIncField;
    qryMainProductName: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainSalesDescription: TWideStringField;
    qryMainPURCHASEDESC: TWideStringField;
    qryMainPriceInc: TFloatField;
    qryMainDiscontinued: TWideStringField;
    qryMainPartType: TWideStringField;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    qryMainCUSTDATE1: TDateTimeField;
    qryMainCUSTDATE2: TDateTimeField;
    qryMainCUSTDATE3: TDateTimeField;
    qryMainBARCODE: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainProductionNotes: TWideMemoField;
    qryMainGeneralNotes: TWideMemoField;
    qryMainIsSystemProduct: TWideStringField;
    qryMainBatch: TWideStringField;
    qryMainMultiplebins: TWideStringField;
    qryMainSNtracking: TWideStringField;
    qryMainArea: TWideStringField;
    qryMainPreferedSupp: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
  Protected
    Procedure SetGridColumns;override;
  public
    { Public declarations }
  end;


implementation

uses CommonDbLib, CommonLib;

{$R *.dfm}

procedure TProductsWithBlanknameListGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  try
      with scriptmain do begin
          SQL.Clear;
          SQL.add('create table if not exists erpfix_tblparts_2020500 like tblparts;');
          SQL.add('insert ignore into erpfix_tblparts_2020500 select * from  tblparts  WHERE IFNULL(partname, "") = "";');
          SQL.add('delete from  tblparts  WHERE IFNULL(partname, "") = "";');
          Execute;
      end;
  finally
    closedb(Qrymain);
    RefreshQuery;
  end;
end;

procedure TProductsWithBlanknameListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TProductsWithBlanknameListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainpartsID.fieldname);
  SetUpcustomFields('Product');
end;
initialization
  RegisterClassOnce(TProductsWithBlanknameListGUI);

end.
