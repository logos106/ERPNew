unit BOMTreeWorkOrders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseTreeView, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, VirtualTrees, Shader, DNMSpeedButton,
  wwdbdatetimepicker, DNMPanel;

type
  TRowcolorSet = record
      DarkColor :TColor ;
      LightColor :TColor;
  end;

  TBOMTreeWorkOrdersGUI = class(TBaseTreeViewGUI)
    qryMain: TERPQuery;
    qryMainPPID: TIntegerField;
    qryMainsaleId: TIntegerField;
    qryMainsaleLineId: TIntegerField;
    qryMainproductName: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMainSequenceDown: TIntegerField;
    qryMainCaption: TWideStringField;
    qryMainDuration: TFloatField;
    qryMainparentID: TIntegerField;
    qryMainproctreeId: TIntegerField;
    qryMainchildrenIDs: TBlobField;
    qryMaindescription: TWideStringField;
    qryMainKeyStr: TWideStringField;
    chkAlternateRowcolor: TCheckBox;
    qryMainCaptionIntend: TWideMemoField;
    qryMainTotalDuration: TFloatField;
    qryMainTotalManQty: TFloatField;
    qryMainTotalScheduled: TFloatField;
    qryMaintotalStarted: TFloatField;
    qryMainToBedone: TFloatField;
    qryMainAllocatedFrom: TDateTimeField;
    qryMainAllocatedto: TDateTimeField;
    qryMainCurrentStatus: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure TreeBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure TreeAfterItemPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect);
    procedure chkAlternateRowcolorClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    RootNode:PVirtualNode;
    RowColorIndex :Integer;
    function FindMatchingParent(const Node: PVirtualNode;const ParentID: Integer): PVirtualNode;
    function USeAlternateRowcolor:Boolean;
    Procedure Formatcolumns;
  Protected
    procedure RefreshTree; override;
    Procedure Readguiprefs;Override;
    Procedure WriteGuiPrefs;Override;
    procedure DoAfterContract;Override;
    function Addcolumn(const ColumnName: string; const FieldType: TValueType; const ColWidth: integer;const Align: TAlignment = taLeftJustify;displayLabel:String = ''): TTreeColumn; Override;
  public
  end;


implementation

uses CommonDbLib, LogLib, tcConst, CommonLib, ProcessUtils;

const
  (*cTree         = 0;
  cTotalManQty  = 1;
  cCaption      = 2;
  cSequenceDown = 3;
  cDescription  = 4;
  cDuration     = 5;
  cDurationF    = 6;
  cTotalDuration= 7;
  cTotalDurationF=8;
  cparentID     = 9;
  cproctreeId   = 10;
  cchildrenIDs  = 11;
  cIsSalesRootrec=12;
  cProctreeCtr   =13;
  cSaleId       = 14;
  cSaleLineId   = 15;
  cProduct      = 16;
  cUOM          = 17;
  cSold         = 18;
  cShipped      = 19;
  cBackorder    = 20;
  cColorIndex   = 21;*)


  cTree           = 0;
  cTotalManQty    = 1;
  cDescription    = 2;//4;
  cDurationF      = 3;//6;
  cTotalDurationF =4;//8;
  cTotalScheduledf=5;
  cTotalStartedF  =6;
  cToBedoneF      =7;
  cAllocationFrom =8;
  cAllocationTo   =9;
  cCurrentStatus  =10;
  cSaleId         = 11;//14;
  cProduct        = 12;//16;
  cUOM            = 13;//17;
  cSold           = 14;//18;
  cShipped        = 15;//19;
  cBackorder      = 16;//20;

  //invisiblecolumn
  cSequenceDown   = 17;//3;
  cCaption        = 18;
  cDuration       = 19;//5;
  cTotalDuration  = 20;//7;
  cparentID       = 21;//9;
  cproctreeId     = 22;//10;
  cchildrenIDs    = 23;//11;
  cIsSalesRootrec =24;//12;
  cProctreeCtr    =25;//13;
  cSaleLineId     = 26;//15;
  cColorIndex     = 27;//21;
  cTotalScheduled = 28;
  cTotalStarted   = 29;
  cToBedone       = 30;



  RowcolorSets : Array [1..2] of TRowcolorSet = ((DarkColor: $00BBFFBB ; LightColor:$00D9FFD9) , (DarkColor:$00BBD1FF; LightColor: $00D7E3FF ));


