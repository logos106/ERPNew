unit RadioFreqTrackingListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, kbmMemTable, CustomInputBox, wwdblook,
  Shader, DAScript, MyScript, ERPdbComponents, AdvOfficeStatusBar, wwcheckbox;

type
  TRFTListType = (ltSummary, ltDetails, ltExtraDetails);

  TRadioFreqTrackingList = class(TBaseListingGUI)
    qryChannels: TMyQuery;
    qryChannelsChannelNo: TIntegerField;
    qryChannelsTxFreq: TFloatField;
    qryChannelsRxFreq: TFloatField;
    qryChannelsRepeaterNo: TStringField;
    qryChannelsRptLocations: TStringField;
    qryChannelsDeviation: TStringField;
    qryChannelsLicenseNo: TStringField;
    qryChannelsDetails: TStringField;
    qryChannelsChannelsID: TWordField;
    qryChannelsRFTID: TIntegerField;
    qryChannelsActive: TStringField;
    qrySelcallsDetails: TMyQuery;
    qrySelcallsDetailsSelcallNo: TStringField;
    qrySelcallsDetailsVehicle: TStringField;
    qrySelcallsDetailsDriver: TStringField;
    qrySelcallsDetailsNote: TStringField;
    qrySelcallsDetailsSelcallDetailsID: TIntegerField;
    qrySelcallsDetailsActive: TStringField;
    qryRFT: TMyQuery;
    qryRFTRptRate: TFloatField;
    qryRFTSetupFee: TFloatField;
    qryRFTDescription: TMemoField;
    qryRFTRFTID: TIntegerField;
    qryRFTSelcallType: TStringField;
    qryRFTCustomerName: TStringField;
    qryRFTFreqBand: TStringField;
    qryRFTAntennaTypeBase: TStringField;
    qryRFTAntennaTypeMobiles1: TStringField;
    qryRFTAntennaTypeMobiles2: TStringField;
    qryRFTAntennaTypeMobiles3: TStringField;
    qryRFTRadioModelsUsed1: TStringField;
    qryRFTRadioModelsUsed2: TStringField;
    qryRFTRadioModelsUsed3: TStringField;
    qryRFTActive: TStringField;
    qryRFTMonthlyRental: TFloatField;
    dsRFT: TDataSource;
    dsChannels: TDataSource;
    qryMainCustomerName: TStringField;
    qryMainSelcallType: TStringField;
    qryMainFrequencyBand: TStringField;
    qryMainNumberOfMobiles: TIntegerField;
    qryMainRptRate: TFloatField;
    qryMainMonthlyRental: TFloatField;
    qryMainSetupFee: TFloatField;
    qryMainDescriptionOfSystem: TStringField;
    qryMainChannelNo: TIntegerField;
    qryMainTxFreq: TFloatField;
    qryMainRxFreq: TFloatField;
    qryMainSubtone: TStringField;
    qryMainRepeaterNo: TStringField;
    qryMainRptLocations: TStringField;
    qryMainDeviation: TStringField;
    qryMainLicenceNo: TStringField;
    qryMainDetails: TStringField;
    qryMainSelcallNo: TStringField;
    qryMainVehicle: TStringField;
    qryMainDriver: TStringField;
    qryMainRecID: TIntegerField;
    qryMainRFTID: TIntegerField;
    qryMainFleetNote: TStringField;
    qryChannelsNote: TStringField;
    qrySelcallsDetailsDateInstalled: TDateField;
    qrySelcallsDetailsAntennaType: TStringField;
    qrySelcallsDetailsRego: TStringField;
    qrySelcallsDetailsSerial: TStringField;
    qrySelcallsDetailsRadioModel: TStringField;
    qrySelcallsDetailsInvoice: TStringField;
    qryChannelsSubtone: TStringField;
    qryRFTUnitQty: TIntegerField;
    chkDisplayInactive: TCheckBox;
    Label4: TLabel;
    Bevel1: TBevel;
    qryMainFleetNo: TIntegerField;
    qrySelcallsDetailsFleetNo: TLargeintField;
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
    procedure grdMainDblClick(Sender: TObject); override;
    procedure FormDestroy(Sender: TObject);
    procedure RefreshQuery; override;
    procedure chkDisplayInactiveClick(Sender: TObject);
  private
    fsTablename:String;
  public
    { Public declarations }
    procedure CreateTempTable;
    procedure FillTempTable(ListType: TRFTListType);
  end;

