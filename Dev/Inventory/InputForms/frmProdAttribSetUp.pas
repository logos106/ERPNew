unit frmProdAttribSetUp;

interface

uses
  Windows, frmBase, Classes, Controls, ExtCtrls, DNMPanel, StdCtrls, Mask,
  DBCtrls, wwcheckbox, Grids, Wwdbigrd, Wwdbgrid, DB, MemDS, DBAccess,
  MyAccess,ERPdbComponents, wwdbedit, wwdblook, frmProdAttribBase, Menus;

type
  TfmProdAttribSetUp = class(TfmProdAttribBase)
    SubForm: TDNMPanel;
    qrygroups: TERPQuery;
    qrynames: TERPQuery;
    DSDetailsDetails: TDataSource;
    DSMaster: TDataSource;
    dbgAttribName: TwwDBGrid;
    grdListValues: TwwDBGrid;
    Label1: TLabel;
    DBCheckBox1: TwwCheckBox;
    Label2: TLabel;
    qryvalues: TERPQuery;
    DSDetails: TDataSource;
    edtTitle: TwwDBEdit;
    qrygroupsPAG_ID: TIntegerField;
    qrygroupsName: TWideStringField;
    qrygroupsActive: TWideStringField;
    qrynamesPAN_ID: TIntegerField;
    qrynamesPAG_ID: TIntegerField;
    qrynamesName: TWideStringField;
    qrynamesActive: TWideStringField;
    qryvaluesPAV_ID: TIntegerField;
    qryvaluesPAN_ID: TIntegerField;
    qryvaluesValue: TWideStringField;
    qryvaluesAbbreviation: TWideStringField;
    qryvaluesActive: TWideStringField;
    Label3: TLabel;
    Label4: TLabel;
    qrygroupsXAxisAttribute: TLargeintField;
    qrygroupsYAxisAttribute: TLargeintField;
    qrygroupsOrderbyAttribute: TLargeintField;
    Label7: TLabel;
    Label8: TLabel;
    cboXAxisAttribute: TwwDBLookupCombo;
    cboYAxisAttribute: TwwDBLookupCombo;
    cboOrderbyAttribute: TwwDBLookupCombo;
    cboProductType: TwwDBLookupCombo;
    Label34: TLabel;
    qryProductTypeLookup: TERPQuery;
    qrygroupsPartType: TWideStringField;
    qrygroupsglobalref: TWideStringField;
    Label5: TLabel;
    wwDBEdit1: TwwDBEdit;
    Bevel3: TBevel;
    qrygroupsProdDesc: TWideStringField;
    qrynamesglobalref: TWideStringField;
    qrynamesmsTimeStamp: TDateTimeField;
    qrygroupsmsTimeStamp: TDateTimeField;
    qryvaluesglobalref: TWideStringField;
    qryvaluesmsTimeStamp: TDateTimeField;
    Label6: TLabel;
    qrygroupsmsUpdateSiteCode: TWideStringField;
    qrygroupsCUSTFLD1: TWideStringField;
    qrygroupsCUSTFLD2: TWideStringField;
    qrygroupsCUSTFLD3: TWideStringField;
    qrygroupsCUSTFLD4: TWideStringField;
    qrygroupsCUSTFLD5: TWideStringField;
    qrygroupsCUSTFLD6: TWideStringField;
    qrygroupsCUSTFLD7: TWideStringField;
    qrygroupsCUSTFLD8: TWideStringField;
    qrygroupsCUSTFLD9: TWideStringField;
    qrygroupsCUSTFLD10: TWideStringField;
    qrygroupsCUSTFLD11: TWideStringField;
    qrygroupsCUSTFLD12: TWideStringField;
    qrygroupsCUSTFLD13: TWideStringField;
    qrygroupsCUSTFLD14: TWideStringField;
    qrygroupsCUSTFLD15: TWideStringField;
    qrygroupsCUSTDATE1: TDateTimeField;
    qrygroupsCUSTDATE2: TDateTimeField;
    qrygroupsCUSTDATE3: TDateTimeField;
    qrygroupsNotes: TWideStringField;
    qrygroupsSpecialInstructions: TWideStringField;
    Label9: TLabel;
    txtComments: TDBMemo;
    DBMemo1: TDBMemo;
    Label10: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgAttribNameExit(Sender: TObject);
    procedure grdListValuesExit(Sender: TObject);
    procedure DBCheckBox1Click(Sender: TObject);
    procedure cboXAxisAttributeNotInList(Sender: TObject;LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure dbgAttribNameEnter(Sender: TObject);
    procedure grdListValuesEnter(Sender: TObject);
    procedure cboXAxisAttributeEnter(Sender: TObject);
    procedure cboProductTypeEnter(Sender: TObject);
    procedure FieldSetTextStripBlanks(Sender: TField; const Text: String);
  private
  Protected
  public
    Function OnTabchange:Boolean;
    Procedure SetupGrid; 
  end;

implementation

uses
  CommonLib,BaseInputForm, frmProdAttribMain, CommonDbLib, FastFuncs;

{$R *.dfm}

procedure TfmProdAttribSetUp.FormCreate(Sender: TObject);
begin
  inherited;
  qrygroups.Connection := TBaseInputGUI(Self.Owner).MyConnection;
  qrynames.Connection := TBaseInputGUI(Self.Owner).MyConnection;
  qryvalues.Connection := TBaseInputGUI(Self.Owner).MyConnection;
  dbgAttribName.Hint := 'Example :' +chr(13)   +
                        'Colour AND / OR size etc.' + chr(13);
  dbgAttribName.ShowHint := True;
  grdListValues.hint := 'Example :' +chr(13)   +
                        'Colour : Red, Blue, Black etc.' +chr(13) +
                        'Size     : Short, Long etc.' + chr(13);
  grdListValues.showhint := True;
end;
procedure TfmProdAttribSetUp.FormShow(Sender: TObject);
begin
  inherited;
  SubForm.Color := TBaseInputGUI(Self.Owner).TabColor;
  if qryProductTypeLookup.active = False then qryProductTypeLookup.open;
end;
procedure TfmProdAttribSetUp.dbgAttribNameExit(Sender: TObject);
begin
  inherited;
  (*AttributeGroups.ProductAttributeNames.PostDb;*)
  AttributeGroups.AttributeNames.PostDb;
end;

procedure TfmProdAttribSetUp.grdListValuesExit(Sender: TObject);
begin
  inherited;
  (*AttributeGroups.ProductAttributeNames.ProductAttributeValues.PostDb;*)
  AttributeGroups.AttributeNames.ProductAttributeValues.PostDb;
end;

procedure TfmProdAttribSetUp.DBCheckBox1Click(Sender: TObject);
begin
  inherited;
  If TfmProdAttribMain(Self.Owner).BusobjLoading then Exit;
  if not TwwCheckBox(Sender).DataSource.DataSet.Active then Exit;
  TwwCheckBox(Sender).DataSource.DataSet.Edit;
  if TwwCheckBox(Sender).Checked then
    TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'T'
  else
    TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'F';
  TwwCheckBox(Sender).DataSource.DataSet.Edit;
end;


procedure TfmProdAttribSetUp.cboXAxisAttributeNotInList(
  Sender: TObject; LookupTable: TDataSet; NewValue: String;
  var Accept: Boolean);
begin
  Accept := False;

end;

procedure TfmProdAttribSetUp.dbgAttribNameEnter(Sender: TObject);
begin
  inherited;
  AttributeGroups.AttributeNames;  
  if AttributeGroups.AttributeNames.Count =0 then
     AttributeGroups.AttributeNames.New;
end;

Function  TfmProdAttribSetUp.OnTabchange:boolean;
begin
  AttributeGroups.PostDB;
  REsult := AttributeGroups.ValidateData;
end;

procedure TfmProdAttribSetUp.grdListValuesEnter(Sender: TObject);
begin
  inherited;
  AttributeGroups.AttributeNames.ProductAttributeValues;
  grdListValues.SetActiveField('Value');
end;

procedure TfmProdAttribSetUp.SetupGrid;
begin
  With CommonDbLib.TempMyQuery do try
    SQL.add('SELECT p.PARTSID  ' +
            ' FROM tblproductattributeproducts AS pap ' +
            ' Inner Join tblparts AS p ON pap.ProductID =p.PARTSID ' +
            ' WHERE pap.PAG_ID = ' +IntToStr(AttributeGroups.ID));
    open;
    if recordcount > 0 then begin
        dbgAttribName.Options := dbgAttribName.options - [dgEditing];
    end else begin
        dbgAttribName.Options := dbgAttribName.options + [dgEditing];
    end;
  finally
      if active then close;
      Free;
  end;
end;

procedure TfmProdAttribSetUp.cboXAxisAttributeEnter(Sender: TObject);
begin
  inherited;
  if AttributeGroups.AttributeNames.count = 0 then SetControlFocus(dbgAttribName);
end;

procedure TfmProdAttribSetUp.cboProductTypeEnter(Sender: TObject);
begin
  inherited;
  cboProductType.readonly := AttributeGroups.CleanID<> 0; 
end;

procedure TfmProdAttribSetUp.FieldSetTextStripBlanks(Sender: TField;
  const Text: String);
begin
  Sender.AsString:= Trim(Text);
end;

initialization
  RegisterClassOnce(TfmProdAttribSetUp);
end.



