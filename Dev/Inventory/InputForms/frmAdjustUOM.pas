unit frmAdjustUOM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, Shader, DBCtrls, ExtCtrls, DNMPanel,
  BaseFormForm, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, DNMSpeedButton, ImgList,
  Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, wwdblook, ComCtrls,
  Grids, Wwdbigrd, Wwdbgrid, ProgressDialog;

type
  TfmAdjustUOM = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    QryUOMFrom: TERPQuery;
    QryUOMTo: TERPQuery;
    QryUOMFromUnitID: TIntegerField;
    QryUOMFromUnitName: TWideStringField;
    QryUOMFromMultiplier: TFloatField;
    QryUOMFromUnitDescription: TWideStringField;
    QryUOMFromBaseUnitName: TWideStringField;
    QryUOMFromPARTNAME: TWideStringField;
    QryUOMToUnitID: TIntegerField;
    QryUOMToUnitName: TWideStringField;
    QryUOMToMultiplier: TFloatField;
    QryUOMToUnitDescription: TWideStringField;
    QryUOMToBaseUnitName: TWideStringField;
    QryUOMToPARTNAME: TWideStringField;
    dsUOMTo: TDataSource;
    dsUOMFrom: TDataSource;
    QryUOMToPartID: TIntegerField;
    QryUOMFromPartID: TIntegerField;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    QryUOMFromSNtracking: TWideStringField;
    DNMPanel3: TDNMPanel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    dsMain: TDataSource;
    grdMain: TwwDBGrid;
    Qrymain: TERPQuery;
    QrymainPartsId: TIntegerField;
    QrymainDepartmentID: TIntegerField;
    QrymainUOMID: TIntegerField;
    QrymainUOM: TWideStringField;
    QrymainUOMMultiplier: TFloatField;
    QrymaingLevel: TLargeintField;
    QrymainProductName: TWideStringField;
    QrymainProductColumn1: TWideStringField;
    QrymainProductColumn2: TWideStringField;
    QrymainProductColumn3: TWideStringField;
    QrymainPartsDescription: TWideStringField;
    QrymainClassname: TWideStringField;
    QrymainBatchnumber: TWideStringField;
    QrymainExpiryDate: TWideStringField;
    QrymainBatchExpiryDate: TDateTimeField;
    QrymainBinlocation: TWideStringField;
    QrymainBinnumber: TWideStringField;
    QrymainSerialnumber: TWideStringField;
    QrymainUOMQty: TFloatField;
    QrymainQty: TFloatField;
    QrymainInstockUOMQty: TFloatField;
    QrymainInstockQty: TFloatField;
    QrymainCost: TFloatField;
    QrymainValue: TFloatField;
    QrymainSNtracking: TWideStringField;
    QrymainTransfer: TWideStringField;
    QrymainTransfered: TWideStringField;
    QrymainReason: TWideStringField;
    DNMPanel4: TDNMPanel;
    fromPartname: TDBText;
    Label4: TLabel;
    Label3: TLabel;
    fromMultiplier: TDBText;
    cboFrom: TwwDBLookupCombo;
    Label1: TLabel;
    Bevel1: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    toPartName: TDBText;
    Label6: TLabel;
    Label5: TLabel;
    toMultiplier: TDBText;
    cboTo: TwwDBLookupCombo;
    Label2: TLabel;
    Bevel2: TBevel;
    lblStatus: TLabel;
    QryAllUOM1111: TERPQuery;
    QryAllUOM1111UnitID: TIntegerField;
    QryAllUOM1111UnitName: TWideStringField;
    QryAllUOM1111Multiplier: TFloatField;
    QryAllUOM1111UnitDescription: TWideStringField;
    QryAllUOM1111BaseUnitName: TWideStringField;
    QryAllUOM1111PartID: TIntegerField;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Label7: TLabel;
    unitName: TDBText;
    btnUOMlist: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboFromCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboToCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);
    procedure btnUOMlistClick(Sender: TObject);
  private
    fiProductID: Integer;
    Procedure showUOMdetails;
    Procedure CreateTemptable; 
  public
    Property ProductId :Integer Read fiProductID Write fiProductID;
  end;


implementation

uses CommonLib, ProductQtyLib, CommonDbLib, FastFuncs,
  BusobjStockAdjustEntry, StockAdjustEntryList ,
  BusObjGLAccount, BusObjBase, DateUtils, CommonFormLib;

{$R *.dfm}
procedure TfmAdjustUOM.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := True;
  inherited;
  fiProductID := 0;
  
end;

