unit frmQueryOptionsFrm;

{

 Date     Version Who  What
 -------- -------- ---  ------------------------------------------------------
 13/09/05  1.00.01 IJB  Changed "Account_No" to "AccountNo" in
                        CreateTempMailMergeTable to match field name used elswhere
 30/09/05  1.00.02 DSP  Added options of 'Equipment Name' and
                        'Equipment Description' for the filter fields. Replaced
                        undercores with spaces in the filter field labels. Fixed
                        various faults including the radio buttons on the
                        'Sort Records' tab not being on panels. A fault with
                        writing to a Word document still needs to be fixed.
 20/10/05  1.00.03 DLS  Added RegisterClass
 20/02/06  1.00.04 DSP  Added password to email authentication.
 09/06/06  1.00.05  Al  Changed field names from "CUSTFLD1 as CFLabel1" to just "CUSTFLD1"

}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, ExtCtrls, Buttons, DNMSpeedButton, ComCtrls,AdvOfficeStatusBar,  DB, OleServer,
  Word2000, Variants, BaseInputForm, DNMPanel, Clipbrd, wwclearbuttongroup,
  wwradiogroup, wwdbedit, Wwdotdot, Wwdbcomb, Psock, SelectionDialog, AppEvnts,
  MyAccess, ActnList, ActnMan, DBAccess, MemDS, MyClasses, DataState,
  EmailUtils, tcTypes, Menus, AdvMenus, Shader;

const
  GP_SELECT_LOYALTY = 4; // index for 'loyalty' on rgSelect radio group

type
  TfrmQueryOptions = class(TBaseInputGUI)
    TabCtl3: TPageControl;
    Filter_Records: TTabSheet;
    Sort_Records: TTabSheet;
    Letter_Label: TLabel;
    WordApplication1: TWordApplication;
    DNMPanel1: TDNMPanel;
    Field_Label: TLabel;
    Col1_Label: TLabel;
    Label21: TLabel;
    cboComparison1: TComboBox;
    cboCompare1: TEdit;
    cboAndOr2: TComboBox;
    cboField2: TComboBox;
    cboComparison2: TComboBox;
    cboCompare2: TEdit;
    cboAndOr3: TComboBox;
    cboField3: TComboBox;
    cboComparison3: TComboBox;
    cboCompare3: TEdit;
    cboAndOr4: TComboBox;
    cboField4: TComboBox;
    cboComparison4: TComboBox;
    cboCompare4: TEdit;
    cboAndOr5: TComboBox;
    cboField5: TComboBox;
    cboComparison5: TComboBox;
    cboCompare5: TEdit;
    cboAndOr6: TComboBox;
    cboField6: TComboBox;
    cboComparison6: TComboBox;
    cboCompare6: TEdit;
    cboField1: TComboBox;
    DNMPanel2: TDNMPanel;
    Label40: TLabel;
    Label48: TLabel;
    Label55: TLabel;
    OpenDialog1: TOpenDialog;
    txtLetter: TEdit;
    SpeedButton1: TDNMSpeedButton;
    rgSelect: TwwRadioGroup;
    cmdClose: TDNMSpeedButton;
    cmdDocument: TDNMSpeedButton;
    SendSettings: TTabSheet;
    DNMPanel3: TDNMPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel4: TBevel;
    Bevel6: TBevel;
    FirstPreference: TwwDBComboBox;
    SecondPreference: TwwDBComboBox;
    ThirdPreference: TwwDBComboBox;
    cmdAutoSend: TDNMSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    pnlChooseRpt: TDNMPanel;
    lblChooseRpt: TLabel;
    chkChooseRpt: TCheckBox;
    tabLoyalty: TTabSheet;
    pnlLoyalty: TDNMPanel;
    grpLoyalty: TwwRadioGroup;
    dtp1: TDateTimePicker;
    dtp2: TDateTimePicker;
    dtp3: TDateTimePicker;
    dtp4: TDateTimePicker;
    dtp5: TDateTimePicker;
    dtp6: TDateTimePicker;
    btnExport: TDNMSpeedButton;
    SaveDialog1: TSaveDialog;
    qryCustomers: TMyQuery;
    qryMailMerge: TMyQuery;
    qrytmpMailMerge: TMyQuery;
    qryEmployees: TMyQuery;
    qryOthers: TMyQuery;
    qrySuppliers: TMyQuery;
    tblCustomFields: TMyTable;
    tblWordMerge: TMyTable;
    tblCustomFieldsGlobalRef: TStringField;
    tblCustomFieldsCFLabel1: TStringField;
    tblCustomFieldsCFCust1: TStringField;
    tblCustomFieldsCFEmpl1: TStringField;
    tblCustomFieldsCFSupp1: TStringField;
    tblCustomFieldsCFIsCombo1: TStringField;
    tblCustomFieldsCFLabel2: TStringField;
    tblCustomFieldsCFCust2: TStringField;
    tblCustomFieldsCFEmpl2: TStringField;
    tblCustomFieldsCFSupp2: TStringField;
    tblCustomFieldsCFIsCombo2: TStringField;
    tblCustomFieldsCFLabel3: TStringField;
    tblCustomFieldsCFCust3: TStringField;
    tblCustomFieldsCFEmpl3: TStringField;
    tblCustomFieldsCFSupp3: TStringField;
    tblCustomFieldsCFIsCombo3: TStringField;
    tblCustomFieldsCFLabel4: TStringField;
    tblCustomFieldsCFCust4: TStringField;
    tblCustomFieldsCFEmpl4: TStringField;
    tblCustomFieldsCFSupp4: TStringField;
    tblCustomFieldsCFIsCombo4: TStringField;
    tblCustomFieldsCFLabel5: TStringField;
    tblCustomFieldsCFCust5: TStringField;
    tblCustomFieldsCFEmpl5: TStringField;
    tblCustomFieldsCFSupp5: TStringField;
    tblCustomFieldsCFIsCombo5: TStringField;
    tblCustomFieldsCFLabel6: TStringField;
    tblCustomFieldsCFCust6: TStringField;
    tblCustomFieldsCFEmpl6: TStringField;
    tblCustomFieldsCFSupp6: TStringField;
    tblCustomFieldsCFIsCombo6: TStringField;
    tblCustomFieldsCFLabel7: TStringField;
    tblCustomFieldsCFCust7: TStringField;
    tblCustomFieldsCFEmpl7: TStringField;
    tblCustomFieldsCFSupp7: TStringField;
    tblCustomFieldsCFIsCombo7: TStringField;
    tblCustomFieldsCFLabel8: TStringField;
    tblCustomFieldsCFCust8: TStringField;
    tblCustomFieldsCFEmpl8: TStringField;
    tblCustomFieldsCFSupp8: TStringField;
    tblCustomFieldsCFIsCombo8: TStringField;
    tblCustomFieldsCFLabel9: TStringField;
    tblCustomFieldsCFCust9: TStringField;
    tblCustomFieldsCFEmpl9: TStringField;
    tblCustomFieldsCFSupp9: TStringField;
    tblCustomFieldsCFIsCombo9: TStringField;
    tblCustomFieldsCFLabel10: TStringField;
    tblCustomFieldsCFCust10: TStringField;
    tblCustomFieldsCFEmpl10: TStringField;
    tblCustomFieldsCFSupp10: TStringField;
    tblCustomFieldsCFIsCombo10: TStringField;
    tblCustomFieldsCFLabel11: TStringField;
    tblCustomFieldsCFCust11: TStringField;
    tblCustomFieldsCFEmpl11: TStringField;
    tblCustomFieldsCFSupp11: TStringField;
    tblCustomFieldsCFIsCombo11: TStringField;
    tblCustomFieldsCFLabel12: TStringField;
    tblCustomFieldsCFCust12: TStringField;
    tblCustomFieldsCFEmpl12: TStringField;
    tblCustomFieldsCFSupp12: TStringField;
    tblCustomFieldsCFIsCombo12: TStringField;
    tblCustomFieldsCFLabel13: TStringField;
    tblCustomFieldsCFCust13: TStringField;
    tblCustomFieldsCFEmpl13: TStringField;
    tblCustomFieldsCFSupp13: TStringField;
    tblCustomFieldsCFIsCombo13: TStringField;
    tblCustomFieldsCFLabel14: TStringField;
    tblCustomFieldsCFCust14: TStringField;
    tblCustomFieldsCFEmpl14: TStringField;
    tblCustomFieldsCFSupp14: TStringField;
    tblCustomFieldsCFIsCombo14: TStringField;
    tblCustomFieldsCFLabel15: TStringField;
    tblCustomFieldsCFCust15: TStringField;
    tblCustomFieldsCFEmpl15: TStringField;
    tblCustomFieldsCFSupp15: TStringField;
    tblCustomFieldsCFIsCombo15: TStringField;
    tblCustomFieldsEditedFlag: TStringField;
    tblCustomFieldsCFOthr1: TStringField;
    tblCustomFieldsCFOthr2: TStringField;
    tblCustomFieldsCFOthr3: TStringField;
    tblCustomFieldsCFOthr4: TStringField;
    tblCustomFieldsCFOthr5: TStringField;
    tblCustomFieldsCFOthr6: TStringField;
    tblCustomFieldsCFOthr7: TStringField;
    tblCustomFieldsCFOthr8: TStringField;
    tblCustomFieldsCFOthr9: TStringField;
    tblCustomFieldsCFOthr10: TStringField;
    tblCustomFieldsCFOthr11: TStringField;
    tblCustomFieldsCFOthr12: TStringField;
    tblCustomFieldsCFOthr13: TStringField;
    tblCustomFieldsCFOthr14: TStringField;
    tblCustomFieldsCFOthr15: TStringField;
    tblCustomFieldsCFAssets1: TStringField;
    tblCustomFieldsCFAssets2: TStringField;
    tblCustomFieldsCFAssets3: TStringField;
    tblCustomFieldsCFAssets4: TStringField;
    tblCustomFieldsCFAssets5: TStringField;
    tblCustomFieldsCFAssets6: TStringField;
    tblCustomFieldsCFAssets7: TStringField;
    tblCustomFieldsCFAssets8: TStringField;
    tblCustomFieldsCFAssets9: TStringField;
    tblCustomFieldsCFAssets10: TStringField;
    tblCustomFieldsCFAssets11: TStringField;
    tblCustomFieldsCFAssets12: TStringField;
    tblCustomFieldsCFAssets13: TStringField;
    tblCustomFieldsCFAssets14: TStringField;
    tblCustomFieldsCFAssets15: TStringField;
    tblCustomFieldsCFCust16: TStringField;
    tblCustomFieldsCFCust17: TStringField;
    tblCustomFieldsCFCust18: TStringField;
    tblCustomFieldsCFEmpl16: TStringField;
    tblCustomFieldsCFEmpl17: TStringField;
    tblCustomFieldsCFEmpl18: TStringField;
    tblCustomFieldsCFSupp16: TStringField;
    tblCustomFieldsCFSupp17: TStringField;
    tblCustomFieldsCFSupp18: TStringField;
    tblCustomFieldsCFOthr16: TStringField;
    tblCustomFieldsCFOthr17: TStringField;
    tblCustomFieldsCFOthr18: TStringField;
    tblCustomFieldsCFAssets16: TStringField;
    tblCustomFieldsCFAssets17: TStringField;
    tblCustomFieldsCFAssets18: TStringField;
    tblCustomFieldsCFIsRequired1: TStringField;
    tblCustomFieldsCFIsRequired2: TStringField;
    tblCustomFieldsCFIsRequired3: TStringField;
    tblCustomFieldsCFIsRequired4: TStringField;
    tblCustomFieldsCFIsRequired5: TStringField;
    tblCustomFieldsCFIsRequired6: TStringField;
    tblCustomFieldsCFIsRequired7: TStringField;
    tblCustomFieldsCFIsRequired8: TStringField;
    tblCustomFieldsCFIsRequired9: TStringField;
    tblCustomFieldsCFIsRequired10: TStringField;
    tblCustomFieldsCFIsRequired11: TStringField;
    tblCustomFieldsCFIsRequired12: TStringField;
    tblCustomFieldsCFIsRequired13: TStringField;
    tblCustomFieldsCFIsRequired14: TStringField;
    tblCustomFieldsCFIsRequired15: TStringField;
    tblCustomFieldsCFLabel16: TStringField;
    tblCustomFieldsCFLabel17: TStringField;
    tblCustomFieldsCFLabel18: TStringField;
    tblCustomFieldsCFIsRequired16: TStringField;
    tblCustomFieldsCFIsRequired17: TStringField;
    tblCustomFieldsCFIsRequired18: TStringField;
    tblCustomFieldsID: TIntegerField;
    DNMPanel4: TDNMPanel;
    cboSort1: TComboBox;
    Option42: TRadioButton;
    Label43: TLabel;
    Option44: TRadioButton;
    Label45: TLabel;
    DNMPanel5: TDNMPanel;
    Label6: TLabel;
    Label7: TLabel;
    cboSort2: TComboBox;
    Option49: TRadioButton;
    Option51: TRadioButton;
    DNMPanel6: TDNMPanel;
    Label8: TLabel;
    Label9: TLabel;
    cboSort3: TComboBox;
    Option56: TRadioButton;
    Option58: TRadioButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure btnExportClick(Sender: TObject);
    procedure cboAndOr2Change(Sender: TObject);
    procedure cboAndOr3Change(Sender: TObject);
    procedure cboAndOr4Change(Sender: TObject);
    procedure cboAndOr5Change(Sender: TObject);
    procedure cboAndOr6Change(Sender: TObject);
    procedure cboCompare1Change(Sender: TObject);
    procedure cboCompare2Change(Sender: TObject);
    procedure cboCompare3Change(Sender: TObject);
    procedure cboCompare4Change(Sender: TObject);
    procedure cboCompare5Change(Sender: TObject);
    procedure cboComparison1Change(Sender: TObject);
    procedure cboComparison2Change(Sender: TObject);
    procedure cboComparison3Change(Sender: TObject);
    procedure cboComparison4Change(Sender: TObject);
    procedure cboComparison5Change(Sender: TObject);
    procedure cboComparison6Change(Sender: TObject);
    procedure cboField1Change(Sender: TObject);
    procedure cboField2Change(Sender: TObject);
    procedure cboField3Change(Sender: TObject);
    procedure cboField4Change(Sender: TObject);
    procedure cboField5Change(Sender: TObject);
    procedure cboField6Change(Sender: TObject);
    procedure cboSort1Change(Sender: TObject);
    procedure cboSort2Change(Sender: TObject);
    procedure cmdAutoSendClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdDocumentClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure grpSelectClick(Sender: TObject);
    procedure rgSelectChange(Sender: TObject);
    procedure rgSelectClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure TabCtl3Change(Sender: TObject);
    procedure txtLetterExit(Sender: TObject);
    procedure cboSortCloseUp(Sender: TObject);
  private
    { Private declarations }
    FMergeType: TMailMergeType;
    FEmailSender: T2cEmailSender;
    fsFax: boolean;
    fsReportName: string;
    fsLastFieldValue: array[1..6] of string;
    function CreateMergeTable: boolean;
    function GetCriteria: Variant;
    function GetUserMailMergeTempName: string;
    function SortBy: Variant;
    procedure AllowFilters;
    procedure CreateTempMailMergeTable;
    procedure DeleteTempStatementTable;
    procedure LoadTemplate(const MailMergeID: integer; const bPrint, bSave: boolean;
      const DoClose: boolean = true; const FileName: string = '');
      reintroduce;
    procedure EmailMailMerge(const MailMergeID: integer);
    procedure FaxMailMerge(const MailMergeID: integer);
    procedure ClearFilterAndSortCombos;
    procedure UpdateTableMergeFields;
    function IsEquipmentUsed: boolean;
    procedure TestSortValues;
  protected
    function GetReportTypeID: integer; override;
  public
    { Public declarations }
    
    function IsDateField(const sField: string): boolean;
  end;

