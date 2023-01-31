unit frmStSTransferPackage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmStSInputBase, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, Shader, DNMSpeedButton, DNMPanel, StdCtrls, wwdblook,
  DBCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb, ComCtrls, AdvDateTimePicker,
  AdvDBDateTimePicker, Grids, Wwdbigrd, Wwdbgrid, DAScript, MyScript,
  wwdbdatetimepicker;

type
  TTransferLineItem = record
    LineID:       Integer;
    TransferID:   Integer;
    PackageID:    Integer;
    TagID:        Integer;
    StsTag:       string;
    StSProductId: Integer;
  end;

  TTransferLineItems = array of TTransferLineItem;

  TTransferMode = (trmdNewOut, trmdOut, trmdIn);

  TUseCase = (useChecked, useUnchecked);

  TfmStSTransferPackage = class(TfmStSInputBase)
    pnlDest: TDNMPanel;
    lbDestination: TLabel;
    lookupDestination: TwwDBLookupCombo;
    lbRoute: TLabel;
    dbmmoRoute: TDBMemo;
    lbTransferType: TLabel;
    cbbTransferType: TwwDBComboBox;
    lbEstDeparture: TLabel;
    lbEstArrival: TLabel;
    pnlSource: TDNMPanel;
    lbSource: TLabel;
    lookupSource: TwwDBLookupCombo;
    lbDriver: TLabel;
    lookupDriver: TwwDBLookupCombo;
    lbVehicle: TLabel;
    lookupVehicle: TwwDBLookupCombo;
    lbEmployeeID: TLabel;
    lbDriverLic: TLabel;
    lbDriverPhone: TLabel;
    lbVehicleMake: TLabel;
    lbVehicleModel: TLabel;
    lbVehiclePlate: TLabel;
    pnlPackageTitle: TDNMPanel;
    wdbgrdPackages: TwwDBGrid;
    dsPackages: TDataSource;
    qryTransfer: TERPQuery;
    qryPackages: TERPQuery;
    dsTransfer: TDataSource;
    qryDriver: TERPQuery;
    dsDriver: TDataSource;
    qryVehicle: TERPQuery;
    dsVehicle: TDataSource;
    qryDepartment: TERPQuery;
    qryDepartmentClassID: TIntegerField;
    qryDepartmentClassName: TWideStringField;
    scrptMain: TERPScript;
    qryDriverEmployeeID: TIntegerField;
    qryDriverName: TWideStringField;
    qryDriverDriverLic: TWideStringField;
    qryDriverDriverPhone: TWideStringField;
    qryVehicleVehicleMake: TWideStringField;
    qryVehicleVehicleModel: TWideStringField;
    qryVehicleVehiclePlate: TWideStringField;
    qryVehicleConcatData: TWideStringField;
    qryVehicleVehicleID: TIntegerField;
    edtEmployeeID: TEdit;
    edtDriverLic: TEdit;
    edtDriverPhone: TEdit;
    edtVehicleMake: TEdit;
    edtVehicleModel: TEdit;
    edtVehiclePlate: TEdit;
    btnAddDriver: TDNMSpeedButton;
    btnAddVehicle: TDNMSpeedButton;
    qryPackagesID: TIntegerField;
    qryPackagesPackageID: TIntegerField;
    qryPackagesDeptID: TIntegerField;
    qryPackagesStsTag: TWideStringField;
    qryPackagesPackageName: TWideStringField;
    qryPackagesPackageDate: TDateTimeField;
    qryPackagesCheck: TBooleanField;
    qryPackagesTagID: TIntegerField;
    qryPackagesStSProductId: TIntegerField;
    chkDone: TDBCheckBox;
    dbdtmEstDeparture: TwwDBDateTimePicker;
    dbdtmEstArrival: TwwDBDateTimePicker;
    qryPackagesTransferID: TIntegerField;
    qryPackagesLineID: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lookupDriverChange(Sender: TObject);
    procedure lookupVehicleChange(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure lookupSourceCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnAddDriverClick(Sender: TObject);
    procedure btnAddVehicleClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FMode: TTransferMode;
    FTransferID: Integer;
  private
    ///<returns> The TTransferLineItem array. Contains information for each Package the user chooses to put in a Transfer  </returns>
    function GetLineItems(const aUseCase: TUseCase = useChecked): TTransferLineItems;
    ///<returns> True if form displays data of existing transfer  </returns>
    function IsReadOnly: Boolean;
    ///<returns> True if transfer receipt confirmed </returns>
    function IsComplete: Boolean;
  private
    ///<summary> Creates temp table like tblStsTransferPackage, opens qryTransfer  </summary>
    procedure PrepareTransferQry;
    ///<summary> Creates temp table like tblStsTransferPackageLines, opens qryPackages  </summary>
    procedure PrepareTransferLinesQry;
    ///<summary> Creates temp table, opens qryDriver  </summary>
    procedure PrepareDriverQry;
    ///<summary> Creates temp table, opens qryVehicle  </summary>
    procedure PrepareVehicleQry;
    ///<summary> Shows a progress bar while the query is running </summary>
    procedure ExecutewithProgress(AllowCancel:Boolean=False);
    ///<summary> Opens qryPackages for display in Packages grid </summary>
    procedure OpenDetails;
    ///<summary> Confirms receipt of Transfer  </summary>
    procedure ReceiveTransfer;
    ///<summary> Saves Transfer data in tblStsTransferPackage and tblStsTransferPackageLines </summary>
    procedure RegisterTransfer;
    ///<summary> Changes 'Enabled', 'Readonly' property of controls depending on Mode value  </summary>
    procedure UpdateReadOnly;
    ///<summary> Updates visibilty and captions of detail grid depending on Mode value </summary>
    procedure UpdateDetailGridView;
    ///<summary> Changes captions of controls depending on Mode value  </summary>
    procedure UpdateView;
  public
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; AMode: TTransferMode; const ATransferID: Integer); overload;
  end;