{$R *.dfm}

procedure TBOMTreeWorkOrdersGUI.Formatcolumns;
begin
    tree.Header.Columns[cTree].Options            := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
    tree.Header.Columns[cTotalManQty].Options     := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
    tree.Header.Columns[cDescription].Options     := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
    tree.Header.Columns[cDurationF].Options       := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
    tree.Header.Columns[cTotalDurationF].Options  := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
    tree.Header.Columns[cSaleId].Options          := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
    tree.Header.Columns[cProduct].Options         := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
    tree.Header.Columns[cUOM].Options             := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
    tree.Header.Columns[cSold].Options            := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
    tree.Header.Columns[cShipped].Options         := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
    tree.Header.Columns[cBackorder].Options       := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
    tree.Header.Columns[cTotalScheduledf].Options := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
    tree.Header.Columns[cTotalStartedF].Options   := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
    tree.Header.Columns[cToBedoneF].Options       := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
    tree.Header.Columns[cAllocationFrom].Options  := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
    tree.Header.Columns[cAllocationTo].Options    := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
    tree.Header.Columns[cCurrentStatus].Options   := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];


    tree.Header.Columns[cTotalManQty].Alignment   := taRightJustify;
    tree.Header.Columns[cSaleId].Alignment        := taRightJustify;
    tree.Header.Columns[cSold].Alignment          := taRightJustify;
    tree.Header.Columns[cShipped].Alignment       := taRightJustify;
    tree.Header.Columns[cBackorder].Alignment     := taRightJustify;
end;

procedure TBOMTreeWorkOrdersGUI.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TBOMTreeWorkOrdersGUI.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;
  inherited;

  Tree.TreeOptions.SelectionOptions := Tree.TreeOptions.SelectionOptions + [toFullRowSelect];

  Self.Columns.HeaderColor := Self.color;
  Tree.Header.Columns.Clear;
  // Add columns to the Tree
(*  lblGroupCaptions.caption := '             Item                        '+
                              '                                               Process                        '+
                              '                                                      Duration                        '+
                              '                                                      Schedule                        '+
                              '                                                      Sales Details                        '+
                              '                                                      Quantity';
  lblGroupCaptions.visible := True;*)
  AddColumn('Tree'                  , vtInteger, 200 , taLeftJustify , '' ) ;
  AddColumn('TotalManQty'           , vtString, 100 , taLeftJustify , 'Man Qty' ) ;
  AddColumn('Description'           , vtString , 150, taLeftJustify , 'Description');
  AddColumn('Duration'              , vtString , 80, taLeftJustify , 'Process'+NL+'Duration');
  AddColumn('TotalDuration'         , vtString , 80, taLeftJustify , 'Total'+NL+'Duration');

  AddColumn('TotalScheduled'        , vtString , 80, taLeftJustify , 'Total'+NL+'Scheduled');
  AddColumn('TotalStarted'          , vtString , 80, taLeftJustify , 'Total'+NL+'Started');
  AddColumn('ToBedone'              , vtString , 80, taLeftJustify , 'To Be'+NL+'Done');
  AddColumn('AllocationFrom'        , vtString , 80, taLeftJustify , 'Schedule'+NL+'From');
  AddColumn('AllocationTo'          , vtString , 80, taLeftJustify , 'Schedule'+NL+'To');
  AddColumn('CurrentStatus'         , vtString , 100, taLeftJustify , 'Job Status');


  AddColumn('SaleId'                , vtInteger, 100  , taRightJustify , 'Id #') ;
  AddColumn('ProductName'           , vtString , 110, taLeftJustify , 'Sale'+NL+'Product');
  AddColumn('UOM'                   , vtString , 80);
  AddColumn('UnitofMeasureQtySold'  , vtFloat , 100, taRightJustify, 'Qty'+NL+'Sold');
  AddColumn('UnitofMeasureShipped'  , vtFloat , 100, taRightJustify , 'Qty'+NL+'Shipped');
  AddColumn('UnitofMeasureBackorder', vtFloat , 100, taRightJustify , 'Back'+NL+'Order');



  AddColumn('SequenceDown'          , vtString , 10);
  AddColumn('Caption'               , vtString , 110, taLeftJustify , 'Item');
  AddColumn('DurationinSec'         , vtString , 100);
  AddColumn('TotalDurationinSec'    , vtString , 100);
  AddColumn('parentID'              , vtInteger, 70);
  AddColumn('proctreeId'            , vtInteger, 70);
  AddColumn('childrenIDs'           , vtString , 250);
  AddColumn('IsSalesRootrec'        , vtString , 250);
  AddColumn('ProctreeCtr'           , vtString , 250);
  AddColumn('SaleLineId'            , vtInteger, 50) ;
  Addcolumn('RowColorIndex'         , vtString , 100);
  AddColumn('TotalScheduledinsec'   , vtString , 100, taLeftJustify );
  AddColumn('TotalStartedinsec'     , vtString , 100, taLeftJustify );
  AddColumn('ToBedoneinsec'         , vtString , 100, taLeftJustify );
  Formatcolumns;


  Columns.Header.Background := Self.color;


