unit WorkOrderStatusList;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 22/11/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton, MessageConst, wwcheckbox,
   wwdblook, Shader, kbmMemTable, DAScript, MyScript, CustomInputBox;

type
  TWorkOrderStatusListGUI = class(TBaseListingGUI)
    qryMainCustomer: TWideStringField;
    qryMainProcess: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainStep: TWideStringField;
    qryMainStepStatus: TWideStringField;
    grpFilter: TRadioGroup;
    qryMainProductID: TIntegerField;
    qryMainDueDate: TDateField;
    btnLineColors: TDNMSpeedButton;
    qryMainProcessLinesID: TIntegerField;
    qryMainLineColor: TIntegerField;
    qryMainExpectedStepTime: TDateTimeField;
    cmdPrintGrid: TDNMSpeedButton;
    qryMainSalesPerson: TWideStringField;
    qryMainSaleID: TIntegerField;
    qryMainSalesOrder: TWideStringField;
    qryMainSalesLine: TIntegerField;
    qryMainStepID: TIntegerField;
    qryMainCompleted: TWideStringField;
    Label4: TLabel;
    chkIncludeCompleted: TwwCheckBox;
    qryMainStepTime: TWideStringField;
    qryMainEmployeeStart: TDateTimeField;
    qryMainEmployeeStop: TDateTimeField;
    qryMainInvoice: TIntegerField;
    procedure cmdPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grpFilterClick(Sender: TObject);
    procedure btnLineColorsClick(Sender: TObject);
    procedure grdMainDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkIncludeCompletedClick(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
  private
    FQueryStore: string;
    procedure PerformRefresh(var Msg: TMessage); message TX_PerformRefresh;
    procedure SetupPopupMenu;
    procedure HandleColorSelect(Sender: TObject);
    procedure HandleActionSelect(Sender: TObject);
    procedure ClearExistingMenuItems;
  protected
    procedure RefreshTotals; override;
    procedure RefreshQuery; override;
    function GetReportTypeID: Integer; override;
  public
    { Public declarations }
  end;

implementation

uses
   CommonLib,  BarcodeProcessObj, AppEnvironment,
  FastFuncs;

const
  ActionArray: array[1..4] of string = ('Start', 'Stop', 'Finish', 'Complete');

{$R *.dfm}

{ TWorkOrderStatusListGUI }

procedure TWorkOrderStatusListGUI.PerformRefresh(var Msg: TMessage);
begin
  RefreshQuery;
end;

procedure TWorkOrderStatusListGUI.cmdPrintClick(Sender: TObject);
var
  Index: Integer;
  ProductID: Integer;
  SaleLineID: Integer;
begin
  if Assigned(Sender) and (TControl(Sender).Name = 'cmdPrint') then begin
    Processingcursor(True);
    qryMain.DisableControls;

    try
      for Index := 0 to grdMain.SelectedList.Count - 1 do begin
        qryMain.GotoBookmark(grdMain.SelectedList[Index]);
        ReportToPrint := 'Barcode Process';
        ProductID := qryMain.FieldByName('ProductID').AsInteger;
        SaleLineID := qryMain.FieldByName('Sales Line #').AsInteger;
        TemplateSQL := ' WHERE (sl.SaleLineID = ' + IntToStr(SaleLineID) + ') ~|||~ WHERE pp.PartID = ' +
                       IntToStr(ProductID) + ' ~|||~ WHERE ed.SaleLineID = ' + IntToStr(SaleLineID);
        LoadTemplate(not chkPreview.Checked, False);
      end;
    finally
      qryMain.EnableControls;
      Processingcursor(False);
    end;
  end
  else
    inherited;
end;

procedure TWorkOrderStatusListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  pnlAdvPrinting.Show;
  FQueryStore := qryMain.SQL.Text;
  qryMain.SQL.Text := qryMain.SQL.Text + ' AND (pr.Completed = ''F'') GROUP BY pr.ProcessID';
  mnuFilter.Items[mnuFilter.Items.Count - 1].Tag := 1;
end;

procedure TWorkOrderStatusListGUI.grpFilterClick(Sender: TObject);
begin
  inherited;
  qryMain.DisableControls;
  qryMain.Close;

  try
    if grpFilter.ItemIndex = 0 then begin
      if chkIncludeCompleted.Checked then begin
        qryMain.SQL.Text := FQueryStore + ' GROUP BY pr.ProcessID';
        grdMain.AddField('Completed');
      end
      else
      begin
        qryMain.SQL.Text := FQueryStore + ' AND (pr.Completed = ''F'') GROUP BY pr.ProcessID';
        grdMain.RemoveField('Completed');
      end;

      ClearExistingMenuItems;
      cmdPrint.Enabled := True;
      btnLineColors.Enabled := False;
    end
    else begin
      if chkIncludeCompleted.Checked then begin
        qryMain.SQL.Text := FQueryStore;
        grdMain.AddField('Completed');
      end
      else
      begin
        qryMain.SQL.Text := FQueryStore + ' AND (pr.Completed = ''F'')';
        grdMain.RemoveField('Completed');
      end;

      cmdPrint.Enabled := False;
      btnLineColors.Enabled := True;
      SetupPopupMenu;
    end;

    qryMain.Open;
    RefreshTotals;
  finally
    qryMain.EnableControls;
  end;
end;

procedure TWorkOrderStatusListGUI.RefreshTotals;
begin
  inherited;
  lblTotal.Caption := IntToStr(qryMain.RecordCount);
end;

procedure TWorkOrderStatusListGUI.btnLineColorsClick(Sender: TObject);
var
  Form: TForm;
  FormCaption: string;
  GroupType: string;
begin
  inherited;
  Form := TForm(GetComponentByClassName('TLineColorConfigGUI'));
  FormCaption := 'Priority Line Colours';
  GroupType := 'WorkOrderStatus';

  if Assigned(Form) then begin
    SendMessage(Form.Handle, TX_PerformStartup, Longint(@FormCaption), Longint(@GroupType));

    if Form.ShowModal = mrOK then
      SetupPopupMenu;

    Form.Release;
  end;
end;

procedure TWorkOrderStatusListGUI.SetupPopupMenu;
var
  ItemIndex: Integer;
  Bitmap: TBitmap;
  NewItem: TMenuItem;
  qryColors: TERPQuery;
begin
  ClearExistingMenuItems;
  Bitmap := TBitmap.Create;
  Bitmap.Width := 16;
  Bitmap.Height := 16;
  qryColors := TERPQuery.Create(nil);

  try
    qryColors.Connection := qryMain.Connection;
    qryColors.SQL.Text := 'SELECT * FROM tbllistlinecolor WHERE (GroupType = ''WorkOrderStatus'') AND (Active = ''T'')';
    qryColors.Open;
    qryColors.First;
    NewItem := TMenuItem.Create(mnuFilter);
    NewItem.Caption := '-';
    mnuFilter.Items.Add(NewItem);
    NewItem := TMenuItem.Create(mnuFilter);
    NewItem.Caption := 'Clear';
    NewItem.OnClick := HandleColorSelect;
    mnuFilter.Items.Add(NewItem);

    while not qryColors.Eof do begin
      NewItem := TMenuItem.Create(mnuFilter);
      NewItem.Caption := qryColors.FieldByName('Text').AsString;
      NewItem.OnClick := HandleColorSelect;
      Bitmap.Canvas.Brush.Color := qryColors.FieldByName('Color').AsInteger;
      Bitmap.Canvas.FillRect(Rect(0, 0, 15, 15));
      NewItem.Bitmap.Assign(Bitmap);
      NewItem.Tag := qryColors.FieldByName('Color').AsInteger;
      mnuFilter.Items.Add(NewItem);
      qryColors.Next;
    end;

    if AppEnv.AccessLevels.GetEmployeeAccessLevel('TBarcodeProcess') < 3 then begin
      NewItem := TMenuItem.Create(mnuFilter);
      NewItem.Caption := '-';
      mnuFilter.Items.Add(NewItem);

      for ItemIndex := Low(ActionArray) to High(ActionArray) do begin
        NewItem := TMenuItem.Create(mnuFilter);
        NewItem.Caption := ActionArray[ItemIndex];
        NewItem.OnClick := HandleActionSelect;
        NewItem.Tag := ItemIndex;
        mnuFilter.Items.Add(NewItem);
      end;
    end;  
  finally
    FreeAndNil(Bitmap);
    FreeAndNil(qryColors);
  end;
end;

procedure TWorkOrderStatusListGUI.HandleColorSelect(Sender: TObject);
var
  Index: Integer;
  ProcessLinesID: Integer;
  qryProcess: TERPQuery;
begin
  if Sender is TMenuItem then begin
    qryProcess := TERPQuery.Create(nil);
    qryMain.DisableControls;

    try
      qryProcess.Connection := qryMain.Connection;

      for Index := 0 to grdMain.SelectedList.Count - 1 do begin
        qryMain.GotoBookmark(grdMain.SelectedList[Index]);
        ProcessLinesID := qryMain.FieldByName('ProcessLinesID').AsInteger;
        qryProcess.SQL.Text := 'SELECT * FROM tblprocesslines WHERE ProcessLinesID = ' + IntToStr(ProcessLinesID);
        qryProcess.Open;
        qryProcess.Edit;
        qryProcess.FieldByName('LineColor').AsInteger := TMenuItem(Sender).Tag;
        qryProcess.Post;
        qryProcess.Close;
      end;

      grdMain.UnselectAll;
      RefreshQuery;
    finally
      qryMain.EnableControls;
      FreeAndNil(qryProcess);
    end;
  end;
end;

procedure TWorkOrderStatusListGUI.grdMainDrawDataCell(Sender: TObject;
  const Rect: TRect; Field: TField; State: TGridDrawState);
var
  Flags: Integer;
  TmpRect: TRect;
  LineColor: Integer;
begin
  inherited;

  if qryMain.IsEmpty then
    LineColor := 0
  else
    LineColor := qryMain.FieldByName('LineColor').AsInteger;

  if (grpFilter.ItemIndex = 1) and (grdMain.Canvas.Brush.Color = grdMain.Color) and (LineColor <> 0) then
    grdMain.Canvas.Brush.Color := LineColor;

  grdMain.Canvas.FillRect(Rect);
  TmpRect := Rect;
  TmpRect.Left := TmpRect.Left + 2;
  TmpRect.Right := TmpRect.Right - 2;
  Flags := DT_VCENTER or DT_SINGLELINE;

  case Field.Alignment of
    taLeftJustify: Flags := Flags or DT_LEFT;

    taCenter: Flags := Flags or DT_CENTER;

    taRightJustify: Flags := Flags or DT_RIGHT;
  end;

  DrawText(grdMain.Canvas.Handle, PChar(Field.DisplayText), -1, TmpRect, Flags);
end;

procedure TWorkOrderStatusListGUI.ClearExistingMenuItems;
var
  ItemIndex: Integer;
  ItemPos: Integer;
begin
  ItemIndex := 0;

  while (ItemIndex < mnuFilter.Items.Count) and (mnuFilter.Items[ItemIndex].Tag <> 1) do
    Inc(ItemIndex);

  if ItemIndex < mnuFilter.Items.Count then begin
    ItemPos := ItemIndex;

    for ItemIndex := mnuFilter.Items.Count - 1 downto ItemPos + 1 do
      mnuFilter.Items[ItemIndex].Free;
  end;
end;

procedure TWorkOrderStatusListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('DateFrom').AsDate := dtFrom.DateTime;
  qryMain.Params.ParamByName('DateTo').AsDate := dtTo.DateTime;
  inherited;
end;

procedure TWorkOrderStatusListGUI.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  AccessLevel: Integer;
  BarcodeProcess: TBarcodeProcess;
begin
  inherited;

  if Key = VK_F9 then begin
    BarcodeProcess := TBarcodeProcess(FindExistingComponent('TBarcodeProcess'));

    if Assigned(BarcodeProcess) then
      BarcodeProcess.BringToFront
    else begin
      AccessLevel := AppEnv.AccessLevels.GetEmployeeAccessLevel('TBarcodeProcess');

      if AccessLevel > 2 then
        CommonLib.MessageDlgXP_Vista('You do not have Access to ' + AppEnv.AccessLevels.GetFormDescription('TBarcodeProcess'), mtWarning	, [mbOK], 0)
      else begin
        BarcodeProcess := TBarcodeProcess(GetComponentByClassName('TBarcodeProcess'));

        if Assigned(BarcodeProcess) then begin
          BarcodeProcess.CreateForm;
          BarcodeProcess.SetupDisplay;
        end;
      end;
    end;
  end;
end;

procedure TWorkOrderStatusListGUI.HandleActionSelect(Sender: TObject);
var
  Index: Integer;
  EmployeeID: Integer;
  SalesLineID: Integer;
  StepID: Integer;
  BarcodeProcess: TBarcodeProcess;
begin
  if Sender is TMenuItem then begin
    qryMain.DisableControls;
    BarcodeProcess := TBarcodeProcess.Create(nil);

    try
      EmployeeID := AppEnv.Employee.EmployeeID;
      BarcodeProcess.DisplayMessages := False;
      BarcodeProcess.ExpectedPrefixTypes := [ptEmployee];

      for Index := 0 to grdMain.SelectedList.Count - 1 do begin
        qryMain.GotoBookmark(grdMain.SelectedList[Index]);
        SalesLineID := qryMain.FieldByName('Sales Line #').AsInteger;
        StepID := qryMain.FieldByName('StepID').AsInteger;
        BarcodeProcess.EnterBarcode('EMP-' + IntToStr(EmployeeID));
        BarcodeProcess.EnterBarcode(ActionArray[TMenuItem(Sender).Tag] + '-' + IntToStr(SalesLineID));

        if not Sysutils.SameText(ActionArray[TMenuItem(Sender).Tag], 'Complete') then
          BarcodeProcess.EnterBarcode('STEP-' + IntToStr(StepID));
      end;

      grdMain.UnselectAll;
      RefreshQuery;
    finally
      FreeAndNil(BarcodeProcess);
      qryMain.EnableControls;
    end;
  end;
end;

procedure TWorkOrderStatusListGUI.chkIncludeCompletedClick(
  Sender: TObject);
begin
  inherited;
  qryMain.DisableControls;
  qryMain.Close;

  try
    if grpFilter.ItemIndex = 0 then begin
      if chkIncludeCompleted.Checked then begin
        qryMain.SQL.Text := FQueryStore + ' GROUP BY pr.ProcessID';
        grdMain.AddField('Completed');
      end
      else
      begin
        qryMain.SQL.Text := FQueryStore + ' AND (pr.Completed = ''F'') GROUP BY pr.ProcessID';
        grdMain.RemoveField('Completed');
      end;
    end
    else begin
      if chkIncludeCompleted.Checked then begin
        qryMain.SQL.Text := FQueryStore;
        grdMain.AddField('Completed');
      end
      else
      begin
        qryMain.SQL.Text := FQueryStore + ' AND (pr.Completed = ''F'')';
        grdMain.RemoveField('Completed');
      end;
    end;

    qryMain.Open;
    RefreshTotals;
  finally
    qryMain.EnableControls;
  end;
end;

procedure TWorkOrderStatusListGUI.qryMainCalcFields(DataSet: TDataSet);
var
  Hours: Integer;
  Minutes: Integer;
begin
  inherited;
  Minutes := MinutesBetween(DataSet.FieldByName('EmployeeStop').AsDateTime, DataSet.FieldByName('EmployeeStart').AsDateTime);
  Hours := Minutes div 60;
  Minutes := Minutes mod 60;
  DataSet.FieldByName('Step Time').AsString := Format('%.2d:%.2d', [Hours, Minutes]);
end;

function TWorkOrderStatusListGUI.GetReportTypeID: Integer;
begin
  Result := 3;
end;

initialization
  RegisterClassOnce(TWorkOrderStatusListGUI);
finalization
  UnRegisterClass(TWorkOrderStatusListGUI);
end.