{TODO -oIgor: The Metrc documentation says about Transfer Type
             "The Transfer Type Drop Down specifies the kind of transfer you are performing. Please
              see your State Supplemental for details on your transfer types. Please see your State's
              rules and regulations as to the type of transfers that are allowed for your license type."

              Currently, cbbTransferType uses a predefined list of test items. You need to clarify
              what Transfer Types can be and implement the correct list of items in the cbbTransferType.  }

implementation

{$R *.dfm}

uses
  CommonLib, CommonDbLib, LogLib, tcConst, StringUtils, BusObjSeedToSale, StSConst, frmStsDriver, frmStSVehicle,
  StsUtils;


procedure TfmStSTransferPackage.PrepareDriverQry;
var
  sErrorMsg, sTableName: string;
begin
  try
    sErrorMsg  := '';
    sTableName := CommonDbLib.GetUserTemporaryTableName('StsDriver');
    Logtext('TfmStSTransferPackage.PrepareDriverQry temp_table: ' + sTableName,'', True);

    CloseDB(qryDriver);
    with qryDriver do begin
      SQL.Clear;
      SQL.Add(Format('SELECT * FROM %s ORDER BY Name;', [sTableName]));
    end;

    // create temp table
    CommonDbLib.ExecuteDBCommand(Format(
      'DROP TABLE if EXISTS %s; ' +
      'CREATE TABLE `%s` (' +
      '`ID` INT(11) NOT NULL AUTO_INCREMENT,' +
      '`EmployeeID` INT(11) NOT NULL DEFAULT 0,' +
      '`Name` VARCHAR(255) NULL DEFAULT NULL,' +
      '`DriverLic` VARCHAR(255) NULL DEFAULT NULL,' +
      '`DriverPhone` VARCHAR(255) NULL DEFAULT NULL,' +
      'PRIMARY KEY (`ID`) USING BTREE' +
      ');',
      [sTableName, sTableName]), sErrorMsg);

    if Length(sErrorMsg) > 0 then
      Logtext(Format('TfmStSTransferPackage.PrepareDriverQry error: %s', [sErrorMsg]),'', True);

    // Binny said: "MY SUGGESTION IS TO USE EMPLOYEE FOR DRIVER AND FIXED ASSET FOR VERHICLE . MAY BE, INTRODUCE NEW FLAGS/TABLE IF REQUIRED"

    // Populate temp table
    scrptMain.SQL.text := Format(
      'INSERT INTO %s (EmployeeID, Name, DriverLic, DriverPhone) ' +
      'SELECT EmployeeID, CONCAT_WS(" ", FirstName, MiddleName, LastName) AS Name, COALESCE(CUSTFLD1, "") AS DriverLic, COALESCE(Mobile, Phone, AltPhone, "") AS DriverPhone ' +
      'FROM tblemployees WHERE COALESCE(CUSTFLD2, "")="ISDRIVER"  ORDER BY EmployeeID;', [sTableName]);
    ExecutewithProgress;

    OpenDB(qryDriver);
  except
    on E: Exception do
      Logtext(Format('TfmStSTransferPackage.PrepareDriverQry exception: [%s] %s', [E.Classname, E.Message]),'', True);
  end;