(*      with Tree.Header do begin
          Columns[cTree].CaptionText := 'Tree';
          Columns[cSaleId].CaptionText := 'Sale #';
          Columns[cSaleLineId].CaptionText := 'Line #';
          Columns[cProduct].CaptionText := 'Product';
          Columns[cCaption].CaptionText := 'Caption';
          Columns[cUOM].CaptionText := 'UOM';
          Columns[cSold].CaptionText := 'Sold';
          Columns[cShipped].CaptionText := 'Shipped';
          Columns[cBackorder].CaptionText := 'Back Order';
          Columns[cSequenceDown].CaptionText := 'Squence';
          Columns[cDurationf].CaptionText := 'Duration';
          Columns[cDuration].CaptionText := 'Duration';
          Columns[cparentID].CaptionText := 'ParentId';
          Columns[cproctreeId].CaptionText := 'ProctreeId';
          Columns[cchildrenIDs].CaptionText := 'Childrens';
          Columns[cDescription].CaptionText := 'Process';
      end;*)

end;
procedure TBOMTreeWorkOrdersGUI.FormShow(Sender: TObject);
begin
  inherited;
(*  lblGroupCaptions.top := Tree.top+1;
  lblGroupCaptions.Left := Tree.Left;
  lblGroupCaptions.Width := Tree.Width;*)

end;

function TBOMTreeWorkOrdersGUI.Addcolumn(const ColumnName: string;  const FieldType: TValueType; const ColWidth: integer; const Align: TAlignment;  displayLabel: String): TTreeColumn;
begin
  REsult := inherited Addcolumn(ColumnName, FieldType, ColWidth, Align, displayLabel);
(*  if Assigned(result) then
    TVirtualTReecolumn(Result).Options := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]*)
end;

procedure TBOMTreeWorkOrdersGUI.chkAlternateRowcolorClick(Sender: TObject);
begin
  inherited;
  Self.Repaint;
end;

Procedure TBOMTreeWorkOrdersGUI.DoAfterContract;
begin
  inherited;
  if Assigned(RootNode) then
    Tree.Expanded[Rootnode] := true;
end;
function TBOMTreeWorkOrdersGUI.FindMatchingParent(const Node: PVirtualNode; const ParentID: Integer): PVirtualNode;
var
  ParentNode, ChildNode: PVirtualNode;
  Rec: (*PVirtualNode*)PNodeRec;

