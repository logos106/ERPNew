unit PaymentConformationObj;

interface

uses Classes, Menus, AdvMenus, StdCtrls;

const
  ReviewColour = $00006BD7;
  ApprovedColour = $0000CA00;

type
  TSupPayRec = record
    ClientName: string;
    TransID: integer;
    TransType: string;
    ClientID: integer;
    Amount: double;
  end;

type
  TPaymentConformationObj = class(TComponent)
  private
    ReviewAmountLabel: TLabel;
    ApprovedAmountLabel: TLabel;
    mnuBreak: TMenuItem;
    mnuReview: TMenuItem;
    mnuApprove: TMenuItem;
    mnuApproveClear: TMenuItem;
    mnuApproveAllClear: TMenuItem;
    mnuReviewClear: TMenuItem;
    mnuReviewAllClear: TMenuItem;
    fsTablename:String;
    fOnReviewChange: TNotifyEvent;
    procedure PopupMenuClick(Sender: TObject);
    procedure AddReview(Sender: TMenuItem);
    procedure ClearAllReviews(Sender: TMenuItem);
    procedure ClearReview(Sender: TMenuItem);
    procedure ApprovedReview(Sender: TMenuItem);
    procedure ExecuteSql(const SqlStr: string);
    function GetPurchaseGR(const ID: integer): string;
    (*function GetPurchaseID(const GR: string): integer;*)
    function IsPOApprovedFlagged(const ID: integer): Boolean;
    function GetPrePaymentGR(const ID: integer): string;
    (*function GetPrePaymentID(const GR: string): integer;*)
    function DoubleToCurrString(const d: double): string;
    function GetReviewTotal: double;
    function GetApprovedTotal: double;
    procedure ValidateConformation;
    (*procedure FlagSupPayLine(const SupPayDetails: TSupPayRec; const SuppPayment: TfmSuppPayments);*)
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadPopupMenu(const ModifyPopupMenu: TAdvPopupMenu; const ReviewLabel, ApprovedLabel: TLabel);
    procedure EnablePopupMenu(const Value: boolean);
    function IsStatusReview(const ID: integer; const TransType: string): boolean;
    function IsStatusApproved(const ID: integer; const TransType: string): boolean;
    (*procedure PayApproved;*)
    procedure UpdateTotals;
    property APTablename: string read fsTablename write fsTablename;
    property OnReviewChange: TNotifyEvent read fOnReviewChange write fOnReviewChange;
  end;

implementation

uses FastFuncs,SysUtils,  MyAccess,ERPdbComponents, CommonDBLib, Wwdbgrid, CommonLib,
     DB,  tcDataUtils, Dialogs, Controls, Forms, 
     AppEnvironment, MySQLConst, tcConst;

const
  INSERTSQL = 'INSERT HIGH_PRIORITY INTO tblpaymentconformations (TransGlobalRef, TransType, ClientName, Amount, Status, Active, CreationDate) VALUES ';

  { TPaymentConformationObj }

constructor TPaymentConformationObj.Create(AOwner: TComponent);
begin
  inherited;
  mnuBreak := TMenuItem.Create(Self);
  mnuReview := TMenuItem.Create(Self);
  mnuApprove := TMenuItem.Create(Self);
  mnuApproveClear := TMenuItem.Create(Self);
  mnuApproveAllClear := TMenuItem.Create(Self);
  mnuReviewClear := TMenuItem.Create(Self);
  mnuReviewAllClear := TMenuItem.Create(Self);
  mnuReview.OnClick := PopupMenuClick;
  mnuApprove.OnClick := PopupMenuClick;
  mnuApproveClear.OnClick := PopupMenuClick;
  mnuApproveAllClear.OnClick := PopupMenuClick;
  mnuReviewClear.OnClick := PopupMenuClick;
  mnuReviewAllClear.OnClick := PopupMenuClick;
  mnuBreak.Name := 'Break';
  mnuReview.Name := 'Review';
  mnuApprove.Name := 'Approve';
  mnuApproveClear.Name := 'ApproveClear';
  mnuApproveAllClear.Name := 'ApproveAllClear';
  mnuReviewClear.Name := 'ReviewClear';
  mnuReviewAllClear.Name := 'ReviewAllClear';
  mnuBreak.Caption := '-';
  mnuReview.Caption := 'Review For Payment';
  mnuApprove.Caption := 'Approve For Payment';
  mnuApproveClear.Caption := 'Clear Approval';
  mnuApproveAllClear.Caption := 'Clear All Approvals';
  mnuReviewClear.Caption := 'Clear Review';
  mnuReviewAllClear.Caption := 'Clear All Reviews';
  mnuReview.Enabled := false;
  mnuApprove.Enabled := false;
  mnuApproveClear.Enabled := false;
  mnuApproveAllClear.Enabled := false;
  mnuReviewClear.Enabled := false;
  mnuReviewAllClear.Enabled := false;