end;

procedure TfmStSTransferPackage.PrepareTransferLinesQry;
var
  sErrorMsg, sTableName, sExecQry, sWhere: string;
  tmpExecQry: TERPQuery;
begin
  try
    sErrorMsg  := '';
    sTableName := CommonDbLib.GetUserTemporaryTableName('StsTransfLines');
    Logtext('TfmStSTransferPackage.PrepareTransferLinesQry temp_table: ' + sTableName,'', True);

    sWhere := '';
    with qryPackages.SQL do begin
      Clear;
      if FMode = trmdNewOut then sWhere := 'WHERE DeptID=:DeptID';
      Add(Format('SELECT * FROM %s %s;', [sTableName, sWhere]));
    end;

    // Qry to edit 'Checked' field in dbgrid
    with qryPackages.SQLUpdate do begin
      Clear;
      Add(Format('UPDATE %s AS T SET T.Checked=:Checked WHERE T.ID=:ID;', [sTableName]));
    end;

    // create temp table
    CommonDbLib.ExecuteDBCommand(Format(
      'DROP TABLE if EXISTS %s; ' +
      'CREATE TABLE `%s` (' +
      '`ID` INT(11) NOT NULL AUTO_INCREMENT,' +
      '`LineID` INT(11) NOT NULL DEFAULT 0,' +
      '`TransferID` INT(11) NOT NULL DEFAULT 0,' +
      '`PackageID` INT(11) NOT NULL DEFAULT 0,' +
      '`DeptID` INT(11) NOT NULL DEFAULT 0,' +
      '`TagID` INT(11) NOT NULL DEFAULT 0,' +
      '`StSProductId` INT(11) NOT NULL DEFAULT 0,' +
      '`StsTag` VARCHAR(255) NOT NULL DEFAULT "",' +
      '`PackageName` VARCHAR(255) NULL DEFAULT NULL,' +
      '`PackageDate` DATETIME NOT NULL,' +
      'PRIMARY KEY (`ID`) USING BTREE);' +
      'ALTER TABLE %s ADD COLUMN `Checked` TINYINT(1) NOT NULL DEFAULT 0;',
      [sTableName, sTableName, sTableName]), sErrorMsg);

    if Length(sErrorMsg) > 0 then
      Logtext(Format('TfmStSTransferPackage.PrepareTransferLinesQry error: %s', [sErrorMsg]),'', True);

    // Populate temp table
    case FMode of
      trmdNewOut:      // new Outgoing transfer
         sExecQry := 'INSERT INTO %s (LineID, TransferID, PackageID, DeptID,   TagID, StSProductId,   StsTag,   PackageName,   PackageDate) ' +
                     'SELECT          0,      0,          P.ID,      S.DeptID, S.ID,  S.TagProductID, S.StsTag, P.PackageName, P.PackageDate ' +
                     'FROM tblstspackage P INNER JOIN tblststags S ON P.StsTagsID = S.ID ' +
                     'WHERE (P.ParentPkgID = 0) AND (P.Done = "T") AND (S.TagProductID= :TagProductID) ' +
                     'ORDER BY P.ID;';
      trmdOut, trmdIn: // Existing transfers
         sExecQry := 'INSERT INTO %s (LineID, TransferID,    PackageID, DeptID,   TagID, StSProductId,   StsTag,   PackageName,   PackageDate,   Checked) ' +
                     'SELECT          TL.ID,  TL.TransferID, P.ID,      S.DeptID, S.ID,  S.TagProductID, S.StsTag, P.PackageName, P.PackageDate, (COALESCE(TL.Rejected, "F") = "T") AS Rejected ' +
                     'FROM tblstspackage P INNER JOIN tblststags S ON P.StsTagsID = S.ID ' +
                     '                     INNER JOIN tblststransferpackagelines TL ON P.ID = TL.PackageID ' +
                     'WHERE (S.TagProductID= :TagProductID) AND  (TL.TransferID= :TransferID) ' +
                     'ORDER BY P.ID;';
    end;

    tmpExecQry := TERPQuery.Create(nil);
    try
      with tmpExecQry do begin
        Connection := MyConnection;
        SQL.Text   := Format(sExecQry, [sTableName]);

        Params[0].AsInteger := TStSPackage.ProductID;

        case FMode of
          trmdOut, trmdIn:
            Params[1].AsInteger := FTransferID;
        end;
        Execute;
      end;
    finally
      FreeAndNil(tmpExecQry);
    end;

  except
    on E: Exception do
      Logtext(Format('TfmStSTransferPackage.PrepareTransferLinesQry exception: [%s] %s', [E.Classname, E.Message]),'', True);
  end;