procedure TfmAdjustUOM.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmAdjustUOM.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  inherited;
end;

procedure TfmAdjustUOM.btnOKClick(Sender: TObject);
var
  ProgressDialog: TProgressDialog;
  StockAdjustReverse:TStockAdjustEntry;
  StockAdjustAdd:TStockAdjustEntry;

  Originalno :String;
  ctr:Integer;
  form :Tcomponent ;
  SACreated:Boolean;


  Procedure NewStock;
  begin
    StockAdjustReverse.PostDB;
    StockAdjustReverse.New;
    StockAdjustReverse.EnforceUOM := True;
    StockAdjustReverse.AdjustmentOnInstock := False;
    StockAdjustReverse.AdjustmentDate := Now;
    StockAdjustReverse.Notes := 'Adjust UOM - Reverse the Stock';
    StockAdjustReverse.PostDB;
    if Originalno = '' then Originalno := StockAdjustReverse.globalref;
    StockAdjustReverse.ImportgroupOriginalno := Originalno;
    StockAdjustReverse.PostDB;
    StockAdjustReverse.Lines.DoFieldChangewhenDisabled := true;

    StockAdjustAdd.PostDB;
    StockAdjustAdd.New;
    StockAdjustAdd.EnforceUOM := True;
    StockAdjustAdd.AdjustmentOnInstock := False;
    StockAdjustAdd.AdjustmentDate := IncSecond(StockAdjustReverse.AdjustmentDate, 1);
    StockAdjustAdd.Notes := 'Adjust UOM - Add Stock for the new UOM';
    StockAdjustAdd.PostDB;
    StockAdjustAdd.ImportgroupOriginalno := Originalno;
    StockAdjustAdd.PostDB;
    StockAdjustAdd.Lines.DoFieldChangewhenDisabled := true;


  end;

(*  function ValidUOM(const PartsID:Integer):Boolean ;
  begin
      result := true;
      if QryAllUOM.Locate('PartID' , PartsId, []) then
        if QryAllUOMUnitID.asInteger <> QryUOMToUnitID.asInteger then result := false;
      if result then
        result := (QryUOMToPartID.asInteger = PartsId)  or (QryUOMToPartID.asInteger =0);
  end;*)
  Function ValidforserialNo(const SNTracking:Boolean ):Boolean;
  begin
    result := true;
    if   (QryUOMFromMultiplier.asFloat = QryUOMToMultiplier.asFloat) then exit;
    result := not (SNTracking);
  end;
begin
  inherited;
  if cbofrom.Text = '' then exit;
  if cboto.text = '' then exit;

  if QryUOMToUnitID.asInteger = QryUOMFromUnitID.asInteger then begin
    CommonLib.MessageDlgXP_Vista('Same Unit of measure is selected to Move From and To.  Please selese different Unit of Measures.' , mtInformation , [mbok], 0);
    Exit;
  end;

  if TAccount.IDToggle('Stock Adjustment') = 0 then begin
      CommonLib.MessageDlgXP_Vista('Adjustment failed - Stock Adjustment Account Entry is missing.' , mtInformation , [mbok], 0);
      Exit;
  end;
  if (QryUOMFromPartID.asInteger = QryUOMToPartID.asInteger) or (QryUOMToPartID.asInteger =0) or (QryUOMFromPartID.asInteger=0) then else begin
      CommonLib.MessageDlgXP_Vista('Products of the UOM selected don''t match'  , mtInformation , [mbok], 0);
      Exit;
  end;


  //createTemptable;
(*  with QryAllUOM do begin
      if Active then close;
      SQL.clear;
      SQl.add('SELECT `U`.`UnitID`, `U`.`UnitName`, `U`.`Multiplier`, `U`.`UnitDescription`,' +
                  '`U`.`BaseUnitName`,`U`.`PartID`  FROM `tblunitsofmeasure` AS `U`' +
                  ' where `U`.`UnitName` = ' + QuotedStr(QryUOMToUnitName.asString));
      open;
  end;*)

    With Qrymain do begin


      if recordcount = 0 then begin
        commonlib.MessageDlgXP_Vista('No stock found for '+ QryUOMFromUnitName.asString, mtInformation , [mbOk],0);
        Exit;
      end;
      Originalno := '';

      StockAdjustReverse:= TStockAdjustEntry.create(Nil);
      StockAdjustReverse.connection := TMyDacDataConnection.create(StockAdjustReverse);
      StockAdjustReverse.Connection.Connection := CommonDbLib.GetNewMyDacConnection(StockAdjustReverse);
      StockAdjustReverse.Connection.BeginTransaction;

      StockAdjustAdd:= TStockAdjustEntry.create(Nil);
      StockAdjustAdd.connection := StockAdjustReverse.connection;

      try
        NewStock;

        ProgressDialog := TProgressDialog.Create(nil);
        try
          ProgressDialog.Caption := 'Please Wait .......';
          ProgressDialog.MinValue := 0;
          ProgressDialog.MaxValue := recordcount;
          ProgressDialog.Step := 1;
          ProgressDialog.Execute;
          ctr:= 0;
          SACreated := False;
          First;
          while Eof = False do begin
            if not Validforserialno(fieldByname('SNTracking').asBoolean) then begin
                    if Qrymain.state = dsBrowse then Qrymain.edit;
                    QrymainTransfered.asBoolean := False;
                    QrymainReason.asString :='Serialised Product - New UOM''s multiplier is different';
                    if Qrymain.state = dsEdit then Qrymain.Post;
