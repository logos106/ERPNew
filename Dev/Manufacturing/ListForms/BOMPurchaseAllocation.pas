unit BOMPurchaseAllocation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, CustomInputBox;

type
  TBOMPurchaseAllocationGUI = class(TBaseListingGUI)
    qryMainpqatype: TWideStringField;
    qryMainBAtchno: TWideStringField;
    qryMainExpirydate: TDateTimeField;
    qryMainBinLocation: TWideStringField;
    qryMainBinNumber: TWideStringField;
    qryMainSerialno: TWideStringField;
    qryMainBatchQty: TFloatField;
    qryMainBinQTY: TFloatField;
    qryMainProductType: TWideStringField;
    qryMainUOMBatchQty: TFloatField;
    qryMainUOMBinQTY: TFloatField;
    qryMainPQADetailID: TLargeintField;
    qryMainPQABAtchId: TLargeintField;
    qryMainPQABinID: TLargeintField;
    qryMainPQASNID: TLargeintField;
    qryMainBinID: TIntegerField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fiProctreeId: Integer;
  Protected
    procedure SetGridColumns; Override;
    function isvalidtoSelect:Boolean;Override;
  public
    Property ProctreeId :Integer read fiProctreeId write fiProctreeId;
    Procedure RefreshQuery; override;
    Class function ListSQL:String;
  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TBOMPurchaseAllocationGUI.FormCreate(Sender: TObject);
begin
  inherited;
  DisableSortoncolumtitleclick:= TRue;
  fiProctreeId:= 0;
end;

procedure TBOMPurchaseAllocationGUI.FormShow(Sender: TObject);
begin
  inherited;
  btnCustomize.Enabled := False;
end;

procedure TBOMPurchaseAllocationGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Sametext(QrymainPQAtype.asString , 'Batch') then begin
    if sametext(field.fieldname , qrymainbinlocation.fieldname) or
        sametext(field.fieldname , qrymainbinnumber.fieldname) or
        sametext(field.fieldname , qrymainbinQty.fieldname) or
        sametext(field.fieldname , qrymainserialno.fieldname) then AFont.color := abrush.color;
  end else if Sametext(QrymainPQAtype.asString , 'Bin') then begin
    if sametext(field.fieldname , qrymainbatchno.fieldname) or
        sametext(field.fieldname , qrymainexpiryDate.fieldname) or
        sametext(field.fieldname , qrymainbatchQty.fieldname) or
        sametext(field.fieldname , qrymainserialno.fieldname) then AFont.color := abrush.color;
  end else if Sametext(QrymainPQAtype.asString , 'SN') then begin
    if sametext(field.fieldname , qrymainbatchno.fieldname) or
        sametext(field.fieldname , qrymainexpiryDate.fieldname) or
        sametext(field.fieldname , qrymainbatchQty.fieldname) or
        sametext(field.fieldname , qrymainbinlocation.fieldname) or
        sametext(field.fieldname , qrymainbinnumber.fieldname) or
        sametext(field.fieldname , qrymainbinQty.fieldname)then AFont.color := abrush.color;
  end;
end;

procedure TBOMPurchaseAllocationGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  if selecting then
    Accept := sametext(Qrymainproducttype.asString , QrymainPQAtype.asString);
end;

function TBOMPurchaseAllocationGUI.isvalidtoSelect: Boolean;
begin
    result := sametext(Qrymainproducttype.asString , QrymainPQAtype.asString);
end;

class function TBOMPurchaseAllocationGUI.ListSQL: String;
begin
  With TBOMPurchaseAllocationGUI.create(nil) do try
    result:= Qrymain.SQL.text;
  finally
    Free;
  end;
end;

procedure TBOMPurchaseAllocationGUI.RefreshQuery;
begin
  Qrymain.ParamByName('ProctreeID').AsInteger := ProctreeId;
  inherited;
end;

procedure TBOMPurchaseAllocationGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainPQAtype.fieldname    );
  RemoveFieldfromGrid(QrymainProductType.fieldname);
  RemoveFieldfromGrid(qryMainBinID.fieldname      );
  RemoveFieldfromGrid(qryMainPQABAtchId.fieldname );
  RemoveFieldfromGrid(qryMainPQABinID.fieldname   );
  RemoveFieldfromGrid(qryMainPQASNID.fieldname    );
  RemoveFieldfromGrid(qryMainPQADetailID.fieldname);
  RemoveFieldfromGrid(qryMainBatchQty.fieldname   );
  RemoveFieldfromGrid(qryMainBinQTY.fieldname     );
end;
initialization
  RegisterClassOnce(TBOMPurchaseAllocationGUI);

end.

