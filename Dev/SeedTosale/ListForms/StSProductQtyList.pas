unit StSProductQtyList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProductQtylist, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TStSProductQtyListGUI = class(TProductQtylistGUI)
    qryMainStrainName: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private

  Protected
    Function ExtraTables:String; Override;
    Function ExtraFields:String; Override;
    Function OrderFields:String; Override;
    Procedure SetGridColumns;override;

  public
  end;


implementation

uses DbSharedObjectsObj, CommonDbLib, CommonLib, AppEnvironment, tcConst;

{$R *.dfm}

function TStSProductQtyListGUI.ExtraFields: String;
begin
  REsult := 'STSS.StrainName AS StrainName,' +NL+
  'if (STSS.ImmatureProductID = P.PartsId, 1 , if(STSS.VegetativeProductId = P.PartsId, 2, if(STSS.FloweringProductID = P.PartsId,3, if(STSS.HarvestProductId = P.PartsId,4,5)))) AS StsProdSeq,  ';
end;

function TStSProductQtyListGUI.OrderFields: String;
begin
  REsult := 'ORDER BY StrainName, StsProdSeq, Partname';
end;

procedure TStSProductQtyListGUI.SetGridColumns;
begin
  inherited;
end;

function TStSProductQtyListGUI.ExtraTables: String;
begin
  REsult := 'Left JOIN tblstsstrains STSS ON (STSS.ImmatureProductID = P.PartsId) OR (STSS.VegetativeProductId = P.PartsId) OR (STSS.FloweringProductID = P.PartsId) OR (STSS.HarvestProductId = P.PartsId) ';
end;

procedure TStSProductQtyListGUI.FormCreate(Sender: TObject);
var
  qry: TERPQuery;
begin
  inherited;
  Widerform(1500);
  HaveDateRangeSelection := False;
  btnExpressDetail.visible := False;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    closedb(qry);
    qry.SQL.Text :=' SELECT Distinct STS.ImmatureProductId   ProductId FROM tblstsstrains STS  where ifnull(STS.ImmatureProductId  ,0)<> 0 UNION ' +
                   ' select Distinct STS.VegetativeProductId ProductId FROM tblstsstrains STS  where ifnull(STS.VegetativeProductId,0)<> 0 UNION ' +
                   ' select Distinct STS.FloweringProductID  ProductId FROM tblstsstrains STS  where ifnull(STS.FloweringProductID ,0)<> 0 UNION  '+
                   ' select Distinct STS.HarvestProductID    ProductId FROM tblstsstrains STS  where ifnull(STS.HarvestProductID   ,0)<> 0 UNION  '+
                   ' select Distinct P.partsId               ProductId FROM tblparts P where trim(P.partname )<> "" and P.partname = '+ quotedstr(Appenv.companyprefs.StSPackageTagProduct)+' UNION  '+
                   ' select Distinct P.partsId               ProductId FROM tblparts P where trim(P.partname )<> "" and P.partname = '+ quotedstr(Appenv.companyprefs.StSPlantTagProduct);
    OpenDb(qry);
    ProductIDs := qry.GroupConcat('ProductID');
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

initialization
  RegisterClassOnce(TStSProductQtyListGUI);

end.
