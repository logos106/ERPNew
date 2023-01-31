unit frmImportTNT_Rates;

interface

uses
  Windows, Forms, Dialogs, StdCtrls, Buttons, DNMSpeedButton, ComCtrls,AdvOfficeStatusBar, Controls, ExtCtrls,
  Classes, SysUtils, MyAccess,ERPdbComponents, AppEvnts, DNMPanel, BaseInputForm,
  SelectionDialog, DB, Variants,  DBAccess, DataState, Menus, AdvMenus,
  Graphics, Shader;

type
  TRecordTypeTNT_Rates = (TNT_FileHeader, TNT_CustomerHeader, TNT_CustomerServiceGroup,
    TNT_CustomerServiceType, TNT_CustomerTrafficLane, TNT_ScheduleHeader,
    TNT_ScheduleServiceGroup, TNT_ScheduleServiceType, TNT_ScheduleServiceTrafficLaneRates,
    TNT_FileTrailer, TNT_RecordFailed);

  TRecordTypeTNT_RatesInfo = array[Low(TRecordTypeTNT_Rates)..High(TRecordTypeTNT_Rates)] of string;

const
  TNT_Rates_Description: TRecordTypeTNT_RatesInfo = ('FileHeader', 'CustomerHeader', 'CustomerServiceGroup',
    'CustomerServiceType', 'CustomerTrafficLane', 'ScheduleHeader', 'ScheduleServiceGroup',
    'ScheduleServiceType', 'ScheduleServiceTrafficLaneRates', 'FileTrailer', '');

  TNT_Rates_TableName: TRecordTypeTNT_RatesInfo = ('tblTNTFileHeader', 'tblTNTCustomerHeader', 'tblTNTCustomerServiceGroup',
    'tblTNTCustomerServiceType', 'tblTNTCustomerTrafficLane', 'tblTNTScheduleHeader', 'tblTNTScheduleServiceGroup',
    'tblTNTScheduleServiceType', 'tblTNTScheduleServiceTrafficLaneRates', 'tblTNTFileTrailer', '');

  TNT_Rates_RecordTypeIndicator: TRecordTypeTNT_RatesInfo = ('H', 'A', 'B', 'C', 'D', 'S', 'T', 'U', 'V', 'Z', '');


type
  TImportTNTRatesGUI = class(TBaseInputGUI)
    OpenDialog1: TOpenDialog;
    SpeedButton1: TDNMSpeedButton;
    txtFilePath: TEdit;
    Letter_Label: TLabel;
    lblImporting: TLabel;
    ImportProgressBar: TProgressBar;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    qryUpdate: TERPQuery;
    qryUpdateExc: TERPCommand;
    F: TextFile;
    LineNumber, FileLinesCount: integer;
    function IsDir(const DirPath: string): boolean;
    function IsFile(const FileName: string): boolean;
    function LineCount(const FileName: string): integer;
    function GetLineOfString(const I, LinesCount: integer): string;
    procedure ProcessLineOfString(const LineString: string);
    function RecordTypeStrToRecordTypeTNT_Rates(const RecordType: string): TRecordTypeTNT_Rates;
    function GetFixedWidthField(const LineString: string; const StartPos, Count: integer): string;
    function StrToMysqlDateTime(const StrDate: string): TDateTime;
    procedure ClearTNTTables;
  public
    { Public declarations }
    
  end;

//var
//  ImportTNTRatesGUI: TImportTNTRatesGUI;


implementation
   
uses FastFuncs,StrUtils, CommonDbLib, DateUtils, DNMExceptions, CommonLib;

{$R *.DFM}

function TImportTNTRatesGUI.RecordTypeStrToRecordTypeTNT_Rates(const RecordType: string): TRecordTypeTNT_Rates;
var
  i: TRecordTypeTNT_Rates;
begin
  Result := TNT_RecordFailed;
  for i := Low(TRecordTypeTNT_Rates) to High(TRecordTypeTNT_Rates) do begin
    if RecordType = TNT_Rates_RecordTypeIndicator[i] then begin
      Result := i;
      Break;
    end;
  end;
end;

procedure TImportTNTRatesGUI.btnOKClick(Sender: TObject);
var
  LINESTRING: string;
  I, Count: integer;
