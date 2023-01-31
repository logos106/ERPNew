unit frmRepairExportconfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DNMSpeedButton, StdCtrls, Shader, ExtCtrls,
  DNMPanel, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus,
  AdvMenus, DataState, SelectionDialog, AppEvnts, Grids, Wwdbigrd, Wwdbgrid, BusobjRepairsExportConfig,
  BusObjBase, Mask, wwdbedit, DBCtrls, ComCtrls, wwcheckbox, ProgressDialog;

const
  NoOfFieldsToExport =36;
type
  TfmRepairExportconfig = class(TBaseInputGUI)
    DNMPanel3: TDNMPanel;
    btnCancel: TDNMSpeedButton;
    btnSave: TDNMSpeedButton;
    dsRepairsExportConfig: TDataSource;
    QryRepairsExportConfig: TERPQuery;
    QryRepairsExportConfigID: TIntegerField;
    QryRepairsExportConfigGlobalref: TWideStringField;
    QryRepairsExportConfigManufactureId: TIntegerField;
    QryRepairsExportConfigF1: TWideStringField;
    QryRepairsExportConfigF2: TWideStringField;
    QryRepairsExportConfigF3: TWideStringField;
    QryRepairsExportConfigF4: TWideStringField;
    QryRepairsExportConfigF5: TWideStringField;
    QryRepairsExportConfigF6: TWideStringField;
    QryRepairsExportConfigF7: TWideStringField;
    QryRepairsExportConfigF8: TWideStringField;
    QryRepairsExportConfigF9: TWideStringField;
    QryRepairsExportConfigF10: TWideStringField;
    QryRepairsExportConfigF11: TWideStringField;
    QryRepairsExportConfigF12: TWideStringField;
    QryRepairsExportConfigF13: TWideStringField;
    QryRepairsExportConfigF14: TWideStringField;
    QryRepairsExportConfigF15: TWideStringField;
    QryRepairsExportConfigF16: TWideStringField;
    QryRepairsExportConfigF17: TWideStringField;
    QryRepairsExportConfigF18: TWideStringField;
    QryRepairsExportConfigF19: TWideStringField;
    QryRepairsExportConfigF20: TWideStringField;
    QryRepairsExportConfigF21: TWideStringField;
    QryRepairsExportConfigF22: TWideStringField;
    QryRepairsExportConfigF23: TWideStringField;
    QryRepairsExportConfigF24: TWideStringField;
    QryRepairsExportConfigF25: TWideStringField;
    QryRepairsExportConfigF26: TWideStringField;
    QryRepairsExportConfigF27: TWideStringField;
    QryRepairsExportConfigF28: TWideStringField;
    QryRepairsExportConfigF29: TWideStringField;
    QryRepairsExportConfigF30: TWideStringField;
    QryRepairsExportConfigF31: TWideStringField;
    QryRepairsExportConfigF32: TWideStringField;
    QryRepairsExportConfigF33: TWideStringField;
    QryRepairsExportConfigF34: TWideStringField;
    QryRepairsExportConfigF35: TWideStringField;
    QryRepairsExportConfigF36: TWideStringField;
    QryRepairsExportConfigDescription1: TWideStringField;
    QryRepairsExportConfigDescription2: TWideStringField;
    QryRepairsExportConfigDescription3: TWideStringField;
    QryRepairsExportConfigDescription4: TWideStringField;
    QryRepairsExportConfigDescription5: TWideStringField;
    QryRepairsExportConfigDescription6: TWideStringField;
    QryRepairsExportConfigDescription7: TWideStringField;
    QryRepairsExportConfigDescription8: TWideStringField;
    QryRepairsExportConfigDescription9: TWideStringField;
    QryRepairsExportConfigDescription10: TWideStringField;
    QryRepairsExportConfigDescription11: TWideStringField;
    QryRepairsExportConfigDescription12: TWideStringField;
    QryRepairsExportConfigDescription13: TWideStringField;
    QryRepairsExportConfigDescription14: TWideStringField;
    QryRepairsExportConfigDescription15: TWideStringField;
    QryRepairsExportConfigDescription16: TWideStringField;
    QryRepairsExportConfigDescription17: TWideStringField;
    QryRepairsExportConfigDescription18: TWideStringField;
    QryRepairsExportConfigDescription19: TWideStringField;
    QryRepairsExportConfigDescription20: TWideStringField;
    QryRepairsExportConfigDescription21: TWideStringField;
    QryRepairsExportConfigDescription22: TWideStringField;
    QryRepairsExportConfigDescription23: TWideStringField;
    QryRepairsExportConfigDescription24: TWideStringField;
    QryRepairsExportConfigDescription25: TWideStringField;
    QryRepairsExportConfigDescription26: TWideStringField;
    QryRepairsExportConfigDescription27: TWideStringField;
    QryRepairsExportConfigDescription28: TWideStringField;
    QryRepairsExportConfigDescription29: TWideStringField;
    QryRepairsExportConfigDescription30: TWideStringField;
    QryRepairsExportConfigDescription31: TWideStringField;
    QryRepairsExportConfigDescription32: TWideStringField;
    QryRepairsExportConfigDescription33: TWideStringField;
    QryRepairsExportConfigDescription34: TWideStringField;
    QryRepairsExportConfigDescription35: TWideStringField;
    QryRepairsExportConfigDescription36: TWideStringField;
    QryRepairsExportConfigACTIVE: TWideStringField;
    QryRepairsExportConfigmstimeStamp: TDateTimeField;
    DNMPanel2: TDNMPanel;
    DNMPanel1: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    QryRepairsExportConfigDateformat: TWideStringField;
    dsDescription: TDataSource;
    QryDescription: TERPQuery;
    IntegerField1: TIntegerField;
    StringField1: TWideStringField;
    IntegerField2: TIntegerField;
    StringField2: TWideStringField;
    StringField3: TWideStringField;
    StringField4: TWideStringField;
    StringField5: TWideStringField;
    StringField6: TWideStringField;
    StringField7: TWideStringField;
    StringField8: TWideStringField;
    StringField9: TWideStringField;
    StringField10: TWideStringField;
    StringField11: TWideStringField;
    StringField12: TWideStringField;
    StringField13: TWideStringField;
    StringField14: TWideStringField;
    StringField15: TWideStringField;
    StringField16: TWideStringField;
    StringField17: TWideStringField;
    StringField18: TWideStringField;
    StringField19: TWideStringField;
    StringField20: TWideStringField;
    StringField21: TWideStringField;
    StringField22: TWideStringField;
    StringField23: TWideStringField;
    StringField24: TWideStringField;
    StringField25: TWideStringField;
    StringField26: TWideStringField;
    StringField27: TWideStringField;
    StringField28: TWideStringField;
    StringField29: TWideStringField;
    StringField30: TWideStringField;
    StringField31: TWideStringField;
    StringField32: TWideStringField;
    StringField33: TWideStringField;
    StringField34: TWideStringField;
    StringField35: TWideStringField;
    StringField36: TWideStringField;
    StringField37: TWideStringField;
    StringField38: TWideStringField;
    StringField39: TWideStringField;
    StringField40: TWideStringField;
    StringField41: TWideStringField;
    StringField42: TWideStringField;
    StringField43: TWideStringField;
    StringField44: TWideStringField;
    StringField45: TWideStringField;
    StringField46: TWideStringField;
    StringField47: TWideStringField;
    StringField48: TWideStringField;
    StringField49: TWideStringField;
    StringField50: TWideStringField;
    StringField51: TWideStringField;
    StringField52: TWideStringField;
    StringField53: TWideStringField;
    StringField54: TWideStringField;
    StringField55: TWideStringField;
    StringField56: TWideStringField;
    StringField57: TWideStringField;
    StringField58: TWideStringField;
    StringField59: TWideStringField;
    StringField60: TWideStringField;
    StringField61: TWideStringField;
    StringField62: TWideStringField;
    StringField63: TWideStringField;
    StringField64: TWideStringField;
    StringField65: TWideStringField;
    StringField66: TWideStringField;
    StringField67: TWideStringField;
    StringField68: TWideStringField;
    StringField69: TWideStringField;
    StringField70: TWideStringField;
    StringField71: TWideStringField;
    StringField72: TWideStringField;
    StringField73: TWideStringField;
    StringField74: TWideStringField;
    DateTimeField1: TDateTimeField;
    StringField75: TWideStringField;
    QryRepairsExportConfigShowF1: TWideStringField;
    QryRepairsExportConfigShowF2: TWideStringField;
    QryRepairsExportConfigShowF3: TWideStringField;
    QryRepairsExportConfigShowF4: TWideStringField;
    QryRepairsExportConfigShowF5: TWideStringField;
    QryRepairsExportConfigShowF6: TWideStringField;
    QryRepairsExportConfigShowF7: TWideStringField;
    QryRepairsExportConfigShowF8: TWideStringField;
    QryRepairsExportConfigShowF9: TWideStringField;
    QryRepairsExportConfigShowF10: TWideStringField;
    QryRepairsExportConfigShowF11: TWideStringField;
    QryRepairsExportConfigShowF12: TWideStringField;
    QryRepairsExportConfigShowF13: TWideStringField;
    QryRepairsExportConfigShowF14: TWideStringField;
    QryRepairsExportConfigShowF15: TWideStringField;
    QryRepairsExportConfigShowF16: TWideStringField;
    QryRepairsExportConfigShowF17: TWideStringField;
    QryRepairsExportConfigShowF18: TWideStringField;
    QryRepairsExportConfigShowF19: TWideStringField;
    QryRepairsExportConfigShowF20: TWideStringField;
    QryRepairsExportConfigShowF21: TWideStringField;
    QryRepairsExportConfigShowF22: TWideStringField;
    QryRepairsExportConfigShowF23: TWideStringField;
    QryRepairsExportConfigShowF24: TWideStringField;
    QryRepairsExportConfigShowF25: TWideStringField;
    QryRepairsExportConfigShowF26: TWideStringField;
    QryRepairsExportConfigShowF27: TWideStringField;
    QryRepairsExportConfigShowF28: TWideStringField;
    QryRepairsExportConfigShowF29: TWideStringField;
    QryRepairsExportConfigShowF30: TWideStringField;
    QryRepairsExportConfigShowF31: TWideStringField;
    QryRepairsExportConfigShowF32: TWideStringField;
    QryRepairsExportConfigShowF33: TWideStringField;
    QryRepairsExportConfigShowF34: TWideStringField;
    QryRepairsExportConfigShowF35: TWideStringField;
    QryRepairsExportConfigShowF36: TWideStringField;
    QryRepairsExportConfigF1Order: TIntegerField;
    QryRepairsExportConfigF2Order: TIntegerField;
    QryRepairsExportConfigF3Order: TIntegerField;
    QryRepairsExportConfigF4Order: TIntegerField;
    QryRepairsExportConfigF5Order: TIntegerField;
    QryRepairsExportConfigF6Order: TIntegerField;
    QryRepairsExportConfigF7Order: TIntegerField;
    QryRepairsExportConfigF8Order: TIntegerField;
    QryRepairsExportConfigF9Order: TIntegerField;
    QryRepairsExportConfigF10Order: TIntegerField;
    QryRepairsExportConfigF11Order: TIntegerField;
    QryRepairsExportConfigF12Order: TIntegerField;
    QryRepairsExportConfigF13Order: TIntegerField;
    QryRepairsExportConfigF14Order: TIntegerField;
    QryRepairsExportConfigF15Order: TIntegerField;
    QryRepairsExportConfigF16Order: TIntegerField;
    QryRepairsExportConfigF17Order: TIntegerField;
    QryRepairsExportConfigF18Order: TIntegerField;
    QryRepairsExportConfigF19Order: TIntegerField;
    QryRepairsExportConfigF20Order: TIntegerField;
    QryRepairsExportConfigF21Order: TIntegerField;
    QryRepairsExportConfigF22Order: TIntegerField;
    QryRepairsExportConfigF23Order: TIntegerField;
    QryRepairsExportConfigF24Order: TIntegerField;
    QryRepairsExportConfigF25Order: TIntegerField;
    QryRepairsExportConfigF26Order: TIntegerField;
    QryRepairsExportConfigF27Order: TIntegerField;
    QryRepairsExportConfigF28Order: TIntegerField;
    QryRepairsExportConfigF29Order: TIntegerField;
    QryRepairsExportConfigF30Order: TIntegerField;
    QryRepairsExportConfigF31Order: TIntegerField;
    QryRepairsExportConfigF32Order: TIntegerField;
    QryRepairsExportConfigF33Order: TIntegerField;
    QryRepairsExportConfigF34Order: TIntegerField;
    QryRepairsExportConfigF35Order: TIntegerField;
    QryRepairsExportConfigF36Order: TIntegerField;
    DNMSpeedButton1: TDNMSpeedButton;
    Description1: TDBText;
    Description2: TDBText;
    Description3: TDBText;
    Description4: TDBText;
    Description5: TDBText;
    Description6: TDBText;
    Description7: TDBText;
    Description8: TDBText;
    Description9: TDBText;
    Description10: TDBText;
    Description11: TDBText;
    Description12: TDBText;
    Description13: TDBText;
    Description14: TDBText;
    Description15: TDBText;
    Description16: TDBText;
    Description17: TDBText;
    Description18: TDBText;
    Description31: TDBText;
    Description32: TDBText;
    Description33: TDBText;
    Description34: TDBText;
    Description35: TDBText;
    Description36: TDBText;
    Description19: TDBText;
    Description20: TDBText;
    Description21: TDBText;
    Description22: TDBText;
    Description23: TDBText;
    Description24: TDBText;
    Description25: TDBText;
    Description26: TDBText;
    Description27: TDBText;
    Description28: TDBText;
    Description29: TDBText;
    Description30: TDBText;
    Label1: TLabel;
    FieldName1: TwwDBEdit;
    FieldName2: TwwDBEdit;
    FieldName3: TwwDBEdit;
    FieldName4: TwwDBEdit;
    FieldName5: TwwDBEdit;
    FieldName6: TwwDBEdit;
    FieldName7: TwwDBEdit;
    FieldName8: TwwDBEdit;
    FieldName9: TwwDBEdit;
    FieldName10: TwwDBEdit;
    FieldName11: TwwDBEdit;
    FieldName12: TwwDBEdit;
    FieldName13: TwwDBEdit;
    FieldName14: TwwDBEdit;
    FieldName15: TwwDBEdit;
    FieldName16: TwwDBEdit;
    FieldName17: TwwDBEdit;
    FieldName18: TwwDBEdit;
    FieldName19: TwwDBEdit;
    FieldName20: TwwDBEdit;
    FieldName21: TwwDBEdit;
    FieldName22: TwwDBEdit;
    FieldName23: TwwDBEdit;
    FieldName24: TwwDBEdit;
    FieldName25: TwwDBEdit;
    FieldName26: TwwDBEdit;
    FieldName27: TwwDBEdit;
    FieldName28: TwwDBEdit;
    FieldName29: TwwDBEdit;
    FieldName30: TwwDBEdit;
    FieldName31: TwwDBEdit;
    FieldName32: TwwDBEdit;
    FieldName33: TwwDBEdit;
    FieldName34: TwwDBEdit;
    FieldName35: TwwDBEdit;
    FieldName36: TwwDBEdit;
    Order1: TwwDBEdit;
    Order2: TwwDBEdit;
    Order3: TwwDBEdit;
    Order4: TwwDBEdit;
    Order5: TwwDBEdit;
    Order6: TwwDBEdit;
    Order7: TwwDBEdit;
    Order8: TwwDBEdit;
    Order9: TwwDBEdit;
    Order10: TwwDBEdit;
    Order11: TwwDBEdit;
    Order12: TwwDBEdit;
    Order13: TwwDBEdit;
    Order14: TwwDBEdit;
    Order15: TwwDBEdit;
    Order16: TwwDBEdit;
    Order17: TwwDBEdit;
    Order18: TwwDBEdit;
    Order19: TwwDBEdit;
    Order20: TwwDBEdit;
    Order21: TwwDBEdit;
    Order22: TwwDBEdit;
    Order23: TwwDBEdit;
    Order24: TwwDBEdit;
    Order25: TwwDBEdit;
    Order26: TwwDBEdit;
    Order27: TwwDBEdit;
    Order28: TwwDBEdit;
    Order29: TwwDBEdit;
    Order30: TwwDBEdit;
    Order31: TwwDBEdit;
    Order32: TwwDBEdit;
    Order33: TwwDBEdit;
    Order34: TwwDBEdit;
    Order35: TwwDBEdit;
    Order36: TwwDBEdit;
    chkShowF1: TwwCheckBox;
    chkShowF2: TwwCheckBox;
    chkShowF3: TwwCheckBox;
    chkShowF4: TwwCheckBox;
    chkShowF5: TwwCheckBox;
    chkShowF6: TwwCheckBox;
    chkShowF7: TwwCheckBox;
    chkShowF8: TwwCheckBox;
    chkShowF9: TwwCheckBox;
    chkShowF10: TwwCheckBox;
    chkShowF11: TwwCheckBox;
    chkShowF12: TwwCheckBox;
    chkShowF13: TwwCheckBox;
    chkShowF14: TwwCheckBox;
    chkShowF15: TwwCheckBox;
    chkShowF16: TwwCheckBox;
    chkShowF17: TwwCheckBox;
    chkShowF18: TwwCheckBox;
    chkShowF19: TwwCheckBox;
    chkShowF20: TwwCheckBox;
    chkShowF21: TwwCheckBox;
    chkShowF22: TwwCheckBox;
    chkShowF23: TwwCheckBox;
    chkShowF24: TwwCheckBox;
    chkShowF25: TwwCheckBox;
    chkShowF26: TwwCheckBox;
    chkShowF27: TwwCheckBox;
    chkShowF28: TwwCheckBox;
    chkShowF29: TwwCheckBox;
    chkShowF30: TwwCheckBox;
    chkShowF31: TwwCheckBox;
    chkShowF32: TwwCheckBox;
    chkShowF33: TwwCheckBox;
    chkShowF34: TwwCheckBox;
    chkShowF35: TwwCheckBox;
    chkShowF36: TwwCheckBox;
    DBComboBox1: TDBComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QryRepairsExportConfigF1OrderSetText(Sender: TField;
      const Text: String);
    procedure ChangePosition(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure grdRepairsExportConfigFlatCalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean;
      AFont: TFont; ABrush: TBrush);
    procedure QryRepairsExportConfigFlatShowFSetText(Sender: TField;
      const Text: String);
  private
    RepairsExportConfig:TRepairsExportConfig;
    fiManufactureID: Integer;
    DoSetText:boolean;
    Tablename :string;
    function FieldNo(Const Value:Integer):String;
    procedure firsttab;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Property ManufactureID:Integer read fiManufactureID Write fiManufactureID;
  end;