const 
  TempTableName = 'RFTList';

var
  RadioFreqTrackingList: TRadioFreqTrackingList;

implementation

uses
  CommonLib, CommonDbLib, RadioFreqTracking, Forms, FastFuncs;

{$R *.dfm}

procedure TRadioFreqTrackingList.FormCreate(Sender: TObject);
begin
  fsTablename :=GetUserTemporaryTableName(TempTableName);
  inherited;
  CreateTempTable;
  FillTempTable(ltSummary);
  fbEnableWebSearch := True;
  UseTmpTable := True;
end;

procedure TRadioFreqTrackingList.cmdNewClick(Sender: TObject);
var 
  Form: TRadioFreqTrackingGUI;
begin
  inherited;
  Form := TRadioFreqTrackingGUI(GetComponentByClassName('TRadioFreqTrackingGUI'));
  if Assigned(Form) then begin
    Form.AttachObserver(self);
    Form.FormStyle := fsMDIChild;
    Form.BringToFront;
  end;
end;

procedure TRadioFreqTrackingList.CreateTempTable;
var
  slSQL: TStringList;
begin
  DestroyUserTemporaryTable(fsTableName);
  slSQL := TStringList.Create;
  try
    slSQL.Clear;
    slSQL.Add('CREATE TABLE `' + fsTableName + '` (');

    slSQL.Add('`RecID` INT(11) AUTO_INCREMENT,');
    slSQL.Add('`RFTID` INT (11),');
    slSQL.Add('`CustomerName` VARCHAR (255),');
    slSQL.Add('`SelcallType` VARCHAR (20),');
    slSQL.Add('`FrequencyBand` VARCHAR (20),');
    slSQL.Add('`NumberOfMobiles` INT (11),');
    slSQL.Add('`RptRate` DOUBLE,');
    slSQL.Add('`MonthlyRental` DOUBLE,');
    slSQL.Add('`SetupFee` DOUBLE,');
    slSQL.Add('`DescriptionOfSystem` VARCHAR (255),');

    {channel details}
    slSQL.Add('`ChannelNo` INT (11),');
    slSQL.Add('`TxFreq` DOUBLE,');
    slSQL.Add('`RxFreq` DOUBLE,');
    slSQL.Add('`Subtone` VARCHAR (250),');
    slSQL.Add('`RepeaterNo` VARCHAR (20),');
    slSQL.Add('`RptLocations` VARCHAR (20),');
    slSQL.Add('`Deviation` VARCHAR (20),');
    slSQL.Add('`LicenceNo` VARCHAR (20),');
    slSQL.Add('`Details` VARCHAR (50),');
    slSQL.Add('`ChannelNote` VARCHAR (250),');

    {Selcall details}
    slSQL.Add('`FleetNo` INT (11),');
    slSQL.Add('`SelcallNo` VARCHAR (20),');
    slSQL.Add('`Vehicle` VARCHAR (20),');
    slSQL.Add('`Driver` VARCHAR (20),');
    slSQL.Add('`FleetNote` VARCHAR (250),');

    slSQL.Add('PRIMARY KEY (`RecID`)) TYPE=MyISAM;');

    CreateUserTemporaryTable(slSQL);
  finally
    // Free used objects.
    if Assigned(slSQL) then
      FreeAndNil(slSQL);
  end;
end;