var
  MFR: TMergeFieldRec;

function MergeFieldExists(const TableName, FieldName: string): boolean;
procedure InsertMergeFieldRecord(const MFR: TMergeFieldRec; const UpdateExisting: boolean);

implementation

uses FastFuncs,CommonDbLib, DNMLib, DNMExceptions, FaxObj,
    LoyaltyObj, CommonLib, AppEnvironment, tcDataUtils, ComObj, tcConst;

const
  GRP_LOYALTY_AMOUNT       = 0;
  GRP_LOYALTY_SALE_DAYS    = 1;
  GRP_LOYALTY_APPOINT_DAYS = 2;
  GRP_LOYALTY_CONTACT_APPOINT_DAYS = 3;

  {$R *.DFM}

function MergeFieldExists(const TableName, FieldName: string): boolean;
begin
  with TMyQuery.Create(nil) do try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.Add('SELECT Count(*) FROM tblmergefields');
      SQL.Add('WHERE TableName = :TableName AND FieldName = :FieldName');
      ParamByName('TableName').AsString := TableName;
      ParamByName('FieldName').AsString := FieldName;
      Open;
      Result := Fields[0].AsInteger > 0;
    finally
      Free;
    end;
end;

procedure InsertMergeFieldRecord(const MFR: TMergeFieldRec; const UpdateExisting: boolean);
var
  RecordExists: boolean;
begin
  RecordExists := MergeFieldExists(MFR.TableName, MFR.FieldName);
  if RecordExists then Exit; // update functionality not implemented yet
  
  with TMyQuery.Create(nil) do try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.Add('INSERT HIGH_PRIORITY INTO tblmergefields');
      SQL.Add('SET GlobalRef = :GlobalRef, TableName = :TableName, FieldName = :FieldName,');
      SQL.Add('FieldLabel = :FieldLabel, IsDate = :IsDate');
      ParamByName('GlobalRef').AsString := MFR.GlobalRef;
      ParamByName('TableName').AsString := MFR.TableName;
      ParamByName('FieldName').AsString := MFR.FieldName;
      ParamByName('FieldLabel').AsString := MFR.FieldLabel;
      ParamByName('IsDate').AsBoolean := MFR.IsDate;
      Execute;
    finally
      Free;
    end;
end;

procedure TfrmQueryOptions.cboAndOr2Change(Sender: TObject);
begin
  cboField2.Enabled := true;
  cboComparison2.Enabled := true;
end;

procedure TfrmQueryOptions.cboAndOr3Change(Sender: TObject);
begin
  cboField3.Enabled := true;
  cboComparison3.Enabled := true;
end;

procedure TfrmQueryOptions.cboAndOr4Change(Sender: TObject);
begin
  cboField4.Enabled := true;
  cboComparison4.Enabled := true;
end;

procedure TfrmQueryOptions.cboAndOr5Change(Sender: TObject);
begin
  cboField5.Enabled := true;
  cboComparison5.Enabled := true;
end;

procedure TfrmQueryOptions.cboAndOr6Change(Sender: TObject);
begin
  cboField6.Enabled := true;
  cboComparison6.Enabled := true;
end;

procedure TfrmQueryOptions.cboCompare1Change(Sender: TObject);
begin
  cboAndOr2.Enabled := true;
  cboField2.Enabled := true;
  cboComparison2.Enabled := true;
end;

procedure TfrmQueryOptions.cboCompare2Change(Sender: TObject);
begin
  cboAndOr3.Enabled := true;
  cboField3.Enabled := true;
  cboComparison3.Enabled := true;
end;

procedure TfrmQueryOptions.cboCompare3Change(Sender: TObject);
begin
  cboAndOr4.Enabled := true;
  cboField4.Enabled := true;
  cboComparison4.Enabled := true;
end;

procedure TfrmQueryOptions.cboCompare4Change(Sender: TObject);
begin
  cboAndOr5.Enabled := true;
  cboField5.Enabled := true;
  cboComparison5.Enabled := true;
end;

procedure TfrmQueryOptions.cboCompare5Change(Sender: TObject);
begin
  cboAndOr6.Enabled := true;
  cboField6.Enabled := true;
  cboComparison6.Enabled := true;
end;

procedure TfrmQueryOptions.cboComparison1Change(Sender: TObject);
begin
  if cboComparison1.Text = 'is blank' then cboAndOr2.Enabled := true
  else cboCompare1.Enabled := true;

  if cboComparison1.Text = 'is not blank' then cboAndOr2.Enabled := true
  else cboCompare1.Enabled := true;
end;

procedure TfrmQueryOptions.cboComparison2Change(Sender: TObject);
begin
  if cboComparison2.Text = 'is blank' then cboAndOr3.Enabled := true
  else cboCompare2.Enabled := true;

  if cboComparison2.Text = 'is not blank' then cboAndOr3.Enabled := true
  else cboCompare2.Enabled := true;
end;

procedure TfrmQueryOptions.cboComparison3Change(Sender: TObject);
begin
  if cboComparison3.Text = 'is blank' then cboAndOr4.Enabled := true
  else cboCompare3.Enabled := true;

  if cboComparison3.Text = 'is not blank' then cboAndOr4.Enabled := true
  else cboCompare3.Enabled := true;
end;

procedure TfrmQueryOptions.cboComparison4Change(Sender: TObject);
begin
  if cboComparison4.Text = 'is blank' then cboAndOr5.Enabled := true
  else cboCompare4.Enabled := true;
    
  if cboComparison4.Text = 'is not blank' then cboAndOr5.Enabled := true
  else cboCompare4.Enabled := true;
