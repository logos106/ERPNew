unit ProductQtys;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  Grids, Wwdbigrd, Wwdbgrid, ComCtrls, StdCtrls, wwdblook, DNMSpeedButton,
  ProgressDialog;

type
  TfmProductQtys = class(TBaseInputGUI)
    QryParts: TERPQuery;
    QrySA: TERPQuery;
    QryProductList: TERPQuery;
    Qryproductmovement: TERPQuery;
    dsParts: TDataSource;
    dsSa: TDataSource;
    dsProductList: TDataSource;
    dsproductmovement: TDataSource;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    grdParts: TwwDBGrid;
    grdSa: TwwDBGrid;
    grdProductList: TwwDBGrid;
    grdproductmovement: TwwDBGrid;
    QryPartsPQAID: TIntegerField;
    QryPartsProductID: TIntegerField;
    QryPartsDepartmentID: TIntegerField;
    QryPartsProductName: TWideStringField;
    QryPartsAvailableQty: TFloatField;
    QryPartsAllocatedBOQty: TFloatField;
    QryPartsSOQty: TFloatField;
    QryPartsSOBOQty: TFloatField;
    QryPartsInstockQty: TFloatField;
    QryPartsPOBOQty: TFloatField;
    QrySAPQAID: TIntegerField;
    QrySAProductID: TIntegerField;
    QrySADepartmentID: TIntegerField;
    QrySAProductName: TWideStringField;
    QrySAAvailableQty: TFloatField;
    QrySAAllocatedBOQty: TFloatField;
    QrySASOQty: TFloatField;
    QrySASOBOQty: TFloatField;
    QrySAInstockQty: TFloatField;
    QrySAPOBOQty: TFloatField;
    gQryParts: TERPQuery;
    gQrySA: TERPQuery;
    gQryProductList: TERPQuery;
    gQryproductmovement: TERPQuery;
    gdsParts: TDataSource;
    gdsSa: TDataSource;
    gdsProductList: TDataSource;
    gdsproductmovement: TDataSource;
    wwDBGrid1: TwwDBGrid;
    wwDBGrid2: TwwDBGrid;
    wwDBGrid3: TwwDBGrid;
    wwDBGrid4: TwwDBGrid;
    TabSheet3: TTabSheet;
    DNMSpeedButton1: TDNMSpeedButton;
    dsProductQty: TDataSource;
    ProductQty: TERPQuery;
    wwDBGrid5: TwwDBGrid;
    ProductQtyID: TLargeintField;
    ProductQtyPQAId: TLargeintField;
    ProductQtyDescription: TWideStringField;
    ProductQtyd1: TFloatField;
    ProductQtyd2: TFloatField;
    ProductQtyd3: TFloatField;
    ProductQtyd4: TFloatField;
    QryProductListPQAID: TIntegerField;
    QryProductListProductID: TIntegerField;
    QryProductListDepartmentID: TIntegerField;
    QryProductListProductName: TWideStringField;
    QryProductListAvailableQty: TFloatField;
    QryProductListAllocatedBOQty: TFloatField;
    QryProductListSOQty: TFloatField;
    QryProductListSOBOQty: TFloatField;
    QryProductListInstockQty: TFloatField;
    QryProductListPOBOQty: TFloatField;
    QryproductmovementPQAID: TIntegerField;
    QryproductmovementProductID: TIntegerField;
    QryproductmovementDepartmentID: TIntegerField;
    QryproductmovementProductName: TWideStringField;
    QryproductmovementAvailableQty: TFloatField;
    QryproductmovementAllocatedBOQty: TFloatField;
    QryproductmovementSOQty: TFloatField;
    QryproductmovementSOBOQty: TFloatField;
    QryproductmovementInstockQty: TFloatField;
    QryproductmovementPOBOQty: TFloatField;
    gQryProductListPQAID: TIntegerField;
    gQryProductListProductID: TIntegerField;
    gQryProductListDepartmentID: TIntegerField;
    gQryProductListProductName: TWideStringField;
    gQryProductListAvailableQty: TFloatField;
    gQryProductListAllocatedBOQty: TFloatField;
    gQryProductListSOQty: TFloatField;
    gQryProductListSOBOQty: TFloatField;
    gQryProductListInstockQty: TFloatField;
    gQryProductListPOBOQty: TFloatField;
    gQryproductmovementPQAID: TIntegerField;
    gQryproductmovementProductID: TIntegerField;
    gQryproductmovementDepartmentID: TIntegerField;
    gQryproductmovementProductName: TWideStringField;
    gQryproductmovementAvailableQty: TFloatField;
    gQryproductmovementAllocatedBOQty: TFloatField;
    gQryproductmovementSOQty: TFloatField;
    gQryproductmovementSOBOQty: TFloatField;
    gQryproductmovementInstockQty: TFloatField;
    gQryproductmovementPOBOQty: TFloatField;
    gQrySAPQAID: TIntegerField;
    gQrySAProductID: TIntegerField;
    gQrySADepartmentID: TIntegerField;
    gQrySAProductName: TWideStringField;
    gQrySAAvailableQty: TFloatField;
    gQrySAAllocatedBOQty: TFloatField;
    gQrySASOQty: TFloatField;
    gQrySASOBOQty: TFloatField;
    gQrySAInstockQty: TFloatField;
    gQrySAPOBOQty: TFloatField;
    gQryPartsPQAID: TIntegerField;
    gQryPartsProductID: TIntegerField;
    gQryPartsDepartmentID: TIntegerField;
    gQryPartsProductName: TWideStringField;
    gQryPartsAvailableQty: TFloatField;
    gQryPartsAllocatedBOQty: TFloatField;
    gQryPartsSOQty: TFloatField;
    gQryPartsSOBOQty: TFloatField;
    gQryPartsInstockQty: TFloatField;
    gQryPartsPOBOQty: TFloatField;
    dtp: TDateTimePicker;
    chkIgnoreDates: TCheckBox;
    DNMSpeedButton2: TDNMSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    DNMSpeedButton3: TDNMSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure wwDBGrid5CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure DNMSpeedButton3Click(Sender: TObject);
  private
      fstablename :String;
    fiPartsID: Integer;
    procedure RefreshQuery;
    procedure compareValues(const Value: Integer);
  public
    Property PartsID:Integer read fiPartsID write fiPartsID;
  end;