end;

procedure TfmStSTransferPackage.PrepareTransferQry;
var
  sErrorMsg, sTableName, sSQL: string;
begin
  try
    sErrorMsg  := '';

    case FMode of
      trmdNewOut: // in case New transfer use empty temp table
        sTableName := CommonDbLib.GetUserTemporaryTableName('StsTransferPkg');

      trmdOut, trmdIn: // in case Existing transfer use real table
        sTableName := 'tblststransferpackage';
    end;


    // in case New transfer create temp table like tblStsTransferPackage
    if FMode = trmdNewOut then
    begin
      Logtext('TfmStSTransferPackage.PrepareTransferQry temp_table: ' + sTableName,'', True);

      CommonDbLib.ExecuteDBCommand(Format(
        'DROP TABLE IF EXISTS %s; ' +
        'CREATE TABLE %s LIKE tblststransferpackage; ',
        [sTableName, sTableName]), sErrorMsg);

      if Length(sErrorMsg) > 0 then
        Logtext(Format('TfmStSTransferPackage.PrepareTransferQry error: %s', [sErrorMsg]),'', True);
    end;

    case FMode of
      trmdNewOut:      sSQL := Format('SELECT *, (Done="T") AS Completed FROM %s;',             [sTableName]);
      trmdOut, trmdIn: sSQL := Format('SELECT *, (Done="T") AS Completed FROM %s WHERE ID=%d;', [sTableName, FTransferID]);
    end;

    qryTransfer.SQL.Text := sSQL;
    OpenDB(qryTransfer);


    if FMode = trmdNewOut then begin
      qryTransfer.Insert; // Make controls editable
      qryTransfer.FieldByName('EstDeparture').AsDateTime := Now;
      qryTransfer.FieldByName('EstArrival').AsDateTime   := Now + 1/24;
    end;

  except
    on E: Exception do
      Logtext(Format('TfmStSTransferPackage.PrepareTransferQry exception: [%s] %s', [E.Classname, E.Message]),'', True);
  end;
end;

procedure TfmStSTransferPackage.PrepareVehicleQry;
var
  sErrorMsg, sTableName: string;
begin
  try
    sErrorMsg  := '';
    sTableName := CommonDbLib.GetUserTemporaryTableName('StsVehicle');
    Logtext('TfmStSTransferPackage.PrepareVehicleQry temp_table: ' + sTableName,'', True);

    CloseDB(qryVehicle);
    with qryVehicle do begin
      SQL.Clear;
      SQL.Add(Format('SELECT * FROM %s ORDER BY ConcatData;', [sTableName]));
    end;

    // create temp table
    CommonDbLib.ExecuteDBCommand(Format(
      'DROP TABLE if EXISTS %s; ' +
      'CREATE TABLE `%s` (' +
      '`ID` INT(11) NOT NULL AUTO_INCREMENT,' +
      '`VehicleID` INT(11) NOT NULL DEFAULT 0,' +
      '`VehicleMake` VARCHAR(255) NULL DEFAULT NULL,' +
      '`VehicleModel` VARCHAR(255) NULL DEFAULT NULL,' +
      '`VehiclePlate` VARCHAR(255) NULL DEFAULT NULL,' +
      '`ConcatData` VARCHAR(255) NULL DEFAULT NULL,' +
      'PRIMARY KEY (`ID`) USING BTREE' +
      ');',
      [sTableName, sTableName]), sErrorMsg);

    if Length(sErrorMsg) > 0 then
      Logtext(Format('TfmStSTransferPackage.PrepareVehicleQry error: %s', [sErrorMsg]),'', True);

    // Binny said: "MY SUGGESTION IS TO USE EMPLOYEE FOR DRIVER AND FIXED ASSET FOR VERHICLE . MAY BE, INTRODUCE NEW FLAGS/TABLE IF REQUIRED"

    // Populate temp table
    scrptMain.SQL.text := Format(
      'INSERT INTO %s (VehicleID, VehicleMake, VehicleModel, VehiclePlate, ConcatData) ' +
      'SELECT AssetID, COALESCE(Manufacture, "") AS Manufacture, COALESCE(Model, "") AS Model, COALESCE(Serial, "") AS Serial, CONCAT_WS(" ", Manufacture, Model, Serial) AS ConcatData ' +
      'FROM tblfixedassets ' +
      'WHERE PartName="STSVEHICLE" ' +
      'ORDER BY Manufacture;', [sTableName]);
    ExecutewithProgress;

    OpenDB(qryVehicle);
  except
    on E: Exception do
      Logtext(Format('TfmStSTransferPackage.PrepareVehicleQry exception: [%s] %s', [E.Classname, E.Message]),'', True);
  end;