procedure TRadioFreqTrackingList.FillTempTable(ListType: TRFTListType);
begin
  try
    qryMain.DisableControls;

    qryMain.SQL.Text := 'SELECT ' + #13#10 +
    'RecID                   as      RecID,                  ' + #13#10 +
    'RFTID                   as      RFTID,                  ' + #13#10 +
    'CustomerName            as      CustomerName,           ' + #13#10 +
    'SelcallType             as      SelcallType,            ' + #13#10 +
    'FrequencyBand           as      FrequencyBand,          ' + #13#10 +
    'NumberOfMobiles         as      NumberOfMobiles,        ' + #13#10 +
    'RptRate                 as      RptRate,                ' + #13#10 +
    'MonthlyRental           as      MonthlyRental,          ' + #13#10 +
    'SetupFee                as      SetupFee,               ' + #13#10 +
    'DescriptionOfSystem     as      DescriptionOfSystem,    ' + #13#10 +
    'ChannelNo               as      ChannelNo,              ' + #13#10 +
    'TxFreq                  as      TxFreq,                 ' + #13#10 +
    'RxFreq                  as      RxFreq,                 ' + #13#10 +
    'Subtone                 as      Subtone,                ' + #13#10 +
    'RepeaterNo              as      RepeaterNo,             ' + #13#10 +
    'RptLocations            as      RptLocations,           ' + #13#10 +
    'Deviation               as      Deviation,              ' + #13#10 +
    'LicenceNo               as      LicenceNo,              ' + #13#10 +
    'Details                 as      Details,                ' + #13#10 +
    'FleetNo                 as      FleetNo,                ' + #13#10 +
    'SelcallNo               as      SelcallNo,              ' + #13#10 +
    'Vehicle                 as      Vehicle,                ' + #13#10 +
    'Driver                  as      Driver,                 ' + #13#10 +
    'FleetNote               as      FleetNote,              ' + #13#10 +
    'ChannelNote             as      ChannelNote             ' + #13#10 +
    'FROM ' + #13#10 + fsTableName  + #13#10 + ' ORDER BY RecID';
    qryMain.Open;

    qryRFT.Open;
    qryChannels.Open;
    qrySelcallsDetails.Open;

    while not qryRFT.Eof do begin //Summary
      if true then begin
        {Fill Table}
        qryMain.Insert;
        qryMain.FieldByName('RFTID').asInteger := qryRFTRFTID.asInteger;
        qryMain.FieldByName('CustomerName').asString := qryRFTCustomerName.asString;
        qryMain.FieldByName('SelcallType').asString := qryRFTSelcallType.asString;
        qryMain.FieldByName('FrequencyBand').asString := qryRFTFreqBand.asString;
        qryMain.FieldByName('NumberOfMobiles').asInteger := qryRFTUnitQty.asInteger;
        qryMain.FieldByName('RptRate').AsFloat := qryRFTRptRate.AsFloat;
        qryMain.FieldByName('MonthlyRental').AsFloat := qryRFTUnitQty.asInteger * qryRFTRptRate.AsFloat;
        qryMain.FieldByName('SetupFee').AsFloat := qryRFTSetupFee.AsFloat;
        qryMain.FieldByName('DescriptionOfSystem').asString := qryRFTDescription.asString;
        qryMain.Post;
      end;
      if (ListType = ltDetails) or (ListType = ltExtraDetails) then begin
        qryChannels.First;
        while not qryChannels.Eof do begin // with Details
          qryMain.Insert;
          qryMain.FieldByName('RFTID').asInteger := qryRFTRFTID.asInteger;
          qryMain.FieldByName('CustomerName').asString := qryRFTCustomerName.asString;
          qryMain.FieldByName('SelcallType').asString := qryRFTSelcallType.asString;
          qryMain.FieldByName('NumberOfMobiles').asInteger := qryRFTUnitQty.asInteger;
          qryMain.FieldByName('RptRate').AsFloat := qryRFTRptRate.AsFloat;
          qryMain.FieldByName('MonthlyRental').AsFloat := qryRFTUnitQty.asInteger * qryRFTRptRate.AsFloat;
          qryMain.FieldByName('SetupFee').AsFloat := qryRFTSetupFee.AsFloat;
          qryMain.FieldByName('DescriptionOfSystem').asString := qryRFTDescription.asString;

          qryMain.FieldByName('ChannelNo').asInteger := qryChannelsChannelNo.asInteger;
          qryMain.FieldByName('TxFreq').AsFloat := qryChannelsTxFreq.AsFloat;
          qryMain.FieldByName('RxFreq').AsFloat := qryChannelsRxFreq.AsFloat;
          qryMain.FieldByName('Subtone').asString := qryChannelsSubtone.asString;
          qryMain.FieldByName('RepeaterNo').asString := qryChannelsRepeaterNo.asString;
          qryMain.FieldByName('RptLocations').asString := qryChannelsRptLocations.asString;
          qryMain.FieldByName('Deviation').asString := qryChannelsDeviation.asString;
          qryMain.FieldByName('LicenceNo').asString := qryChannelsLicenseNo.asString;
          qryMain.FieldByName('Details').asString := qryChannelsDetails.asString;
          qryMain.Post;

          if (ListType = ltExtraDetails) or (ListType = ltExtraDetails) then begin
            qrySelcallsDetails.First;
            while not qrySelcallsDetails.Eof do begin // Extra Details
              qryMain.Insert;
              qryMain.FieldByName('RFTID').asInteger := qryRFTRFTID.asInteger;
              qryMain.FieldByName('CustomerName').asString := qryRFTCustomerName.asString;
              qryMain.FieldByName('SelcallType').asString := qryRFTSelcallType.asString;
              qryMain.FieldByName('FrequencyBand').asString := qryRFTFreqBand.asString;
              qryMain.FieldByName('NumberOfMobiles').asInteger := qryRFTUnitQty.asInteger;
              qryMain.FieldByName('RptRate').AsFloat := qryRFTRptRate.AsFloat;
              qryMain.FieldByName('MonthlyRental').AsFloat := qryRFTUnitQty.asInteger * qryRFTRptRate.AsFloat;
              qryMain.FieldByName('SetupFee').AsFloat := qryRFTSetupFee.AsFloat;
              qryMain.FieldByName('DescriptionOfSystem').asString := qryRFTDescription.asString;

              qryMain.FieldByName('ChannelNo').asInteger := qryChannelsChannelNo.asInteger;
              qryMain.FieldByName('TxFreq').AsFloat := qryChannelsTxFreq.AsFloat;
              qryMain.FieldByName('RxFreq').AsFloat := qryChannelsRxFreq.AsFloat;
              qryMain.FieldByName('Subtone').asString := qryChannelsSubtone.asString;
              qryMain.FieldByName('RepeaterNo').asString := qryChannelsRepeaterNo.asString;
              qryMain.FieldByName('RptLocations').asString := qryChannelsRptLocations.asString;
              qryMain.FieldByName('Deviation').asString := qryChannelsDeviation.asString;
              qryMain.FieldByName('LicenceNo').asString := qryChannelsLicenseNo.asString;
              qryMain.FieldByName('Details').asString := qryChannelsDetails.asString;

              qryMain.FieldByName('FleetNo').asInteger := qrySelcallsDetailsFleetNo.asInteger;
              qryMain.FieldByName('SelcallNo').asString := qrySelcallsDetailsSelcallNo.asString;
              qryMain.FieldByName('Vehicle').asString := qrySelcallsDetailsVehicle.asString;
              qryMain.FieldByName('Driver').asString := qrySelcallsDetailsDriver.asString;
              qryMain.FieldByName('FleetNote').asString := qrySelcallsDetailsNote.asString;
              qryMain.Post;
              qrySelcallsDetails.Next;
            end;
          end;
          qryChannels.Next;
        end;
      end;
      qryRFT.Next;
    end;
    qryRFT.Close;
    qryChannels.Close;
    qrySelcallsDetails.Close;

    qryMain.Close;
    qryMain.Open;
  finally
    qryMain.EnableControls;
  end; 