end;

destructor TPaymentConformationObj.Destroy;
begin
  FreeAndNil(mnuBreak);
  FreeAndNil(mnuReview);
  FreeAndNil(mnuApprove);
  mnuApproveClear.Free;
  mnuApproveAllClear.Free;
  FreeAndNil(mnuReviewClear);
  FreeAndNil(mnuReviewAllClear);
  inherited;
end;

procedure TPaymentConformationObj.EnablePopupMenu(const Value: boolean);
begin
  mnuReview.Enabled := Value;
  mnuApprove.Enabled := Value;
  mnuApproveClear.Enabled := Value;
  mnuApproveAllClear.Enabled := Value;
  mnuReviewClear.Enabled := Value;
  mnuReviewAllClear.Enabled := Value;
end;

procedure TPaymentConformationObj.LoadPopupMenu(const ModifyPopupMenu: TAdvPopupMenu; const ReviewLabel, ApprovedLabel: TLabel);
begin
  ReviewAmountLabel := ReviewLabel;
  ApprovedAmountLabel := ApprovedLabel;
  ModifyPopupMenu.Items.Add(mnuBreak);
  if (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnPaymentComfirmationAdd') = 1) then
    ModifyPopupMenu.Items.Add(mnuReview);
  if (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnPaymentComfirmationApprove') = 1) then begin
    ModifyPopupMenu.Items.Add(mnuApprove);
    ModifyPopupMenu.Items.Add(mnuApproveClear);
    ModifyPopupMenu.Items.Add(mnuApproveAllClear);
  end;
  if (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnPaymentComfirmationAdd') = 1) then begin
    ModifyPopupMenu.Items.Add(mnuReviewClear);
    ModifyPopupMenu.Items.Add(mnuReviewAllClear);
  end;
end;

procedure TPaymentConformationObj.PopupMenuClick(Sender: TObject);
begin
  if not (Sender is TMenuItem) then
    Exit; 
  TMenuItem(Sender).OnClick := nil;
  try
    if Sysutils.SameText(TMenuItem(Sender).Name, 'Review') then begin
      AddReview(TMenuItem(Sender));
    end else if Sysutils.SameText(TMenuItem(Sender).Name, 'Approve') then begin
      ApprovedReview(TMenuItem(Sender));
    end else if Sysutils.SameText(TMenuItem(Sender).Name, 'ApproveClear') then begin
      ApprovedReview(TMenuItem(Sender));
    end else if Sysutils.SameText(TMenuItem(Sender).Name, 'ApproveAllClear') then begin
      ApprovedReview(TMenuItem(Sender));
    end else if Sysutils.SameText(TMenuItem(Sender).Name, 'ReviewClear') then begin
      ClearReview(TMenuItem(Sender));
    end else if Sysutils.SameText(TMenuItem(Sender).Name, 'ReviewAllClear') then begin
      ClearAllReviews(TMenuItem(Sender));
    end;
  finally
    TMenuItem(Sender).OnClick := PopupMenuClick;
  end;
end;

procedure TPaymentConformationObj.ExecuteSql(const SqlStr: string);
var
  qry: TERPCommand;
begin
  qry := TERPCommand.Create(Self);
  try
    with qry do begin
      Connection := CommonDBLib.GetSharedMyDacConnection;
      qry.SQL.Add(SqlStr);
      try
        qry.Execute;
//        if Assigned(fOnReviewChange) then
//          fOnReviewChange(self);
      except
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TPaymentConformationObj.GetPrePaymentGR(const ID: integer): string;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(Self);
  qryTemp.Options.FlatBuffers := True;
  try
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTemp.Sql.Add('SELECT PrePaymentID, GlobalRef FROM tblprepayments WHERE PrePaymentID =' + IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function TPaymentConformationObj.GetPurchaseGR(const ID: integer): string;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
//  qryTemp.Options.FlatBuffers := True;
  try
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTemp.Sql.Add('SELECT PurchaseOrderID, GlobalRef FROM tblpurchaseorders WHERE PurchaseOrderID =' + IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

(*function TPaymentConformationObj.GetPrePaymentID(const GR: string): integer;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(Self);
  qryTemp.Options.FlatBuffers := True;
  try
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTemp.Sql.Add('SELECT PrePaymentID, GlobalRef FROM tblprepayments WHERE GlobalRef =' + QuotedStr(Trim(GR)) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('PrePaymentID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;*)

(*function TPaymentConformationObj.GetPurchaseID(const GR: string): integer;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(Self);
  qryTemp.Options.FlatBuffers := True;
  try
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTemp.Sql.Add('SELECT PurchaseOrderID, GlobalRef FROM tblpurchaseorders WHERE GlobalRef =' + QuotedStr(Trim(GR)) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('PurchaseOrderID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;*)

function TPaymentConformationObj.IsStatusApproved(const ID: integer; const TransType: string): boolean;
var
  qryTemp: TERPQuery;
  tmpGR: string;
begin
  qryTemp := TERPQuery.Create(Self);
  qryTemp.Options.FlatBuffers := True;
  try
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    if not Sysutils.SameText(TransType, 'Supplier Prepayment') and not Sysutils.SameText(TransType, 'Supplier Payment') and not Empty(TransType) then
      tmpGR := GetPurchaseGR(ID)
    else if Sysutils.SameText(TransType, 'Supplier Prepayment') then
      tmpGR := GetPrePaymentGR(ID);

    qryTemp.Sql.Add('SELECT ID FROM tblpaymentconformations WHERE ');
    qryTemp.Sql.Add('TransGlobalRef = ' + QuotedStr(tmpGR));
    qryTemp.Sql.Add(' AND TransType = ' + QuotedStr(TransType));
    qryTemp.Sql.Add(' AND Active = "T" ');    
    qryTemp.Sql.Add(' AND Status = "A" ;');

    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := true;
    end else begin
      Result := false;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function TPaymentConformationObj.IsStatusReview(const ID: integer; const TransType: string): boolean;
var
  qryTemp: TERPQuery;
  tmpGR: string;
begin
  qryTemp := TERPQuery.Create(Self);
  qryTemp.Options.FlatBuffers := True;
  try
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    if not Sysutils.SameText(TransType, 'Supplier Prepayment') and not Sysutils.SameText(TransType, 'Supplier Payment') and not Empty(TransType) then
      tmpGR := GetPurchaseGR(ID)
    else if Sysutils.SameText(TransType, 'Supplier Prepayment') then
      tmpGR := GetPrePaymentGR(ID);

    qryTemp.Sql.Add('SELECT ID FROM tblpaymentconformations WHERE ');
    qryTemp.Sql.Add('TransGlobalRef = ' + QuotedStr(tmpGR));
    qryTemp.Sql.Add(' AND TransType = ' + QuotedStr(TransType));
    qryTemp.Sql.Add(' AND Active = "T" ');
    qryTemp.Sql.Add(' AND Status = "R" ;');

    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := true;
    end else begin
      Result := false;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TPaymentConformationObj.AddReview(Sender: TMenuItem);
var
  PopupMenu: TAdvPopupMenu;
  Grid: TwwDBGrid;
  i: integer;
begin
  PopupMenu := nil;
  Grid := nil;

  if (Sender.GetParentComponent is TAdvPopupMenu) then
    PopupMenu := TAdvPopupMenu(Sender.GetParentComponent);

  if Assigned(PopupMenu) then
    if (PopupMenu.PopupComponent is TwwDBGrid) then
      Grid := TwwDBGrid(PopupMenu.PopupComponent);

  if not Assigned(Grid) then 
    Exit;

  if (Grid.SelectedList.Count <> 0) then
    for i := 0 to Grid.SelectedList.Count - 1 do begin
      if not Grid.DataSource.DataSet.BookmarkValid(Grid.SelectedList.Items[i]) then 
        Continue;
      Grid.DataSource.DataSet.GotoBookmark(Grid.SelectedList.Items[i]);

      if not Sysutils.SameText(Grid.DataSource.DataSet.FieldByName('Type').AsString, 'Supplier Prepayment') and not Sysutils.SameText(Grid.DataSource.DataSet.FieldByName('Type').AsString, 'Supplier Payment') and
        not Empty(Grid.DataSource.DataSet.FieldByName('Type').AsString) then begin
        ExecuteSql(INSERTSQL + '(' + QuotedStr(GetPurchaseGR(Grid.DataSource.DataSet.FieldByName('PurchaseOrderID').AsInteger)) +
          ',' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Type').AsString) + ',' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Name').AsString) + ',' +
          Grid.DataSource.DataSet.FieldByName('AmountDue').AsString + ',' +
          '"R", "T",' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, Now())) + ')');
        ExecuteSql('UPDATE tblpaymentconformations SET Active= "T", Status="R", ClientName=' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Name').AsString) + ', ' +
          'Amount=' + Grid.DataSource.DataSet.FieldByName('AmountDue').AsString + ' ' +
          'WHERE TransType=' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Type').AsString) +
          ' AND TransGlobalRef=' + QuotedStr(GetPurchaseGR(Grid.DataSource.DataSet.FieldByName('PurchaseOrderID').AsInteger)) + ';');
      end;

      if Sysutils.SameText(Grid.DataSource.DataSet.FieldByName('Type').AsString, 'Supplier Prepayment') then begin
        ExecuteSql(INSERTSQL + '(' + QuotedStr(GetPrePaymentGR(Grid.DataSource.DataSet.FieldByName('PurchaseOrderID').AsInteger)) +
          ',' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Type').AsString) + ',' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Name').AsString) + ',' +
          Grid.DataSource.DataSet.FieldByName('AmountDue').AsString + ',' +
          '"R", "T",' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, Now())) + ')');
        ExecuteSql('UPDATE tblpaymentconformations SET Active= "T", Status="R", ClientName=' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Name').AsString) + ', ' +
          'Amount=' + Grid.DataSource.DataSet.FieldByName('AmountDue').AsString + ' ' +
          'WHERE TransType=' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Type').AsString) +
          ' AND TransGlobalRef=' + QuotedStr(GetPrePaymentGR(Grid.DataSource.DataSet.FieldByName('PurchaseOrderID').AsInteger)) + ';');
      end;
    end;
  UpdateTotals;
  if Assigned(Grid) then begin
    Grid.DataSource.DataSet.Edit;
    Grid.Update;
    Grid.UnselectAll;
  end;
  if Assigned(fOnReviewChange) then
    fOnReviewChange(self);
end;

procedure TPaymentConformationObj.ApprovedReview(Sender: TMenuItem);
var
  PopupMenu: TAdvPopupMenu;
  Grid: TwwDBGrid;
  i: integer;
begin
  PopupMenu := nil;
  Grid := nil;

  if (Sender.GetParentComponent is TAdvPopupMenu) then
    PopupMenu := TAdvPopupMenu(Sender.GetParentComponent);

  if Assigned(PopupMenu) then
    if (PopupMenu.PopupComponent is TwwDBGrid) then
      Grid := TwwDBGrid(PopupMenu.PopupComponent);

  if not Assigned(Grid) then
    Exit;

  if SameText(Sender.Name, 'ApproveAllClear') then begin
    ExecuteSql('UPDATE tblpaymentconformations SET Active= "F" '+
      'where Status = "A"');
    Grid.DataSource.DataSet.Edit;
    Grid.Update;
    Grid.UnselectAll;
    exit;
  end;

  if (Grid.SelectedList.Count <> 0) then
    for i := 0 to Grid.SelectedList.Count - 1 do begin
      if not Grid.DataSource.DataSet.BookmarkValid(Grid.SelectedList.Items[i]) then
        Continue;
      Grid.DataSource.DataSet.GotoBookmark(Grid.SelectedList.Items[i]);

      if SameText(Sender.Name, 'ApproveClear') then begin
        ExecuteSql('UPDATE tblpaymentconformations SET Active= "F" '+
          'WHERE TransType=' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Type').AsString) +
          ' AND TransGlobalRef=' + QuotedStr(GetPurchaseGR(Grid.DataSource.DataSet.FieldByName('PurchaseOrderID').AsInteger)) + ';');
      end
      else begin

        if not Sysutils.SameText(Grid.DataSource.DataSet.FieldByName('Type').AsString, 'Supplier Prepayment') and not Sysutils.SameText(Grid.DataSource.DataSet.FieldByName('Type').AsString, 'Supplier Payment') and
          not Empty(Grid.DataSource.DataSet.FieldByName('Type').AsString) then begin

          If not IsPOApprovedFlagged(Grid.DataSource.DataSet.FieldByName('PurchaseOrderID').AsInteger) then Begin
            CommonLib.MessageDlgXP_Vista('This Transaction ' + NOTAPPROVEDREMINDERDESC +' !'+#13+#10+''+#13+#10+'Therefore will not show in Supplier Payment', mtInformation, [mbOK], 0);
            Exit;
          end;

          ExecuteSql(INSERTSQL + '(' + QuotedStr(GetPurchaseGR(Grid.DataSource.DataSet.FieldByName('PurchaseOrderID').AsInteger)) +
            ',' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Type').AsString) + ',' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Name').AsString) + ',' +
            Grid.DataSource.DataSet.FieldByName('AmountDue').AsString + ',' +
            '"A", "T",' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, Now())) + ')');
          ExecuteSql('UPDATE tblpaymentconformations SET Active= "T", Status="A", ClientName=' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Name').AsString) + ',' +
            'Amount=' + Grid.DataSource.DataSet.FieldByName('AmountDue').AsString + ' ' +
            'WHERE TransType=' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Type').AsString) +
            ' AND TransGlobalRef=' + QuotedStr(GetPurchaseGR(Grid.DataSource.DataSet.FieldByName('PurchaseOrderID').AsInteger)) + ';');
        end;

        if Sysutils.SameText(Grid.DataSource.DataSet.FieldByName('Type').AsString, 'Supplier Prepayment') then begin
          ExecuteSql(INSERTSQL + '(' + QuotedStr(GetPrePaymentGR(Grid.DataSource.DataSet.FieldByName('PurchaseOrderID').AsInteger)) +
            ',' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Type').AsString) + ',' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Name').AsString) + ',' +
            Grid.DataSource.DataSet.FieldByName('AmountDue').AsString + ',' +
            '"A", "T",' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, Now())) + ')');
          ExecuteSql('UPDATE tblpaymentconformations SET Active= "T", Status="A", ClientName=' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Name').AsString) + ',' +
            'Amount=' + Grid.DataSource.DataSet.FieldByName('AmountDue').AsString + ' ' +
            'WHERE TransType=' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Type').AsString) +
            ' AND TransGlobalRef=' + QuotedStr(GetPrePaymentGR(Grid.DataSource.DataSet.FieldByName('PurchaseOrderID').AsInteger)) + ';');
        end;
      end;
    end;
  UpdateTotals;
  if Assigned(Grid) then begin
    Grid.DataSource.DataSet.Edit;
    Grid.Update;
    Grid.UnselectAll;
  end;
  if Assigned(fOnReviewChange) then
    fOnReviewChange(self);