begin
  DisableForm;
  try
    btnOK.Enabled := false;
    try
      if empty(txtFilePath.Text) then begin
        SpeedButton1Click(Sender);
      end;
      if empty(txtFilePath.Text) then begin
        Exit;
      end;
      if IsDir(ExtractFileDir(txtFilePath.Text)) then begin
        if IsFile(txtFilePath.Text) then begin
          //Import Function
          lblImporting.Caption := 'Please Wait Importing ..... 0%';
          lblImporting.Visible := true;
          FileLinesCount := LineCount(txtFilePath.Text);
          if (FileLinesCount = 0) then begin
            Self.Close;
            Exit;
          end;
          ImportProgressBar.Min := 0;
          ImportProgressBar.Max := FileLinesCount;
          ImportProgressBar.Position := ImportProgressBar.Min;
          try
            AssignFile(F, txtFilePath.Text);
            Reset(F);
            Count := FileLinesCount;
            //Clean TNT Tables Before new import ;
            ClearTNTTables;
            for I := 1 to Count do begin
              //get next Line
              LineNumber := I;

              LINESTRING := GetLineOfString(I, FileLinesCount);

              // Process Line String
              LINESTRING := Trim(LINESTRING);
              if not empty(LINESTRING) then ProcessLineOfString(LINESTRING);
            end;
          finally
            CloseFile(F);
          end;
          lblImporting.Visible := true;
          Self.Close;
        end else begin
          CommonLib.MessageDlgXP_Vista('File "' + txtFilePath.Text + '"' + #13 + 'Does Not Exist !', mtWarning, [mbOK], 0);
        end;
      end else begin
        CommonLib.MessageDlgXP_Vista('Directory "' + ExtractFileDir(txtFilePath.Text) + '"' + #13 + ' Does Not Exist !', mtWarning, [mbOK], 0);
      end;
    finally
      btnOK.Enabled := true;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TImportTNTRatesGUI.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

function TImportTNTRatesGUI.IsDir(const DirPath: string): boolean;
begin
  Result := DirectoryExists(DirPath);
end;

function TImportTNTRatesGUI.IsFile(const FileName: string): boolean;
begin
  Result := FileExists(FileName);
end;

function TImportTNTRatesGUI.LineCount(const FileName: string): integer;
var
  Count: integer;
begin
  Count := 0;
  AssignFile(F, FileName);
  try
    Reset(F);
    while not Eof(F) do begin
      Readln(F);
      Inc(Count);
    end;
    CloseFile(F);
    Result := Count;
  except
    CommonLib.MessageDlgXP_Vista('File is Already !', mtWarning, [mbOK], 0);
    Result := 0;
  end;
end;

procedure TImportTNTRatesGUI.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    txtFilePath.Text := Opendialog1.FileName;
  end;
end;

function TImportTNTRatesGUI.GetLineOfString(const I, LinesCount: integer): string;
begin
  try
    Readln(F, Result);
    ImportProgressBar.StepIt;
    lblImporting.Caption := 'Please Wait Importing ..... ' + FloatToStrF(((I / LinesCount) * 100),
      ffFixed, 18, 0) + '% Complete';
    Application.ProcessMessages;
  except
    on EInOutError do Result := '';
  end;
end;

procedure TImportTNTRatesGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
end;

function TypeToTableName(RecordType: TRecordTypeTNT_Rates): string;
begin
  Result := TNT_Rates_TableName[RecordType];
end;

procedure TImportTNTRatesGUI.ProcessLineOfString(const LineString: string);
var
  RecordType: TRecordTypeTNT_Rates;
begin
  try
    RecordType := RecordTypeStrToRecordTypeTNT_Rates(uppercase(GetFixedWidthField(LineString, 1, 1)));
    qryUpdate.SQL.Clear;
    if not Empty(TypeToTableName(RecordType)) then begin
      qryUpdate.SQL.Add('SELECT * FROM ' + TypeToTableName(RecordType) + ' WHERE ID = 0;');
      qryUpdate.Open;
    end;
    case RecordType of
      //###################################################
      TNT_FileHeader: 
        begin
          with qryUpdate do begin
            Insert;
            FieldByName('RecordType').AsString := Trim(GetFixedWidthField(LineString, 1, 1));
            FieldByName('RecordNumber').AsString := Trim(GetFixedWidthField(LineString, 2, 8));
            FieldByName('ExtractTime').AsDateTime := StrToMysqlDateTime(Trim(GetFixedWidthField(LineString, 10, 19)));
            FieldByName('FileVersion').AsString := Trim(GetFixedWidthField(LineString, 29, 4));
            FieldByName('Division').AsString := Trim(GetFixedWidthField(LineString, 33, 4));
            Post;
          end;
        end;
      //###################################################
      TNT_CustomerHeader: 
        begin
          with qryUpdate do begin
            Insert;
            FieldByName('RecordType').AsString := Trim(GetFixedWidthField(LineString, 1, 1));
            FieldByName('RecordNumber').AsString := Trim(GetFixedWidthField(LineString, 2, 8));
            FieldByName('AccountCode').AsString := Trim(GetFixedWidthField(LineString, 10, 9));
            FieldByName('DefaultSchedule').AsString := Trim(GetFixedWidthField(LineString, 19, 1));
            Post;
          end;
        end;
      //###################################################
      TNT_CustomerServiceGroup: 
        begin
          with qryUpdate do begin
            Insert;
            FieldByName('RecordType').AsString := Trim(GetFixedWidthField(LineString, 1, 1));
            FieldByName('RecordNumber').AsString := Trim(GetFixedWidthField(LineString, 2, 8));
            FieldByName('AccountCode').AsString := Trim(GetFixedWidthField(LineString, 10, 9));
            FieldByName('ServiceGroup').AsString := Trim(GetFixedWidthField(LineString, 19, 4));
            FieldByName('BasicUse').AsString := Trim(GetFixedWidthField(LineString, 23, 1));
            FieldByName('BasicDiscount').AsString := Trim(GetFixedWidthField(LineString, 24, 7));
            FieldByName('BasicAmount').AsString := Trim(GetFixedWidthField(LineString, 31, 7));
            FieldByName('RateUse').AsString := Trim(GetFixedWidthField(LineString, 38, 1));
            FieldByName('RateDiscount').AsString := Trim(GetFixedWidthField(LineString, 39, 7));
            FieldByName('RateCalcType').AsString := Trim(GetFixedWidthField(LineString, 46, 4));
            FieldByName('RateUsage').AsString := Trim(GetFixedWidthField(LineString, 50, 1));
            FieldByName('RateUseMaxWeight').AsString := Trim(GetFixedWidthField(LineString, 51, 1));
            FieldByName('RateMaxWeigth').AsString := Trim(GetFixedWidthField(LineString, 52, 5));
            FieldByName('RateBreakType').AsString := Trim(GetFixedWidthField(LineString, 57, 1));
            FieldByName('RateCalcMethod').AsString := Trim(GetFixedWidthField(LineString, 58, 1));
            FieldByName('RateAmount').AsString := Trim(GetFixedWidthField(LineString, 59, 7));
            FieldByName('MinimumUse').AsString := Trim(GetFixedWidthField(LineString, 66, 1));
            FieldByName('MinimumDiscount').AsString := Trim(GetFixedWidthField(LineString, 67, 7));
            FieldByName('MinimumConAmount').AsString := Trim(GetFixedWidthField(LineString, 74, 7));
            FieldByName('MinimumItemAmount').AsString := Trim(GetFixedWidthField(LineString, 81, 7));
            FieldByName('OverrideCubicFactor').AsString := Trim(GetFixedWidthField(LineString, 88, 1));
            FieldByName('CubicFactor').AsString := Trim(GetFixedWidthField(LineString, 89, 4));
            FieldByName('OverrideSplitBasic').AsString := Trim(GetFixedWidthField(LineString, 93, 1));
            FieldByName('SplitBasic').AsString := Trim(GetFixedWidthField(LineString, 94, 1));
            FieldByName('OverrideSurchargePercent').AsString := Trim(GetFixedWidthField(LineString, 95, 1));
            FieldByName('SurchargePercent').AsString := Trim(GetFixedWidthField(LineString, 96, 7));
            FieldByName('OverrideSurchargeAmount').AsString := Trim(GetFixedWidthField(LineString, 103, 1));
            FieldByName('SurchargeAmount').AsString := Trim(GetFixedWidthField(LineString, 104, 7));
            FieldByName('OverrideDangerousGoodsPercent').AsString := Trim(GetFixedWidthField(LineString, 111, 1));
            FieldByName('DangerousGoodsPercent').AsString := Trim(GetFixedWidthField(LineString, 112, 7));
            FieldByName('OverrideDangerousGoodsAmount').AsString := Trim(GetFixedWidthField(LineString, 119, 1));
            FieldByName('DangerousGoodsAmount').AsString := Trim(GetFixedWidthField(LineString, 120, 7));
            FieldByName('OverrideSaturdayDeliveryFee').AsString := Trim(GetFixedWidthField(LineString, 127, 1));
            FieldByName('SaturdayDeliveryFee').AsString := Trim(GetFixedWidthField(LineString, 128, 7));
            FieldByName('OverrideTimeCharge').AsString := Trim(GetFixedWidthField(LineString, 135, 1));
            FieldByName('TimeCharge').AsString := Trim(GetFixedWidthField(LineString, 136, 7));
            FieldByName('OverrideReceiverPaysCharge').AsString := Trim(GetFixedWidthField(LineString, 143, 1));
            FieldByName('ReceiverPaysCharge').AsString := Trim(GetFixedWidthField(LineString, 144, 7));
            FieldByName('OverrideATC').AsString := Trim(GetFixedWidthField(LineString, 151, 1));
            FieldByName('ATCPremium').AsString := Trim(GetFixedWidthField(LineString, 152, 9));
            FieldByName('ATCInsuredValue').AsString := Trim(GetFixedWidthField(LineString, 161, 8));
            FieldByName('RTIDefaultCode').AsString := Trim(GetFixedWidthField(LineString, 169, 4));
            FieldByName('Schedule').AsString := Trim(GetFixedWidthField(LineString, 173, 1));
            FieldByName('OnForwardUse').AsString := Trim(GetFixedWidthField(LineString, 174, 1));
            FieldByName('OnForwardingCharge').AsString := Trim(GetFixedWidthField(LineString, 175, 7));
            FieldByName('OnForwardingDiscount').AsString := Trim(GetFixedWidthField(LineString, 182, 7));
            FieldByName('GetMinimumConNoteCharge').AsString := Trim(GetFixedWidthField(LineString, 189, 1));
            FieldByName('AllowDiscountOnWAintrastateLanes').AsString := Trim(GetFixedWidthField(LineString, 190, 1));
            Post;
          end;
        end;
      //###################################################
      TNT_CustomerServiceType: 
        begin
          with qryUpdate do begin
            Insert;
            FieldByName('RecordType').AsString := Trim(GetFixedWidthField(LineString, 1, 1));
            FieldByName('RecordNumber').AsString := Trim(GetFixedWidthField(LineString, 2, 8));
            FieldByName('AccountCode').AsString := Trim(GetFixedWidthField(LineString, 10, 9));
            FieldByName('ServiceGroup').AsString := Trim(GetFixedWidthField(LineString, 19, 4));
            FieldByName('ServiceType').AsString := Trim(GetFixedWidthField(LineString, 23, 4));
            FieldByName('BasicUse').AsString := Trim(GetFixedWidthField(LineString, 27, 1));
            FieldByName('BasicDiscount').AsString := Trim(GetFixedWidthField(LineString, 28, 7));
            FieldByName('BasicAmount').AsString := Trim(GetFixedWidthField(LineString, 35, 7));
            FieldByName('MTLBasicDiscount').AsString := Trim(GetFixedWidthField(LineString, 42, 7));
            FieldByName('MTLBasicUse').AsString := Trim(GetFixedWidthField(LineString, 49, 1));
            FieldByName('MTLRateDiscount').AsString := Trim(GetFixedWidthField(LineString, 50, 7));
            FieldByName('MTLRateUse').AsString := Trim(GetFixedWidthField(LineString, 57, 1));
            FieldByName('MTLMinimumConCharge').AsString := Trim(GetFixedWidthField(LineString, 58, 7));
            FieldByName('MTLBreak1').AsString := Trim(GetFixedWidthField(LineString, 65, 5));
            FieldByName('MTLBasic1').AsString := Trim(GetFixedWidthField(LineString, 70, 7));
            FieldByName('MTLBreak2').AsString := Trim(GetFixedWidthField(LineString, 77, 5));
            FieldByName('MTLBasic2').AsString := Trim(GetFixedWidthField(LineString, 82, 7));
            FieldByName('MTLBreak3').AsString := Trim(GetFixedWidthField(LineString, 89, 5));
            FieldByName('MTLBasic3').AsString := Trim(GetFixedWidthField(LineString, 94, 7));
            FieldByName('MTLBreak4').AsString := Trim(GetFixedWidthField(LineString, 101, 5));
            FieldByName('MTLBasic4').AsString := Trim(GetFixedWidthField(LineString, 106, 7));
            FieldByName('MTLBreak5').AsString := Trim(GetFixedWidthField(LineString, 113, 5));
            FieldByName('MTLBasic5').AsString := Trim(GetFixedWidthField(LineString, 118, 7));
            FieldByName('RateUse').AsString := Trim(GetFixedWidthField(LineString, 125, 1));
            FieldByName('RateDiscount').AsString := Trim(GetFixedWidthField(LineString, 126, 7));
            FieldByName('RateCalcType').AsString := Trim(GetFixedWidthField(LineString, 133, 4));
            FieldByName('RateUsage').AsString := Trim(GetFixedWidthField(LineString, 137, 1));
            FieldByName('RateUseMaxWeight').AsString := Trim(GetFixedWidthField(LineString, 138, 1));
            FieldByName('RateMaxWeigth').AsString := Trim(GetFixedWidthField(LineString, 139, 5));
            FieldByName('RateBreakType').AsString := Trim(GetFixedWidthField(LineString, 144, 1));
            FieldByName('RateCalcMethod').AsString := Trim(GetFixedWidthField(LineString, 145, 1));
            FieldByName('RateAmount').AsString := Trim(GetFixedWidthField(LineString, 146, 7));
            FieldByName('MinimumUse').AsString := Trim(GetFixedWidthField(LineString, 153, 1));
            FieldByName('MinimumDiscount').AsString := Trim(GetFixedWidthField(LineString, 154, 7));
            FieldByName('MinimumConAmount').AsString := Trim(GetFixedWidthField(LineString, 161, 7));
            FieldByName('MinimumItemAmount').AsString := Trim(GetFixedWidthField(LineString, 168, 7));
            FieldByName('OverrideCubicFactor').AsString := Trim(GetFixedWidthField(LineString, 175, 1));
            FieldByName('CubicFactor').AsString := Trim(GetFixedWidthField(LineString, 176, 4));
            FieldByName('Articles').AsString := Trim(GetFixedWidthField(LineString, 180, 1));
            FieldByName('WhichBasicToUse').AsString := Trim(GetFixedWidthField(LineString, 181, 1));
            FieldByName('AllowRateTypeAtBreakLevelToBeAltered').AsString := Trim(GetFixedWidthField(LineString, 182, 1));
            FieldByName('AllowDiscountOnWAintrastateLanes').AsString := Trim(GetFixedWidthField(LineString, 183, 1));
            FieldByName('OnForwardingChargesUsage').AsString := Trim(GetFixedWidthField(LineString, 184, 1));
            FieldByName('OnForwardingCharge').AsString := Trim(GetFixedWidthField(LineString, 185, 7));
            FieldByName('OnForwardingDiscount').AsString := Trim(GetFixedWidthField(LineString, 192, 7));
            Post;
          end;
        end;
      //###################################################
      TNT_CustomerTrafficLane: 
        begin
          with qryUpdate do begin
            Insert;
            FieldByName('RecordType').AsString := Trim(GetFixedWidthField(LineString, 1, 1));
            FieldByName('RecordNumber').AsString := Trim(GetFixedWidthField(LineString, 2, 8));
            FieldByName('AccountCode').AsString := Trim(GetFixedWidthField(LineString, 10, 9));
            FieldByName('ServiceGroup').AsString := Trim(GetFixedWidthField(LineString, 19, 4));
            FieldByName('ServiceType').AsString := Trim(GetFixedWidthField(LineString, 23, 4));
            FieldByName('SourceRatingArea').AsString := Trim(GetFixedWidthField(LineString, 27, 4));
            FieldByName('DestinationRatingArea').AsString := Trim(GetFixedWidthField(LineString, 35, 4));
            FieldByName('RateType').AsString := Trim(GetFixedWidthField(LineString, 39, 1));
            FieldByName('RateCalculationType').AsString := Trim(GetFixedWidthField(LineString, 40, 4));
            FieldByName('Reciprocal').AsString := Trim(GetFixedWidthField(LineString, 44, 1));
            FieldByName('FlagOnly').AsString := Trim(GetFixedWidthField(LineString, 45, 1));
            FieldByName('AllowOnForwarding').AsString := Trim(GetFixedWidthField(LineString, 46, 1));
            FieldByName('AllowDiscountOnWAintrastateLanes').AsString := Trim(GetFixedWidthField(LineString, 47, 1));
            FieldByName('OverrideMinimum').AsString := Trim(GetFixedWidthField(LineString, 48, 1));
            FieldByName('OverrideConNoteUsage').AsString := Trim(GetFixedWidthField(LineString, 49, 1));
            FieldByName('MinimumConCharge').AsString := Trim(GetFixedWidthField(LineString, 50, 7));
            FieldByName('MinimumItemUsage').AsString := Trim(GetFixedWidthField(LineString, 57, 1));
            FieldByName('MinimumItemCharge').AsString := Trim(GetFixedWidthField(LineString, 58, 7));
            FieldByName('BasicUsage').AsString := Trim(GetFixedWidthField(LineString, 59, 1));
            FieldByName('BasicCharge').AsString := Trim(GetFixedWidthField(LineString, 60, 7));
            FieldByName('UseKiloRates').AsString := Trim(GetFixedWidthField(LineString, 67, 1));
            FieldByName('KiloBreakType').AsString := Trim(GetFixedWidthField(LineString, 68, 1));
            FieldByName('KiloRateType1').AsString := Trim(GetFixedWidthField(LineString, 69, 1));
            FieldByName('KiloBreak1').AsString := Trim(GetFixedWidthField(LineString, 70, 5));
            FieldByName('KiloIncrement1').AsString := Trim(GetFixedWidthField(LineString, 75, 5));
            FieldByName('KiloBasicType1').AsString := Trim(GetFixedWidthField(LineString, 80, 1));
            FieldByName('KiloBasicChargeOrDiscountAmount1').AsString := Trim(GetFixedWidthField(LineString, 81, 7));
            FieldByName('K_RateType1').AsString := Trim(GetFixedWidthField(LineString, 88, 1));
            FieldByName('KiloRate1').AsString := Trim(GetFixedWidthField(LineString, 89, 9));
            FieldByName('KiloRateType2').AsString := Trim(GetFixedWidthField(LineString, 98, 1));
            FieldByName('KiloBreak2').AsString := Trim(GetFixedWidthField(LineString, 99, 5));
            FieldByName('KiloIncrement2').AsString := Trim(GetFixedWidthField(LineString, 104, 5));
            FieldByName('KiloBasicType2').AsString := Trim(GetFixedWidthField(LineString, 109, 1));
            FieldByName('KiloBasicChargeOrDiscountAmount2').AsString := Trim(GetFixedWidthField(LineString, 110, 7));
            FieldByName('K_RateType2').AsString := Trim(GetFixedWidthField(LineString, 117, 1));
            FieldByName('KiloRate2').AsString := Trim(GetFixedWidthField(LineString, 118, 9));
            FieldByName('KiloRateType3').AsString := Trim(GetFixedWidthField(LineString, 127, 1));
            FieldByName('KiloBreak3').AsString := Trim(GetFixedWidthField(LineString, 128, 5));
            FieldByName('KiloIncrement3').AsString := Trim(GetFixedWidthField(LineString, 133, 5));
            FieldByName('KiloBasicType3').AsString := Trim(GetFixedWidthField(LineString, 138, 1));
            FieldByName('KiloBasicChargeOrDiscountAmount3').AsString := Trim(GetFixedWidthField(LineString, 139, 7));
            FieldByName('K_RateType3').AsString := Trim(GetFixedWidthField(LineString, 146, 1));
            FieldByName('KiloRate3').AsString := Trim(GetFixedWidthField(LineString, 147, 9));
            FieldByName('KiloRateType4').AsString := Trim(GetFixedWidthField(LineString, 156, 1));
            FieldByName('KiloBreak4').AsString := Trim(GetFixedWidthField(LineString, 157, 5));
            FieldByName('KiloIncrement4').AsString := Trim(GetFixedWidthField(LineString, 162, 5));
            FieldByName('KiloBasicType4').AsString := Trim(GetFixedWidthField(LineString, 167, 1));
            FieldByName('KiloBasicChargeOrDiscountAmount4').AsString := Trim(GetFixedWidthField(LineString, 168, 7));
            FieldByName('K_RateType4').AsString := Trim(GetFixedWidthField(LineString, 175, 1));
            FieldByName('KiloRate4').AsString := Trim(GetFixedWidthField(LineString, 176, 9));
            FieldByName('KiloRateType5').AsString := Trim(GetFixedWidthField(LineString, 185, 1));
            FieldByName('KiloBreak5').AsString := Trim(GetFixedWidthField(LineString, 186, 5));
            FieldByName('KiloIncrement5').AsString := Trim(GetFixedWidthField(LineString, 191, 5));
            FieldByName('KiloBasicType5').AsString := Trim(GetFixedWidthField(LineString, 196, 1));
            FieldByName('KiloBasicChargeOrDiscountAmount5').AsString := Trim(GetFixedWidthField(LineString, 197, 7));
            FieldByName('K_RateType5').AsString := Trim(GetFixedWidthField(LineString, 204, 1));
            FieldByName('KiloRate5').AsString := Trim(GetFixedWidthField(LineString, 205, 9));
            FieldByName('UseCubicRates').AsString := Trim(GetFixedWidthField(LineString, 214, 1));
            FieldByName('CubicBreakType').AsString := Trim(GetFixedWidthField(LineString, 215, 1));
            FieldByName('CubicRateType1').AsString := Trim(GetFixedWidthField(LineString, 216, 1));
            FieldByName('CubicBreak1').AsString := Trim(GetFixedWidthField(LineString, 217, 9));
            FieldByName('CubicIncrement1').AsString := Trim(GetFixedWidthField(LineString, 226, 9));
            FieldByName('CubicBasicType1').AsString := Trim(GetFixedWidthField(LineString, 235, 1));
            FieldByName('CubicBasicChargeOrDiscountAmount1').AsString := Trim(GetFixedWidthField(LineString, 236, 7));
            FieldByName('C_RateType1').AsString := Trim(GetFixedWidthField(LineString, 243, 1));
            FieldByName('CubicRate1').AsString := Trim(GetFixedWidthField(LineString, 244, 9));
            FieldByName('CubicRateType2').AsString := Trim(GetFixedWidthField(LineString, 253, 1));
            FieldByName('CubicBreak2').AsString := Trim(GetFixedWidthField(LineString, 254, 9));
            FieldByName('CubicIncrement2').AsString := Trim(GetFixedWidthField(LineString, 263, 9));
            FieldByName('CubicBasicType2').AsString := Trim(GetFixedWidthField(LineString, 272, 1));
            FieldByName('CubicBasicChargeOrDiscountAmount2').AsString := Trim(GetFixedWidthField(LineString, 273, 7));
            FieldByName('C_RateType2').AsString := Trim(GetFixedWidthField(LineString, 280, 1));
            FieldByName('CubicRate2').AsString := Trim(GetFixedWidthField(LineString, 281, 9));
            FieldByName('CubicRateType3').AsString := Trim(GetFixedWidthField(LineString, 290, 1));
            FieldByName('CubicBreak3').AsString := Trim(GetFixedWidthField(LineString, 291, 9));
            FieldByName('CubicIncrement3').AsString := Trim(GetFixedWidthField(LineString, 300, 9));
            FieldByName('CubicBasicType3').AsString := Trim(GetFixedWidthField(LineString, 309, 1));
            FieldByName('CubicBasicChargeOrDiscountAmount3').AsString := Trim(GetFixedWidthField(LineString, 310, 7));
            FieldByName('C_RateType3').AsString := Trim(GetFixedWidthField(LineString, 317, 1));
            FieldByName('CubicRate3').AsString := Trim(GetFixedWidthField(LineString, 318, 9));
            FieldByName('CubicRateType4').AsString := Trim(GetFixedWidthField(LineString, 327, 1));
            FieldByName('CubicBreak4').AsString := Trim(GetFixedWidthField(LineString, 328, 9));
            FieldByName('CubicIncrement4').AsString := Trim(GetFixedWidthField(LineString, 337, 9));
            FieldByName('CubicBasicType4').AsString := Trim(GetFixedWidthField(LineString, 346, 1));
            FieldByName('CubicBasicChargeOrDiscountAmount4').AsString := Trim(GetFixedWidthField(LineString, 347, 7));
            FieldByName('C_RateType4').AsString := Trim(GetFixedWidthField(LineString, 354, 1));
            FieldByName('CubicRate4').AsString := Trim(GetFixedWidthField(LineString, 355, 9));
            FieldByName('CubicRateType5').AsString := Trim(GetFixedWidthField(LineString, 364, 1));
            FieldByName('CubicBreak5').AsString := Trim(GetFixedWidthField(LineString, 365, 9));
            FieldByName('CubicIncrement5').AsString := Trim(GetFixedWidthField(LineString, 374, 9));
            FieldByName('CubicBasicType5').AsString := Trim(GetFixedWidthField(LineString, 383, 1));
            FieldByName('CubicBasicChargeOrDiscountAmount5').AsString := Trim(GetFixedWidthField(LineString, 384, 7));
            FieldByName('C_RateType5').AsString := Trim(GetFixedWidthField(LineString, 391, 1));
            FieldByName('CubicRate5').AsString := Trim(GetFixedWidthField(LineString, 392, 9));
            FieldByName('UseItemRates').AsString := Trim(GetFixedWidthField(LineString, 401, 1));
            FieldByName('ItemMaxWeight').AsString := Trim(GetFixedWidthField(LineString, 402, 4));
            FieldByName('ItemType').AsString := Trim(GetFixedWidthField(LineString, 406, 1));
            FieldByName('ItemRateType1').AsString := Trim(GetFixedWidthField(LineString, 407, 1));
            FieldByName('ItemBreak1').AsString := Trim(GetFixedWidthField(LineString, 408, 4));
            FieldByName('ItemIncrement1').AsString := Trim(GetFixedWidthField(LineString, 412, 4));
            FieldByName('ItemBasicType1').AsString := Trim(GetFixedWidthField(LineString, 416, 1));
            FieldByName('ItemBasicChargeOrDiscountAmount1').AsString := Trim(GetFixedWidthField(LineString, 417, 7));
            FieldByName('I_RateType1').AsString := Trim(GetFixedWidthField(LineString, 424, 1));
            FieldByName('ItemRate1').AsString := Trim(GetFixedWidthField(LineString, 425, 9));
            FieldByName('ItemRateType2').AsString := Trim(GetFixedWidthField(LineString, 434, 1));
            FieldByName('ItemBreak2').AsString := Trim(GetFixedWidthField(LineString, 435, 4));
            FieldByName('ItemIncrement2').AsString := Trim(GetFixedWidthField(LineString, 439, 4));
            FieldByName('ItemBasicType2').AsString := Trim(GetFixedWidthField(LineString, 443, 9));
            FieldByName('ItemBasicChargeOrDiscountAmount2').AsString := Trim(GetFixedWidthField(LineString, 452, 7));
            FieldByName('I_RateType2').AsString := Trim(GetFixedWidthField(LineString, 459, 1));
            FieldByName('ItemRate2').AsString := Trim(GetFixedWidthField(LineString, 460, 9));
            FieldByName('ItemRateType3').AsString := Trim(GetFixedWidthField(LineString, 469, 1));
            FieldByName('ItemBreak3').AsString := Trim(GetFixedWidthField(LineString, 470, 4));
            FieldByName('ItemIncrement3').AsString := Trim(GetFixedWidthField(LineString, 474, 4));
            FieldByName('ItemBasicType3').AsString := Trim(GetFixedWidthField(LineString, 478, 1));
            FieldByName('ItemBasicChargeOrDiscountAmount3').AsString := Trim(GetFixedWidthField(LineString, 479, 7));
            FieldByName('I_RateType3').AsString := Trim(GetFixedWidthField(LineString, 486, 1));
            FieldByName('ItemRate3').AsString := Trim(GetFixedWidthField(LineString, 487, 9));
            FieldByName('ItemRateType4').AsString := Trim(GetFixedWidthField(LineString, 496, 1));
            FieldByName('ItemBreak4').AsString := Trim(GetFixedWidthField(LineString, 497, 4));
            FieldByName('ItemIncrement4').AsString := Trim(GetFixedWidthField(LineString, 501, 4));
            FieldByName('ItemBasicType4').AsString := Trim(GetFixedWidthField(LineString, 505, 1));
            FieldByName('ItemBasicChargeOrDiscountAmount4').AsString := Trim(GetFixedWidthField(LineString, 506, 7));
            FieldByName('I_RateType4').AsString := Trim(GetFixedWidthField(LineString, 513, 1));
            FieldByName('ItemRate4').AsString := Trim(GetFixedWidthField(LineString, 514, 9));
            FieldByName('ItemRateType5').AsString := Trim(GetFixedWidthField(LineString, 523, 1));
            FieldByName('ItemBreak5').AsString := Trim(GetFixedWidthField(LineString, 524, 4));
            FieldByName('ItemIncrement5').AsString := Trim(GetFixedWidthField(LineString, 528, 4));
            FieldByName('ItemBasicType5').AsString := Trim(GetFixedWidthField(LineString, 532, 1));
            FieldByName('ItemBasicChargeOrDiscountAmount5').AsString := Trim(GetFixedWidthField(LineString, 533, 7));
            FieldByName('I_RateType5').AsString := Trim(GetFixedWidthField(LineString, 540, 1));
            FieldByName('ItemRate5').AsString := Trim(GetFixedWidthField(LineString, 541, 9));
            Post;
          end;
        end;
      //###################################################
      TNT_ScheduleHeader: 
        begin
          with qryUpdate do begin
            Insert;
            FieldByName('RecordType').AsString := Trim(GetFixedWidthField(LineString, 1, 1));
            FieldByName('RecordNumber').AsString := Trim(GetFixedWidthField(LineString, 2, 8));
            Post;
          end;
        end;
      //###################################################
      TNT_ScheduleServiceGroup: 
        begin
          with qryUpdate do begin
            Insert;
            FieldByName('RecordType').AsString := Trim(GetFixedWidthField(LineString, 1, 1));
            FieldByName('RecordNumber').AsString := Trim(GetFixedWidthField(LineString, 2, 8));
            FieldByName('ScheduleNumber').AsString := Trim(GetFixedWidthField(LineString, 10, 1));
            FieldByName('ServiceGroup').AsString := Trim(GetFixedWidthField(LineString, 11, 4));
            FieldByName('SplitBasic').AsString := Trim(GetFixedWidthField(LineString, 15, 1));
            FieldByName('SurchargePercent').AsString := Trim(GetFixedWidthField(LineString, 16, 7));
            FieldByName('SurchargeAmount').AsString := Trim(GetFixedWidthField(LineString, 23, 9));
            FieldByName('DangerousGoodsPercent').AsString := Trim(GetFixedWidthField(LineString, 32, 7));
            FieldByName('DangerousGoodsAmount').AsString := Trim(GetFixedWidthField(LineString, 39, 7));
            FieldByName('SaturdayDeliveryFee').AsString := Trim(GetFixedWidthField(LineString, 46, 9));
            FieldByName('TimeCharge').AsString := Trim(GetFixedWidthField(LineString, 55, 9));
            FieldByName('ReceiverPaysCharge').AsString := Trim(GetFixedWidthField(LineString, 64, 9));
            FieldByName('ATCPremium').AsString := Trim(GetFixedWidthField(LineString, 73, 9));
            FieldByName('ATCInsuredValue').AsString := Trim(GetFixedWidthField(LineString, 82, 8));
            FieldByName('MinimumConNoteChargeFlag').AsString := Trim(GetFixedWidthField(LineString, 90, 1));
            FieldByName('MinimumConCharge').AsString := Trim(GetFixedWidthField(LineString, 91, 9));
            FieldByName('MinimumItemCharge').AsString := Trim(GetFixedWidthField(LineString, 100, 9));
            Post;
          end;
        end;
      //###################################################
      TNT_ScheduleServiceType: 
        begin
          with qryUpdate do begin
            Insert;
            FieldByName('RecordType').AsString := Trim(GetFixedWidthField(LineString, 1, 1));
            FieldByName('RecordNumber').AsString := Trim(GetFixedWidthField(LineString, 2, 8));
            FieldByName('ScheduleNumber').AsString := Trim(GetFixedWidthField(LineString, 10, 1));
            FieldByName('ServiceGroup').AsString := Trim(GetFixedWidthField(LineString, 11, 4));
            FieldByName('ServiceType').AsString := Trim(GetFixedWidthField(LineString, 15, 4));
            FieldByName('CubicFator').AsString := Trim(GetFixedWidthField(LineString, 19, 4));
            FieldByName('BasicToUse').AsString := Trim(GetFixedWidthField(LineString, 23, 1));
            FieldByName('AlterRateTypeAtBreakLevel').AsString := Trim(GetFixedWidthField(LineString, 24, 1));
            FieldByName('OnForwardingUsage').AsString := Trim(GetFixedWidthField(LineString, 25, 1));
            FieldByName('OnForwardingCharge').AsString := Trim(GetFixedWidthField(LineString, 26, 7));
            FieldByName('Articles').AsString := Trim(GetFixedWidthField(LineString, 33, 1));
            Post;
          end;
        end;
      //###################################################
      TNT_ScheduleServiceTrafficLaneRates: 
        begin
          with qryUpdate do begin
            Insert;
            FieldByName('RecordType').AsString := Trim(GetFixedWidthField(LineString, 1, 1));
            FieldByName('RecordNumber').AsString := Trim(GetFixedWidthField(LineString, 2, 8));
            FieldByName('ScheduleNumber').AsString := Trim(GetFixedWidthField(LineString, 10, 1));
            FieldByName('ServiceGroup').AsString := Trim(GetFixedWidthField(LineString, 11, 4));
            FieldByName('ServiceType').AsString := Trim(GetFixedWidthField(LineString, 15, 4));
            FieldByName('SourceRatingArea').AsString := Trim(GetFixedWidthField(LineString, 19, 4));
            FieldByName('DestinationRatingArea').AsString := Trim(GetFixedWidthField(LineString, 23, 4));
            FieldByName('RateType').AsString := Trim(GetFixedWidthField(LineString, 27, 1));
            FieldByName('RateCalculationType').AsString := Trim(GetFixedWidthField(LineString, 28, 4));
            FieldByName('Reciprocal').AsString := Trim(GetFixedWidthField(LineString, 32, 1));
            FieldByName('AllowOnForwardingOnThisLane').AsString := Trim(GetFixedWidthField(LineString, 33, 1));
            FieldByName('UseMinimumConNoteCharge').AsString := Trim(GetFixedWidthField(LineString, 34, 1));
            FieldByName('MinimumConCharge').AsString := Trim(GetFixedWidthField(LineString, 35, 7));
            FieldByName('UseMinimumItemCharge').AsString := Trim(GetFixedWidthField(LineString, 42, 1));
            FieldByName('MinimumItemCharge').AsString := Trim(GetFixedWidthField(LineString, 43, 7));
            FieldByName('UseBasicCharge').AsString := Trim(GetFixedWidthField(LineString, 50, 1));
            FieldByName('BasicCharge').AsString := Trim(GetFixedWidthField(LineString, 51, 7));
            FieldByName('UseKiloRates').AsString := Trim(GetFixedWidthField(LineString, 58, 1));
            FieldByName('KiloBreakType').AsString := Trim(GetFixedWidthField(LineString, 59, 1));
            FieldByName('KiloRateType1').AsString := Trim(GetFixedWidthField(LineString, 60, 1));
            FieldByName('KiloBreak1').AsString := Trim(GetFixedWidthField(LineString, 61, 5));
            FieldByName('KiloIncrement1').AsString := Trim(GetFixedWidthField(LineString, 66, 5));
            FieldByName('KiloBasicForBreakPoint1').AsString := Trim(GetFixedWidthField(LineString, 71, 7));
            FieldByName('KiloRate1').AsString := Trim(GetFixedWidthField(LineString, 78, 9));
            FieldByName('KiloRateType2').AsString := Trim(GetFixedWidthField(LineString, 87, 1));
            FieldByName('KiloBreak2').AsString := Trim(GetFixedWidthField(LineString, 88, 5));
            FieldByName('KiloIncrement2').AsString := Trim(GetFixedWidthField(LineString, 93, 5));
            FieldByName('KiloBasicForBreakPoint2').AsString := Trim(GetFixedWidthField(LineString, 98, 7));
            FieldByName('KiloRate2').AsString := Trim(GetFixedWidthField(LineString, 105, 9));
            FieldByName('KiloRateType3').AsString := Trim(GetFixedWidthField(LineString, 114, 1));
            FieldByName('KiloBreak3').AsString := Trim(GetFixedWidthField(LineString, 115, 5));
            FieldByName('KiloIncrement3').AsString := Trim(GetFixedWidthField(LineString, 120, 5));
            FieldByName('KiloBasicForBreakPoint3').AsString := Trim(GetFixedWidthField(LineString, 125, 7));
            FieldByName('KiloRate3').AsString := Trim(GetFixedWidthField(LineString, 132, 9));
            FieldByName('KiloRateType4').AsString := Trim(GetFixedWidthField(LineString, 141, 1));
            FieldByName('KiloBreak4').AsString := Trim(GetFixedWidthField(LineString, 142, 5));
            FieldByName('KiloIncrement4').AsString := Trim(GetFixedWidthField(LineString, 147, 5));
            FieldByName('KiloBasicForBreakPoint4').AsString := Trim(GetFixedWidthField(LineString, 152, 7));
            FieldByName('KiloRate4').AsString := Trim(GetFixedWidthField(LineString, 159, 9));
            FieldByName('KiloRateType5').AsString := Trim(GetFixedWidthField(LineString, 168, 1));
            FieldByName('KiloBreak5').AsString := Trim(GetFixedWidthField(LineString, 169, 5));
            FieldByName('KiloIncrement5').AsString := Trim(GetFixedWidthField(LineString, 174, 5));
            FieldByName('KiloBasicForBreakPoint5').AsString := Trim(GetFixedWidthField(LineString, 179, 7));
            FieldByName('KiloRate5').AsString := Trim(GetFixedWidthField(LineString, 186, 9));
            FieldByName('UseCubicRates').AsString := Trim(GetFixedWidthField(LineString, 195, 1));
            FieldByName('CubicBreakType').AsString := Trim(GetFixedWidthField(LineString, 196, 1));
            FieldByName('CubicRateType1').AsString := Trim(GetFixedWidthField(LineString, 197, 1));
            FieldByName('CubicBreak1').AsString := Trim(GetFixedWidthField(LineString, 198, 9));
            FieldByName('CubicIncrement1').AsString := Trim(GetFixedWidthField(LineString, 207, 9));
            FieldByName('CubicBasicForBreakPoint1').AsString := Trim(GetFixedWidthField(LineString, 216, 7));
            FieldByName('CubicRate1').AsString := Trim(GetFixedWidthField(LineString, 223, 9));
            FieldByName('CubicRateType2').AsString := Trim(GetFixedWidthField(LineString, 232, 1));
            FieldByName('CubicBreak2').AsString := Trim(GetFixedWidthField(LineString, 233, 9));
            FieldByName('CubicIncrement2').AsString := Trim(GetFixedWidthField(LineString, 242, 9));
            FieldByName('CubicBasicForBreakPoint2').AsString := Trim(GetFixedWidthField(LineString, 251, 7));
            FieldByName('CubicRate2').AsString := Trim(GetFixedWidthField(LineString, 258, 9));
            FieldByName('CubicRateType3').AsString := Trim(GetFixedWidthField(LineString, 267, 1));
            FieldByName('CubicBreak3').AsString := Trim(GetFixedWidthField(LineString, 268, 9));
            FieldByName('CubicIncrement3').AsString := Trim(GetFixedWidthField(LineString, 277, 9));
            FieldByName('CubicBasicForBreakPoint3').AsString := Trim(GetFixedWidthField(LineString, 286, 7));
            FieldByName('CubicRate3').AsString := Trim(GetFixedWidthField(LineString, 293, 9));
            FieldByName('CubicRateType4').AsString := Trim(GetFixedWidthField(LineString, 302, 1));
            FieldByName('CubicBreak4').AsString := Trim(GetFixedWidthField(LineString, 303, 9));
            FieldByName('CubicIncrement4').AsString := Trim(GetFixedWidthField(LineString, 312, 9));
            FieldByName('CubicBasicForBreakPoint4').AsString := Trim(GetFixedWidthField(LineString, 321, 7));
            FieldByName('CubicRate4').AsString := Trim(GetFixedWidthField(LineString, 328, 9));
            FieldByName('CubicRateType5').AsString := Trim(GetFixedWidthField(LineString, 337, 1));
            FieldByName('CubicBreak5').AsString := Trim(GetFixedWidthField(LineString, 338, 9));
            FieldByName('CubicIncrement5').AsString := Trim(GetFixedWidthField(LineString, 347, 9));
            FieldByName('CubicBasicForBreakPoint5').AsString := Trim(GetFixedWidthField(LineString, 356, 7));
            FieldByName('CubicRate5').AsString := Trim(GetFixedWidthField(LineString, 363, 9));
            FieldByName('UseItemRates').AsString := Trim(GetFixedWidthField(LineString, 372, 1));
            FieldByName('ItemMaxWeight').AsString := Trim(GetFixedWidthField(LineString, 373, 4));
            FieldByName('ItemType').AsString := Trim(GetFixedWidthField(LineString, 377, 1));
            FieldByName('ItemRateType1').AsString := Trim(GetFixedWidthField(LineString, 378, 1));
            FieldByName('ItemBreak1').AsString := Trim(GetFixedWidthField(LineString, 379, 4));
            FieldByName('ItemIncrement1').AsString := Trim(GetFixedWidthField(LineString, 383, 4));
            FieldByName('ItemBasicForBreakPoint1').AsString := Trim(GetFixedWidthField(LineString, 387, 7));
            FieldByName('ItemRate1').AsString := Trim(GetFixedWidthField(LineString, 394, 9));
            FieldByName('ItemRateType2').AsString := Trim(GetFixedWidthField(LineString, 403, 1));
            FieldByName('ItemBreak2').AsString := Trim(GetFixedWidthField(LineString, 404, 4));
            FieldByName('ItemIncrement2').AsString := Trim(GetFixedWidthField(LineString, 409, 4));
            FieldByName('ItemBasicForBreakPoint2').AsString := Trim(GetFixedWidthField(LineString, 413, 7));
            FieldByName('ItemRate2').AsString := Trim(GetFixedWidthField(LineString, 420, 9));
            FieldByName('ItemRateType3').AsString := Trim(GetFixedWidthField(LineString, 429, 1));
            FieldByName('ItemBreak3').AsString := Trim(GetFixedWidthField(LineString, 430, 4));
            FieldByName('ItemIncrement3').AsString := Trim(GetFixedWidthField(LineString, 434, 4));
            FieldByName('ItemBasicForBreakPoint3').AsString := Trim(GetFixedWidthField(LineString, 438, 7));
            FieldByName('ItemRate3').AsString := Trim(GetFixedWidthField(LineString, 445, 9));
            FieldByName('ItemRateType4').AsString := Trim(GetFixedWidthField(LineString, 454, 1));
            FieldByName('ItemBreak4').AsString := Trim(GetFixedWidthField(LineString, 455, 4));
            FieldByName('ItemIncrement4').AsString := Trim(GetFixedWidthField(LineString, 459, 4));
            FieldByName('ItemBasicForBreakPoint4').AsString := Trim(GetFixedWidthField(LineString, 463, 7));
            FieldByName('ItemRate4').AsString := Trim(GetFixedWidthField(LineString, 470, 9));
            FieldByName('ItemRateType5').AsString := Trim(GetFixedWidthField(LineString, 479, 1));
            FieldByName('ItemBreak5').AsString := Trim(GetFixedWidthField(LineString, 480, 4));
            FieldByName('ItemIncrement5').AsString := Trim(GetFixedWidthField(LineString, 484, 4));
            FieldByName('ItemBasicForBreakPoint5').AsString := Trim(GetFixedWidthField(LineString, 488, 7));
            FieldByName('ItemRate5').AsString := Trim(GetFixedWidthField(LineString, 495, 9));
            Post;
          end;
        end;
      //###################################################
      TNT_FileTrailer: 
        begin
          with qryUpdate do begin
            Insert;
            FieldByName('RecordType').AsString := Trim(GetFixedWidthField(LineString, 1, 1));
            FieldByName('RecordNumber').AsString := Trim(GetFixedWidthField(LineString, 2, 8));
            FieldByName('ExtractTime').AsDateTime := StrToMysqlDateTime(Trim(GetFixedWidthField(LineString, 10, 19)));
            Post;
          end;
        end;
      //###################################################
      TNT_RecordFailed: 
        begin
        end;
    end;
    qryUpdate.Close;
  except
  end;
end;

function TImportTNTRatesGUI.GetFixedWidthField(const LineString: string; const StartPos, Count: integer): string;
begin
  Result := MidStr(LineString, StartPos, Count);
end;

function TImportTNTRatesGUI.StrToMysqlDateTime(const StrDate: string): TDateTime;
var
  Year, Month, Day, Hour, Minute, Second: word;
begin
  //Assume String Date 'yyyy-mm-dd hh:mm:ss'
  try
    Year   := FastFuncs.StrToInt(GetFixedWidthField(StrDate, 1, 4));
    Month  := FastFuncs.StrToInt(GetFixedWidthField(StrDate, 6, 2));
    Day    := FastFuncs.StrToInt(GetFixedWidthField(StrDate, 9, 2));
    Hour   := FastFuncs.StrToInt(GetFixedWidthField(StrDate, 12, 2));
    Minute := FastFuncs.StrToInt(GetFixedWidthField(StrDate, 15, 2));
    Second := FastFuncs.StrToInt(GetFixedWidthField(StrDate, 18, 2));
    Result := EncodeDateTime(Year, Month, Day, Hour, Minute, Second, 0);
  except
    Result := null;
  end;
end;

procedure TImportTNTRatesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  qryUpdateExc := TERPCommand.Create(nil);
  qryUpdateExc.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryUpdate := TERPQuery.Create(nil);
  qryUpdate.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryUpdate.ParamCheck := false;
end;

procedure TImportTNTRatesGUI.FormDestroy(Sender: TObject);
begin
  FreeandNil(qryUpdate);
  FreeandNil(qryUpdateExc);
  inherited;
end;

procedure TImportTNTRatesGUI.ClearTNTTables;
var
  i: TRecordTypeTNT_Rates;
begin
  for i := Low(TRecordTypeTNT_Rates) to High(TRecordTypeTNT_Rates) do begin
    if not Empty(TypeToTableName(i)) then begin
      qryUpdateExc.SQL.Clear;
      qryUpdateExc.SQL.Add('DELETE QUICK FROM ' + TypeToTableName(i) + ';');
      qryUpdateExc.Execute;
    end;
  end;
end;

procedure TImportTNTRatesGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

initialization
  RegisterClassOnce(TImportTNTRatesGUI);
end.

