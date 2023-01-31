// Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  //07/09/05  1.00.## ISB	Modified To Work With New Filtering on Baselisting.

unit RunListGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess, MyAccess, Mask,
  wwdbedit, Wwdotdot, Wwdbcomb, kbmMemTable, wwdblook, CustomInputBox, ProgressDialog,
  DeliveryObj, wwdbdatetimepicker, Shader;

type
  TRunAssignerGUI = class(TBaseListingGUI)
    qryMainCompany: TStringField;
    qryMainAddress: TStringField;
    qryMainRunName: TStringField;
    CustomInputBox1: TCustomInputBox;
    btnAssign: TDNMSpeedButton;
    btnUnassign: TDNMSpeedButton;
    qryMainMobile: TStringField;
    qryMainPhone: TStringField;
    qryMainSuburb: TStringField;
    qryMainPostCode: TStringField;
    Label7: TLabel;
    qryMainContact: TStringField;
    qryMainRunID: TIntegerField;
    qryMainContactID: TIntegerField;
    qryMainID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainDetails: TIntegerField;
    qryMainType: TStringField;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grpFiltersClick(Sender: TObject); override;
    procedure grdMainDblClick(Sender: TObject); override;
    procedure btnAssignClick(Sender: TObject);
    procedure btnUnassignClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);

  private
    { Private declarations }
    procedure CreateTemporaryTable;
    function GetTemporaryTableName: string;
    procedure ClearTemporaryTable;
    procedure PopulateTemporaryTable;
    procedure DropTemporaryTable;
    
  public
    { Public declarations }
    MyDelivery: TDeliveryObj;
    procedure RefreshQuery; override;
  end;

  //var
  //  RunAssignerGUI: TRunAssignerGUI;

implementation

{$R *.dfm}

uses
  CommonDbLib, frmRunSelector, frmRun, frmRunDespatch, DNMLib,
  DeliveryLib, CommonLib, ClientDiscountObj;

procedure TRunAssignerGUI.FormDestroy(Sender: TObject);
begin
  if Assigned(MyDelivery) then FreeAndNil(MyDelivery);
  DropTemporaryTable;
  inherited;
end;

procedure TRunAssignerGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TRunAssignerGUI.RefreshQuery;
begin
  qryMain.Close;
  PopulateTemporaryTable;
  inherited;

  grdMain.RemoveField('RunID');
  grdMain.ColumnByName('Address').DisplayWidth := 60;
  grdMain.ColumnByName('Company').DisplayWidth := 26;
  grdMain.ColumnByName('Contact').DisplayWidth := 29;
  grdMain.ColumnByName('Phone').DisplayWidth := 20;
  grdMain.ColumnByName('Mobile').DisplayWidth := 20;
  grdMain.ColumnByName('Suburb').DisplayWidth := 20;
end;

procedure TRunAssignerGUI.grpFiltersClick(Sender: TObject);
begin
  btnUnassign.Enabled := false;
  btnAssign.Enabled := false;
  grdMain.UnselectAll;
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := '(RunID <> 0)';
        btnUnassign.Enabled := true;
        btnAssign.Enabled := false;
      end;

    1: 
      begin
        GroupFilterString := '(RunID = 0)';
        btnUnassign.Enabled := false;
        btnAssign.Enabled := true;
      end;
  end;
  inherited;
end;

procedure TRunAssignerGUI.grdMainDblClick(Sender: TObject);
begin
  if (grpFilters.ItemIndex = 0) or (grpFilters.ItemIndex = 2) then begin
    if grpFilters.ItemIndex = 2 then begin
      if qryMain.FieldByName('RunID').AsInteger = 0 then Exit;
    end;

    inherited;
  end;
end;

procedure TRunAssignerGUI.btnAssignClick(Sender: TObject);
var
  qrySpecialProducts, qryRunLines, qryParts: TMyQuery;
  qryCompulsoryProducts: TMyQuery;
  iX, iResult, iSequence: integer;
  RunInfo: TRunInfo;
  MyProgressDialog: TProgressDialog;
  dIncPrice, dPriceEx, dDiscount, dQty, dTax: double;
  sDescript, sMsg: string;
  ClientDiscount: TClientDiscountObj;  