begin
  Result := nil;
  try
    try

      ParentNode := Node;
      Rec := Tree.GetNodeData(ParentNode);
      if Assigned(Rec) and (PnodeRec(Rec)^.Data.ByName['proctreeId'].Value  = inttostr(ParentID)) then begin
          result :=ParentNode;
          Exit;
      end;

      ChildNode := ParentNode.FirstChild;
      while Assigned(ChildNode)  do begin
        Rec := Tree.GetNodeData(ChildNode);

        if Assigned(Rec) and (PnodeRec(Rec)^.Data.ByName['proctreeId'].Value  = inttostr(ParentID)) then begin
          result :=ChildNode;
          Exit;
        end else begin
          Result :=  FindMatchingParent(ChildNode , ParentID);
          if Assigned(Result) then exit;

          ChildNode := ParentNode.NextSibling;
        end;
      end;

    except
      on E: Exception do begin
        raise;
      end;
    end;
  finally
    // LogD('',lbEnd);
  end;
end;

procedure TBOMTreeWorkOrdersGUI.RefreshTree;
var
  Rec,ParentRec: PNodeRec;
  BOMNode,ParentNode :PVirtualNode;
  salelineId:Integer;
  ProctreeId, ProctreeCtr :Integer;

  Function FindParentNode:PVirtualNode;
  begin
      if Qrymain.FieldByName('parentID').asInteger =0 then begin
        Result := RootNode;
        Exit;
      end;
      if (BOMNode<> nil) and (strToint(Rec^.Data.ByName['proctreeId'].asString) = Qrymain.FieldByName('parentID').asInteger) then begin
            REsult :=BOMNode;
            Exit;
      end;
      if Assigned(ParentNode) then begin
        if (strToint(ParentRec^.Data.ByName['proctreeId'].asString) = Qrymain.FieldByName('parentID').asInteger) then begin
            REsult :=ParentNode;
            Exit;
        end;
      end;
      Result := FindMatchingParent(RootNode,   Qrymain.FieldByName('parentID').asInteger);
  end;
  Procedure AddRecToTree(Const IsSalesRootrec:Boolean);
  begin
        if ParentNode <> nil then begin
            ParentRec:= Tree.GetNodeData(ParentNode);
            BOMNode:= Tree.AddChild(ParentNode);
            Rec := Tree.GetNodeData(BOMNode);
            Rec^.Data := TNodeData.Create(Self.Columns);
            Rec^.Data.Id                                        := Qrymain.FieldByName('PPID').AsInteger;
            Rec^.Data.KeyStr                                    := Qrymain.FieldByName('KeyStr').asString;
            Rec^.Data.ByName['Tree'].Value                      := Qrymain.FieldByName('Caption').ASString;
            Rec^.Data.ByName['TotalManQty'].Value               := floatToStrF(Qrymain.FieldByName('TotalManQty').asfloat , ffFixed, 15, 2);
            Rec^.Data.ByName['saleId'].Value                    := IntToStr(Qrymain.FieldByName('saleId').asInteger);
            Rec^.Data.ByName['saleLineId'].Value                := IntToStr(Qrymain.FieldByName('salelineId').asInteger);
            Rec^.Data.ByName['productName'].asString            := Qrymain.FieldByName('productName').ASString;
            Rec^.Data.ByName['UOM'].asString                    := Qrymain.FieldByName('UOM').ASString;
            Rec^.Data.ByName['UnitofMeasureQtySold'].asString   := FloatTostrf(Qrymain.FieldByName('UnitofMeasureQtySold').AsFloat, ffFixed , 15, 2);
            Rec^.Data.ByName['UnitofMeasureShipped'].asString   := FloatTostrf(Qrymain.FieldByName('UnitofMeasureShipped').AsFloat, ffFixed , 15, 2);
            Rec^.Data.ByName['UnitofMeasureBackorder'].asString := FloatTostrf(Qrymain.FieldByName('UnitofMeasureBackorder').AsFloat, ffFixed , 15, 2);
            Rec^.Data.ByName['SequenceDown'].asString           := inttostr(Qrymain.FieldByName('SequenceDown').asInteger);
            Rec^.Data.ByName['Caption'].asString                := Qrymain.FieldByName('CaptionIntend').ASString ;
            Rec^.Data.ByName['DurationinSec'].asString          := floattostr(Qrymain.FieldByName('Duration').AsFloat);
            Rec^.Data.ByName['Duration'].asString               := SecondsToTime(Qrymain.FieldByName('Duration').asInteger);
            Rec^.Data.ByName['TotalDurationinSec'].asString     := floattostr(Qrymain.FieldByName('TotalDuration').AsFloat);
            Rec^.Data.ByName['TotalDuration'].asString          := SecondsToTime(Qrymain.FieldByName('TotalDuration').asInteger);
            Rec^.Data.ByName['parentID'].asString               := inttostr(Qrymain.FieldByName('parentID').asInteger);
            Rec^.Data.ByName['proctreeId'].asString             := inttostr(Qrymain.FieldByName('proctreeId').asInteger);
            Rec^.Data.ByName['childrenIDs'].asString            := Qrymain.FieldByName('childrenIDs').ASString;
            Rec^.Data.ByName['description'].asString            := Qrymain.FieldByName('description').ASString;
            Rec^.Data.ByName['IsSalesRootrec'].asString         := iif(IsSalesRootrec , 'T', 'F');
            Rec^.Data.ByName['TotalScheduled'].asString         := SecondsToTime(Qrymain.FieldByName('TotalScheduled').asInteger);
            Rec^.Data.ByName['TotalStarted'].asString           := SecondsToTime(Qrymain.FieldByName('totalStarted').asInteger);
            Rec^.Data.ByName['ToBedone'].asString               := SecondsToTime(Qrymain.FieldByName('ToBedone').asInteger);
            Rec^.Data.ByName['TotalScheduledinsec'].asString    := inttostr(Qrymain.FieldByName('TotalScheduled').asInteger);
            Rec^.Data.ByName['TotalStartedinsec'].asString      := inttostr(Qrymain.FieldByName('totalStarted').asInteger);
            Rec^.Data.ByName['ToBedoneinsec'].asString          := inttostr(Qrymain.FieldByName('ToBedone').asInteger);
            Rec^.Data.ByName['AllocationFrom'].asString         := iif(Qrymain.FieldByName('AllocatedFrom').asDatetime =0 , '' , FormatDateTime(FormatSettings.ShortdateFormat , Qrymain.FieldByName('AllocatedFrom').asDatetime));
            Rec^.Data.ByName['AllocationTo'].asString           := iif(Qrymain.FieldByName('Allocatedto').asDatetime=0,'', FormatDateTime(FormatSettings.ShortdateFormat , Qrymain.FieldByName('Allocatedto').asDatetime));
            Rec^.Data.ByName['CurrentStatus'].asString          := Qrymain.FieldByName('CurrentStatus').asString;

            if ProctreeId = Qrymain.FieldByName('ProctreeId').AsInteger then ProctreeCtr:= ProctreeCtr+1
            else ProctreeCtr:= 1;
            if IsSalesRootrec then ParentNode := BOMNode;
            Rec^.Data.ByName['ProctreeCtr'].asString := inttostr(ProctreeCtr);
            ProctreeId := Qrymain.FieldByName('ProctreeId').AsInteger;
            Rec^.Data.ByName['RowColorIndex'].asString := inttostr(RowColorIndex);
          end;
  end;