end;

procedure TfrmQueryOptions.cboComparison5Change(Sender: TObject);
begin
  if cboComparison5.Text = 'is blank' then cboAndOr6.Enabled := true
  else cboCompare5.Enabled := true;
    
  if cboComparison5.Text = 'is not blank' then cboAndOr6.Enabled := true
  else cboCompare5.Enabled := true;
end;

procedure TfrmQueryOptions.cboComparison6Change(Sender: TObject);
begin
  if cboComparison6.Text = 'is blank' then else cboCompare6.Enabled := true;

  if cboComparison6.Text = 'is not blank' then else cboCompare6.Enabled := true;
end;

procedure TfrmQueryOptions.cboSort1Change(Sender: TObject);
begin
  if (FastFuncs.SameText(cboSort1.Text, 'Equipment Name') or FastFuncs.SameText(cboSort1.Text, 'Equipment Description')) and
    (not IsEquipmentUsed) then begin
    CommonLib.MessageDlgXP_Vista('Equipment must be chosen in the filter fields to be used for sorting',
      mtInformation, [mbOK], 0);
  end;

  cboSort2.Enabled := true;
end;

procedure TfrmQueryOptions.cboSort2Change(Sender: TObject);
begin
  cboSort3.Enabled := true;
end;

procedure TfrmQueryOptions.cmdDocumentClick(Sender: TObject);
var
  oFileName: OleVariant;
  oMergeDoc: OleVariant;
  oPause: OleVariant;
begin
  if not CreateMergeTable then Exit;

  WordApplication1.Disconnect;
  WordApplication1.DDETerminateAll;
  WordApplication1.Connect;
  WordApplication1.Visible := true;
  
  oFileName := Self.txtLetter.Text;
  WordApplication1.Documents.Open(oFileName, EmptyParam,
    EmptyParam, EmptyParam, EmptyParam, EmptyParam,
    EmptyParam, EmptyParam, EmptyParam, EmptyParam,
    EmptyParam, EmptyParam);

  with WordApplication1.ActiveDocument.MailMerge do begin
    WordApplication1.ActiveDocument.MailMerge.Destination := wdSendToNewDocument;
    WordApplication1.ActiveDocument.MailMerge.SuppressBlankLines := true;
    WordApplication1.ActiveDocument.MailMerge.DataSource.FirstRecord := wdDefaultFirstRecord;
    WordApplication1.ActiveDocument.MailMerge.DataSource.LastRecord := integer(wdDefaultLastRecord);
    Try
      WordApplication1.ActiveDocument.MailMerge.Execute(oPause);
    except
      on E: EOleException do begin
        CommonLib.MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
      end;
    end;
  end;

  oMergeDoc := txtLetter.Text;
  
  WordApplication1.Documents.Item(oMergeDoc).Activate;
  WordApplication1.ActiveDocument.Close(EmptyParam, EmptyParam, EmptyParam);
  WordApplication1.Activate;
  WordApplication1.Disconnect;
  WordApplication1.DDETerminateAll;

  Self.Close;
end;

procedure TfrmQueryOptions.grpSelectClick(Sender: TObject);
begin
  cboField1.Text := '';
  cboField2.Text := '';
  cboField3.Text := '';
  cboField4.Text := '';
  cboField5.Text := '';
  cboField6.Text := '';
  cboAndOr2.Text := '';
  cboAndOr3.Text := '';
  cboAndOr4.Text := '';
  cboAndOr5.Text := '';
  cboAndOr6.Text := '';
  cboComparison1.Text := '';
  cboComparison2.Text := '';
  cboComparison3.Text := '';
  cboComparison4.Text := '';
  cboComparison5.Text := '';
  cboComparison6.Text := '';
  cboCompare1.Text := '';
  cboCompare2.Text := '';
  cboCompare3.Text := '';
  cboCompare4.Text := '';
  cboCompare5.Text := '';
  cboCompare6.Text := '';
  cboSort1.Text := '';
  cboSort2.Text := '';
  cboSort3.Text := '';
  cboField2.Enabled := false;
  cboField3.Enabled := false;
  cboField4.Enabled := false;
  cboField5.Enabled := false;
  cboField6.Enabled := false;
  cboAndOr2.Enabled := false;
  cboAndOr3.Enabled := false;
  cboAndOr4.Enabled := false;
  cboAndOr5.Enabled := false;
  cboAndOr6.Enabled := false;
  cboComparison2.Enabled := false;
  cboComparison3.Enabled := false;
  cboComparison4.Enabled := false;
  cboComparison5.Enabled := false;
  cboComparison6.Enabled := false;
  cboCompare2.Enabled := false;
  cboCompare1.Enabled := false;
  cboCompare3.Enabled := false;
  cboCompare4.Enabled := false;
  cboCompare5.Enabled := false;
  cboCompare6.Enabled := false;
  cboSort2.Enabled := false;
  cboSort3.Enabled := false;
end;

function TfrmQueryOptions.GetCriteria: Variant;
var
  strCriteria: string;
  arrX: array[0..8] of string;
  arrY: array[0..8] of string;
  intX: integer;
  bDateField: boolean;
  wYear, wMonth, wDay: word;
  sDateString: string;
