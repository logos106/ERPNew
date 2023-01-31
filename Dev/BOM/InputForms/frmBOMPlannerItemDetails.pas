unit frmBOMPlannerItemDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls,
  DNMSpeedButton, Shader, DNMPanel , BOMPlannerLib, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, DB, MemDS, DBAccess, MyAccess, ERPdbComponents , planner;

type
  TfmBOMPlannerItemDetails = class(TBaseForm)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdCancel: TDNMSpeedButton;
    qryMain: TERPQuery;
    dsMain: TDataSource;
    grdMain: TwwDBGrid;
    btnGrid: TwwIButton;
    MyConnection1: TERPConnection;
    qryMainDescription: TWideStringField;
    qryMaindata: TWideStringField;
    qryMainCategory: TLargeintField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCancelClick(Sender: TObject);
  private
  public
    Class Procedure ShowItemDetails( const AOwner:TComponent;  const Item: TPlannerItem);
  end;


implementation

uses CommonDbLib, tcConst, LogLib;

{$R *.dfm}

{ TfmBOMPlannerItemDetails }

procedure TfmBOMPlannerItemDetails.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmBOMPlannerItemDetails.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmBOMPlannerItemDetails.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if QrymainCategory.asInteger in [1,3,5] then begin
    AFont.color := clMaroon;
    AFont.size := 12;
    Afont.style := Afont.style  +[fsbold];
    Afont.style := Afont.style  +[fsUnderline];
    ABrush.color := GridColhighLightGreen;
  end;
end;

class procedure TfmBOMPlannerItemDetails.ShowItemDetails( const AOwner:TComponent;  const Item: TPlannerItem);
begin
  if Assigned(Item.ItemObject) then begin
    With TfmBOMPlannerItemDetails.create(AOwner) do try
      With TBOMPlannerItem(Item.ItemObject) do begin
        CloseDB(qryMain);
        qryMain.SQL.text :=
          '          Select 1 as Id ,1 as Category,    "Sales Details"        as Description , "" as Data ' + NL+
          ' Union all Select 2 as Id ,2 as Category,    "    Sale #"              as Description , ' + Quotedstr(inttostr( SaleID                             ))+' as Data ' +NL+
          ' Union all Select 3 as Id ,2 as Category,    "    Customer Name"       as Description , ' + Quotedstr(customername                                 )+' as Data ' +NL+
          ' Union all Select 4 as Id ,2 as Category,    "    Sale Date"           as Description , ' + Quotedstr(Formatdatetime (FormatSettings.Shortdateformat, saledate    ))+' as Data ' +NL+
          ' Union all Select 5 as Id ,2 as Category,    "    Product"             as Description , ' + Quotedstr(ProductName                                  )+' as Data ' +NL+
          ' Union all Select 6 as Id ,2 as Category,    "    Sale Qty"            as Description , ' + Quotedstr(FloattostrF( UnitofMeasureShipped , ffGeneral, 15,2))+' as Data ' +NL+
          ' Union all Select 7 as Id ,2 as Category,    "    UOM"                 as Description , ' + Quotedstr(UOM                                          )+' as Data ' +NL+

          ' Union all Select 8 as Id ,3 as Category,    "Item Details"        as Description , "" as Data ' +NL+
          //' Union all Select  as Id ,3 as Category,    "Item"               as Description , ' + caption              )+' as Data ' +NL+
          ' Union all Select 9 as Id ,4 as Category,    "    Tree"                as Description , ' + Quotedstr(ItemCaption          )+' as Data ' +NL+
          ' Union all Select 10 as Id ,4 as Category,    "    Process"            as Description , ' + Quotedstr(ProcessStep          )+' as Data ' +NL+
          ' Union all Select 11 as Id ,4 as Category,    "    Resource"           as Description , ' + Quotedstr(Resource             )+' as Data ' +NL+
          ' Union all Select 12 as Id ,4 as Category,    "    Resource Detail"    as Description , ' + Quotedstr(ResourceDetail       )+' as Data ' +NL+
          ' Union all Select 13 as Id ,4 as Category,    "    Employee"           as Description , ' + Quotedstr(EmployeeName         )+' as Data ' +NL+
          ' Union all Select 14 as Id ,4 as Category,    "    Total Duration" ""  as Description , ' + Quotedstr(Duration             )+' as Data ' +NL+
          ' Union all Select 15 as Id ,4 as Category,    "    Scheduled Duration" as Description , ' + Quotedstr(SchdDuration         )+' as Data ' +NL+
          ' Union all Select 16 as Id ,4 as Category,    "            -->From"     as Description , ' + Quotedstr(Formatdatetime (FormatSettings.Shortdateformat +' hh:nn:ss am/pm', TimeStart            ))+' as Data ' +NL+
          ' Union all Select 17 as Id ,4 as Category,    "           -->To"       as Description , ' + Quotedstr(Formatdatetime (FormatSettings.Shortdateformat+' hh:nn:ss am/pm', TimeEnd              ))+' as Data ' +NL+

          ' Union all Select 18 as Id ,5 as Category,    "Build Details"      as Description , "" as Data ' +NL+
          ' Union all Select 19 as Id ,6 as Category,    "    Build Date"         as Description , ' + Quotedstr(Formatdatetime (FormatSettings.Shortdateformat+' hh:nn:ss am/pm', BuildDate            ))+' as Data ' +NL+
          ' Union all Select 20 as Id ,6 as Category,    "    Scheduled To Build" as Description , ' + Quotedstr(FloattostrF( QtyScheduled , ffGeneral, 15,2))+'  as Data ' +NL+
          ' Union all Select 21 as Id ,6 as Category,    "    Built So far"       as Description , ' + Quotedstr(FloattostrF( QtyBuilt     , ffGeneral, 15,2))+' as Data ' +NL+
          ' Order by id';
        clog(qrymain.SQL.Text);
        qryMain.connection := CommonDbLib.GetSharedMyDacConnection;
        OpenDB(qryMain);
      end;
      ShowModal;
    finally
      Free;
    end;
  end;
end;

end.