implementation

uses CommonLib, BusObjConst, FastFuncs, tcDataUtils, CommonDbLib;



{$R *.dfm}

procedure TfmRepairExportconfig.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TRepairsExportConfig then TRepairsExportConfig(Sender).Dataset := QryRepairsExportConfig;
    end;
end;

procedure TfmRepairExportconfig.FormCreate(Sender: TObject);
begin
  inherited;
  RepairsExportConfig:=TRepairsExportConfig.Create(Self);
  RepairsExportConfig.Connection := TMyDacDataConnection.Create(RepairsExportConfig);
  RepairsExportConfig.Connection.Connection := Self.MyConnection;
  RepairsExportConfig.BusObjEvent :=DoBusinessObjectEvent;
  fiManufactureID:= 0;
  DoSetText := True;
  Tablename := CommonDbLib.GetUserTemporaryTableName('RepairsExportConfig');
  
end;

procedure TfmRepairExportconfig.FormShow(Sender: TObject);
begin
  RepairsExportConfig.loadSelect('ifnull(ManufactureId,0) = ' +IntToStr(ManufactureID));
  RepairsExportConfig.Connection.BeginTransaction;
  if RepairsExportConfig.count = 0 then begin
    RepairsExportConfig.New;
    RepairsExportConfig.ManufactureId := ManufactureID;
    RepairsExportConfig.PostDB;
  end;
  if ManufactureID <> 0 then
    TitleLabel.Caption := getManufactureName(ManufactureID);

  firsttab;
  Openqueries;