begin
  inherited;

  closedb(qryMain);
  qryMain.parambyname('dateFrom').asDatetime := filterdateFrom;
  qryMain.parambyname('DateTo').asDatetime := filterdateTo;
  OpenDb(qryMain);
  clog(Qrymain.SQLtext);
  Tree.Clear;
  SaleLineId := 0;
  ProctreeId := 0;
  RowColorIndex := 1;
  if qryMain.recordcount > 0 then begin
    qryMain.First;
    BOMNode:= nil;
    ParentNode:= nil;

    RootNode:= Tree.AddChild(nil);
    Rec := Tree.GetNodeData(RootNode);
    Rec^.Data := TNodeData.Create(Self.Columns);
    Rec^.Data.Id                                        := 0;
    Rec^.Data.KeyStr                                    := 'Root';
    Rec^.Data.ByName['Tree'].Value                      := 'Work Orders';
    Rec^.Data.ByName['TotalManQty'].Value               := '';
    Rec^.Data.ByName['saleId'].Value                    := '';
    Rec^.Data.ByName['saleLineId'].Value                := '';
    Rec^.Data.ByName['productName'].asString            := '';
    Rec^.Data.ByName['UOM'].asString                    := '';
    Rec^.Data.ByName['UnitofMeasureQtySold'].asString   := '';
    Rec^.Data.ByName['UnitofMeasureShipped'].asString   := '';
    Rec^.Data.ByName['UnitofMeasureBackorder'].asString := '';
    Rec^.Data.ByName['SequenceDown'].asString           := '';
    Rec^.Data.ByName['Caption'].asString                := '';
    Rec^.Data.ByName['DurationinSec'].asString          := '';
    Rec^.Data.ByName['Duration'].asString               := '';
    Rec^.Data.ByName['TotalDurationinSec'].asString     := '';
    Rec^.Data.ByName['TotalDuration'].asString          := '';
    Rec^.Data.ByName['parentID'].Value                  := '0';
    Rec^.Data.ByName['proctreeId'].Value                := '0';
    Rec^.Data.ByName['childrenIDs'].asString            := '';
    Rec^.Data.ByName['description'].asString            := '';
    Rec^.Data.ByName['IsSalesRootrec'].asString         := 'F';
    Rec^.Data.ByName['ProctreeCtr'].asString            := '0';
    Rec^.Data.ByName['RowColorIndex'].asString          := '0';
    Rec^.Data.ByName['TotalScheduled'].asString         := '';
    Rec^.Data.ByName['TotalStarted'].asString           := '';
    Rec^.Data.ByName['ToBedone'].asString               := '';
    Rec^.Data.ByName['AllocationFrom'].asString         := '';
    Rec^.Data.ByName['AllocationTo'].asString           := '';
    Rec^.Data.ByName['CurrentStatus'].asString          := '';
    Rec^.Data.ByName['TotalScheduledinsec'].asString    := '';
    Rec^.Data.ByName['TotalStartedinsec'].asString      := '';
    Rec^.Data.ByName['ToBedoneinsec'].asString          := '';



    DoShowProgressbar(Qrymain.RecordCount+1 ,WAITMSG);
    try
      While qryMain.Eof = False do begin
          DoStepProgressbar(inttostr(Qrymain.RecNo)+' of ' + inttostr(qrymain.RecordCount)+'    -> ' +
                            Qrymain.FieldByName('saleId').asString + ':' +
                            Qrymain.FieldByName('productName').ASString +' ' +
                            Qrymain.FieldByName('UnitofMeasureShipped').asString +' ' +
                            Qrymain.FieldByName('UOM').ASString);

          if SaleLineId <> Qrymain.FieldByName('salelineId').asInteger then begin
            if RowColorIndex = 1 then RowColorIndex := 2 else RowColorIndex := 1;
            ProctreeId := 0;
            ParentNode:= RootNode;
            AddRecToTree(true);
            SaleLineId :=  Qrymain.FieldByName('salelineId').asInteger;
            ProctreeId := 0;
          end else begin
            ParentNode:= FindParentNode;
          end;
          AddRecToTree(False);

        qryMain.Next;
      end;
      DoStepProgressbar(WAITMSG);
      with Tree.Header do begin
          Columns[cTree].Options            := Columns[cTree].Options           + [coVisible];
          Columns[cSaleId].Options          := Columns[cSaleId].Options         + [coVisible];
          Columns[cProduct].Options         := Columns[cProduct].Options        + [coVisible];
          Columns[cUOM].Options             := Columns[cUOM].Options            + [coVisible];
          Columns[cSold].Options            := Columns[cSold].Options           + [coVisible];
          Columns[cShipped].Options         := Columns[cShipped].Options        + [coVisible];
          Columns[cBackorder].Options       := Columns[cBackorder].Options      + [coVisible];
          Columns[cDurationf].Options       := Columns[cDurationf].Options      + [coVisible];
          Columns[cTotalDurationf].Options  := Columns[cTotalDurationf].Options + [coVisible];
          Columns[cDescription].Options     := Columns[cDescription].Options    + [coVisible];
          Columns[cTotalScheduledf].Options := Columns[cTotalScheduledf].Options+ [coVisible];
          Columns[cTotalStartedF].Options   := Columns[cTotalStartedF].Options  + [coVisible];
          Columns[cToBedoneF].Options       := Columns[cToBedoneF].Options      + [coVisible];
          Columns[cAllocationFrom].Options  := Columns[cAllocationFrom].Options + [coVisible];
          Columns[cAllocationTo].Options    := Columns[cAllocationTo].Options   + [coVisible];
          Columns[cCurrentStatus].Options   := Columns[cCurrentStatus].Options  + [coVisible];



          Columns[cSaleLineId].Options    := Columns[cSaleLineId].Options       - [coVisible];
          Columns[cCaption].Options       := Columns[cCaption].Options          - [coVisible];
          Columns[cSequenceDown].Options  := Columns[cSequenceDown].Options     - [coVisible];
          Columns[cDuration].Options      := Columns[cDuration].Options         - [coVisible];
          Columns[cTotalDuration].Options := Columns[cTotalDuration].Options    - [coVisible];
          Columns[cparentID].Options      := Columns[cparentID].Options         - [coVisible];
          Columns[cproctreeId].Options    := Columns[cproctreeId].Options       - [coVisible];
          Columns[cchildrenIDs].Options   := Columns[cchildrenIDs].Options      - [coVisible];
          Columns[cIsSalesRootrec].Options:= Columns[cIsSalesRootrec].Options   - [coVisible];
          Columns[cProctreeCtr].Options   := Columns[cProctreeCtr].Options      - [coVisible];
          Columns[cColorIndex].Options    := Columns[cColorIndex].Options       - [coVisible];
          Columns[cTotalScheduled].Options:= Columns[cTotalScheduledf].Options  - [coVisible];
          Columns[cTotalStarted].Options  := Columns[cTotalStartedF].Options    - [coVisible];
          Columns[cToBedone].Options      := Columns[cToBedoneF].Options        - [coVisible];
      end;


    finally
      DoHideProgressbar;
      btnExpandAll.Caption := 'Expand All';
      btnExpandAll.Click;
    end;

  end;