(*            end else if not ValidUOM(FieldByname('PartsID').asInteger) then begin
                    if Qrymain.state = dsBrowse then Qrymain.edit;
                    QrymainTransfered.asBoolean := False;
                    QrymainReason.asString :='New UOM is not available for this  product';
                    if Qrymain.state = dsEdit then Qrymain.Post;*)
            end else if (fieldByname('Qty').asFloat <> 0) and (FieldByname('Transfer').asBoolean)   then begin
                    {Reverse Stock}
                    StockAdjustReverse.Lines.New;
                    StockAdjustReverse.Lines.ProductID  := Fieldbyname('PartsId').asInteger;
                    StockAdjustReverse.Lines.DeptID     := fieldByname('DepartmentId').asInteger;
                    StockAdjustReverse.Lines.UOM        := QryUOMFromUnitName.asString;
                    (*if StockAdjustReverse.Lines.UOMID   <> QryUOMFromUnitID.asInteger then
                      StockAdjustReverse.Lines.UOMID      := QryUOMFromUnitID.asInteger;*)
                    if fieldbyname('gLevel').asInteger = 1 then begin
                      StockAdjustReverse.Lines.AdjustQty := 0-fieldByname('Qty').asFloat;
                    end else begin
                      if FieldByName('Batchnumber').asString        <> '' then StockAdjustReverse.Lines.BatchNo      := FieldByName('Batchnumber').asString;
                      if FieldByName('BatchExpiryDate').AsdateTime  <> 0  then StockAdjustReverse.Lines.ExpiryDate   := FieldByName('BatchExpiryDate').AsdateTime ;
                      if FieldByName('binlocation').AsString        <> '' then StockAdjustReverse.Lines.binlocation  := FieldByname('binlocation').asString;
                      if FieldByName('binNumber').AsString          <> '' then StockAdjustReverse.Lines.binNumber    := FieldByname('binNumber').asString;
                      if FieldByName('Serialnumber').AsString       <> '' then StockAdjustReverse.Lines.Serialnumber := FieldByname('Serialnumber').asString;
                      StockAdjustReverse.Lines.AllocationAdjustQty := 0-fieldByname('Qty').asFloat;
                    end;
                    StockAdjustReverse.Lines.PostDB;

                    {Add Stock}
                    StockAdjustAdd.Lines.New;
                    StockAdjustAdd.Lines.ProductID  := Fieldbyname('PartsId').asInteger;
                    StockAdjustAdd.Lines.DeptID     := fieldByname('DepartmentId').asInteger;
                    StockAdjustAdd.Lines.UOM        := QryUOMToUnitName.asString;