var
  fmProductQtys: TfmProductQtys;

implementation

uses CommonDbLib, FastFuncs, CommonLib;

{$R *.dfm}

procedure TfmProductQtys.FormCreate(Sender: TObject);
begin
  inherited;
    fstablename :=CommonDbLib.GetUserTemporaryTableName(Self.Classname);
    closeDb(ProductQty);
    with CommonDbLib.TempMyQuery do try
      connection := Self.MyConnection;
      SQL.add('drop table if exists  ' +fsTablename +';');
      SQL.add('CREATE table ' +fsTablename +
              ' (ID INT UNSIGNED AUTO_INCREMENT, ' +
              ' PQAId INT UNSIGNED, ' +
              ' Description VARCHAR (50), ' +
              ' d1 DOUBLE , ' +
              ' d2 DOUBLE , ' +
              ' d3 DOUBLE , ' +
              ' d4 DOUBLE , ' +
              ' PRIMARY KEY(ID), INDEX(PQAId))');
      Execute;
    finally
        Free;
    end;
    ProductQty.SQl.clear;
    ProductQty.SQL.add('Select * from ' +fsTablename);
end;

procedure TfmProductQtys.DNMSpeedButton1Click(Sender: TObject);
begin
    compareValues(1);
end;
procedure TfmProductQtys.compareValues(const Value :Integer);
var
  d1,d2,d3,d4:Double;