begin
  arrX[0] := 'equal to';
  arrX[1] := 'not equal to';
  arrX[2] := 'less than';
  arrX[3] := 'greater than';
  arrX[4] := 'less than or equal';
  arrX[5] := 'greater than or equal';
  arrX[6] := 'is blank';
  arrX[7] := 'is not blank';
  arrX[8] := 'starts with';
  arrY[0] := '=';
  arrY[1] := '<>';
  arrY[2] := '<';
  arrY[3] := '>';
  arrY[4] := '<=';
  arrY[5] := '>=';
  //    arrY[6] := 'Is Null';
  //    arrY[7] := 'Is Not Null';
  arrY[6] := '=""';
  arrY[7] := '<>""';
  arrY[8] := 'Like';

  if (cboField1.Text <> '') and (cboComparison1.Text <> '') then begin
    bDateField := IsDateField(cboField1.Text);
    DecodeDate(dtp1.DateTime, wYear, wMonth, wDay);
    sDateString := FastFuncs.IntToStr(wYear) + '-' + FastFuncs.IntToStr(wMonth) + '-' + FastFuncs.IntToStr(wDay);

    for intX := 0 to 8 do begin
      if cboComparison1.Text = arrX[intX] then begin
        if not bDateField then begin
          if cboCompare1.Text <> '' then begin
            if cboComparison1.Text <> arrX[8] then begin
              strCriteria := '`' + cboField1.Text + '` ' + arrY[intX] + ' "' + cboCompare1.Text + '"'
            end else begin
              strCriteria := '`' + cboField1.Text + '` ' + arrY[intX] + ' "' + cboCompare1.Text + '%"';
            end;
          end else begin
            strCriteria := '`' + cboField1.Text + '` ' + arrY[intX];
          end;
        end else begin
          if cboComparison1.Text <> arrX[8] then begin
            strCriteria := '`' + cboField1.Text + '` ' + arrY[intX] + ' "' + sDateString + '"'
          end else begin
            strCriteria := '`' + cboField1.Text + '` ' + arrY[intX] + ' "' + sDateString + '%"';
          end;
        end;
      end;
    end;

    if (cboAndOr2.Text <> '') and (cboField2.Text <> '') and (cboComparison2.Text <> '') then begin
      bDateField := IsDateField(cboField2.Text);
      DecodeDate(dtp2.DateTime, wYear, wMonth, wDay);
      sDateString := FastFuncs.IntToStr(wYear) + '-' + FastFuncs.IntToStr(wMonth) + '-' + FastFuncs.IntToStr(wDay);
      for intX := 0 to 8 do begin
        if cboComparison2.Text = arrX[intX] then begin
          if not bDateField then begin
            if (cboCompare2.Text <> '') then begin
              if cboComparison2.Text <> arrX[8] then begin
                strCriteria := strCriteria + ' ' + cboAndOr2.Text + ' ' + '`' + cboField2.Text +
                  '` ' + arrY[intX] + ' "' + cboCompare2.Text + '"';
              end else begin
                strCriteria := strCriteria + ' ' + cboAndOr2.Text + ' ' + '`' + cboField2.Text +
                  '` ' + arrY[intX] + ' "' + cboCompare2.Text + '%"';
              end;
            end else begin
              strCriteria := strCriteria + ' ' + cboAndOr2.Text + ' ' + '`' + cboField2.Text + '` ' + arrY[intX];
            end;
          end else begin
            if cboComparison2.Text <> arrX[8] then begin
              strCriteria := strCriteria + ' ' + cboAndOr2.Text + ' ' + '`' + cboField2.Text +
                '` ' + arrY[intX] + ' "' + sDateString + '"'
            end else begin
              strCriteria := strCriteria + ' ' + cboAndOr2.Text + ' ' + '`' + cboField2.Text +
                '` ' + arrY[intX] + ' "' + sDateString + '%"'
            end;
          end;
        end;
      end;

      if (cboAndOr3.Text <> '') and (cboField3.Text <> '') and
        (cboComparison3.Text <> '') then begin
        bDateField := IsDateField(cboField3.Text);
        DecodeDate(dtp3.DateTime, wYear, wMonth, wDay);
        sDateString := FastFuncs.IntToStr(wYear) + '-' + FastFuncs.IntToStr(wMonth) + '-' + FastFuncs.IntToStr(wDay);
        for intX := 0 to 8 do begin
          if cboComparison3.Text = arrX[intX] then begin
            if not bDateField then begin
              if cboCompare3.Text <> '' then begin
                if cboComparison3.Text <> arrX[8] then begin
                  strCriteria := strCriteria + ' ' + cboAndOr3.Text + ' ' + QuotedStr(cboField3.Text) +
                    ' ' + arrY[intX] + ' "' + cboCompare3.Text + '"';
                end else begin
                  strCriteria := strCriteria + ' ' + cboAndOr3.Text + ' ' + QuotedStr(cboField3.Text) +
                    ' ' + arrY[intX] + ' "' + cboCompare3.Text + '%"';
                end;
              end else begin
                strCriteria := strCriteria + ' ' + cboAndOr3.Text + ' ' + QuotedStr(cboField3.Text) + ' ' + arrY[intX];
              end;
            end else begin
              if cboComparison3.Text <> arrX[8] then begin
                strCriteria := strCriteria + ' ' + cboAndOr3.Text + ' ' + QuotedStr(cboField3.Text)
                  + ' ' + arrY[intX] + ' "' + sDateString + '"';
              end else begin
                strCriteria := strCriteria + ' ' + cboAndOr3.Text + ' ' + QuotedStr(cboField3.Text)
                  + ' ' + arrY[intX] + ' "' + sDateString + '%"';
              end;
            end;
          end;
        end;

        if (cboAndOr4.Text <> '') and (cboField4.Text <> '') and
          (cboComparison4.Text <> '') then begin
          bDateField := IsDateField(cboField4.Text);
          DecodeDate(dtp4.DateTime, wYear, wMonth, wDay);
          sDateString := FastFuncs.IntToStr(wYear) + '-' + FastFuncs.IntToStr(wMonth) + '-' + FastFuncs.IntToStr(wDay);
          for intX := 0 to 8 do begin
            if cboComparison4.Text = arrX[intX] then begin
              if not bDateField then begin
                if cboCompare4.Text <> '' then begin
                  if cboComparison4.Text <> arrX[8] then begin
                    strCriteria := strCriteria + ' ' + cboAndOr4.Text + ' ' + QuotedStr(cboField4.Text) +
                      ' ' + arrY[intX] + ' "' + cboCompare4.Text + '"';
                  end else begin
                    strCriteria := strCriteria + ' ' + cboAndOr4.Text + ' ' + QuotedStr(cboField4.Text) +
                      ' ' + arrY[intX] + ' "' + cboCompare4.Text + '%"';
                  end;
                end else begin
                  strCriteria := strCriteria + ' ' + cboAndOr4.Text + ' ' + QuotedStr(cboField4.Text) + ' ' + arrY[intX]
                end;
              end else begin
                if cboComparison4.Text <> arrX[8] then begin
                  strCriteria := strCriteria + ' ' + cboAndOr4.Text + ' ' + QuotedStr(cboField4.Text) +
                    ' ' + arrY[intX] + ' "' + sDateString + '"';
                end else begin
                  strCriteria := strCriteria + ' ' + cboAndOr4.Text + ' ' + QuotedStr(cboField4.Text) +
                    ' ' + arrY[intX] + ' "' + sDateString + '%"';
                end;
              end;
            end;
          end;

          if (cboAndOr5.Text <> '') and (cboField5.Text <> '') and
            (cboComparison5.Text <> '') then begin
            bDateField := IsDateField(cboField5.Text);
            DecodeDate(dtp5.DateTime, wYear, wMonth, wDay);
            sDateString := FastFuncs.IntToStr(wYear) + '-' + FastFuncs.IntToStr(wMonth) + '-' + FastFuncs.IntToStr(wDay);
            for intX := 0 to 8 do begin
              if cboComparison5.Text = arrX[intX] then begin
                if not bDateField then begin
                  if cboCompare5.Text <> '' then begin
                    if cboComparison5.Text <> arrX[8] then begin
                      strCriteria := strCriteria + ' ' + cboAndOr5.Text + ' ' + QuotedStr(cboField5.Text)
                        + ' ' + arrY[intX] + ' "' + cboCompare5.Text + '"';
                    end else begin
                      strCriteria := strCriteria + ' ' + cboAndOr5.Text + ' ' + QuotedStr(cboField5.Text)
                        + ' ' + arrY[intX] + ' "' + cboCompare5.Text + '%"';
                    end;
                  end else begin
                    strCriteria := strCriteria + ' ' + cboAndOr5.Text + ' ' + QuotedStr(cboField5.Text) + ' ' + arrY[intX];
                  end;
                end else begin
                  if cboComparison5.Text <> arrX[8] then begin
                    strCriteria := strCriteria + ' ' + cboAndOr5.Text + ' ' + QuotedStr(cboField5.Text) +
                      ' ' + arrY[intX] + ' "' + sDateString + '"';
                  end else begin
                    strCriteria := strCriteria + ' ' + cboAndOr5.Text + ' ' + QuotedStr(cboField5.Text) +
                      ' ' + arrY[intX] + ' "' + sDateString + '%"';
                  end;
                end;
              end;
            end;

            if (cboAndOr6.Text <> '') and (cboField6.Text <> '') and
              (cboComparison6.Text <> '') then begin
              bDateField := IsDateField(cboField6.Text);
              DecodeDate(dtp6.DateTime, wYear, wMonth, wDay);
              sDateString := FastFuncs.IntToStr(wYear) + '-' + FastFuncs.IntToStr(wMonth) + '-' + FastFuncs.IntToStr(wDay);
              for intX := 0 to 8 do begin
                if cboComparison6.Text = arrX[intX] then begin
                  if not bDateField then begin
                    if cboCompare6.Text <> '' then begin
                      if cboComparison6.Text <> arrX[8] then begin
                        strCriteria := strCriteria + ' ' + cboAndOr6.Text + ' ' + QuotedStr(cboField6.Text) +
                          ' ' + arrY[intX] + ' "' + cboCompare6.Text + '"';
                      end else begin
                        strCriteria := strCriteria + ' ' + cboAndOr6.Text + ' ' + QuotedStr(cboField6.Text) +
                          ' ' + arrY[intX] + ' "' + cboCompare6.Text + '%"';
                      end;
                    end else begin
                      strCriteria := strCriteria + ' ' + cboAndOr6.Text + ' ' + QuotedStr(cboField6.Text) + ' ' + arrY[intX];
                    end;
                  end else begin
                    if cboComparison6.Text <> arrX[8] then begin
                      strCriteria := strCriteria + ' ' + cboAndOr6.Text + ' ' + QuotedStr(cboField6.Text)
                        + ' ' + arrY[intX] + ' "' + sDateString + '"';
                    end else begin
                      strCriteria := strCriteria + ' ' + cboAndOr6.Text + ' ' + QuotedStr(cboField6.Text)
                        + ' ' + arrY[intX] + ' "' + sDateString + '%"';
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  GetCriteria := strCriteria;
end;

function TfrmQueryOptions.SortBy: Variant;
var
  strSortBy: string;
begin
  strSortBy := '';

  if cboSort1.Text <> '' then begin
    strSortBy := ' ORDER BY ' + '`' + cboSort1.Text + '`';

    if Option44.Checked = true then begin
      strSortBy := strSortBy + ' DESC';
    end;

    if cboSort2.Text <> '' then begin
      strSortBy := strSortBy + ', `' + cboSort2.Text + '`';

      if Option51.Checked = true then begin
        strSortBy := strSortBy + ' DESC';
      end;

      if cboSort3.Text <> '' then begin
        strSortBy := strSortBy + ', `' + cboSort3.Text + '`';

        if Option58.Checked = true then begin
          strSortBy := strSortBy + ' DESC';
        end;
      end;
    end;
  end;

  SortBy := strSortBy;
end;

procedure TfrmQueryOptions.cmdCloseClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  Self.Close;
  Screen.Cursor := crDefault;
end;

procedure TfrmQueryOptions.FormShow(Sender: TObject);
begin
  try
    inherited;
    cboField1.Text         := '';
    cboField2.Text         := '';
    cboField3.Text         := '';
    cboField4.Text         := '';
    cboField5.Text         := '';
    cboField6.Text         := '';
    cboAndOr2.Text         := '';
    cboAndOr3.Text         := '';
    cboAndOr4.Text         := '';
    cboAndOr5.Text         := '';
    cboAndOr6.Text         := '';
    cboComparison1.Text    := '';
    cboComparison2.Text    := '';
    cboComparison3.Text    := '';
    cboComparison4.Text    := '';
    cboComparison5.Text    := '';
    cboComparison6.Text    := '';
    cboCompare1.Text       := '';
    cboCompare2.Text       := '';
    cboCompare3.Text       := '';
    cboCompare4.Text       := '';
    cboCompare5.Text       := '';
    cboCompare6.Text       := '';
    cboSort1.Text          := '';
    cboSort2.Text          := '';
    cboSort3.Text          := '';
    cboField1.Enabled      := false;
    cboField2.Enabled      := false;
    cboField3.Enabled      := false;
    cboField4.Enabled      := false;
    cboField5.Enabled      := false;
    cboField6.Enabled      := false;
    cboAndOr2.Enabled      := false;
    cboAndOr3.Enabled      := false;
    cboAndOr4.Enabled      := false;
    cboAndOr5.Enabled      := false;
    cboAndOr6.Enabled      := false;
    cboComparison1.Enabled := false;
    cboComparison2.Enabled := false;
    cboComparison3.Enabled := false;
    cboComparison4.Enabled := false;
    cboComparison5.Enabled := false;
    cboComparison6.Enabled := false;
    cboCompare1.Enabled    := false;
    cboCompare2.Enabled    := false;
    cboCompare3.Enabled    := false;
    cboCompare4.Enabled    := false;
    cboCompare5.Enabled    := false;
    cboCompare6.Enabled    := false;
    cboSort1.Enabled       := false;
    cboSort2.Enabled       := false;
    cboSort3.Enabled       := false;
    txtLetter.Enabled      := false;
    SpeedButton1.Enabled   := false;
    cmdAutoSend.Enabled    := false;
    cmdDocument.Enabled    := false;
    FirstPreference.ItemIndex := 0;
    SecondPreference.ItemIndex := 1;
    ThirdPreference.ItemIndex := 2;
    WordApplication1.Disconnect;
    WordApplication1.DDETerminateAll;
    rgSelectClick(Sender);
    rgSelectChange(Sender);
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    else raise;
  end;
end;

procedure TfrmQueryOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseQueries;
  tblCustomFields.Close;
  tblWordMerge.Close;
  WordApplication1.Disconnect;
  WordApplication1.DDETerminateAll;
  Action := caFree;
  inherited;
end;

procedure TfrmQueryOptions.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName) + 'Letter Templates';
  if OpenDialog1.Execute then begin
    txtLetter.Text := Opendialog1.FileName;
    txtLetter.OnExit(txtLetter);
  end;
end;

procedure TfrmQueryOptions.FormCreate(Sender: TObject);
begin
  inherited;
  //   tblCustomFields.Connection := MyConnection;
  //   tblWordMerge.Connection := MyConnection;
  FEmailSender := T2cEmailSender.Create;
  UpdateTableMergeFields;
end;

procedure TfrmQueryOptions.rgSelectClick(Sender: TObject);
begin
  FMergeType := TMailMergeType(rgSelect.ItemIndex);
  
  Filter_Records.TabVisible := FMergeType <> mmLoyalty;
  Sort_Records.TabVisible := FMergeType <> mmLoyalty;
  tabLoyalty.TabVisible := FMergeType <> mmLoyalty;

  if FMergeType = mmLoyalty then TabCtl3.ActivePage := tabLoyalty
  else TabCtl3.ActivePage := Filter_Records;

  txtLetter.Enabled := FMergeType <> mmLoyalty;
  SpeedButton1.Enabled := FMergeType <> mmLoyalty;
  cmdAutoSend.Enabled := true;
  cmdDocument.Enabled := false;
end;

