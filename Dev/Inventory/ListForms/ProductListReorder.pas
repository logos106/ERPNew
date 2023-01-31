unit ProductListReorder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TProductListReorderGUI = class(TBaseListingGUI)
    qryMainPARTSID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainSalesDescription: TWideStringField;
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
    qryMainClassName: TWideStringField;
    qryMainReOrderPoint: TFloatField;
    qryMainPreferredLevel: TFloatField;
    qryMainReOrderAmount: TFloatField;
    btnProductExpress: TDNMSpeedButton;
    btnProductList: TDNMSpeedButton;
    qryMainAvailable: TFloatField;
    qryMainInStock: TFloatField;
    qryMainAllocatedSO: TFloatField;
    qryMainAllocatedBO: TFloatField;
    qryMainOnOrder: TFloatField;
    qryMainOnBuild: TFloatField;
    qryMainBuilding: TFloatField;
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnProductListClick(Sender: TObject);
    procedure btnProductExpressClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses pqalib,CommonFormLib,commonLib, BaseInputForm, AppEnvironment, ProductQtyLib,
  tcConst;

{$R *.dfm}
procedure TProductListReorderGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfrmParts');
    if Assigned(Form) then begin //if has acess
      with TBaseInputGUI(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TProductListReorderGUI.FormShow(Sender: TObject);
begin
  inherited;
  qryMain.First;
end;

procedure TProductListReorderGUI.btnProductListClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TProductListGUI');
  Self.Close;
end;

procedure TProductListReorderGUI.btnProductExpressClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TProductListExpressGUI');
  Self.Close;
end;

procedure TProductListReorderGUI.FormCreate(Sender: TObject);
begin
  closeDB(Qrymain);
  Qrymain.SQL.clear;
  Qrymain.SQL.Add( 'SELECT');
  Qrymain.SQL.Add( 'P.PARTSID as PARTSID,');
  Qrymain.SQL.Add( 'P.PARTNAME as ProductName,');
  Qrymain.SQL.Add( 'SUBSTRING_INDEX( Concat_WS("^(",P.PRODUCTGROUP,"") ,"^",1) AS FirstColumn,');
  Qrymain.SQL.Add( 'LEFT(MID(SUBSTRING_INDEX( Concat_WS("^",P.PRODUCTGROUP,"") ,"^",2),');
  Qrymain.SQL.Add( 'char_length(SUBSTRING_INDEX( Concat_WS("^",P.PRODUCTGROUP,"") ,"^",1))+2,');
  Qrymain.SQL.Add( 'char_length(SUBSTRING_INDEX( Concat_WS("^",P.PRODUCTGROUP,"") ,"^",2))-');
  Qrymain.SQL.Add( 'char_length(SUBSTRING_INDEX( Concat_WS("^",P.PRODUCTGROUP,"") ,"^",1))),255) AS SecondColumn,');
  Qrymain.SQL.Add( 'LEFT(MID(SUBSTRING_INDEX( Concat_WS("^",P.PRODUCTGROUP,"") ,"^",3),');
  Qrymain.SQL.Add( 'char_length(SUBSTRING_INDEX( Concat_WS("^",P.PRODUCTGROUP,"") ,"^",2))+2,');
  Qrymain.SQL.Add( 'char_length(SUBSTRING_INDEX( Concat_WS("^",P.PRODUCTGROUP,"") ,"^",3))-');
  Qrymain.SQL.Add( 'char_length(SUBSTRING_INDEX( Concat_WS("^",P.PRODUCTGROUP,"") ,"^",2))),255) AS ThirdColumn,');
  Qrymain.SQL.Add( 'P.PARTSDESCRIPTION as SalesDescription,');
  Qrymain.SQL.Add( 'P.PartType,');
  Qrymain.SQL.Add( 'P.CUSTFLD1,');
  Qrymain.SQL.Add( 'P.CUSTFLD2,');
  Qrymain.SQL.Add( 'P.CUSTFLD3,');
  Qrymain.SQL.Add( 'P.CUSTFLD4,');
  Qrymain.SQL.Add( 'P.CUSTFLD5,');
  Qrymain.SQL.Add( 'P.CUSTFLD6,');
  Qrymain.SQL.Add( 'P.CUSTFLD7,');
  Qrymain.SQL.Add( 'P.CUSTFLD8,');
  Qrymain.SQL.Add( 'P.CUSTFLD9,');
  Qrymain.SQL.Add( 'P.CUSTFLD10,');
  Qrymain.SQL.Add( 'P.CUSTFLD11,');
  Qrymain.SQL.Add( 'P.CUSTFLD12,');
  Qrymain.SQL.Add( 'P.CUSTFLD13,');
  Qrymain.SQL.Add( 'P.CUSTFLD14,');
  Qrymain.SQL.Add( 'P.CUSTFLD15,');
  Qrymain.SQL.Add( 'P.CUSTDATE1,');
  Qrymain.SQL.Add( 'P.CUSTDATE2,');
  Qrymain.SQL.Add( 'P.CUSTDATE3,');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tAvailable) +',0.0),' +inttostr(tcConst.GeneralRoundPlaces) +') AS "Available",');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInstock) +',0.0),' +inttostr(tcConst.GeneralRoundPlaces) +') AS "In Stock",');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tSO) +',0.0),' +inttostr(tcConst.GeneralRoundPlaces) +') AS "Allocated SO",');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInvBO) +',0.0),' +inttostr(tcConst.GeneralRoundPlaces) +') AS "Allocated BO",');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tPOBO) +',0.0),' +inttostr(tcConst.GeneralRoundPlaces) +') AS "On Order",');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tOnBuild) +',0.0),' +inttostr(tcConst.GeneralRoundPlaces) +') AS "On Build",');
  Qrymain.SQL.Add( 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tBuilding) +',0.0),' +inttostr(tcConst.GeneralRoundPlaces) +') AS "Building",');
  Qrymain.SQL.Add( 'PC.ClassName as ClassName,');
  Qrymain.SQL.Add( 'PC.ReOrderPoint as ReOrderPoint,');
  Qrymain.SQL.Add( 'PC.PreferredLevel as PreferredLevel,');
  Qrymain.SQL.Add( 'PC.ReOrderAmount as ReOrderAmount');
  (*Qrymain.SQL.Add( 'FROM tblparts p');
  Qrymain.SQL.Add( 'inner join tblproductclasses PC on PC.ProductId = P.PartsId');*)
  Qrymain.SQL.Add('FROM ' + ProductTables(tProductList));
  Qrymain.SQL.Add( 'Where (p.Active="T") AND  char_length(p.PARTNAME) > 0 AND not IsNull(p.PARTNAME)');
  qryMain.SQL.Add('GROUP BY P.PARTSID ');
  inherited;

end;

initialization
  RegisterClassOnce(TProductListReorderGUI);

end.