end;

procedure TfmStSTransferPackage.ReceiveTransfer;
var
  I: Integer;
  stsTransfer: TStsPkgTransfer;
  lineItems, rejectedItems: TTransferLineItems;
  tmpLines: TStSPkgTransferLines;
begin
  try
    BeginTransaction;
    stsTransfer := TStsPkgTransfer.CreateWithSharedConn(nil);
    try
      tmpLines := nil;

      // save Rejected lines
      rejectedItems := GetLineItems(useChecked);
      if Length(rejectedItems) > 0 then begin

        stsTransfer.Load(rejectedItems[0].TransferID); // all lines have the same TransferID
        tmpLines := stsTransfer.Lines;

        tmpLines.First;
        while not tmpLines.EOF do begin
          for I := Low(rejectedItems) to High(rejectedItems) do begin
            if rejectedItems[I].LineID = tmpLines.ID then begin
              tmpLines.Rejected := 'T';
              tmpLines.PostDB;
              Break;
            end;
          end;
          tmpLines.Next;
        end;
      end;

      // process Unchecked Lines
      lineItems := GetLineItems(useUnchecked); // array of Package data to receive

      if Length(lineItems) = 0 then Exit;
      Assert(Length(lineItems) > 0, 'Length(lineItems) > 0');

      if tmpLines = nil then begin // no Rejected lines so tmpLines was not initialized
        stsTransfer.Load(lineItems[0].TransferID); // all lines have the same TransferID
        tmpLines := stsTransfer.Lines;
      end;

      // first prepare transaction for Source Department
      tmpLines.First;
      while not tmpLines.EOF do begin
        for I := Low(lineItems) to High(lineItems) do begin
          if lineItems[I].LineID = tmpLines.ID then begin
            with tmpLines.StSTagObj do begin // StSTagObj is TStsTags instance for each record in stsTransfer.Lines
              DeptID := qryTransfer.FieldByName('SourceDeptID').AsInteger;
              PostDB;
            end;
            Break;
          end;
        end;
        tmpLines.Next; // process all records in stsTransfer.Lines
      end;

      stsTransfer.Save;  // make inventory transactions for Source Department


      // then prepare transaction for Destination Department
      tmpLines.First;
      while not tmpLines.EOF do begin
        for I := Low(lineItems) to High(lineItems) do begin
          if lineItems[I].LineID = tmpLines.ID then begin
            with tmpLines.StSTagObj do begin // StSTagObj is TStsTags instance for each record in stsTransfer.Lines
              DeptID := qryTransfer.FieldByName('DestDeptID').AsInteger;
              PostDB;
            end;
            Break;
          end;
        end;
        tmpLines.Next; // process all records in stsTransfer.Lines
      end;

      stsTransfer.Save;  // make inventory transactions for Destination Department


      with stsTransfer do begin
        Done := 'T'; // mark Transfer as Finished
        PostDB;
      end;

      CommitTransaction;
      MessageDlgXP_Vista('Transfer is received', mtInformation, [mbOK], 0);
    finally
      FreeAndNil(stsTransfer);
    end;
  except
    on E: Exception do
    begin
      RollbackTransaction;
      MessageDlgXP_Vista('Failed to receive transfer', mtError, [mbOK], 0);
      Logtext(Format('TfmStSTransferPackage.RegisterTransfer exception: [%s] %s', [E.Classname, E.Message]),'', True);
    end;
  end;
end;

procedure TfmStSTransferPackage.RegisterTransfer;
var
  I: Integer;
  stsTransfer: TStsPkgTransfer;
  lineItems: TTransferLineItems;