end;
procedure TBOMTreeWorkOrdersGUI.TreeAfterItemPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect);
begin
(*var
  NodeData: PNodeRec;
  iRowColorIndex :Integer;
begin
  inherited;

  NodeData := Sender.GetNodeData(Node);
  if Assigned(NodeData) then begin
    iRowColorIndex := strToInt(NodeData^.Data.ByName['RowColorIndex'].Value);
    if (iRowColorIndex <>0)  then begin
          TargetCanvas.Pen.Color := RowcolorSets[iRowColorIndex].DarkColor;
           with ItemRect do begin
                TargetCanvas.MoveTo(Left,Top);
                TargetCanvas.LineTo(Left,Bottom-1);
                TargetCanvas.MoveTo(Right,Top);
                TargetCanvas.LineTo(Right,Bottom-1);
              end;
    end;
  end;*)

end;

procedure TBOMTreeWorkOrdersGUI.TreeBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
var
  NodeData: PNodeRec;
  iRowColorIndex :Integer;
begin
  inherited;

  NodeData := Sender.GetNodeData(Node);
  if Assigned(NodeData) then begin
      iRowColorIndex := strToInt(NodeData^.Data.ByName['RowColorIndex'].Value);
      TargetCanvas.Pen.Width:=3;
        if (NodeData^.Data.ByName['IsSalesRootrec'].Value ='T')  and (Tree.Expanded[Node]) then begin
          if USeAlternateRowcolor and (iRowColorIndex <>0) then begin
           TargetCanvas.brush.color := RowcolorSets[iRowColorIndex].DarkColor;
          end else begin
           TargetCanvas.brush.color := GridColhighLightGreen;
          end;
        end else begin
          if USeAlternateRowcolor and (iRowColorIndex <>0) then begin
           TargetCanvas.brush.color := RowcolorSets[iRowColorIndex].LightColor;
          end else begin
           TargetCanvas.brush.color := clWhite;
          end;
        end;
        TargetCanvas.FillRect(CellRect);
  end;