procedure TfrmQueryOptions.txtLetterExit(Sender: TObject);
begin
  inherited;
  if not Empty(txtLetter.Text) then begin
    if DirectoryExists(ExtractFileDir(txtLetter.Text)) then begin
      if FileExists(txtLetter.Text) then begin
        cmdAutoSend.Enabled := false;
        cmdDocument.Enabled := true;
      end else begin
        CommonLib.MessageDlgXP_Vista('File "' + txtLetter.Text + '"' + #13 + 'Does Not Exist !',
          mtWarning, [mbOK], 0);
        cmdAutoSend.Enabled := true;
        cmdDocument.Enabled := false;
      end;
    end else begin
      CommonLib.MessageDlgXP_Vista('Directory "' + ExtractFileDir(txtLetter.Text) + '"' + #13 +
        ' Does Not Exist !', mtWarning, [mbOK], 0);
      cmdAutoSend.Enabled := true;
      cmdDocument.Enabled := false;
    end;
  end else begin
    cmdAutoSend.Enabled := true;
    cmdDocument.Enabled := false;
  end;
end;

function TfrmQueryOptions.CreateMergeTable: boolean;
var
  MMString, sCustDateSQL: string;
  SL: TStrings;
  Min, Max, I, J: integer;
  EquipmentUsed: boolean;
begin
  Result := true;
  EquipmentUsed := IsEquipmentUsed;

  qryMailMerge.SQL.Clear;
  qryMailMerge.SQL.Add('DROP TABLE IF EXISTS tblAWordMerge');
  qryMailMerge.Execute;
  qryMailMerge.SQL.Clear;
  qryMailMerge.SQL.Add('CREATE TABLE tblAWordMerge TYPE=MyISAM ');

  if FMergeType <> mmEmployees then begin
    qryMailMerge.SQL.Add('SELECT Company, Title AS Title,');
    qryMailMerge.SQL.Add('FirstName AS "First Name", LastName AS "Last Name",');
    qryMailMerge.SQL.Add('Street AS Address, Street2 AS "Street 2",');
    qryMailMerge.SQL.Add('Suburb, State, Postcode, BillStreet AS "Bill Address",');
    qryMailMerge.SQL.Add('BillStreet2 AS "Bill Street 2", BillSuburb AS "Bill Suburb",');
    qryMailMerge.SQL.Add('BillState AS "Bill State", BillPostcode AS "Bill Postcode",');
    qryMailMerge.SQL.Add('BillCountry as "Bill Country", Phone, AltPhone AS "Alt Phone",');
    qryMailMerge.SQL.Add('Mobile, FaxNumber AS Fax, Email,');
    qryMailMerge.SQL.Add('PhoneSupportTill AS "Phone Support Till", Contact1 AS "Contact 1",');
    qryMailMerge.SQL.Add('Contact2 AS "Contact 2", Contact1Phone AS "Contact 1 Phone",');
    qryMailMerge.SQL.Add('Contact2Phone AS "Contact 2 Phone", CreationDate AS "Creation Date",');
    qryMailMerge.SQL.Add('UpdateDate AS "Update Date", ClientNo AS "Account No", ABN,');
    qryMailMerge.SQL.Add('Feedback, Discount, SpecialDiscount AS "Special Discount", ');

    if FMergeType = mmCustomers then begin
      qryMailMerge.SQL.Add('JobName AS "Job Name", IsJob AS "Is Job",RepName AS "Rep Name",');
      qryMailMerge.SQL.Add('Customer, Supplier, OtherContact AS "Other Contact",');
      qryMailMerge.SQL.Add('tblClients.ClientTypeID, tblClients.Active,');
      qryMailMerge.SQL.Add('tblclienttype.TypeName AS "Customer Type",')
    end else begin
      qryMailMerge.SQL.Add('JobName AS "Job Name", IsJob AS "Is Job",');
      qryMailMerge.SQL.Add('RepName AS "Rep Name", Customer, Supplier, OtherContact AS "Other Contact", Active,');
    end;
  end else begin // merge type = employees
    qryMailMerge.SQL.Add('SELECT');
    qryMailMerge.SQL.Add('Company, Title AS Title, FirstName AS "First Name",');
    qryMailMerge.SQL.Add('LastName AS "Last Name", Street AS Address, Street2 AS "Street 2",');
    qryMailMerge.SQL.Add('Suburb, State, Postcode, Country,');
    qryMailMerge.SQL.Add('Phone, AltPhone AS "Alt Phone", Mobile,');
    qryMailMerge.SQL.Add('FaxNumber AS Fax, Email, AltContact AS "Alt Contact",');
    qryMailMerge.SQL.Add('CreationDate AS "Creation Date",');
    qryMailMerge.SQL.Add('DateStarted AS "Date Started",');
    qryMailMerge.SQL.Add('DateFinished AS "Date Finished", ABN, Active,');
  end;

  tblCustomFields.Open;

//  if tblCustomFieldsCFCust1.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD1 as CFLabel1, ');
//  if tblCustomFieldsCFCust2.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD2 as CFLabel2, ');
//  if tblCustomFieldsCFCust3.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD3 as CFLabel3, ');
//  if tblCustomFieldsCFCust4.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD4 as CFLabel4, ');
//  if tblCustomFieldsCFCust5.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD5 as CFLabel5, ');
//  if tblCustomFieldsCFCust6.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD6 as CFLabel6, ');
//  if tblCustomFieldsCFCust7.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD7 as CFLabel7, ');
//  if tblCustomFieldsCFCust8.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD8 as CFLabel8, ');
//  if tblCustomFieldsCFCust9.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD9 as CFLabel9, ');
//  if tblCustomFieldsCFCust10.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD10 as CFLabel10, ');
//  if tblCustomFieldsCFCust11.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD11 as CFLabel11, ');
//  if tblCustomFieldsCFCust12.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD12 as CFLabel12, ');
//  if tblCustomFieldsCFCust13.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD13 as CFLabel13, ');
//  if tblCustomFieldsCFCust14.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD14 as CFLabel14, ');
//  if tblCustomFieldsCFCust15.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD15 as CFLabel15, ');

   if tblCustomFieldsCFCust1.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD1, ');
  if tblCustomFieldsCFCust2.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD2, ');
  if tblCustomFieldsCFCust3.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD3, ');
  if tblCustomFieldsCFCust4.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD4, ');
  if tblCustomFieldsCFCust5.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD5, ');
  if tblCustomFieldsCFCust6.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD6, ');
  if tblCustomFieldsCFCust7.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD7, ');
  if tblCustomFieldsCFCust8.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD8, ');
  if tblCustomFieldsCFCust9.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD9, ');
  if tblCustomFieldsCFCust10.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD10, ');
  if tblCustomFieldsCFCust11.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD11, ');
  if tblCustomFieldsCFCust12.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD12, ');
  if tblCustomFieldsCFCust13.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD13, ');
  if tblCustomFieldsCFCust14.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD14, ');
  if tblCustomFieldsCFCust15.AsBoolean then qryMailMerge.SQL.Add('CUSTFLD15, ');

  sCustDateSQL := '';

  if FMergeType <> mmEmployees then begin
    if tblCustomFieldsCFCust16.AsBoolean then if sCustDateSQL = '' then sCustDateSQL := 'CUSTDATE1 as CUSTDATE1';

    if tblCustomFieldsCFCust17.AsBoolean then if sCustDateSQL = '' then sCustDateSQL := 'CUSTDATE2 as CUSTDATE2'
      else sCustDateSQL := sCustDateSQL + ', CUSTDATE2 as CUSTDATE2';

    if tblCustomFieldsCFCust18.AsBoolean then if sCustDateSQL = '' then sCustDateSQL := 'CUSTDATE3 as CUSTDATE3'
      else sCustDateSQL := sCustDateSQL + ', CUSTDATE3 as CUSTDATE3';

    if sCustDateSQL <> '' then qryMailMerge.SQL.Add(sCustDateSQL + ',');

    if (FMergeType = mmCustomers) and EquipmentUsed then
      qryMailMerge.SQL.Add(' EquipmentName AS "Equipment Name", EquipmentDescription AS "Equipment Description", ');

    qryMailMerge.SQL.Add(' Phone AS Filler ');
    qryMailMerge.SQL.Add(' FROM tblClients')
  end else begin
    qryMailMerge.SQL.Add(' Phone AS Filler ');
    qryMailMerge.SQL.Add(' FROM tblEmployees');
  end;

  case FMergeType of
    mmCustomers:
      begin
        qryMailMerge.SQL.Add(' LEFT JOIN tblclienttype Using(ClientTypeID)');

        if EquipmentUsed then begin
          qryMailMerge.SQL.Add(' LEFT JOIN tblcustomerequip ce ON tblClients.ClientID=ce.ClientID');
          qryMailMerge.SQL.Add(' LEFT JOIN tblequipment USING(EquipmentID)');
        end;

        qryMailMerge.SQL.Add(' WHERE tblClients.Active="T" AND Customer="T" ');

        if not EquipmentUsed then qryMailMerge.SQL.Add('GROUP BY Company');
      end;

    mmSuppliers:
      begin
        qryMailMerge.SQL.Add(' WHERE tblClients.Active="T" AND Supplier="T"');
      end;

    mmEmployees:
      begin
        qryMailMerge.SQL.Add(' WHERE Active="T"');
      end;

    mmOtherContact:
      begin
        qryMailMerge.SQL.Add(' WHERE tblClients.Active="T" AND OtherContact="T"');
      end;

    mmLoyalty:
      begin
      end;
  end;

  if cboField1.Text <> '' then qryMailMerge.SQL.Add('HAVING ' + VarToStr(GetCriteria));

  if cboSort1.Text <> '' then qryMailMerge.SQL.Add(VarToStr(SortBy));

  DeleteFile('C:\Platinum1\tblAWordMerge.txt');

  try
    tblWordMerge.Close;
    qryMailMerge.Execute;
    tblWordMerge.Open;

    if tblWordMerge.IsEmpty then begin
      CommonLib.MessageDlgXP_Vista('There Are No Records Matching Your Selected Criteria !',
        mtWarning, [mbOK], 0);
      Result := false;
      Exit;
    end;
  except
    on E: EMyError do begin
      CommonLib.MessageDlgXP_Vista('There Is a Mismatch In Your Selected Criteria !', mtWarning, [mbOK], 0);

      //ErrorMsg := 'Error: ' + E.Message + CRLF + qryMailMerge.SQL.Text;
      //LogMessage(ErrorMsg, 'C:\QueryText.txt');

      TabCtl3.ActivePage := Filter_Records;
      Result := false;
      Exit;
    end else raise;
  end;

  DeleteTempStatementTable;
  CreateTempMailMergeTable;

  if qrytmpMailMerge.Active then qrytmpMailMerge.Close;

  qrytmpMailMerge.SQL.Clear;
  qrytmpMailMerge.SQL.Add('SELECT * FROM ' + GetUserMailMergeTempName + ';');
  qrytmpMailMerge.Open;

  with tblWordMerge do begin
    SL := TStringList.Create; // Creates new list

    try
      Min := 0;
      Max := tblWordMerge.RecordCount - 1;
      for j := 0 to tblWordMerge.FieldCount - 2 do MMString := MMString + '"' + tblWordMerge.Fields[j].FieldName + '",';

      MMString := MMString + '"' + tblWordMerge.Fields[tblWordMerge.FieldCount - 1].FieldName + '"' + #13;
      SL.Add(MMString);
      MMString := '';
      tblWordMerge.First;

      for i := Min to Max do begin
        qrytmpMailMerge.Insert;
        for j := 0 to tblWordMerge.FieldCount - 2 do begin
          MMString := MMString + '"' + FastFuncs.Trim(tblWordMerge.Fields[j].AsString) + '",';

          // Add field to Email temp table incase we are emailing (is EmailMergeFlag set to 1 ?)
          if not (tblWordMerge.Fields[j].isnull) then Begin
            Try
              qrytmpMailMerge.FieldByName(tblWordMerge.Fields[j].FieldName).AsVariant := FastFuncs.Trim(tblWordMerge.Fields[j].AsVariant);
            except
              Continue;
            end;
          end;
        end;

        MMString := MMString + '"' + FastFuncs.Trim(tblWordMerge.Fields[tblWordMerge.FieldCount - 1].AsString) + '"' + #13;
        SL.Add(MMString);
        MMString := '';
        tblWordMerge.Next;
      end;
      qrytmpMailMerge.Post;
      SL.SaveToFile('C:\Platinum1\tblAWordMerge.txt'); { save the list }
    finally
      FreeandNil(SL);
    end;
  end;