end;

function TPaymentConformationObj.DoubleToCurrString(const d: double): string;
begin
  Result := CurrToStrF(FloatToCurr(d), ffCurrency, 2);
end;

function TPaymentConformationObj.GetApprovedTotal: double;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(Self);
  qryTemp.Options.FlatBuffers := True;
  try
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTemp.Sql.Add('SELECT Sum(Amount) as Total FROM tblpaymentconformations WHERE Status = "A" AND Active = "T";');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('Total').AsFloat;
    end else begin
      Result := 0.00;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function TPaymentConformationObj.GetReviewTotal: double;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(Self);
  qryTemp.Options.FlatBuffers := True;
  try
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTemp.Sql.Add('SELECT Sum(Amount) as Total FROM tblpaymentconformations WHERE Status = "R" AND Active = "T";');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('Total').AsFloat;
    end else begin
      Result := 0.00;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TPaymentConformationObj.UpdateTotals;
begin
  ValidateConformation;
  ReviewAmountLabel.Caption := DoubleToCurrString(GetReviewTotal);
  ApprovedAmountLabel.Caption := DoubleToCurrString(GetApprovedTotal);
end;

(*procedure TPaymentConformationObj.PayApproved;
var
  qryTemp: TERPQuery;
  SuppPayment: TfmSuppPayments;
  SupPayRec: TSupPayRec;
  LastClientName: string;
begin
  if (CommonLib.MessageDlgXP_Vista('This Function will Create # Supplier Payments. Cancelling these'+#13+#10+
      'Payments will also Remove them from the Approved List. '+#13+#10+''+#13+#10+
      'Proceed with Payment of Approved Payments ?', mtInformation, [mbYes, mbNo], 0) = mrNo) then Exit;
  SuppPayment := nil;
  LastClientName := '';
  qryTemp := TERPQuery.Create(Self);
  qryTemp.Options.FlatBuffers := True;
  try
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTemp.Sql.Add('SELECT * FROM tblpaymentconformations WHERE Status = "A" AND Active = "T" ');
    qryTemp.Sql.Add('Order By ClientName');
    qryTemp.Open;
    if (qryTemp.RecordCount > 0) then begin
      qryTemp.First;
      while not qryTemp.Eof do begin
        SupPayRec.ClientName := qryTemp.FieldByName('ClientName').AsString;
        SupPayRec.TransType := qryTemp.FieldByName('TransType').AsString;

        if Sysutils.SameText(SupPayRec.TransType, 'Supplier Prepayment') then
          SupPayRec.TransID := GetPrePaymentID(qryTemp.FieldByName('TransGlobalRef').AsString)
        else
          SupPayRec.TransID := GetPurchaseID(qryTemp.FieldByName('TransGlobalRef').AsString);

        SupPayRec.ClientID := tcDataUtils.GetClientID(SupPayRec.ClientName);
        SupPayRec.Amount := qryTemp.FieldByName('Amount').AsFloat;

        if not Sysutils.SameText(LastClientName, qryTemp.FieldByName('ClientName').AsString) then begin
          while FormStillOpen('TfmSuppPayments', SuppPayment) do begin
            Sleep(250);
            Application.ProcessMessages;
          end;

          SuppPayment := TfmSuppPayments(CommonLib.GetComponentByClassName('TfmSuppPayments'));
          SuppPayment.KeyID := 0;
          SuppPayment.FormStyle := fsMDIChild;
          SuppPayment.BringToFront;
          SuppPayment.Update; 
          // Select the supplier
          if SuppPayment.cboClientlookup.Locate('ClientID', SupPayRec.ClientID, [loCaseInsensitive]) then begin
            if AppEnv.Employee.UseClientAccountNoOnPayments then
              SuppPayment.UseAccNo.Click;
            SuppPayment.tblMaster.Edit;
            SuppPayment.tblMaster.FieldByName('SupplierID').AsInteger := SupPayRec.ClientID;
            SuppPayment.tblMaster.Post;
            SuppPayment.tblMaster.Edit;
            SuppPayment.cboClient.Text := SupPayRec.ClientName;
            SuppPayment.cboClientCloseUp(SuppPayment.cboClient, SuppPayment.cboClient.LookupTable, SuppPayment.tblMaster, true);
            SuppPayment.tblMaster.FieldByName('PaymentDate').AsDateTime := Now;
            SuppPayment.Update;
          end;
          LastClientName := SupPayRec.ClientName;
        end;
        FlagSupPayLine(SupPayRec, SuppPayment);
        qryTemp.Next;
      end;
      ExecuteSql('UPDATE tblpaymentconformations SET Active= "F" WHERE `Status` = "A";');
    end;
  finally
    FreeAndNil(qryTemp);
    UpdateTotals;
  end;
end;*)