begin
  inherited;
  if grdMain.SelectedList.Count < 1 then begin
    CommonLib.MessageDlgXP_Vista('You must at least pick one record before attempting to assign runs to customers.  Hold down the Ctrl Key and left click with your mouse to choose customers.',
      mtInformation, [mbOK], 0);
    Exit;
  end;

  // Request which run name that we are to assign to selection.
  with TfrmRunSelectorGUI(GetComponentByClassName('TfrmRunSelectorGUI')) do begin
    TfrmRunSelectorGUI(GetComponentByClassName('TfrmRunSelectorGUI')).ResultRecord := @RunInfo;
    TfrmRunSelectorGUI(GetComponentByClassName('TfrmRunSelectorGUI')).FormStyle := fsNormal;
    iResult := TfrmRunSelectorGUI(GetComponentByClassName('TfrmRunSelectorGUI')).ShowModal;
    // If user cancelled, then exit
    if iResult = mrCancel then Exit;
  end;

  if FormStillOpen('TfrmRunSequencerGUI') then begin
    // Save the run and terminate window display.
    TFrmRunSequencerGUI(FindExistingComponent('TfrmRunSequencerGUI')).cmdOK.Click;
    Application.ProcessMessages;
  end;
  //  if Assigned(frmRunSequencerGUI) then begin
  //    // Save the run and terminate window display.
  //    frmRunSequencerGUI.cmdOK.Click;
  //    Application.ProcessMessages;
  //  end;

  MyProgressDialog := TProgressDialog.Create(nil);
  qrySpecialProducts := TMyQuery.Create(nil);
  qryCompulsoryProducts := TMyQuery.Create(nil);
  qryRunLines := TMyQuery.Create(nil);
  qryParts := TMyQuery.Create(nil);

  try
    qrySpecialProducts.Connection := CommonDbLib.GetSharedMyDacConnection;
    qrySpecialProducts.ParamCheck := true;

    qryParts.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryParts.ParamCheck := true;
    qryParts.SQL.Clear;
    qryParts.SQL.Add('SELECT PartsID, TaxCode FROM tblparts WHERE (PartsID = :xPartID);');

    qryRunLines.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryRunLines.ParamCheck := true;
    qryRunLines.SQL.Clear;
    qryRunLines.SQL.Add('SELECT * FROM tblrunslines WHERE RunID = :xRunID LIMIT 0;');
    qryRunLines.Open;

    qryMain.DisableControls;
    MyProgressDialog.Caption  := 'Assigning Run to Selected Customers ...';
    MyProgressDialog.MinValue := 0;
    MyProgressDialog.MaxValue := grdMain.SelectedList.Count;
    MyProgressDialog.Step     := 1;
    MyProgressDialog.Value    := 0;
    MyProgressDialog.Execute;
    for iX := 0 to grdMain.SelectedList.Count - 1 do begin
      // Goto Selected Record.
      qryMain.GotoBookmark(grdMain.SelectedList.Items[iX]);

      // Get next relative sequence entry number.
      iSequence := MyDelivery.DoesCustomerHaveSequenceNumber(RunInfo.RunID, qryMain.FieldByName('ClientID').AsInteger);
      if iSequence = 0 then begin
        iSequence := GetMyNextSequenceNumber(RunInfo.RunID);
      end;

      // Has this customer already been assigned to a run?
      if IsCustomerOnRun(qryMain.FieldByName('ClientID').AsInteger, qryMain.FieldByName('Contact').AsString) then begin
        // Yes, Skip Customer and Increment our Progress Status Bar.
        MyProgressDialog.StepIt;
        Application.ProcessMessages;
        // Get next selected record.
        Continue;
      end;

      // Check now to see if their is any default compulsory run products that must be added.
      qryCompulsoryProducts.Connection := CommonDbLib.GetSharedMyDacConnection;
      qryCompulsoryProducts.SQL.Clear;
      qryCompulsoryProducts.SQL.Add('SELECT * FROM tbldefaultrunparts ORDER BY ProductName;');
      qryCompulsoryProducts.Open;
      if qryCompulsoryProducts.RecordCount > 0 then begin
        while not qryCompulsoryProducts.Eof do begin
          qryRunLines.Insert;
          qryRunLines.FieldByName('ClientID').AsInteger := qryMain.FieldByName('ClientID').AsInteger;
          if qryMain.FieldByName('Details').AsInteger = 0 then begin
            qryRunLines.FieldByName('IsContact').AsString := 'F';
          end else begin
            qryRunLines.FieldByName('IsContact').AsString := 'T';
            qryRunLines.FieldByName('ContactID').AsInteger := qryMain.FieldByName('ContactID').AsInteger;
          end;

          qryRunLines.FieldByName('ClientName').AsString := qryMain.FieldByName('Contact').AsString;
          qryRunLines.FieldByName('Company').AsString := qryMain.FieldByName('Company').AsString;
          qryRunLines.FieldByName('TaxCode').AsString := qryCompulsoryProducts.FieldByName('TaxCode').AsString;
          qryRunLines.FieldByName('Qty').AsFloat := qryCompulsoryProducts.FieldByName('Qty').AsFloat;
          qryRunLines.FieldByName('StartDate').AsDateTime := Date;
          qryRunLines.FieldByName('FreqInterval').AsFloat := qryCompulsoryProducts.FieldByName('FreqInterval').AsFloat;
          qryRunLines.FieldByName('FreqType').AsString := qryCompulsoryProducts.FieldByName('FreqType').AsString;

          MyDelivery.CalcScheduledDates(qryCompulsoryProducts.FieldByName('FreqInterval').AsInteger,
            qryCompulsoryProducts.FieldByName('FreqType').AsString, Date());

          qryRunLines.FieldByName('NextRunDate').AsDateTime := Date;

          if MyDelivery.ScheduledTimes[1] <> 0 then begin
            qryRunLines.FieldByName('DateAfterNext').AsDateTime := MyDelivery.ScheduledTimes[1];
          end else begin
            qryRunLines.FieldByName('DateAfterNext').AsDateTime := Date;
          end;

          qryRunLines.FieldByName('RunID').AsInteger := RunInfo.RunID;
          qryRunLines.FieldByName('Sequence').AsInteger := iSequence;
          qryRunLines.FieldByName('Phone').AsString := qryMain.FieldByName('Phone').AsString;
          qryRunLines.FieldByName('Mobile').AsString := qryMain.FieldByName('Mobile').AsString;
          qryRunLines.FieldByName('Address').AsString := qryMain.FieldByName('Address').AsString;
          qryRunLines.FieldByName('ProductID').AsInteger := qryCompulsoryProducts.FieldByName('ProductID').AsInteger;
          qryRunLines.FieldByName('ProductName').AsString := qryCompulsoryProducts.FieldByName('ProductName').AsString;

          ClientDiscount := TClientDiscountObj.Create;
          try
            ClientDiscount.ClientPrice_Discounts(qryRunLines.FieldByName('ClientID').AsInteger, 0,
              qryRunLines.FieldByName('ProductID').AsInteger, RunInfo.ClassID,
              qryRunLines.FieldByName('Qty').AsFloat, RunInfo.Date, 1,
              '', '', '', '', '',
              false, dPriceEx, dDiscount, sDescript, sMsg);
          finally
            FreeandNil(ClientDiscount);
          end;

          qryRunLines.FieldByName('OriginalExPrice').AsFloat := dPriceEx;
          qryRunLines.FieldByName('Discount').AsFloat := dDiscount;
          dPriceEx := dPriceEx - (dPriceEx * dDiscount);
          qryRunLines.FieldByName('UnitExPrice').AsFloat := dPriceEx;
          dIncPrice := GetAmountInc(dPriceEx, GetTaxRate(qryRunLines.FieldByName('TaxCode').AsString));
          dQty := qryRunLines.FieldByName('Qty').AsFloat;
          dTax := (dIncPrice - dPriceEx) * dQty;
          qryRunLines.FieldByName('TaxAmount').AsFloat := dTax;
          dIncPrice := dIncPrice * dQty;
          qryRunLines.FieldByName('OrderValue').AsFloat := RoundCurrency(dIncPrice);

          qryRunLines.Post;
          qryCompulsoryProducts.Next;
        end;
      end;
        
      // Check now to see if the client has any special products
      // that must be added.
      qrySpecialProducts.SQL.Clear;
      qrySpecialProducts.SQL.Add('SELECT * FROM tblcustomerlines WHERE CustomerID = :xCID AND IncludeInRun = "T";');
      qrySpecialProducts.Params.ParamByName('xCID').AsInteger := qryMain.FieldByName('ClientID').AsInteger;
      qrySpecialProducts.Open;

      // Do we have any special products to add?
      if qrySpecialProducts.RecordCount > 0 then begin
        while not qrySpecialProducts.Eof do begin
          // Yes, lets add them in.
          qryParts.Close;
          qryParts.Params.ParamByName('xPartID').AsInteger := qrySpecialProducts.FieldByName('ProductID').AsInteger;
          qryParts.Open;

          qryRunLines.Insert;
          qryRunLines.FieldByName('ClientID').AsInteger := qryMain.FieldByName('ClientID').AsInteger;
          if qryMain.FieldByName('Details').AsInteger = 0 then begin
            qryRunLines.FieldByName('IsContact').AsString := 'F';
          end else begin
            qryRunLines.FieldByName('IsContact').AsString := 'T';
            qryRunLines.FieldByName('ContactID').AsInteger := qryMain.FieldByName('ContactID').AsInteger;
          end;

          qryRunLines.FieldByName('ClientName').AsString := qryMain.FieldByName('Contact').AsString;
          qryRunLines.FieldByName('Company').AsString := qryMain.FieldByName('Company').AsString;
          qryRunLines.FieldByName('TaxCode').AsString := qryParts.FieldByName('TaxCode').AsString;
          qryRunLines.FieldByName('Qty').AsFloat := 1;
          qryRunLines.FieldByName('StartDate').AsDateTime := Date;
          qryRunLines.FieldByName('FreqInterval').AsFloat := 1;
          qryRunLines.FieldByName('FreqType').AsString := 'Week(s)';

          MyDelivery.CalcScheduledDates(1, 'Week(s)', Date());
          qryRunLines.FieldByName('NextRunDate').AsDateTime := Date;
          if MyDelivery.ScheduledTimes[1] <> 0 then begin
            qryRunLines.FieldByName('DateAfterNext').AsDateTime := MyDelivery.ScheduledTimes[1];
          end else begin
            qryRunLines.FieldByName('DateAfterNext').AsDateTime := Date;
          end;

          qryRunLines.FieldByName('RunID').AsInteger := RunInfo.RunID;
          qryRunLines.FieldByName('Sequence').AsInteger := iSequence;
          qryRunLines.FieldByName('Phone').AsString := qryMain.FieldByName('Phone').AsString;
          qryRunLines.FieldByName('Mobile').AsString := qryMain.FieldByName('Mobile').AsString;
          qryRunLines.FieldByName('Address').AsString := qryMain.FieldByName('Address').AsString;
          qryRunLines.FieldByName('ProductID').AsInteger := qrySpecialProducts.FieldByName('ProductID').AsInteger;
          qryRunLines.FieldByName('ProductName').AsString := qrySpecialProducts.FieldByName('Name').AsString;

          ClientDiscount := TClientDiscountObj.Create;
          try
            ClientDiscount.ClientPrice_Discounts(qryRunLines.FieldByName('ClientID').AsInteger, 0,
              qryRunLines.FieldByName('ProductID').AsInteger, RunInfo.ClassID,
              qryRunLines.FieldByName('Qty').AsFloat, RunInfo.Date, 1,
              '', '', '', '', '',
              false, dPriceEx, dDiscount, sDescript, sMsg);
          finally
            FreeandNil(ClientDiscount);
          end;

          qryRunLines.FieldByName('OriginalExPrice').AsFloat := dPriceEx;
          qryRunLines.FieldByName('Discount').AsFloat := dDiscount;
          dPriceEx := dPriceEx - (dPriceEx * dDiscount);
          qryRunLines.FieldByName('UnitExPrice').AsFloat := dPriceEx;
          dIncPrice := GetAmountInc(dPriceEx, GetTaxRate(qryRunLines.FieldByName('TaxCode').AsString));
          dQty := qryRunLines.FieldByName('Qty').AsFloat;
          dTax := (dIncPrice - dPriceEx) * dQty;
          qryRunLines.FieldByName('TaxAmount').AsFloat := dTax;
          dIncPrice := dIncPrice * dQty;
          qryRunLines.FieldByName('OrderValue').AsFloat := RoundCurrency(dIncPrice);


          qryRunLines.Post;
          qrySpecialProducts.Next;
        end;
      end else begin
        // Just a one line insert.
        qryRunLines.Insert;
        qryRunLines.FieldByName('ClientID').AsInteger := qryMain.FieldByName('ClientID').AsInteger;
        if qryMain.FieldByName('Details').AsInteger = 0 then begin
          qryRunLines.FieldByName('IsContact').AsString := 'F';
        end else begin
          qryRunLines.FieldByName('IsContact').AsString := 'T';
          qryRunLines.FieldByName('ContactID').AsInteger := qryMain.FieldByName('ContactID').AsInteger;
        end;

        qryRunLines.FieldByName('ClientName').AsString := qryMain.FieldByName('Contact').AsString;
        qryRunLines.FieldByName('Company').AsString := qryMain.FieldByName('Company').AsString;
        qryRunLines.FieldByName('Qty').AsFloat := 1;
        qryRunLines.FieldByName('StartDate').AsDateTime := Date;
        qryRunLines.FieldByName('FreqInterval').AsFloat := 1;
        qryRunLines.FieldByName('FreqType').AsString := 'Week(s)';
        MyDelivery.CalcScheduledDates(1, 'Week(s)', Date());

        qryRunLines.FieldByName('NextRunDate').AsDateTime := Date;
        if MyDelivery.ScheduledTimes[1] <> 0 then begin
          qryRunLines.FieldByName('DateAfterNext').AsDateTime := MyDelivery.ScheduledTimes[1];
        end else begin
          qryRunLines.FieldByName('DateAfterNext').AsDateTime := Date;
        end;

        qryRunLines.FieldByName('RunID').AsInteger := RunInfo.RunID;
        qryRunLines.FieldByName('Sequence').AsInteger := iSequence;
        qryRunLines.FieldByName('Phone').AsString := qryMain.FieldByName('Phone').AsString;
        qryRunLines.FieldByName('Mobile').AsString := qryMain.FieldByName('Mobile').AsString;
        qryRunLines.FieldByName('Address').AsString := qryMain.FieldByName('Address').AsString;
        qryRunLines.Post;
      end;
      // Increment our Progress Status Bar.
      MyProgressDialog.StepIt;
      Application.ProcessMessages;
    end;
  finally
    // Free our used objects.
    if Assigned(MyProgressDialog) then
      FreeandNil(MyProgressDialog);
    if Assigned(qryRunLines) then
      FreeandNil(qryRunLines);
    if Assigned(qryParts) then
      FreeandNil(qryParts);
    if Assigned(qrySpecialProducts) then
      FreeandNil(qrySpecialProducts);
    if Assigned(qryCompulsoryProducts) then
      FreeandNil(qryCompulsoryProducts);

    // Return user control.
    qryMain.EnableControls;

    // Refresh query.
    RefreshQuery;
  end;