end;

procedure TfrmQueryOptions.cmdAutoSendClick(Sender: TObject);
var
  i: integer;
  Sent: boolean;
  oLoyalty: TLoyalty;
begin
  inherited;

  Screen.Cursor := crHourGlass;

  try
    if chkChooseRpt.Checked then begin
      LoadReportTypes;

      if dlgReportSelect.Execute then begin
        ReportToPrint := dlgReportSelect.SelectedItems.Text;

        if not Empty(ReportToPrint) then begin
          fsReportName := TemplateNameToTemplateClassName(FastFuncs.Trim(ReportToPrint));
        end else begin
          fsReportName := GetDefaultReport(GetReportTypeID);
        end;
      end;
    end else begin
      fsReportName := GetDefaultReport(GetReportTypeID);
    end;

    if Empty(fsReportName) then begin
      CommonLib.MessageDlgXP_Vista('No Template Provided', mtError, [mbOK], 0);
      Exit;
    end;

    Application.ProcessMessages;

    if FMergeType = mmLoyalty then begin
      // retrieve Loyalty program clients and populate the Mail merge table

      oLoyalty := TLoyalty.Create;

      try
        if grpLoyalty.ItemIndex = GRP_LOYALTY_AMOUNT then begin
          oLoyalty.RecordAmountClients;
        end else if grpLoyalty.ItemIndex = GRP_LOYALTY_SALE_DAYS then begin
          oLoyalty.RecordSaleDaysClients;
        end else if grpLoyalty.ItemIndex = GRP_LOYALTY_APPOINT_DAYS then begin
          oLoyalty.RecordAppointDaysClients;
        end else if grpLoyalty.ItemIndex = GRP_LOYALTY_CONTACT_APPOINT_DAYS then begin
          oLoyalty.RecordAppointDaysContacts;
        end;

        if not oLoyalty.bAnyFound then begin
          CommonLib.MessageDlgXP_Vista('None found, No Mailout', mtWarning, [mbOK], 0);
          oLoyalty.SetReminderDate;
          Exit;
        end;

        if qrytmpMailMerge.Active then qrytmpMailMerge.Close;
        qrytmpMailMerge.SQL.Clear;
        qrytmpMailMerge.SQL.Add('SELECT * FROM ' + GetUserMailMergeTempName +
          ';');
      finally
        FreeandNil(oLoyalty);
      end;
    end else begin
      // get here for non loyalty program mailouts
      if not CreateMergeTable then Exit;
    end;

    qrytmpMailMerge.Open;
    qrytmpMailMerge.First;
    for i := 0 to qrytmpMailMerge.RecordCount - 1 do begin
      Sent := false;
      case FirstPreference.ItemIndex of
        0:
          begin {Email}
            if not
              Empty(GetClientEmail(GetClientID(qrytmpMailMerge.FieldByName('Company').AsString))) then begin
              ReportToPrint := '';
              EmailMailMerge(qrytmpMailMerge.FieldByName('MailMergeID').AsInteger);
              Sent := true;
            end;
          end;
        1:
          begin {Fax}
            if not
              Empty(GetClientFaxNumber(GetClientID(qrytmpMailMerge.FieldByName('Company').AsString))) then begin
              ReportToPrint := '';
              FaxMailMerge(qrytmpMailMerge.FieldByName('MailMergeID').AsInteger);
              Sent := true;
            end;
          end;
        2:
          begin {Printer}
            ReportToPrint := '';
            LoadTemplate(qrytmpMailMerge.FieldByName('MailMergeID').AsInteger,
              true, false);
            Sent := true;
          end;
      end;
      if not Sent then begin
        case SecondPreference.ItemIndex of
          0:
            begin {Email}
              if not
                Empty(GetClientEmail(GetClientID(qrytmpMailMerge.FieldByName('Company').AsString))) then begin
                ReportToPrint := '';
                EmailMailMerge(qrytmpMailMerge.FieldByName('MailMergeID').AsInteger);
                Sent := true;
              end;
            end;
          1:
            begin {Fax}
              if not
                Empty(GetClientFaxNumber(GetClientID(qrytmpMailMerge.FieldByName('Company').AsString))) then begin
                ReportToPrint := '';
                FaxMailMerge(qrytmpMailMerge.FieldByName('MailMergeID').AsInteger);
                Sent := true;
              end;
            end;
          2:
            begin {Printer}
              ReportToPrint := '';
              LoadTemplate(qrytmpMailMerge.FieldByName('MailMergeID').AsInteger,
                true, false);
              Sent := true;
            end;
        end;
      end;

      if not Sent then begin
        case ThirdPreference.ItemIndex of
          0:
            begin {Email}
              if not
                Empty(GetClientEmail(GetClientID(qrytmpMailMerge.FieldByName('Company').AsString))) then begin
                ReportToPrint := '';
                EmailMailMerge(qrytmpMailMerge.FieldByName('MailMergeID').AsInteger);
              end;
            end;
          1:
            begin {Fax}
              if not
                Empty(GetClientFaxNumber(GetClientID(qrytmpMailMerge.FieldByName('Company').AsString))) then begin
                ReportToPrint := '';
                FaxMailMerge(qrytmpMailMerge.FieldByName('MailMergeID').AsInteger);
              end;
            end;
          2:
            begin {Printer}
              ReportToPrint := '';
              LoadTemplate(qrytmpMailMerge.FieldByName('MailMergeID').AsInteger,
                true, false);
            end;
        end;
      end;
      qrytmpMailMerge.Next;
    end;
    Self.Close;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmQueryOptions.CreateTempMailMergeTable;
var
  qryTemp: TMyCommand;