(*                    if StockAdjustAdd.Lines.UOMID   <> QryUOMToUnitID.asInteger then
                      StockAdjustAdd.Lines.UOMID    := QryUOMToUnitID.asInteger;*)
                    if fieldbyname('gLevel').asInteger = 1 then begin
                      StockAdjustAdd.Lines.AdjustQty := fieldByname('Qty').asFloat;
                    end else begin
                        if FieldByName('Batchnumber').asString        <> '' then StockAdjustAdd.Lines.BatchNo      := FieldByName('Batchnumber').asString;
                        if FieldByName('BatchExpiryDate').AsdateTime  <> 0  then StockAdjustAdd.Lines.ExpiryDate   := FieldByName('BatchExpiryDate').AsdateTime ;
                        if FieldByName('binlocation').AsString        <> '' then StockAdjustAdd.Lines.binlocation  := FieldByname('binlocation').asString;
                        if FieldByName('binNumber').AsString          <> '' then StockAdjustAdd.Lines.binNumber    := FieldByname('binNumber').asString;
                        if FieldByName('Serialnumber').AsString       <> '' then StockAdjustAdd.Lines.Serialnumber := FieldByname('Serialnumber').asString;
                        StockAdjustAdd.Lines.AllocationAdjustQty := fieldByname('Qty').asFloat;
                    end;
                    StockAdjustAdd.Lines.PostDB;
                    if Qrymain.state = dsBrowse then Qrymain.edit;
                    QrymainTransfered.asBoolean := True;
                    QrymainReason.asString :='Transferred';
                    if Qrymain.state = dsEdit then Qrymain.Post;
                  ctr:= ctr+2;
                  SACreated := True;
            end;
            if ctr >= 400 then begin
              StockAdjustAdd.Lines.PostDB;
              StockAdjustAdd.PostDB;
              StockAdjustReverse.Lines.PostDB;
              StockAdjustReverse.PostDB;
              NewStock;
              ctr:= 0;
            end;

            ProgressDialog.StepIt;
            Next;
          end;

          if StockAdjustReverse.Lines.count = 0 then begin
            StockAdjustReverse.Deleted := true;
            StockAdjustReverse.PostDB;
          end;
          if StockAdjustAdd.Lines.count = 0 then begin
            StockAdjustAdd.Deleted := true;
            StockAdjustAdd.PostDB;
          end;

          if SACreated then begin
            StockAdjustReverse.Connection.CommitTransaction;
          end else begin
            StockAdjustReverse.Connection.RollbackTransaction;
          end;
        finally
          ProgressDialog.CloseDialog;
          Freeandnil(ProgressDialog);
        end;

        if (Originalno <> '') and (SACreated) then begin
              CommonLib.MessageDlgXP_Vista( 'All Available Quantity of Unit of Measure '+ QryUOMFromUnitName.asString + '-' + QryUOMFromPARTNAME.asString +'(' + QryUOMFromMultiplier.asString +')'+
                                          ' is moved to ' + QryUOMToUnitName.asString +'-' +QryUOMToPARTNAME.asString +'(' + QryUOMToMultiplier.asString +').' +
                                      chr(13)+chr(13)+'The Original no of the Stock Adjustment: ' +Originalno +
                                      chr(13) +Chr(13) +'Please make sure the stock adjustment is processed.', mtInformation, [mbok], 0);
              form := GetComponentByClassName('TStockAdjustEntryListGUI');
              if assigned(Form) then begin
                  TStockAdjustEntryListGUI(Form).FormStyle := fsMDIChild;
                  TStockAdjustEntryListGUI(Form).qryMain.Filter := 'Originalno = ' +QuotedStr(Originalno);
                  TStockAdjustEntryListGUI(Form).qryMain.Filtered := True;
                  //TStockAdjustEntryListGUI(Form).btnProcessall.visible := True;
                  TStockAdjustEntryListGUI(Form).BringToFront;
              end;
        end else if SACreated = False then begin
            CommonLib.MessageDlgXP_Vista( 'None transferred', mtInformation, [mbok], 0);
        end;
      Except
        on E:Exception do begin
          StockAdjustReverse.Connection.RollbackTransaction;
          commonlib.MessageDlgXP_Vista('Adjustment Failed' + chr(13) +chr(13) +E.Message , mtWarning , [mbOk],0);
        end;
      end;
    end;
end;

procedure TfmAdjustUOM.btnUOMlistClick(Sender: TObject);
begin
  inherited;
  OpenErpListform('TUOMListGUI'            );
  closeWait;
end;

procedure TfmAdjustUOM.FormShow(Sender: TObject);
begin
  inherited;
  OpenDB(QryUOMFrom);
  OpenDb(QryUOMTo);
  OpenDb(Qrymain);
  showUOMdetails;
end;

procedure TfmAdjustUOM.cboFromCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if Modified = false then Exit;
  inherited;
  closeDb(QryUOMTo);
  QryuomTo.SQl.clear;
  QryuomTo.SQl.Add('  SELECT `U`.`UnitID`, `U`.`UnitName`,`U`.`Multiplier`,' +
            '`U`.`UnitDescription`,`U`.`BaseUnitName`,`P`.`PARTNAME`, `U`.`PartID`' +
            ' FROM `tblunitsofmeasure` AS `U`' +
            ' Left Join `tblparts` AS `P` ON `U`.`PartID` = `P`.`PARTSID`' +
            ' where `U`.`UnitID` <> ' + IntToStr(QryUOMFromUnitID.asInteger)) ;
  if QryUOMFromPartID.asInteger <> 0 then
    QryuomTo.SQl.Add('  and (`U`.`PartID` = ' + IntToStr(QryUOMFromPartID.asInteger) +
            ' or ifnull(`U`.`PartID` ,0) = 0)' );
    if QryUOMFromSNtracking.asBoolean then
      QryuomTo.SQl.Add('  and U.Multiplier = ' +FloattoStr(QryUOMFromMultiplier.asFloat));
  QryuomTo.SQl.Add('  ORDER BY `U`.`UnitName` ASC');
  opendb(QryUOMTo);
  cboto.text := '';
  showUOMdetails;
  CreateTemptable;