end;

procedure TBOMTreeWorkOrdersGUI.TreeGetText(Sender: TBaseVirtualTree;  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;  var CellText: string);
var
  NodeData: PNodeRec;
  //ParentNodeData: PNodeRec;
  Datavisible:Boolean;

begin
  try
    inherited;
  Except
  end;
  Try
      NodeData := Sender.GetNodeData(Node);

      if Assigned(NodeData) then begin
        if NodeData^.Data.ByName['IsSalesRootrec'].Value ='T' then begin
          Datavisible :=  (Column = cSaleId) or (Column = cSold)   or (Column = cShipped)  or  (Column = cBackorder)or (Column = cUOM)   or  (Column = cProduct);
        end else begin
          Datavisible :=   not ((Column = cSaleId) or (Column = cSold)   or (Column = cShipped)  or  (Column = cBackorder)or (Column = cUOM)   or  (Column = cProduct));
          if strToInt(NodeData^.Data.ByName['ProctreeCtr'].asString) > 1 then
            Datavisible := (Column = cDurationf) or (Column = cTotalDurationf)  or (column = cDescription);
        end;

        if Datavisible then begin

        end else begin
           CellText := '';
        end;

        (*
        ParentNodeData := nil;

        if assigned (Node.Parent) then ParentNodeData := Tree.GetNodeData(Node.Parent);

        if Assigned(ParentNodeData) and (ParentNodeData^.Data.ByName['saleLineId'].Value = NodeData^.Data.ByName['saleLineId'].Value) then begin
          if (Column = cSaleId)     then CellText := '' ;
          if (Column = cSold)       then CellText := '' ;
          if (Column = cShipped)    then CellText := '' ;
          if (Column = cBackorder)  then CellText := '' ;
          if (Column = cUOM)        then CellText := '' ;
          if (Column = cProduct)  then CellText := '' ;

        end else begin
          if (Column = cSaleId)     then CellText := NodeData^.Data.ByName['Saleid'].Value;
          if (Column = cSold)       then CellText := NodeData^.Data.ByName['UnitofMeasureQtySold'].Value;
          if (Column = cShipped)    then CellText := NodeData^.Data.ByName['UnitofMeasureShipped'].Value;
          if (Column = cBackorder)  then CellText := NodeData^.Data.ByName['UnitofMeasureBackorder'].Value;
          if (Column = cUOM)        then CellText := NodeData^.Data.ByName['UOM'].Value;
          if (Column = cProduct)    then CellText := NodeData^.Data.ByName['ProductName'].Value;
        end;
        if (Column = cDuration)  then if NodeData^.Data.ByName['DurationinSec'].Value ='0' then CellText := '' else CellText := NodeData^.Data.ByName['Duration'].Value;*)

      end;
  Except
    on E:Exception do begin
      if devmode then
        MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
    end;
  End;
end;

function TBOMTreeWorkOrdersGUI.USeAlternateRowcolor: Boolean;
begin
  REsult := chkAlternateRowcolor.Checked;
end;

procedure TBOMTreeWorkOrdersGUI.WriteGuiPrefs;
begin
  inherited;
  GuiPrefs.Node['Options.AlternateRowcolor'].asBoolean := chkAlternateRowcolor.Checked ;
end;
procedure TBOMTreeWorkOrdersGUI.Readguiprefs;
begin
  inherited;
  chkAlternateRowcolor.Checked :=  GuiPrefs.Node['Options.AlternateRowcolor'].asBoolean;
end;

initialization
  RegisterClass(TBOMTreeWorkOrdersGUI);

end.