begin
  qryTemp := TMyCommand.Create(nil);
  qryTemp.Connection := qryMailMerge.Connection;

  try
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('DROP TABLE IF EXISTS ' + GetUserMailMergeTempName + ' ');
    qryTemp.Execute;

    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('CREATE TABLE ' + GetUserMailMergeTempName + ' ( ');
    qryTemp.SQL.Add('`MailMergeID` int(10) NOT NULL auto_increment, ');
    qryTemp.SQL.Add('`Company` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Title` varchar(10) default NULL, ');
    qryTemp.SQL.Add('`First Name` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Last Name` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Address` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Street 2` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Suburb` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`State` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Postcode` varchar(4) default NULL, ');
    qryTemp.SQL.Add('`Country` varchar(255) default NULL, ');    
    qryTemp.SQL.Add('`Bill Address` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Bill Street 2` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Bill Suburb` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Bill State` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Bill Postcode` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Bill Country` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Phone` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Alt Phone` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Alt Contact` varchar(255) default NULL, ');    
    qryTemp.SQL.Add('`Mobile` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Fax` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Email` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Phone Support Till` date default NULL, ');
    qryTemp.SQL.Add('`Contact 1` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Contact 2` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Contact 1 Phone` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Contact 2 Phone` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`CUSTFLD1` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`CUSTFLD2` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`CUSTFLD3` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`CUSTFLD4` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`CUSTFLD5` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`CUSTFLD6` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`CUSTFLD7` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`CUSTFLD8` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`CUSTFLD9` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`CUSTFLD10` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`CUSTFLD11` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`CUSTFLD12` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`CUSTFLD13` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`CUSTFLD14` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`CUSTFLD15` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`CUSTDATE1` date default NULL, ');
    qryTemp.SQL.Add('`CUSTDATE2` date default NULL, ');
    qryTemp.SQL.Add('`CUSTDATE3` date default NULL, ');
    qryTemp.SQL.Add('`Date Started` date default NULL, ');
    qryTemp.SQL.Add('`Date Finished` date default NULL, ');
    qryTemp.SQL.Add('`Creation Date` date default NULL, ');
    qryTemp.SQL.Add('`Update Date` date default NULL, ');
    qryTemp.SQL.Add('`Account No` varchar(255) default NULL,  ');
    qryTemp.SQL.Add('`ABN` varchar(15) default NULL, ');
    qryTemp.SQL.Add('`FeedBack` enum("T","F") default "F", ');
    qryTemp.SQL.Add('`Discount` float(15,5) default NULL, ');
    qryTemp.SQL.Add('`Special Discount` float(15,5) default NULL, ');
    qryTemp.SQL.Add('`Job Name` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Rep Name` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Is Job` enum("T","F") default "F", ');
    qryTemp.SQL.Add('`Customer` enum("T","F") default "F", ');
    qryTemp.SQL.Add('`Supplier` enum("T","F") default "F", ');
    qryTemp.SQL.Add('`Other Contact` enum("T","F") default "F", ');
    qryTemp.SQL.Add('`Active` enum("T","F") default "T", ');
    qryTemp.SQL.Add('`Filler` varchar(20) default NULL, ');
    qryTemp.SQL.Add('`ClientTypeID` int(11) default 0, ');
    qryTemp.SQL.Add('`Customer Type` varchar(255) default NULL, ');
    qryTemp.SQL.Add('`Equipment Name` varchar(50) default NULL, ');
    qryTemp.SQL.Add('`Equipment Description` varchar(100) default NULL, ');
    qryTemp.SQL.Add('PRIMARY KEY  (`MailMergeID`) ');
    qryTemp.SQL.Add(') TYPE=InnoDB; ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function TfrmQueryOptions.GetUserMailMergeTempName: string;
begin
  Result := 'tmp_MailMerge_' + GetMachineIdentification(true, true, true, true);
end;

procedure TfrmQueryOptions.DeleteTempStatementTable;
var
  qryTemp: TMyCommand;
begin
  qryTemp := TMyCommand.Create(nil);
  qryTemp.Connection := qryMailMerge.Connection;

  try
    qryTemp.SQL.Add('DROP TABLE IF EXISTS ' + GetUserMailMergeTempName + ' ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function TfrmQueryOptions.GetReportTypeID: integer;
begin
  Result := 34;
end;

procedure TfrmQueryOptions.EmailMailMerge(const MailMergeID: integer);
var
  f: file;
  RecipientAddress, ReportType, OutGoingFileName: string;
  qryEmailedList: TMyCommand;
  TransactionID, UserID, TransactionDescription: string;
  EmailDate: TDateTime;
begin
  // Clear all previous params/data
  label4.Caption := 'Emailing, Please Wait...';
  RecipientAddress := '';
  ReportType := '';
  OutGoingFileName := '';
  FEmailSender.ResetMessageData;

  RecipientAddress :=
    GetClientEmail(GetClientID(qrytmpMailMerge.FieldByName('Company').AsString));

  if RecipientAddress = '' then begin
    CommonLib.MessageDlgXP_Vista(qrytmpMailMerge.FieldByName('Company').AsString +
      ' does not have an email address to send to. Please review customer information to add an email address.', mtInformation , [mbOK], 0);
  end;

  if RecipientAddress <> '' then begin
    ReportType := 'Correspondence';

    try
      LoadTemplate(MailMergeID, true, true);
    except
      Exit;
    end;
    try
      FEmailSender.Subject := AppEnv.CompanyPrefs.EmailSubjectLine + ' ' + ReportType + ' for ' +
        qrytmpMailMerge.FieldByName('Company').AsString;

      FEmailSender.Recipients := RecipientAddress;

      FEmailSender.EmailBody.Add('This report email has been sent to you from ' + GetCompanyName);

      OutGoingFileName := GetCompanyName + ' ' + ReportType + '.PDF';
      AssignFile(f, ExtractFilePath(ParamStr(0)) + 'EmailReport.PDF');

      if not FileExists(ExtractFilePath(ParamStr(0)) + OutGoingFileName) then begin
        CopyFile(PChar(ExtractFilePath(ParamStr(0)) + 'EmailReport.PDF'),
          PChar(ExtractFilePath(ParamStr(0)) + OutGoingFileName), false);
      end;

      FEmailSender.AddAttachment(ExtractFilePath(ParamStr(0)) +
        OutGoingFileName);

      FEmailSender.Send;
    finally;
    end;

    DeleteFiles(ExtractFilePath(ParamStr(0)), '*.PDF');
    TransactionID := qrytmpMailMerge.FieldByName('MailMergeID').AsString;
    UserID        := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
    EmailDate     := Now;
    // ReportType already defined at start of procedure
    TransactionDescription := GetCompanyName + ' ' + ReportType + ' for ' + qrytmpMailMerge.FieldByName('Company').AsString;
    qryEmailedList         := TMyCommand.Create(nil);
    qryEmailedList.Connection := qryMailMerge.Connection;

    try
      qryEmailedList.SQL.Clear;
      qryEmailedList.SQL.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType, TransactionDescription) Values ("' +
        TransactionID + '","' + UserID + '", "' + FormatDateTime(MysqlDateFormat,
        EmailDate) + '", "' + ReportType + '", "' + TransactionDescription + '")');
      qryEmailedList.Execute;
    finally
      DeleteFiles(ExtractFilePath(ParamStr(0)), '*.PDF');
      FreeandNil(qryEmailedList);
    end;
  end;
end;

procedure TfrmQueryOptions.FaxMailMerge(const MailMergeID: integer);
var
  Fax: TFaxObj;
  FaxNo: string;
begin
  inherited;
  FaxNo := GetClientFaxNumber(GetClientID(qrytmpMailMerge.FieldByName('Company').AsString));

  if Empty(FaxNo) then begin
    CommonLib.MessageDlgXP_Vista(qrytmpMailMerge.FieldByName('Company').AsString +
      ' does not have an Fax Number to Send to.' + #13 + #10 + #13 + #10 +
      'Please Review Customer information to Add an Fax Number.', mtWarning,
      [mbOK], 0);
  end else begin
    label4.Visible := true;
    label4.Caption := 'Adding to Fax Spool...';
    fsFax          := true;
    LoadTemplate(MailMergeID, true, true, false, 'Mail_Merge_Fax_Doc');
    Fax := TFaxObj.Create;

    try
      Fax.NoCoverSheet := true;
      Fax.AddToFaxSpool(AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName,
        qrytmpMailMerge.FieldByName('Company').AsString, FaxNo, 'Mail Merge Fax',
        'N/A', '', ExtractFilePath(ParamStr(0)) + 'IMG0001.BMP', Now());
    finally
      FreeandNil(Fax);
    end;

    label4.Visible := false;
    DeleteFiles(ExtractFilePath(ParamStr(0)), '*.BMP');
  end;
end;

procedure TfrmQueryOptions.LoadTemplate(const MailMergeID: integer; const bPrint, bSave, DoClose: boolean;
  const FileName: string);
var
  sSQL: string;
begin
  if not Empty(fsReportName) then begin
    ReportToPrint := TemplateNameToTemplateClassName(FastFuncs.Trim(fsReportName));
  end else begin
    ReportToPrint := GetDefaultReport(GetReportTypeID);
  end;

  fbReportSQLSupplied := true;
  SSQL := 'SELECT * From ' + GetUserMailMergeTempName;
  sSQL := SSQL + Format(' WHERE %s = %d', ['MailMergeID', MailMergeID]);

  if not bSave then begin
    PrintTemplateReport(ReportToPrint, sSQL, bPrint, 1);
  end else begin
    if Empty(FileName) then begin
      SaveTemplateReport(ReportToPrint, sSQL, bPrint, 'PDF');
    end else begin
      if fsFax then begin
        SaveTemplateReport(ReportToPrint, sSQL, bPrint, 'GraphicFile',
          FileName);
      end else begin
        SaveTemplateReport(ReportToPrint, sSQL, bPrint, 'PDF', FileName);
      end;
    end;
  end;

  ReportToPrint := '';
end;

procedure TfrmQueryOptions.AllowFilters;
var
  Query: TMyQuery;
begin
  cboField1.Enabled := true;
  cboComparison1.Enabled := true;
  cboCompare1.Enabled := true;
  cboSort1.Enabled := true;

  Query := nil;

  case FMergeType of
    mmCustomers: Query := qryCustomers;
    mmSuppliers: Query := qrySuppliers;
    mmEmployees: Query := qryEmployees;
    mmOtherContact: Query := qryOthers;
//    mmLoyalty:;
  end;

  if not Assigned(Query) then Exit; // safety
  
  Query.Open;
  ClearFilterAndSortCombos;
  Query.First;
  while not Query.Eof do begin
    if Query.FieldByName('FieldLabel').Text = '' then begin
      cboSort1.Items.Add(Query.FieldByName('FieldName').Text);
      cboSort2.Items.Add(Query.FieldByName('FieldName').Text);
      cboSort3.Items.Add(Query.FieldByName('FieldName').Text);
      cboField1.Items.Add(Query.FieldByName('FieldName').Text);
      cboField2.Items.Add(Query.FieldByName('FieldName').Text);
      cboField3.Items.Add(Query.FieldByName('FieldName').Text);
      cboField4.Items.Add(Query.FieldByName('FieldName').Text);
      cboField5.Items.Add(Query.FieldByName('FieldName').Text);
      cboField6.Items.Add(Query.FieldByName('FieldName').Text);
    end else if Query.FieldByName('FieldLabel').Text <> '' then begin
      cboSort1.Items.Add(Query.FieldByName('FieldLabel').Text);
      cboSort2.Items.Add(Query.FieldByName('FieldLabel').Text);
      cboSort3.Items.Add(Query.FieldByName('FieldLabel').Text);
      cboField1.Items.Add(Query.FieldByName('FieldLabel').Text);
      cboField2.Items.Add(Query.FieldByName('FieldLabel').Text);
      cboField3.Items.Add(Query.FieldByName('FieldLabel').Text);
      cboField4.Items.Add(Query.FieldByName('FieldLabel').Text);
      cboField5.Items.Add(Query.FieldByName('FieldLabel').Text);
      cboField6.Items.Add(Query.FieldByName('FieldLabel').Text);
    end;
    Query.Next;
  end;
end;

procedure TfrmQueryOptions.rgSelectChange(Sender: TObject);
begin
  inherited;
  FMergeType := TMailMergeType(rgSelect.ItemIndex);

  if FMergeType <> mmLoyalty then AllowFilters;
end;

procedure TfrmQueryOptions.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
  cThisKey: char;
begin
  inherited;
  cThisKey := Chr(Key);
  if Shift = [ssCtrl] then begin
    if cThisKey = 'D' then begin
      SpeedButton1Click(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'F' then begin
      TabCtl3.ActivePageIndex := 0;
      Key := 0;
      Exit;
    end;

    if cThisKey = 'S' then begin
      TabCtl3.ActivePageIndex := 1;
      Key := 0;
      Exit;
    end;

    if cThisKey = 'L' then begin
      TabCtl3.ActivePageIndex := 2;
      Key := 0;
      Exit;
    end;

    if cThisKey = 'T' then begin
      TabCtl3.ActivePageIndex := 3;
      Key := 0;
      Exit;
    end;

    if TabCtl3.ActivePage = SendSettings then begin
      if cThisKey = 'H' then begin
        chkChooseRpt.Checked := chkChooseRpt.Checked xor true;
        Key := 0;
        Exit;
      end;
      Exit;
    end;

    if TabCtl3.ActivePage = tabLoyalty then begin
      if cThisKey = 'E' then begin
        grpLoyalty.ItemIndex := 0;
        Key := 0;
        Exit;
      end;

      if cThisKey = 'R' then begin
        grpLoyalty.ItemIndex := 1;
        Key := 0;
        Exit;
      end;

      if cThisKey = 'A' then begin
        grpLoyalty.ItemIndex := 2;
        Key := 0;
        Exit;
      end;

      if cThisKey = 'O' then begin
        grpLoyalty.ItemIndex := 3;
        Key := 0;
        Exit;
      end;
      Exit;
    end;
  end;
end;

procedure TfrmQueryOptions.ClearFilterAndSortCombos;
begin
  cboField1.Clear;
  cboField2.Clear;
  cboField3.Clear;
  cboField4.Clear;
  cboField5.Clear;
  cboField6.Clear;
  cboComparison1.ItemIndex := -1;
  cboComparison2.ItemIndex := -1;
  cboComparison3.ItemIndex := -1;
  cboComparison4.ItemIndex := -1;
  cboComparison5.ItemIndex := -1;
  cboComparison6.ItemIndex := -1;
  cboCompare1.Text := '';
  cboCompare2.Text := '';
  cboCompare3.Text := '';
  cboCompare4.Text := '';
  cboCompare5.Text := '';
  cboCompare6.Text := '';
  cboField2.Enabled := false;
  cboField3.Enabled := false;
  cboField4.Enabled := false;
  cboField5.Enabled := false;
  cboField6.Enabled := false;
  cboComparison2.Enabled := false;
  cboComparison3.Enabled := false;
  cboComparison4.Enabled := false;
  cboComparison5.Enabled := false;
  cboComparison6.Enabled := false;
  cboCompare2.Enabled := false;
  cboCompare3.Enabled := false;
  cboCompare4.Enabled := false;
  cboCompare5.Enabled := false;
  cboCompare6.Enabled := false;
  cboSort1.Clear;
  cboSort2.Clear;
  cboSort3.Clear;
  cboSort2.Enabled := false;
  cboSort3.Enabled := false;
end;

procedure TfrmQueryOptions.TabCtl3Change(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmQueryOptions.cboField1Change(Sender: TObject);
begin
  inherited;
  if IsDateField(cboField1.Text) then begin
    dtp1.Visible           := true;
    cboCompare1.Visible    := false;
    cboAndOr2.Enabled      := true;
    cboField2.Enabled      := true;
    cboComparison2.Enabled := true;
  end else begin
    TestSortValues;
    dtp1.Visible        := false;
    cboCompare1.Visible := true;
    fsLastFieldValue[1] := cboField1.Text;
  end;
end;

procedure TfrmQueryOptions.cboField2Change(Sender: TObject);
begin
  inherited;
  if IsDateField(cboField2.Text) then begin
    dtp2.Visible           := true;
    cboCompare2.Visible    := false;
    cboAndOr3.Enabled      := true;
    cboField3.Enabled      := true;
    cboComparison3.Enabled := true;
  end else begin
    TestSortValues;
    dtp2.Visible        := false;
    cboCompare2.Visible := true;
    fsLastFieldValue[2] := cboField2.Text;
  end;
end;

procedure TfrmQueryOptions.cboField3Change(Sender: TObject);
begin
  inherited;
  if IsDateField(cboField3.Text) then begin
    dtp3.Visible           := true;
    cboCompare3.Visible    := false;
    cboAndOr4.Enabled      := true;
    cboField4.Enabled      := true;
    cboComparison4.Enabled := true;
  end else begin
    TestSortValues;
    dtp3.Visible        := false;
    cboCompare3.Visible := true;
    fsLastFieldValue[3] := cboField3.Text;
  end;
end;

procedure TfrmQueryOptions.cboField4Change(Sender: TObject);
begin
  inherited;
  if IsDateField(cboField4.Text) then begin
    dtp4.Visible           := true;
    cboCompare4.Visible    := false;
    cboAndOr5.Enabled      := true;
    cboField5.Enabled      := true;
    cboComparison5.Enabled := true;
  end else begin
    TestSortValues;
    dtp4.Visible        := false;
    cboCompare4.Visible := true;
    fsLastFieldValue[4] := cboField4.Text;
  end;
end;

procedure TfrmQueryOptions.cboField5Change(Sender: TObject);
begin
  inherited;
  if IsDateField(cboField5.Text) then begin
    dtp5.Visible           := true;
    cboCompare5.Visible    := false;
    cboAndOr6.Enabled      := true;
    cboField6.Enabled      := true;
    cboComparison6.Enabled := true;
  end else begin
    TestSortValues;
    dtp5.Visible        := false;
    cboCompare5.Visible := true;
    fsLastFieldValue[5] := cboField5.Text;
  end;
end;

procedure TfrmQueryOptions.cboField6Change(Sender: TObject);
begin
  inherited;
  if IsDateField(cboField6.Text) then begin
    dtp6.Visible        := true;
    cboCompare6.Visible := false;
  end else begin
    TestSortValues;
    dtp6.Visible        := false;
    cboCompare6.Visible := true;
    fsLastFieldValue[6] := cboField6.Text;
  end;
end;

function TfrmQueryOptions.IsDateField(const sField: string): boolean;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT ID, IsDate FROM tblmergefields WHERE FieldName = :xField');
    qry.Params.ParamByName('xField').AsString := sField;
    qry.Open;

    if qry.RecordCount > 0 then begin
      Result := qry.FieldByName('IsDate').AsString = 'T';
    end else begin
      Result := false;
    end;
  finally
    // Free our used object.
    if Assigned(qry) then begin
      qry.Close;
      FreeAndNil(qry);
    end;
  end;
end;

procedure TfrmQueryOptions.btnExportClick(Sender: TObject);
begin
  inherited;
  // First create our merge table.
  if not CreateMergeTable then Exit;

  // Now that I now have a freshly created export file.
  // We now need to have the user specify where they
  // want to save it.
  if SaveDialog1.Execute then begin
    // Ensure the export destination does not exist. If it does, remove it.
    if FileExists(SaveDialog1.FileName) then DeleteFile(SaveDialog1.FileName);

    // Copy file to export location.
    CopyFile('C:\Platinum1\tblAWordMerge.txt', PChar(SaveDialog1.FileName), false);
  end;
end;

procedure TfrmQueryOptions.FormDestroy(Sender: TObject);
begin
  FreeandNil(FEmailSender);
  inherited;
end;

procedure TfrmQueryOptions.UpdateTableMergeFields;
begin
  // address (street1)
  MFR.TableName := 'tblOthers';
  MFR.FieldName := 'Address';
  MFR.FieldLabel := 'Address';
  MFR.IsDate := false;
  InsertMergeFieldRecord(MFR, false);

  // street2
  MFR.TableName := 'tblOthers';
  MFR.FieldName := 'Street2';
  MFR.FieldLabel := 'Street 2';
  MFR.IsDate := false;
  InsertMergeFieldRecord(MFR, false);

  // suburb
  MFR.TableName := 'tblOthers';
  MFR.FieldName := 'Suburb';
  MFR.FieldLabel := 'Suburb';
  MFR.IsDate := false;
  InsertMergeFieldRecord(MFR, false);

  // state
  MFR.TableName := 'tblOthers';
  MFR.FieldName := 'State';
  MFR.FieldLabel := 'State';
  MFR.IsDate := false;
  InsertMergeFieldRecord(MFR, false);

  // post code
  MFR.TableName := 'tblOthers';
  MFR.FieldName := 'Postcode';
  MFR.FieldLabel := 'Postcode';
  MFR.IsDate := false;
  InsertMergeFieldRecord(MFR, false);

  // contact
  MFR.TableName := 'tblOthers';
  MFR.FieldName := 'Contact_1';
  MFR.FieldLabel := 'Contact 1';
  MFR.IsDate := false;
  InsertMergeFieldRecord(MFR, false);
end;

function TfrmQueryOptions.IsEquipmentUsed: boolean;
begin
  if FastFuncs.SameText(cboField1.Text, 'Equipment Name') or
    FastFuncs.SameText(cboField1.Text, 'Equipment Description') or
    FastFuncs.SameText(cboField2.Text, 'Equipment Name') or
    FastFuncs.SameText(cboField2.Text, 'Equipment Description') or
    FastFuncs.SameText(cboField3.Text, 'Equipment Name') or
    FastFuncs.SameText(cboField3.Text, 'Equipment Description') or
    FastFuncs.SameText(cboField4.Text, 'Equipment Name') or
    FastFuncs.SameText(cboField4.Text, 'Equipment Description') or
    FastFuncs.SameText(cboField5.Text, 'Equipment Name') or
    FastFuncs.SameText(cboField5.Text, 'Equipment Description') or
    FastFuncs.SameText(cboField6.Text, 'Equipment Name') or
    FastFuncs.SameText(cboField6.Text, 'Equipment Description') then begin
    Result := true;
  end else Result := false;
end;

procedure TfrmQueryOptions.cboSortCloseUp(Sender: TObject);
begin
  inherited;

  if Sender is TComboBox then begin
    if (FastFuncs.SameText(TComboBox(Sender).Text, 'Equipment Name') or FastFuncs.SameText(TComboBox(Sender).Text, 'Equipment Description')) and
      (not IsEquipmentUsed) then begin
      CommonLib.MessageDlgXP_Vista('Equipment must be chosen in the filter fields to be used for sorting',
        mtInformation, [mbOK], 0);
      TComboBox(Sender).ItemIndex := 0;
    end;
  end;
end;

procedure TfrmQueryOptions.TestSortValues;
var
  Index: integer;
  LastFieldEquipment: boolean;
  SortEquipmentSet: boolean;
begin
  LastFieldEquipment := false;

  for Index := 1 to 6 do begin
    if FastFuncs.SameText(fsLastFieldValue[Index], 'Equipment Name') or
      FastFuncs.SameText(fsLastFieldValue[Index], 'Equipment Description') then begin
      LastFieldEquipment := true;
    end;
  end;

  if (not IsEquipmentUsed) and LastFieldEquipment then begin
    SortEquipmentSet := false;

    if FastFuncs.SameText(cboSort1.Text, 'Equipment Name') or
      FastFuncs.SameText(cboSort1.Text, 'Equipment Description') then begin
      cboSort1.ItemIndex := 0;
      SortEquipmentSet := true;
    end;

    if FastFuncs.SameText(cboSort2.Text, 'Equipment Name') or
      FastFuncs.SameText(cboSort2.Text, 'Equipment Description') then begin
      cboSort2.ItemIndex := 0;
      SortEquipmentSet := true;
    end;

    if FastFuncs.SameText(cboSort3.Text, 'Equipment Name') or
      FastFuncs.SameText(cboSort3.Text, 'Equipment Description') then begin
      cboSort3.ItemIndex := 0;
      SortEquipmentSet := true;
    end;

    if SortEquipmentSet then begin
      CommonLib.MessageDlgXP_Vista('Sort values using ''Equipment'' have been reset since' + #13#10 +
        'there are no filter field ''Equipment'' values.',
        mtInformation, [mbOK], 0);
    end;
  end;
end;

initialization
  RegisterClassOnce(TfrmQueryOptions);
end.