(*procedure TPaymentConformationObj.FlagSupPayLine(const SupPayDetails: TSupPayRec; const SuppPayment: TfmSuppPayments);
var
  I: integer;
  Trans_Type: string;
const
  TrnType = 0;
  AmountDue = 8;
  Apply = 15;
  ID = 16;
begin
  for I := 1 to SuppPayment.SubfrmPayments.RowCount - 1 do begin
    Trans_Type := SupPayDetails.TransType;
    if Sysutils.SameText(SupPayDetails.TransType, 'PO') then  
      Trans_Type := 'Purchase Order';
    if Sysutils.SameText(SupPayDetails.TransType, 'Supplier Prepayment') then  
      Trans_Type := 'Prepayment';
    if Sysutils.SameText(SuppPayment.SubfrmPayments.Rows[I].Strings[TrnType], Trans_Type) and
      Sysutils.SameText(SuppPayment.SubfrmPayments.Rows[I].Strings[ID], IntToStr(SupPayDetails.TransID)) then begin
      SuppPayment.AutoIncreasePaymentAmount := true;
      SuppPayment.SubfrmPayments.SetCheckBoxState(Apply, I, true);
      SuppPayment.SubfrmPaymentsCheckBoxClick(nil, Apply, I, true);
      SuppPayment.SubfrmPayments.Refresh;
      Exit;
    end;
  end;
end;*)