begin
  try
    BeginTransaction;
    stsTransfer := TStsPkgTransfer.CreateWithSharedConn(nil);
    try
      with stsTransfer do begin
        New;
        SourceDeptID := qryTransfer.FieldByName('SourceDeptID').AsInteger;
        DestDeptID   := qryTransfer.FieldByName('DestDeptID'  ).AsInteger;
        TransferType := qryTransfer.FieldByName('TransferType').AsString;
        Route        := qryTransfer.FieldByName('Route'       ).AsString;
        DriverID     := qryTransfer.FieldByName('DriverID'    ).AsInteger;
        VehicleID    := qryTransfer.FieldByName('VehicleID'   ).AsInteger;
        Done         := 'F';

        if qryTransfer.FieldByName('EstDeparture').IsNull then EstDeparture := Now
        else EstDeparture := qryTransfer.FieldByName('EstDeparture').AsDateTime;

        if qryTransfer.FieldByName('EstArrival').IsNull   then EstArrival :=   Now
        else EstArrival   := qryTransfer.FieldByName('EstArrival'  ).AsDateTime;

        if ValidateData then
          PostDB
        else begin
          RollbackTransaction;
          Exit;
        end;
      end;


      // process Lines
      lineItems := GetLineItems(useChecked); //array of Package data selected by user to place them in Transfer

      for I := Low(lineItems) to High(lineItems) do begin
        with stsTransfer.Lines do begin
          New;
          PackageID    := lineItems[I].PackageID;
          TagID        := lineItems[I].TagID;
          StSProductId := lineItems[I].StSProductId;
          UOMQty       := 1;
          StSActionID  := TStSTags.NewStsAction(STS_ACTION_TRANSFER_PACKAGES);
          PostDB;
        end;
      end;

      CommitTransaction;
      MessageDlgXP_Vista('Transfer is registered', mtInformation, [mbOK], 0);
    finally
      FreeAndNil(stsTransfer);
    end;
  except
    on E: Exception do
    begin
      RollbackTransaction;
      MessageDlgXP_Vista('Failed to register transfer', mtError, [mbOK], 0);
      Logtext(Format('TfmStSTransferPackage.RegisterTransfer exception: [%s] %s', [E.Classname, E.Message]),'', True);
    end;
  end;
end;

