unit ProductclassQty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProductclassQtyGUI = class(TBaseListingGUI)
    qryMainProductID: TIntegerField;
    qryMainDepartmentID: TIntegerField;
    qryMainClassname: TWideStringField;
    qryMainAvailableQty: TFloatField;
    qryMainAllocatedBOQty: TFloatField;
    qryMainSOQty: TFloatField;
    qryMainSOBOQty: TFloatField;
    qryMainInstockQty: TFloatField;
    qryMainPOBOQty: TFloatField;
    lblMsg: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
  private
    ficlassId: Integer;
    fiProductID: Integer;
    Procedure MakeQrymain;
  public
    Property classId :Integer read ficlassId write fiClassId;
    Property ProductID :Integer read fiProductID write fiProductID;
    Procedure RefreshQuery; Override;
  end;


implementation

uses CommonLib, ProductQtyLib, tcConst, PQALib, tcDataUtils, AppEnvironment;

{$R *.dfm}
{ TProductclassQtyGUI }

procedure TProductclassQtyGUI.FormCreate(Sender: TObject);
begin
  productID := 0;
  classID   := 0;
  MakeQrymain;
  inherited;
  SearchMode:= smFullList;
end;

procedure TProductclassQtyGUI.FormShow(Sender: TObject);
begin
  inherited;
  lblMsg.caption := 'This screen is showing because there is no stock available for ' + quotedstr(getproduct(ProductID))+' in the ' + quotedstr(getclassname(ClassID))+' ' + Appenv.defaultclass.classheading +'.'+
                    'This is the Available Stock in Other ' + Appenv.defaultclass.classheading+'(s) for the Product.';
end;

procedure TProductclassQtyGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if classId = qrymainDepartmentId.asInteger then afont.color := clinactivecaption;
  if sametext(field.fieldname , QrymainAvailableQty.fieldname) then Afont.color := clmaroon;
end;

procedure TProductclassQtyGUI.MakeQrymain;
begin
    closedb(qrymain);
    qrymain.SQL.clear;
    qrymain.SQL.add('Select distinct ');
    qrymain.SQL.add('PQA.ProductID    as ProductID,');
    qrymain.SQL.add('PQA.DepartmentID as DepartmentID,');
    qrymain.SQL.add('C.Classname      as Classname,');
    qrymain.SQL.add('Round(' + ProductQtyLib.SQL4Qty(tAvailable )+ ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as AvailableQty, ');
    qrymain.SQL.add('Round(' + ProductQtyLib.SQL4Qty(tInvBO     )+ ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as AllocatedBOQty, ');
    qrymain.SQL.add('Round(' + ProductQtyLib.SQL4Qty(tSO        )+ ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as SOQty, ');
    qrymain.SQL.add('Round(' + ProductQtyLib.SQL4Qty(tSOBO      )+ ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as SOBOQty, ');
    qrymain.SQL.add('Round(' + ProductQtyLib.SQL4Qty(tInStock   )+ ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as InstockQty, ');
    qrymain.SQL.add('Round(' + ProductQtyLib.SQL4Qty(tPOBO      )+ ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as POBOQty ');
    qrymain.SQL.add('FROM tblPQA as PQA inner join tblclass C on C.classId = PQA.departmentId ');
    qrymain.SQL.add('where PQA.ProductID = :ProductId');
    qrymain.SQL.add('group by PQA.ProductID, PQA.DepartmentID');
    qrymain.SQL.add('having AvailableQty >0');
    qrymain.SQL.add('Order by classname');
end;

procedure TProductclassQtyGUI.RefreshQuery;
begin
  Qrymain.parambyname('ProductId').asInteger := ProductID;
  inherited;

end;

initialization
  RegisterClassOnce(TProductclassQtyGUI);

end.