end;

procedure TRunAssignerGUI.btnUnassignClick(Sender: TObject);
var
  qryDespatchRunLines, qryRunLines, qryDespatch: TMyQuery;
  bDoDespatchAlso: boolean;
  iX, iResult: integer;
  MyProgressDialog: TProgressDialog;
begin
  inherited;
  if grdMain.SelectedList.Count < 1 then begin
    CommonLib.MessageDlgXP_Vista('You must at least pick one record before attempting to unassign runs from customers.  Hold down the Ctrl Key and left click with your mouse to choose customers.',
      mtInformation, [mbOK], 0);
    Exit;
  end;

  iResult := CommonLib.MessageDlgXP_Vista('Do you also want to remove these clients from all incomplete despatch runs?' + #13#10#13#10 + 'Press the OK button to remove from despatch.  Otherwise, please press the CANCEL button to leave despatch entries intact.', mtWarning, [mbOK, mbCancel], 0);

  if iResult = mrCancel then begin
    bDoDespatchAlso := false;
  end else begin
    bDoDespatchAlso := true;
    if FormStillOpen('TfrmRunDespatchGUI') then begin
      // Save the run and terminate window display.
      if TfrmRunDespatchGUI(FindExistingComponent('TfrmRunDespatchGUI')).cmdOK.Enabled then begin
        TfrmRunDespatchGUI(FindExistingComponent('TfrmRunDespatchGUI')).cmdOK.Click;
      end else begin
        TfrmRunDespatchGUI(FindExistingComponent('TfrmRunDespatchGUI')).cmdCancel.Click;
      end;
      Application.ProcessMessages;
    end;
    //    if Assigned(frmRunDespatchGUI) then begin
    //      // Save the run and terminate window display.
    //      if frmRunDespatchGUI.cmdOK.Enabled then begin
    //        frmRunDespatchGUI.cmdOK.Click;
    //      end else begin
    //        frmRunDespatchGUI.cmdCancel.Click;
    //      end;
    //      Application.ProcessMessages;
    //    end;
  end;
  if FormStillOpen('TfrmRunSequencerGUI') then begin
    // Save the run and terminate window display.
    TFrmRunSequencerGUI(FindExistingComponent('TfrmRunSequencerGUI')).cmdOK.Click;
    Application.ProcessMessages;
  end;

  //  if Assigned(frmRunSequencerGUI) then begin
  //    // Save the run and terminate window display.
  //    frmRunSequencerGUI.cmdOK.Click;
  //    Application.ProcessMessages;
  //  end;

  MyProgressDialog := TProgressDialog.Create(nil);
  qryDespatch := TMyQuery.Create(nil);
  qryDespatchRunLines := TMyQuery.Create(nil);
  qryRunLines := TMyQuery.Create(nil);

  try
    qryDespatchRunLines.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryDespatchRunLines.ParamCheck := true;
    qryDespatchRunLines.SQL.Clear;
    qryDespatchRunLines.SQL.Add('DELETE FROM tbldespatchrunlines WHERE ClientID = :xCID AND RunID = :xRunID AND DespatchID = :xDespatchID');

    qryDespatch.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryDespatch.ParamCheck := true;
    qryDespatch.SQL.Clear;
    qryDespatch.SQL.Add('SELECT * FROM tbldespatchruns WHERE InvoicesGenerated = "F"');
    qryDespatch.Open;

    qryRunLines.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryRunLines.ParamCheck := true;
    qryRunLines.SQL.Clear;
    qryRunLines.SQL.Add('DELETE FROM tblrunslines WHERE ClientID = :xCID AND RunID = :xRunID');

    qryMain.DisableControls;
    MyProgressDialog.Caption  := 'Unassigning selected customers from run...';
    MyProgressDialog.MinValue := 0;
    MyProgressDialog.MaxValue := grdMain.SelectedList.Count;
    MyProgressDialog.Step     := 1;
    MyProgressDialog.Value    := 0;
    MyProgressDialog.Execute;
    for iX := 0 to grdMain.SelectedList.Count - 1 do begin
      // Goto Selected Record.
      qryMain.GotoBookmark(grdMain.SelectedList.Items[iX]);

      // Remove client from Template Run lines.
      qryRunLines.Params.ParamByName('xCID').AsInteger := qryMain.FieldByName('ClientID').AsInteger;
      qryRunLines.Params.ParamByName('xRunID').AsInteger := qryMain.FieldByName('RunID').AsInteger;
      qryRunLines.Execute;

      // Are we also including to remove from despatch?
      if bDoDespatchAlso then begin
        qryDespatch.First;
        while not qryDespatch.Eof do begin
          qryDespatchRunLines.Params.ParamByName('xCID').AsInteger := qryMain.FieldByName('ClientID').AsInteger;
          qryDespatchRunLines.Params.ParamByName('xDespatchID').AsInteger :=
            qryDespatch.FieldByName('DespatchID').AsInteger;
          qryDespatchRunLines.Params.ParamByName('xRunID').AsInteger := qryMain.FieldByName('RunID').AsInteger;
          qryDespatchRunLines.Execute;
          qryDespatch.Next;
        end;
      end;

      // Increment our Progress Status Bar.
      MyProgressDialog.StepIt;
      Application.ProcessMessages;
    end;
  finally
    // Free our used objects.
    if Assigned(MyProgressDialog) then
      FreeandNil(MyProgressDialog);
    if Assigned(qryRunLines) then
      FreeandNil(qryRunLines);
    if Assigned(qryDespatch) then
      FreeandNil(qryDespatch);
    if Assigned(qryDespatchRunLines) then
      FreeandNil(qryDespatchRunLines);

    // Return user control.
    qryMain.EnableControls;

    // Refresh query.
    RefreshQuery;
  end;
end;

procedure TRunAssignerGUI.FormCreate(Sender: TObject);
begin
  CheckRunLinesForExistingFields;
  CreateTemporaryTable;
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT * FROM `' + GetTemporaryTableName + '`;');

  inherited;

  MyDelivery := TDeliveryObj.Create;
end;

procedure TRunAssignerGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('Company') + ' ASC CIS';
  BaseIndexFieldNames := qryMain.IndexFieldNames;
end;

procedure TRunAssignerGUI.ClearTemporaryTable;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM `' + GetTemporaryTableName + '`;');
    qry.Execute;
  finally
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TRunAssignerGUI.CreateTemporaryTable;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('CREATE TABLE IF NOT EXISTS `' + GetTemporaryTableName + '` (`ID` INT(11) NOT NULL AUTO_INCREMENT,');
    qry.SQL.Add('`Details` INT (11) DEFAULT "0", `Type` VARCHAR (255), `ClientID` INT (11) DEFAULT "0", `Company` VARCHAR (255), `Contact` VARCHAR (255),');
    qry.SQL.Add('`Address` VARCHAR (255), `Mobile` VARCHAR (255), `Phone` VARCHAR (255),');
    qry.SQL.Add('`Suburb` VARCHAR (255), `PostCode` VARCHAR (32), `ContactID` INT (11) DEFAULT "0",');
    qry.SQL.Add('`RunID` INT (11) DEFAULT "0", `RunName` VARCHAR (255),');
    qry.SQL.Add('PRIMARY KEY(`ID`), UNIQUE(`ID`))  TYPE = InnoDB;');

    // Create temporary table.
    qry.Execute;

  finally
    // Release our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function TRunAssignerGUI.GetTemporaryTableName: string;
begin
  Result := 'tmp_runclientlist_' + GetMachineIdentification(true, true, true, true);
end;

procedure TRunAssignerGUI.PopulateTemporaryTable;
var
  qry: TMyQuery;
  qryRuns: TMyQuery;
  ProgressDialog: TProgressDialog;
begin
  qry := TMyQuery.Create(nil);
  qryRuns := TMyQuery.Create(nil);
  ProgressDialog := TProgressDialog.Create(nil);

  ClearTemporaryTable;

  try
    qryRuns.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryRuns.SQL.Clear;
    qryRuns.SQL.Add('SELECT R.RunID, R.RunName FROM tblruns AS R WHERE R.Active = "T";');
    qryRuns.Open;

    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('INSERT HIGH_PRIORITY INTO `' + GetTemporaryTableName +
      '` (Details, Type, ClientID, ContactID, Company, Contact, Address, Mobile, Phone, Suburb, Postcode, Runname, RunID)');
    qry.SQL.Add('SELECT');
    qry.SQL.Add('0 AS Details,');
    qry.SQL.Add('IF(C.IsJob="T", "Customer Job", "Customer") AS Type,');
    qry.SQL.Add('C.ClientID, 0 AS "ContactID", C.Company,');
    qry.SQL.Add('TRIM(CONCAT_WS(" ", IF(ISNULL(C.Title), "", C.Title), C.Firstname, C.LastName)) AS Contact,');
    qry.SQL.Add('TRIM(LEFT(CONCAT_WS(" ", C.Street, IF(ISNULL(C.Street2), "", C.Street2), IF(ISNULL(C.Suburb), "", C.Suburb),');
    qry.SQL.Add('IF(ISNULL(C.State), "", C.State), IF(ISNULL(C.Postcode), "", C.Postcode),');
    qry.SQL.Add('IF(ISNULL(C.Country), "", C.Country)), 200)) AS Address, C.Mobile, C.Phone,');
    qry.SQL.Add('C.Suburb, C.PostCode, "" AS RunName, 0 AS RunID');
    qry.SQL.Add('FROM tblclients AS C');
    qry.SQL.Add('WHERE C.Active = "T" AND C.Customer = "T"');
    qry.Execute;

    qry.SQL.Clear;
    qry.SQL.Add('INSERT HIGH_PRIORITY INTO `' + GetTemporaryTableName +
      '` (Details, Type, ClientID, ContactID, Company, Contact, Address, Mobile, Phone, Suburb, Postcode, Runname, RunID)');
    qry.SQL.Add('SELECT');
    qry.SQL.Add('1 AS Details,');
    qry.SQL.Add('"Contact" AS Type, C.CusID AS ClientID, C.ContactID, C.Company,');
    qry.SQL.Add('TRIM(CONCAT_WS(" ", IF(ISNULL(C.ContactTitle), "", C.ContactTitle), C.ContactFirstname, C.ContactSurName)) AS Contact,');
    qry.SQL.Add('TRIM(LEFT(CONCAT_WS(" ", C.ContactAddress, IF(ISNULL(C.ContactAddress2), "", C.ContactAddress2),');
    qry.SQL.Add('IF(ISNULL(C.ContactCity), "", C.ContactCity),');
    qry.SQL.Add('IF(ISNULL(C.ContactState), "", C.ContactState), IF(ISNULL(C.ContactPcode), "", C.ContactPcode)), 200)) AS Address, C.ContactMob AS Mobile, C.ContactPh AS Phone,');
    qry.SQL.Add('C.ContactCity AS Suburb, C.ContactPCode AS Postcode, "" AS Runname, 0 AS RunID');
    qry.SQL.Add('FROM tblcontacts AS C');
    qry.SQL.Add('WHERE C.Active = "T" AND C.UseOnRun = "T" AND C.ContactIsCustomer = "F" AND C.ContactIsJob = "F" AND C.ContactIsSupplier = "F" AND ContactIsOtherContact = "F"');
    qry.Execute;

    // Now update temporary table with clients who are related to a run.
    qry.SQL.Clear;
    qry.SQL.Add('UPDATE tblrunslines AS RL');
    qry.SQL.Add('INNER JOIN ' + GetTemporaryTableName + ' AS tmp on tmp.ClientID = RL.ClientID AND RL.ContactID = tmp.ContactID');
    qry.SQL.Add('SET tmp.RunID = RL.RunID;');
    qry.Execute;

    qry.SQL.Clear;
    qry.SQL.Add('UPDATE `' + GetTemporaryTableName + '` AS tmp');
    qry.SQL.Add('INNER JOIN tblruns AS R on tmp.RunID = R.RunID');
    qry.SQL.Add('SET tmp.RunName = R.RunName;');
    qry.Execute;

  finally
    // Release our used objects.
    if Assigned(qry) then FreeAndNil(qry);
    if Assigned(qryRuns) then
      FreeandNil(qryRuns);
    if Assigned(ProgressDialog) then
      FreeandNil(ProgressDialog);
  end;
end;

procedure TRunAssignerGUI.DropTemporaryTable;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `' + GetTemporaryTableName + '`;');
    qry.Execute;
  finally
    // Release our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

initialization
  RegisterClassOnce(TRunAssignerGUI);
end.