begin
  inherited;
  closeDB(ProductQty);
  with CommonDbLib.TempMyQuery do try
    connection := Self.MyConnection;
    SQL.add('drop table if exists  ' +fsTablename +';');
    SQL.add('CREATE table ' +fsTablename +
            ' (ID INT UNSIGNED AUTO_INCREMENT, ' +
            ' PQAId INT UNSIGNED, ' +
            ' Description VARCHAR (50), ' +
            ' d1 DOUBLE , ' +
            ' d2 DOUBLE , ' +
            ' d3 DOUBLE , ' +
            ' d4 DOUBLE , ' +
            ' PRIMARY KEY(ID), INDEX(PQAId))');
    Execute;
  finally
      Free;
  end;
  OpenDB(ProductQty);
      d1:= 0;
      d2:= 0;
      d3:=0;
      d4:= 0;
  With CommonDbLib.TempMyQuery do try
      Connection:= self.MyConnection;
      SQl.add('Select PQAId from tblPQa where ProductId = ' +  IntToStr(fiPartsID));
      open;
      if recordcount = 0 then exit;
      While Eof = False do begin
        ProductQty.Append;
        ProductQtyPQAId.asInteger := FieldByname('PQAID').asInteger;
        ProductQtyDescription.asString := 'Details';
        if Value =1  then begin
          if QryParts.Locate('PQAID'          , ProductQtyPQAId.asInteger  , []) then begin   ProductQtyd1.asFloat :=QryPartsInstockQty.asFloat;            d1 := d1 +QryPartsInstockQty.asFloat;        end;
          if QrySA.Locate('PQAID'             , ProductQtyPQAId.asInteger  , []) then begin   ProductQtyd2.asFloat :=QrySAInstockQty.asFloat;               d2 := d2 +QrySAInstockQty.asFloat;           end;
          if QryProductList.Locate('PQAID'    , ProductQtyPQAId.asInteger  , []) then begin   ProductQtyd3.asFloat :=QryProductListInstockQty.asFloat;      d3 := d3 +QryProductListInstockQty.asFloat;end;
          if Qryproductmovement.Locate('PQAID', ProductQtyPQAId.asInteger  , []) then begin   ProductQtyd4.asFloat :=QryproductmovementInstockQty.asFloat;  d4 := d4 +QryproductmovementInstockQty.asFloat;    end;
        end else if Value = 2 then begin
          if QryParts.Locate('PQAID'          , ProductQtyPQAId.asInteger  , []) then begin   ProductQtyd1.asFloat :=QryPartsAvailableQty.asFloat;            d1 := d1 +QryPartsAvailableQty.asFloat;        end;
          if QrySA.Locate('PQAID'             , ProductQtyPQAId.asInteger  , []) then begin   ProductQtyd2.asFloat :=QrySAAvailableQty.asFloat;               d2 := d2 +QrySAAvailableQty.asFloat;           end;
          if QryProductList.Locate('PQAID'    , ProductQtyPQAId.asInteger  , []) then begin   ProductQtyd3.asFloat :=QryProductListAvailableQty.asFloat;      d3 := d3 +QryProductListAvailableQty.asFloat;end;
          if Qryproductmovement.Locate('PQAID', ProductQtyPQAId.asInteger  , []) then begin   ProductQtyd4.asFloat :=QryproductmovementAvailableQty.asFloat;  d4 := d4 +QryproductmovementAvailableQty.asFloat;    end;
        end;
        ProductQty.Post;
        Next;
      end;
  finally
      Edit1.text := FloatToStrF(d1      ,ffGeneral, 15, 2);
      Edit2.text := FloatToStrF(d2      ,ffGeneral, 15, 2);
      Edit3.text := FloatToStrF(d3      ,ffGeneral, 15, 2);
      Edit4.text := FloatToStrF(d4      ,ffGeneral, 15, 2);
      if Active then Close;
      Free;
  end;
end;
procedure TfmProductQtys.FormShow(Sender: TObject);
begin
RefreshQuery;

end;
procedure TfmProductQtys.RefreshQuery;
var
  transdate:TDateTime;
begin
  inherited;
    closeDB(QryParts);
    closeDB(QrySA);
    closeDB(QryProductList);
    closeDB(Qryproductmovement);
    closeDB(gQryParts);
    closeDB(gQrySA);
    closeDB(gQryProductList);
    closeDB(gQryproductmovement);


    QryParts.Parambyname('ProductID').asInteger           :=fiPartsID;
    QrySA.Parambyname('ProductID').asInteger              :=fiPartsID;
    QryProductList.Parambyname('ProductID').asInteger     :=fiPartsID;
    Qryproductmovement.Parambyname('ProductID').asInteger :=fiPartsID;
    gQryParts.Parambyname('ProductID').asInteger          :=fiPartsID;
    gQrySA.Parambyname('ProductID').asInteger             :=fiPartsID;
    gQryProductList.Parambyname('ProductID').asInteger    :=fiPartsID;
    gQryproductmovement.Parambyname('ProductID').asInteger:=fiPartsID;

    if chkIgnoreDates.checked then transdate := 0 else TransDate := dtp.Date;
    QryParts.Parambyname('TransDate').asDatetime            := TransDate;
    QrySA.Parambyname('TransDate').asDatetime               := TransDate;
    QryProductList.Parambyname('TransDate').asDatetime      := TransDate;
    Qryproductmovement.Parambyname('TransDate').asDatetime  := TransDate;
    gQryParts.Parambyname('TransDate').asDatetime           := TransDate;
    gQrySA.Parambyname('TransDate').asDatetime              := TransDate;
    gQryProductList.Parambyname('TransDate').asDatetime     := TransDate;
    gQryproductmovement.Parambyname('TransDate').asDatetime := TransDate;

    openQueries;
end;

procedure TfmProductQtys.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmProductQtys.wwDBGrid5CalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if (ProductQtyd1.asFloat <> ProductQtyd2.asFloat) or
  (ProductQtyd1.asFloat <> ProductQtyd3.asFloat) or
  (ProductQtyd1.asFloat <> ProductQtyd4.asFloat) then Afont.Color := clred else Afont.color := clblack;
end;

procedure TfmProductQtys.DNMSpeedButton3Click(Sender: TObject);
begin
  inherited;
      compareValues(2);
end;

initialization
  RegisterClassOnce(TfmProductQtys);
end.
