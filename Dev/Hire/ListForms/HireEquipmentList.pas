unit HireEquipmentList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  THireEquipmentListGUI = class(TBaseListingGUI)
    qryMainEquipmentID: TIntegerField;
    qryMainAssetProduct: TWideStringField;
    qryMainEquipmentName: TWideStringField;
    qryMainEquipmentDescription: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainManufacture: TWideStringField;
    qryMainModel: TWideStringField;
    qryMainSerialnumber: TWideStringField;
    qryMaindetails: TLargeintField;
    qryMainAssetProductID: TIntegerField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
  public
  end;

implementation

uses CommonLib, tcConst;

{$R *.dfm}

{ TBaseListingGUI1 }

procedure THireEquipmentListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  SwapBaseIndexFieldPriority := true;
  HaveDateRangeSelection := False;
end;

procedure THireEquipmentListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Qrymaindetails.asInteger = 2 then begin
     if Sametext(field.fieldname , QrymainAssetproduct.fieldname) then
        Afont.color := abrush.color;
  end;
end;

procedure THireEquipmentListGUI.grdMainDblClick(Sender: TObject);
begin
  if QrymainDetails.asInteger = 1 then
    CommonLib.MessageDlgXP_Vista('This is a Group Record.'+NL+'Please Choose a Record with an Equipment Name', mtInformation, [mbOK], 0)
  else inherited;

end;

procedure THireEquipmentListGUI.grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
begin
  if Sametext(Afieldname , QrymainAssetproduct.fieldname) then else
  inherited;

end;

procedure THireEquipmentListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  if GroupFilterString <> '' then GroupFilterString  := GroupFilterString  +' or Details = 1';
  inherited;
end;

procedure THireEquipmentListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  BaseIndexFieldNames :=  QrymainAssetProduct.fieldname+ ' asc cis; ' +QrymainAssetproduct.fieldname+' asc cis; '+QrymainDetails.fieldname+' asc cis; ';
end;

Procedure THireEquipmentListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(Qrymaindetails.fieldname);
  RemoveFieldfromGrid(QrymainEquipmentId.fieldname);
  RemoveFieldfromGrid(QrymainAssetProductID.fieldname);
end;
initialization
  RegisterClassOnce(THireEquipmentListGUI);

end.