procedure TPaymentConformationObj.ClearAllReviews(Sender: TMenuItem);
var
  PopupMenu: TAdvPopupMenu;
  Grid: TwwDBGrid;
begin
  PopupMenu := nil;
  Grid := nil;
  if (Sender.GetParentComponent is TAdvPopupMenu) then
    PopupMenu := TAdvPopupMenu(Sender.GetParentComponent);
  if Assigned(PopupMenu) then
    if (PopupMenu.PopupComponent is TwwDBGrid) then
      Grid := TwwDBGrid(PopupMenu.PopupComponent);
  ExecuteSql('UPDATE tblpaymentconformations SET Active= "F" WHERE `Status` = "R";');
  UpdateTotals;
  if Assigned(Grid) then begin
    Grid.DataSource.DataSet.Edit;
    Grid.Update;
    Grid.UnselectAll;
  end;
  if Assigned(fOnReviewChange) then
    fOnReviewChange(self);
end;

procedure TPaymentConformationObj.ClearReview(Sender: TMenuItem);
var
  PopupMenu: TAdvPopupMenu;
  Grid: TwwDBGrid;
begin
  PopupMenu := nil;
  Grid := nil;
  if (Sender.GetParentComponent is TAdvPopupMenu) then
    PopupMenu := TAdvPopupMenu(Sender.GetParentComponent);

  if Assigned(PopupMenu) then
    if (PopupMenu.PopupComponent is TwwDBGrid) then
      Grid := TwwDBGrid(PopupMenu.PopupComponent);

  if not Assigned(Grid) then 
    Exit;

  if not Sysutils.SameText(Grid.DataSource.DataSet.FieldByName('Type').AsString, 'Supplier Prepayment') and not Sysutils.SameText(Grid.DataSource.DataSet.FieldByName('Type').AsString, 'Supplier Payment') and not Empty(Grid.DataSource.DataSet.FieldByName('Type').AsString) then
  begin
    ExecuteSql('UPDATE tblpaymentconformations SET Active= "F", Status="R", ClientName=' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Name').AsString) + ',' +
      'Amount=' + Grid.DataSource.DataSet.FieldByName('AmountDue').AsString + ' ' +
      'WHERE TransType=' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Type').AsString) +
      ' AND TransGlobalRef=' + QuotedStr(GetPurchaseGR(Grid.DataSource.DataSet.FieldByName('PurchaseOrderID').AsInteger)) + ';');
  end;
  if Sysutils.SameText(Grid.DataSource.DataSet.FieldByName('Type').AsString, 'Supplier Prepayment') then begin
    ExecuteSql('UPDATE tblpaymentconformations SET Active= "F", Status="R", ClientName=' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Name').AsString) + ',' +
      'Amount=' + Grid.DataSource.DataSet.FieldByName('AmountDue').AsString + ' ' +
      'WHERE TransType=' + QuotedStr(Grid.DataSource.DataSet.FieldByName('Type').AsString) +
      ' AND TransGlobalRef=' + QuotedStr(GetPrePaymentGR(Grid.DataSource.DataSet.FieldByName('PurchaseOrderID').AsInteger)) + ';');
  end;
  UpdateTotals;
  if Assigned(Grid) then begin
    Grid.DataSource.DataSet.Edit;
    Grid.Update;
    Grid.UnselectAll;
  end;
  if Assigned(fOnReviewChange) then
    fOnReviewChange(self);