end;

procedure TfmAdjustUOM.showUOMdetails;
begin
  fromMultiplier.visible := cboFrom.text <>'';
  fromPartname.visible := cboFrom.text <>'';
  toMultiplier.visible := cboto.text <>'';
  toPartName.visible := cboto.text <>'';
end;

procedure TfmAdjustUOM.cboToCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if Modified = false then Exit;
  inherited;
  showUOMdetails;
end;

procedure TfmAdjustUOM.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
//  if QrymainTransfer.asBoolean then ABrush.Color := clInfoBk;
  if (QrymainReason.asString = 'transferred') or (QrymainReason.asString = '') then else
    if Sysutils.SameText(Field.fieldname , 'Reason') then
      Abrush.Color := clPurple;
    if Sysutils.SameText(Field.fieldname , 'cost') then
      if QrymainCost.asfloat = 0 then AFont.Color := ABrush.Color;
end;

procedure TfmAdjustUOM.grdMainDblClick(Sender: TObject);
var
  s:String;
begin
  inherited;
  if QrymainTransfer.asBoolean  then s := 'Do you wish to stop transfering this Quantity?'
  else s:= 'Do you wish to transfer this Quantity?';
  if CommonLib.MessageDlgXP_Vista(s, mtConfirmation , [mbyes, mbno] , 0) = mryes then begin
      if Qrymain.state = dsBrowse then Qrymain.edit;
      QrymainTransfer.asBoolean := not(QrymainTransfer.asBoolean);
      if Qrymain.state = dsEdit then Qrymain.Post;
  end;
end;

procedure TfmAdjustUOM.CreateTemptable;
var
    strSQL:TStringList;
  fsTableName:String;
  s:String;

begin
  if cbofrom.Text = '' then exit;
  
  fsTablename := GetUserTemporaryTableName('AdjustUOM');
  strSQL:= TStringList.create;
  try
    strSQL.Add('Drop table if exists ' +fsTablename +';' );
    strSQL.Add('Create table ' +fsTablename );
    strSQL.add(StockQty(False,0 , 0 , tDetailswithSno)+';');
    if QryUOMFrompartId.asinteger =0 then begin
      strSQL.add('delete from ' +fsTablename +' where ifnull(UOM,"")<>' + Quotedstr(QryUOMFromUnitName.asString)+' or ifnull(Qty,0) = 0 ;');
    end else strSQL.add('delete from ' +fsTablename +' where ifnull(UOMID,0)<>' + IntToStr(QryUOMFromUnitID.asInteger)+' or ifnull(Qty,0) = 0 ;');
    strSQL.Add('alter table ' +fsTablename +' add column SNtracking Enum("T", "F") default "F";');
    strSQL.Add('alter table ' +fsTablename +' add column REason varchar(100) default "";');
    strSQL.Add('alter table ' +fsTablename +' add column Transfer Enum("T", "F") default "T";');
    strSQL.Add('alter table ' +fsTablename +' add column Transfered Enum("T", "F") default "F";');
    strSQL.Add('update ' +fsTablename +' T inner join tblParts P on P.PartsId = T.PartsId Set T.SNtracking = P.SnTracking');
    try
      With Commondblib.TempMyScript do try
        SQL.add(strSQL.text);
        Execute;
        lblStatus.Caption := 'Stock List For UOM: '+ QryUOMFromUnitName.asString;
        lblStatus.REfresh;

      finally
          Free;
      end;
    Except
        on E:Exception do begin
            commonlib.MessageDlgXP_Vista('Adjustment Failed' + chr(13) +chr(13) +E.Message , mtWarning , [mbOk],0);
            Exit;
        end;
    end;
  Finally
      FreeandNil(strSQL);
  end;
  s:=     'Select T.* from ' +fsTablename +' T ';
    With Qrymain do begin
      SQL.clear;
      Sql.add(s );
      Open;
    end ;
end;

initialization
  RegisterClassOnce(TfmAdjustUOM);

end.