end;


procedure TfmRepairExportconfig.firsttab;
var
  ctr:Integer;
  x:Integer;
begin
  inherited;
  x:=NoOfFieldsToExport*3;
  DBComboBox1.taborder := x; x:= x-1;
 for ctr := NoOfFieldsToExport downto 1 do
  try
    TwwDBEdit(findcomponent('FieldName'+FieldNo(ctr))).Datafield:= 'F'+FieldNo(ctr);
    TwwDBEdit(findcomponent('Order'+FieldNo(ctr))).Datafield:= 'F'+FieldNo(ctr)+'Order';
    TDBText(findcomponent('Description'+FieldNo(ctr))).Datafield:= 'F'+FieldNo(ctr);


    TwwDBEdit(findcomponent('FieldName'+FieldNo(ctr))).TabOrder := x; x:= x-1;
    TwwDBEdit(findcomponent('Order'+FieldNo(ctr))).TabOrder  := x; x:= x-1;
    TwwDBEdit(findcomponent('chkShowF'+FieldNo(ctr))).TabOrder  := x; x:= x-1;
  except
    //kill exception
  end;
end;

procedure TfmRepairExportconfig.btnSaveClick(Sender: TObject);
begin
  inherited;
  RepairsExportConfig.PostDB;
  RepairsExportConfig.connection.CommitTransaction;
  RepairsExportConfig.Dirty := false;
  Notify(False);
  Self.Close;