end;

procedure TPaymentConformationObj.ValidateConformation;
begin
 ExecuteSql('Update tblpaymentconformations '+
            'INNER JOIN tblpurchaseorders ON tblpurchaseorders.GlobalRef=tblpaymentconformations.TransGlobalRef '+
            'INNER JOIN `'+fsTablename+'` ON tblpurchaseorders.PurchaseOrderID=`'+fsTablename+'`.PurchaseOrderID '+
            'AND `'+fsTablename+'`.AmountDue <> tblpaymentconformations.Amount AND Type != "Supplier Prepayment" '+
            'Set tblpaymentconformations.Active = "F" '+
            'WHERE tblpaymentconformations.TransType!= "Supplier Prepayment";');

 ExecuteSql('Update tblpaymentconformations '+
            'INNER JOIN tblprepayments ON tblprepayments.GlobalRef=tblpaymentconformations.TransGlobalRef '+
            'INNER JOIN `'+fsTablename+'` ON tblprepayments.PrePaymentID=`'+fsTablename+'`.PurchaseOrderID '+
            'AND `'+fsTablename+'`.AmountDue <> tblpaymentconformations.Amount AND Type = "Supplier Prepayment" '+
            'Set tblpaymentconformations.Active = "F" '+
            'WHERE tblpaymentconformations.TransType= "Supplier Prepayment";');
end;

function TPaymentConformationObj.IsPOApprovedFlagged(const ID: integer): Boolean;
var
  qryTemp: TERPQuery;
begin
  Result := False;
  if not AppEnv.CompanyPrefs.POOnlyApprovedTransInSuppPayment then Begin
    Result := True;
    Exit;
  end;
  qryTemp := TERPQuery.Create(Self);
  qryTemp.Options.FlatBuffers := True;
  try
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTemp.Sql.Add('SELECT PurchaseOrderID, Approved FROM tblpurchaseorders WHERE PurchaseOrderID =' + IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('Approved').AsBoolean;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

end.
