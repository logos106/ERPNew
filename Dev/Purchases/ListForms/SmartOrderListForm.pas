unit SmartOrderListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar, ImgList, Menus, AdvMenus, ActnList,
  PrintDAT, SelectionDialog, DNMPanel, wwDialog, Wwlocate,
  MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,
   wwdblook, Shader, kbmMemTable, DNMAction, IntegerListObj, BaseInputForm,
  DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TSmartOrderListGUI = class(TBaseListingGUI)
    Label72: TLabel;
    qryMainNo: TAutoIncField;
    qryMainCreationDate: TDateField;
    qryMainSmartOrderDesc: TWideStringField;
    qryMainDone: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    qryMainSmartOrderID: TAutoIncField;
    qryMainGlobalRef: TWideStringField;
    Label4: TLabel;
    qryMainnotconvertedLines: TLargeintField;
    qryMainconvertedLines: TLargeintField;
    btnSelectREcord: TDNMSpeedButton;
    actSelectREcord: TDNMAction;
    qryMainNoOfItems: TLargeintField;
    btnMergeNew: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainTotalLineamount: TFloatField;
    qryMainApproved: TWideStringField;
    qryMainOrderRep: TWideStringField;
    qryMainApprover: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure btnMergeNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure actSelectREcordUpdate(Sender: TObject);
    procedure actSelectREcordExecute(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormDestroy(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fSmartOrdersToHighlight:TIntegerList;
    fiProctreeId: Integer;
    function UpdateMergedOrders(MergeOrderList:TStringlist): Integer;
    procedure setSmartOrdersToHighlight(const Value: String);
    function IsSmartOrdersToHighlight(const SOID:Integer):Boolean;
    procedure SetProctreeID(const Value: Integer);
    procedure beforeshowSmartorderListDetails(Sender: TObject);
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    Procedure SetGridColumns;override;
    procedure AssignKeyId(Popupform: TBaseInputGUI); Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;

  public
    Property SmartOrdersToHighlight:String write setSmartOrdersToHighlight;
    Property ProctreeId:Integer read fiProctreeId write SetProctreeID;
  end;

  //var
  //  SmartOrderListGUI: TSmartOrderListGUI;

implementation

uses frmSmartOrderFrm, CommonLib, AppEnvironment, BusObjSmartOrder,
  BusObjBase, CommonDbLib, CommonFormLib, SmartorderListDetails, tcDataUtils,
  BusObjApprovals, tcConst;

{$R *.dfm}

procedure TSmartOrderListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if fSmartOrdersToHighlight.count>0 then begin
    if IsSmartOrdersToHighlight(qryMainSmartOrderID.asInteger) then begin
      AFont.Color := clred;
    end;
  end;
end;

procedure TSmartOrderListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        (*GroupFilterString := 'Done <> ' + QuotedStr('T');*)
        GroupFilterString := 'notconvertedLines <> 0';
      end;
    1:
      begin
        (*GroupFilterString := 'Done = ' + QuotedStr('T');*)
        GroupFilterString := 'notconvertedLines = 0';
      end;
  end;
  inherited;
  if Qrymain.active then Qrymain.First;
end;

function TSmartOrderListGUI.IsSmartOrdersToHighlight(  const SOID: Integer): Boolean;
var
  ctr:Integer;
begin
  result := False;
  for ctr:= 0 to fSmartOrdersToHighlight.count-1 do
    if fSmartOrdersToHighlight[ctr] = SOID then begin
      REsult := True;
      Exit;
    end;
end;

procedure TSmartOrderListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
end;

procedure TSmartOrderListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').AsDate := FilterDateFrom;
  qryMain.Params.ParamByName('txtto').AsDate := FilterDateTo;
  inherited;
end;

procedure TSmartOrderListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  //  SmartOrderListGUI := nil;
end;

procedure TSmartOrderListGUI.cmdNewClick(Sender: TObject);
var
  tmpComponent: TComponent;
begin
  DisableForm;
  try
    inherited;
    tmpComponent := GetComponentByClassName('TSmartOrderGUI');
    if not Assigned(tmpComponent) then Exit;
    with TSmartOrderGUI(tmpComponent) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  finally
    EnableForm;
  end;
end;

Function  TSmartOrderListGUI.UpdateMergedOrders(MergeOrderList:TStringlist):Integer;
var
  SmartOrder :TSmartOrder;
begin
  SmartOrder :=TSmartOrder.create(Self);
  try
    SmartOrder.BusObjEvent := DoBusinessObjectEvent;
    stepProgressbar('Making New Smart Order');
    SmartOrder.Connection := TMyDacDataConnection.create(SmartOrder);
    SmartOrder.Connection.Connection := GetNewMyDacConnection(SmartOrder);
    SmartOrder.Load(0);
    SmartOrder.Connection.BeginTransaction;
    stepProgressbar('Merge ' + inttostr(MergeOrderList.count)+' Orders into the New Order');
    result:= SmartOrder.MergedOrders(MergeOrderList);
    if result <> 0 then begin
      stepProgressbar('Save the New Order # ' + inttostr(SmartOrder.ID));
      SmartOrder.Connection.CommitTransaction;
      Grdmain.UnselectAll;
      stepProgressbar('Refresh the List');
      RefreshQuery;
      if Qrymain.Locate('SmartOrderID' , result , []) then begin
          stepProgressbar('Open the New Order');
          grdMainDblClick(grdMain);
      end;
    end else begin
      stepProgressbar('Merging Orders Failed');
      SmartOrder.Connection.RollbackTransaction;
    end;
  Finally
    FreeAndNil(SmartOrder);
  end;
end;

procedure TSmartOrderListGUI.WriteGuiPrefExtra;
begin
  inherited;
end;

procedure TSmartOrderListGUI.btnMergeNewClick(Sender: TObject);
var
  st:tSTringList;
begin
if grdmain.SelectedList.Count <=1 then exit;

Processingcursor(True);
try
  showProgressbar(WAITMSG,grdmain.SelectedList.Count* 10, false);
  try
      st:=tSTringList.create;
      try
        SelectedIDs('SmartOrderID', St);
        if st.count = 0  then begin
           ProcessingCursor(False);
           CommonLib.MessageDlgXP_Vista('Please select at least one Smart Order.' + #13 + #10 +
                                        '(Hold down ''CTRL'' and click on row to toggle selection.)',
              mtInformation, [mbOK], 0);
           Exit;
        end;
        UpdateMergedOrders(st);
      finally
        FreeandNil(st);
      end;
  finally
    HideProgressbar;
  end;
finally
  ProcessingCursor(False);
end;
(*var
  i: integer;
  tmpComponent: TComponent;
begin
  DisableForm;
  try
    inherited;
    if grdMain.SelectedList.Count > 0 then begin
      tmpComponent := GetComponentByClassName('TSmartOrderGUI');
      if not Assigned(tmpComponent) then Exit;
      with TSmartOrderGUI(tmpComponent) do begin
        MergeOrderList.Clear;
        for i := 0 to grdMain.SelectedList.Count - 1 do begin
          qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
          MergeOrderList.Add(qryMain.FieldByName('SmartOrderID').AsInteger);
        end;
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end; // with
    end else CommonLib.MessageDlgXP_Vista('Please select at least one Smart Order.' + #13 + #10 +
        '(Hold down ''CTRL'' and click on row to toggle selection.)',
        mtInformation, [mbOK], 0);
  finally
    EnableForm;
  end;*)
end;

procedure TSmartOrderListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := true;
  fSmartOrdersToHighlight:=TIntegerList.Create;
  inherited;
end;

procedure TSmartOrderListGUI.FormDestroy(Sender: TObject);
begin
  FreeandNil(fSmartOrdersToHighlight);
  inherited;

end;

procedure TSmartOrderListGUI.FormShow(Sender: TObject);
begin
  inherited;
  EnableMultiSelect('Choose Orders to Merge');
end;

procedure TSmartOrderListGUI.actSelectREcordExecute(Sender: TObject);
begin
  inherited;
  if actSelectRecord.Caption ='UnSelect All' then   grdmain.UnSelectAll else grdmain.selectAll;
  actSelectRecordUpdate(actSelectRecord);

end;

procedure TSmartOrderListGUI.actSelectREcordUpdate(Sender: TObject);
begin
  inherited;
  if qrymain.recordcount = grdmain.SelectedList.Count then begin
    actSelectRecord.Caption :='UnSelect All';
  end else begin
    actSelectRecord.Caption :='Select All';
  end;

end;

procedure TSmartOrderListGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  inherited;
  if popupform is TSmartOrderGUI then
    TSmartOrderGUI(popupform).ProctreeId :=ProctreeId ;

end;

procedure TSmartOrderListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TSmartOrderListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TSmartOrderListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TSmartOrderListGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TSmartorderListDetailsGUI' , beforeshowSmartorderListDetails);
  Self.close;
end;
procedure TSmartOrderListGUI.beforeshowSmartorderListDetails(Sender: TObject);
begin
  TSmartorderListDetailsGUI(Sender).dtFrom.Date   := dtFrom.Date;
  TSmartorderListDetailsGUI(Sender).dtto.Date     := dtto.Date;
  TSmartorderListDetailsGUI(Sender).fbDateRangeSupplied := true;
end;
procedure TSmartOrderListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('notconvertedLines');
  RemoveFieldfromGrid('convertedLines');
  RemoveFieldfromGrid('EmployeeID');
  RemoveFieldfromGrid('SmartOrderID');
end;

procedure TSmartOrderListGUI.SetProctreeID(const Value: Integer);
var
  SOIds:String;
begin
  fiProctreeId := Value;
  with tempMyQuery do try
    SQL.add(' SELECT smartorderid FROM tblsmartorderlines AS SOL where ProcTreeId = ' +inttostr(Value));
    open;
    SOIds := Groupconcat('smartorderid');
  finally
    closenFree;
  end;
  if SOIDs <> '' then begin
    SOIDs := 'smartorderid  = ' + replacestr(SOIDs , ',' ,' or smartorderid  = ');
    filterString := SOIDs;
  end;
end;

procedure TSmartOrderListGUI.setSmartOrdersToHighlight(const Value: String);
begin
  fSmartOrdersToHighlight.commatext := Value;
end;

initialization
  RegisterClassOnce(TSmartOrderListGUI);
end.