end;

procedure TfmRepairExportconfig.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmRepairExportconfig.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := false;
  if RepairsExportConfig.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: 
        begin
            RepairsExportConfig.PostDB;
            RepairsExportConfig.Connection.CommitTransaction;
            CanClose := true;
        end;
      mrNo:
        begin
          RepairsExportConfig.Connection.RollbackTransaction;
          RepairsExportConfig.Dirty := false;
          CanClose := true;
        end;
      mrCancel: 
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
  end;  
end;
procedure TfmRepairExportconfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
end;

procedure TfmRepairExportconfig.QryRepairsExportConfigF1OrderSetText(Sender: TField; const Text: String);
begin
  if DoSetText=False then exit;
  if ISInteger(Text) then
    if (strtoint(text)) > 36 then sender.asString := '36'
    else if strtoint(text)<1 then sender.asString := '1'
    else sender.AsString := Text;
    inherited;
end;

procedure TfmRepairExportconfig.ChangePosition(Sender: TObject;var Key: Word; Shift: TShiftState);
var
  x:Integer;
begin
  inherited;
  if ssCtrl in Shift then begin
    if (Key = VK_DOWN) or (Key = VK_UP) then begin
      x:=QryRepairsExportConfig.Fieldbyname(TwwDBEdit(Sender).Datafield).asInteger;
      if Key = VK_DOWN then begin
        x:= x+1;
      end else if Key = VK_UP then begin
        x:= x-1;
      end;
      if x<1 then x:= 36 else if x>36 then x:= 1;
      EditDb(QryRepairsExportConfig);
      QryRepairsExportConfig.Fieldbyname(TwwDBEdit(Sender).Datafield).asInteger := x;
      PostDB(QryRepairsExportConfig);
    end;
  end;