procedure TfmStSTransferPackage.UpdateDetailGridView;
begin
  wdbgrdPackages.ReadOnly := IsReadOnly;

  case FMode of
    trmdOut:
      begin
        wdbgrdPackages.UseTFields := False;
        with wdbgrdPackages.Selected do begin
          Clear;
          Add('Checked' + #9 + '8' + #9 + 'Rejected' + #9 + 'T' + #9);
          Add('PackageID' + #9 + '10' + #9 + 'PackageID' + #9 + 'T' + #9); // FieldName #9 Width #9 Title #9 ReadOnly(T/F) #9
          Add('StsTag' + #9 + '30' + #9 + 'StsTag' + #9 + 'T' + #9);
          Add('PackageName' + #9 + '50' + #9 + 'PackageName' + #9 + 'T' + #9);
          Add('PackageDate' + #9 + '18' + #9 + 'PackageDate' + #9 + 'T' + #9);
        end;
      end;

    trmdIn:
      begin
        wdbgrdPackages.UseTFields := False;
        with wdbgrdPackages.Selected do begin
          Clear;
          wdbgrdPackages.ReadOnly := IsComplete;
          if IsComplete then
            Add('Checked' + #9 + '8' + #9 + 'Rejected' + #9 + 'T' + #9) // if is complete then "Reject" is ReadOnly
          else
            Add('Checked' + #9 + '6' + #9 + 'Reject' + #9 + 'F' + #9);

          Add('PackageID' + #9 + '10' + #9 + 'PackageID' + #9 + 'T' + #9);
          Add('StsTag' + #9 + '30' + #9 + 'StsTag' + #9 + 'T' + #9);
          Add('PackageName' + #9 + '50' + #9 + 'PackageName' + #9 + 'T' + #9);
          Add('PackageDate' + #9 + '18' + #9 + 'PackageDate' + #9 + 'T' + #9);
        end;
      end;

    trmdNewOut:; // do nothing because there are "Selected" in dfm
  end;

end;

procedure TfmStSTransferPackage.UpdateReadOnly;
var
  bReadonly, bEnabled : Boolean;
begin
  bReadonly := IsReadOnly;

  btnAddDriver.Enabled       := not bReadonly;
  btnAddVehicle.Enabled      := not bReadonly;
  dbdtmEstDeparture.Enabled  := not bReadonly;
  dbdtmEstArrival.Enabled    := not bReadonly;

  dbdtmEstDeparture.ReadOnly := bReadonly;
  dbdtmEstArrival.ReadOnly   := bReadonly;
  lookupDestination.ReadOnly := bReadOnly;
  lookupSource.ReadOnly      := bReadOnly;
  lookupDriver.ReadOnly      := bReadOnly;
  lookupVehicle.ReadOnly     := bReadOnly;
  cbbTransferType.ReadOnly   := bReadOnly;
  dbmmoRoute.ReadOnly        := bReadOnly;

  // Register/Receive button Enabled
  bEnabled := qryPackages.Active and (qryPackages.RecordCount > 0);

  case FMode of
    trmdOut: bEnabled := False;
    trmdIn:  bEnabled := bEnabled and qryTransfer.Active and SameText('F', qryTransfer.FieldByName('Done').AsString);
  end;

  btnCompleted.Enabled := bEnabled;

  // detail grid Enabled
  wdbgrdPackages.Enabled := bEnabled;
end;

procedure TfmStSTransferPackage.UpdateView;
begin
  // Captions
  case FMode of
    trmdNewOut:
      Title := 'New Transfer';

    trmdOut: begin
      Title := Format('Transfer #%d (outgoing)', [FTransferID]);
      pnlPackageTitle.Caption := '';
    end;

    trmdIn: begin
      Title := Format('Transfer #%d (incoming)', [FTransferID]);
      btnCompleted.Caption := '&Receive';

      if IsComplete then
        pnlPackageTitle.Caption := ''
      else
        pnlPackageTitle.Caption := 'Check the boxes to select packages to Reject from transfer';
    end;
  end;

end;

procedure TfmStSTransferPackage.btnAddDriverClick(Sender: TObject);
var
  frmDriver: TfrmStsDriverInfo;
begin
  inherited;
  frmDriver := TfrmStsDriverInfo.Create(nil);
  try
    if lookupDriver.Value <> '' then
      frmDriver.KeyID := StrToInt(lookupDriver.Value);
    frmDriver.ShowModal;
    PrepareDriverQry;
    lookupDriverChange(lookupDriver);
  finally
    FreeAndNil(frmDriver);
  end;
end;

procedure TfmStSTransferPackage.btnAddVehicleClick(Sender: TObject);
var
  frmVehicle: TfmStsVehicle;
begin
  inherited;
  frmVehicle := TfmStsVehicle.Create(nil);
  try
    if lookupVehicle.Value <> '' then
      frmVehicle.KeyID := StrToInt(lookupVehicle.Value);
    frmVehicle.ShowModal;
    PrepareVehicleQry;
    lookupVehicleChange(lookupVehicle);
  finally
    FreeAndNil(frmVehicle);
  end;
end;

procedure TfmStSTransferPackage.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmStSTransferPackage.btnCompletedClick(Sender: TObject);
var
  useCase: TUseCase;
begin
  inherited;

  useCase := useChecked;
  case FMode of
    trmdNewOut: useCase := useChecked;
    trmdIn:     useCase := useUnchecked;
  end;

  // check if the user has selected at least one Package
  if Length(GetLineItems(useCase)) = 0 then begin

    if FMode = trmdNewOut then
      MessageDlgXP_Vista('To create a transfer, you need to select at least one package', mtWarning, [mbOK], 0);

    if FMode = trmdIn then
      MessageDlgXP_Vista('To receive a transfer, you need to accept at least one package', mtWarning, [mbOK], 0);

    Exit;
  end;

  if FMode = trmdIn then
    if MessageDlgXP_Vista('Do you agree to receive this transfer?', mtConfirmation, [mbOK, mbCancel], 0) = mrCancel then Exit;

  // check if all fields of the Transfer are filled
  if not IsExistsEmptyControls(Self) then begin
    case FMode of
      trmdNewOut: RegisterTransfer;
      trmdIn:     if not IsComplete then ReceiveTransfer;
    end;

    Close;
  end;
end;

constructor TfmStSTransferPackage.Create(AOwner: TComponent);
begin
  inherited;
  FMode := trmdNewOut;
end;

constructor TfmStSTransferPackage.Create(AOwner: TComponent; AMode: TTransferMode; const ATransferID: Integer);
begin
  Create(AOwner);

  FMode       := AMode;
  FTransferID := ATransferID;
end;

procedure TfmStSTransferPackage.ExecutewithProgress(AllowCancel: Boolean);
begin
  with scrptMain do begin
    Processingcursor(True);
    try
      ShowProgressbar(WAITMSG, strCount(';' , SQL.Text));
      try
        Execute;
      finally
        HideProgressbar;
      end;
    finally
      ProcessingCursor(False);
    end;
  end;
end;

procedure TfmStSTransferPackage.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmStSTransferPackage.FormCreate(Sender: TObject);
var
  fmtSettings: TFormatSettings;
begin
  inherited;
  Title := 'New Transfer';
  FormColor := $0091C8FF;

  fmtSettings := TFormatSettings.Create;
  dbdtmEstDeparture.DisplayFormat := fmtSettings.ShortDateFormat + ' ' + fmtSettings.ShortTimeFormat;
  dbdtmEstArrival.DisplayFormat   := fmtSettings.ShortDateFormat + ' ' + fmtSettings.ShortTimeFormat;

  qryDepartment.Open;
  PrepareDriverQry;
  PrepareVehicleQry;
  PrepareTransferQry;
  PrepareTransferLinesQry;
end;

procedure TfmStSTransferPackage.FormShow(Sender: TObject);
begin
  inherited;

  with TitleShader do begin
    FromColor       := clWhite;
    FromColorMirror := clWhite;
    ToColor         := clWhite;
    ToColorMirror   := clWhite;
  end;

  // "Done" visible
  chkDone.Visible := FMode <> trmdNewOut;

  // Show records in detail grid if form displays Existing transfer
  if FMode <> trmdNewOut then OpenDetails;

  UpdateView;
  UpdateReadonly;
  UpdateDetailGridView;
end;

function TfmStSTransferPackage.GetLineItems(const aUseCase: TUseCase): TTransferLineItems;
var
  I: Integer;
  tmpBkm: TBookmark;
  bCondition: Boolean;
begin
  SetLength(Result, 0);
  try

    with qryPackages do begin
      if Active then begin
        if State in dsEditModes then Post;

        DisableControls;
        try
          I := 0;
          SetLength(Result, 10); // init

          tmpBkm := Bookmark;
          First;
          while not EOF do begin
            if not FieldByName('Checked').IsNull then begin
              if I > High(Result) then SetLength( Result, Length(Result) + Length(Result) );

              // get data from grid
                bCondition := False;
                case aUseCase of
                  useChecked:   bCondition :=     FieldByName('Checked').AsBoolean;
                  useUnchecked: bCondition := not FieldByName('Checked').AsBoolean;
                end;

                if bCondition then begin
                  Result[I].LineID        := FieldByName('LineID'      ).AsInteger;
                  Result[I].TransferID    := FieldByName('TransferID'  ).AsInteger;
                  Result[I].PackageID     := FieldByName('PackageID'   ).AsInteger;
                  Result[I].TagID         := FieldByName('TagID'       ).AsInteger;
                  Result[I].StSTag        := FieldByName('StsTag'      ).AsString;
                  Result[I].StSProductId  := FieldByName('StSProductId').AsInteger;

                  Inc(I);
                end;
            end;
            Next;
          end;

          SetLength(Result, I);  // truncate Result to actual size
        finally
          Bookmark := tmpBkm;
          qryPackages.EnableControls;
        end;
      end;
    end;

  except
    on E: Exception do begin
      SetLength(Result, 0);
      Logtext(Format('TfmStSTransferPackage.GetLineItems exception: [%s] %s', [E.Classname, E.Message]),'', True);
    end;
  end;
end;

function TfmStSTransferPackage.IsComplete: Boolean;
begin
  Result := qryTransfer.Active and (qryTransfer.RecordCount > 0) and SameText(qryTransfer.FieldByName('Done').AsString, 'T');
end;

function TfmStSTransferPackage.IsReadOnly: Boolean;
begin
  Result := (FMode <> trmdNewOut);
end;

procedure TfmStSTransferPackage.lookupDriverChange(Sender: TObject);
begin
  inherited;
  edtEmployeeID.Text  := qryDriver.FieldByName('EmployeeID' ).AsString;
  edtDriverLic.Text   := qryDriver.FieldByName('DriverLic'  ).AsString;
  edtDriverPhone.Text := qryDriver.FieldByName('DriverPhone').AsString;
end;

procedure TfmStSTransferPackage.lookupSourceCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  try

    try
      // show available Packages in Source Department
      OpenDetails;
    finally
      UpdateReadOnly;
    end;

  except
    on E: Exception do
      Logtext(Format('TfmStSTransferPackage.lookupSourceChange exception: [%s] %s', [E.Classname, E.Message]),'', True);
  end;
end;

procedure TfmStSTransferPackage.lookupVehicleChange(Sender: TObject);
begin
  inherited;
  edtVehicleMake.Text  := qryVehicle.FieldByName('VehicleMake' ).AsString;
  edtVehicleModel.Text := qryVehicle.FieldByName('VehicleModel').AsString;
  edtVehiclePlate.Text := qryVehicle.FieldByName('VehiclePlate').AsString;
end;

procedure TfmStSTransferPackage.OpenDetails;
begin
  CloseDB(qryPackages);

  if not qryTransfer.FieldByName('SourceDeptID').IsNull then begin

    if FMode = trmdNewOut then
      qryPackages.ParamByName('DeptID').AsInteger := qryTransfer.FieldByName('SourceDeptID').AsInteger;

    OpenDB(qryPackages);
  end;
end;

initialization
  RegisterClassOnce(TfmStSTransferPackage);

end.