end;

procedure TRadioFreqTrackingList.grpFiltersClick(Sender: TObject);
begin
  inherited;
  CreateTempTable;
  case grpFilters.ItemIndex of
    0:
      begin
        FillTempTable(ltSummary);
      end;
    1: 
      begin
        FillTempTable(ltDetails);
      end;
    2:
      begin
        FillTempTable(ltExtraDetails);
      end;
  end;{case}
end;

procedure TRadioFreqTrackingList.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + 'RFTID';
  inherited;
end;

procedure TRadioFreqTrackingList.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTableName);
  inherited;  
end;

procedure TRadioFreqTrackingList.RefreshQuery;
begin
  grpFiltersClick(nil);
  inherited;
end;

procedure TRadioFreqTrackingList.chkDisplayInactiveClick(Sender: TObject);
begin
  inherited;
  qryRFT.Close;

  try
    if chkDisplayInactive.Checked then begin
      qryRFT.SQL.Text := AnsiStringReplace(qryRFT.SQL.Text, '"T"', '"F"', [rfIgnoreCase]);
    end
    else begin
      qryRFT.SQL.Text := AnsiStringReplace(qryRFT.SQL.Text, '"F"', '"T"', [rfIgnoreCase]);
    end;
  finally
    qryRFT.Open;
    RefreshQuery;
  end;
end;

initialization
  RegisterClassOnce(TRadioFreqTrackingList);
end.