end;

procedure TfmRepairExportconfig.DNMSpeedButton1Click(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  DoSetText := False;
  try
    editDB(QryRepairsExportConfig);
    for ctr := 1 to 36 do
      QryRepairsExportConfig.fieldbyname('F' +FieldNo(ctr)+'Order').asInteger := ctr;
    PostDb(QryRepairsExportConfig);
  finally
      DoSetText:= True;
  end;

end;

procedure TfmRepairExportconfig.grdRepairsExportConfigFlatCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  AFont.Style := AFont.Style - [fsBold];
end;


function TfmRepairExportconfig.FieldNo(const Value: Integer): String;
begin
  result := Trim(IntToStr(Value));
end;

procedure TfmRepairExportconfig.QryRepairsExportConfigFlatShowFSetText(
  Sender: TField; const Text: String);
begin
  inherited;
  Sender.asString := Text;
(*  if Sysutils.SameText(QryRepairsExportConfigFlatFieldDesc.asString , 'ASC Claim Number') then
    if Text ='F' then begin
      MessageDlgXP_Vista(QryRepairsExportConfigFlatF.asString +' Is The Identifying Field and  Cannot Hide' , mtWarning, [mbok] , 0);
      Sender.asString := 'T'
    end;*)
end;

initialization
  RegisterClassOnce(TfmRepairExportconfig);

end.


