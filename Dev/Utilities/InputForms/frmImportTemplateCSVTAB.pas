unit frmImportTemplateCSVTAB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, StdCtrls, Grids,
  Wwdbigrd, Wwdbgrid, DNMPanel, DNMSpeedButton, wwdblook, MemDS, Mask,
  wwdbedit, Wwdotdot, Wwdbcomb, StrUtils, Shader, ImgList;

type
  TImportFileTypes = (iftCSV,iftTAB);

  TImportTemplateCSVTAB = class(TBaseInputGUI)
    grdTemplateLines: TwwDBGrid;
    Bevel1: TBevel;
    btnCancel: TDNMSpeedButton;
    btnOK: TDNMSpeedButton;
    Label1: TLabel;
    cboTemplate: TwwDBLookupCombo;
    qryTemplate: TERPQuery;
    qryTemplateLines: TERPQuery;
    dsTemplateLines: TDataSource;
    qryTemplateTemplateName: TWideStringField;
    qryTemplateLinesID: TIntegerField;
    qryTemplateLinesFieldName: TWideStringField;
    qryTemplateLinesFieldType: TWideStringField;
    qryTemplateLinesFieldDesc: TWideStringField;
    qryTemplateLinesActive: TWideStringField;
    qryTemplateLinesGlobalRef: TWideStringField;
    qryTemplateLinesmsTimeStamp: TDateTimeField;
    qryTemplateLinesTemplateID: TIntegerField;
    qryTemplateAdvImpCSVTABtemplID: TIntegerField;
    qryTemplateActive: TWideStringField;
    qryTemplateGlobalRef: TWideStringField;
    qryTemplatemsTimeStamp: TDateTimeField;
    qryTemplateTemplateType: TIntegerField;
    cboFieldType: TwwDBComboBox;
    btnGetFromFile: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure cboTemplateNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: String; var Accept: Boolean);
    procedure cboTemplateCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdTemplateLinesExit(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGetFromFileClick(Sender: TObject);
    procedure qryTemplateLinesNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    fFileType: TImportFileTypes;
    fsFileName : String;
    fbInitialising : boolean;
    procedure CreateFieldsFromFile;
    procedure DeleteOldTemplateLines;
    function DetectTypeName(const Value : string) : string;
  public
    { Public declarations }
    property FileType : TImportFileTypes read fFileType write fFileType;
    property FileName : string read fsFileName write fsFileName;
  end;

implementation

uses
  Forms,FastFuncs, CommonLib;

Const
  TYPE_INTEGER = 'Integer';
  TYPE_FLOAT = 'Float';
  TYPE_BOOLEAN = 'Boolean';
  TYPE_STRING = 'String';  

{$R *.dfm}

procedure TImportTemplateCSVTAB.cboTemplateNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  inherited;
  LookupTable.Insert;
  LookupTable.FieldByName('TemplateName').AsString := NewValue;
  LookupTable.FieldByName('TemplateType').AsInteger := Ord(fFileType) + 1;
  LookupTable.Post;
  Accept := true;
  Application.ProcessMessages;

  // Now select this new template as the one to edit.
  fbInitialising := true;
  qryTemplateLines.Close;
  qryTemplateLines.ParamCheck := true;
  qryTemplateLines.Params.ParamByName('TemplateID').AsInteger := qryTemplate.FieldByName('AdvImpCSVTABtemplID').AsInteger;
  qryTemplateLines.Open;
  fbInitialising := false;
end;

procedure TImportTemplateCSVTAB.cboTemplateCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not Modified then Exit;
  inherited;
  if cboTemplate.Text = '' then Exit;

  fbInitialising := true;
  qryTemplateLines.Close;
  qryTemplateLines.ParamCheck := true;
  qryTemplateLines.Params.ParamByName('TemplateID').AsInteger := qryTemplate.FieldByName('AdvImpCSVTABtemplID').AsInteger;
  qryTemplateLines.Open;
  fbInitialising := false;
end;

procedure TImportTemplateCSVTAB.grdTemplateLinesExit(Sender: TObject);
begin
  inherited;
  if qryTemplate.State in [dsEdit, dsInsert] then begin
    qryTemplate.Post;
  end;
end;

procedure TImportTemplateCSVTAB.btnOKClick(Sender: TObject);
begin
  inherited;
  CommitTransaction;
end;

procedure TImportTemplateCSVTAB.btnCancelClick(Sender: TObject);
begin
  inherited;
  RollbackTransaction;
end;

procedure TImportTemplateCSVTAB.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    qryTemplate.ParamByName('TemplateType').AsInteger := Ord(fFileType) + 1;
    OpenQueries;

    BeginTransaction;

    // Are we reviewing a preset template?
    {if KeyID <> 0 then begin
      // Locate and Setup.
      if qryTemplate.Locate('AdvImpCSVTABtemplID', KeyID, [loCaseInsensitive]) then begin
        cboTemplate.Text := qryTemplate.FieldByName('TemplateName').AsString;
        cboTemplateCloseUp(Sender, qryTemplate, nil, true);
        cboTemplate.Enabled := false;
      end;
    end;}
  finally
    EnableForm;
  end;  
end;

procedure TImportTemplateCSVTAB.CreateFieldsFromFile;
Var SL, SLDetail, SLDetailType : TStringList;
    i : integer;
begin
  SL := TStringList.Create;
  SLDetail :=TStringList.Create;
  SLDetailType :=TStringList.Create;

  try
    SL.LoadFromFile(FileName);
    if SL.Count = 0 then exit;

    if FileType = iftTAB then begin
      SL[0] := '"' + StringReplace(SL[0],#9,'","', [rfReplaceAll, rfIgnoreCase]) + '"'; // replace all tabs with commas and enclose each field in double quotes
      if SL.Count > 1 then
        SL[1] := '"' + StringReplace(SL[1],#9,'","', [rfReplaceAll, rfIgnoreCase]) + '"'; // replace all tabs with commas and enclose each field in double quotes
    end;
    SLDetail.CommaText := SL[0];
    if SL.Count > 1 then
      SLDetailType.CommaText := SL[1];

    for i := 0 to SLDetail.Count - 1 do begin
      qryTemplateLines.Append;
      qryTemplateLines.FieldByName('FieldName').AsString := SLDetail[i];
      if (SL.Count > 1) AND (SLDetailType.Count > i) then
        qryTemplateLines.FieldByName('FieldType').AsString := DetectTypeName(SLDetailType[i]);
      qryTemplateLines.Post;
    end;
  finally
    FreeandNil(SLDetailType);
    FreeandNil(SLDetail);
    FreeandNil(SL);
  end;
end;

function TImportTemplateCSVTAB.DetectTypeName(const Value: string): string;
Var i : integer;
    AllValid : boolean;
    Point : integer;
begin
  Result := TYPE_STRING;

  //try integer or float
  Point := 0;
  AllValid := true;
  for I := 1 to char_length(Value) do begin
    if CharInSet(Value[i],['0','1','2','3','4','5','6','7','8','9','+','-',FormatSettings.DecimalSeparator]) then begin
      if Value[i] = FormatSettings.DecimalSeparator then begin
        Inc(Point);
        if Point > 1 then begin
          //AllValid := false; //not integer or float
          Result := TYPE_STRING;
          Exit;
        end;
      end;
      if CharInSet(Value[i],['+','-']) then begin
        if i<>1 then begin
          //AllValid := false; //not integer or float
          Result := TYPE_STRING;
          Exit;
        end;
      end;
    end
    else begin
      AllValid := false;
    end;
  end;

  if AllValid then begin
    if Point>0 then begin
      Result := TYPE_FLOAT;
      Exit;
    end else
    begin
      Result := TYPE_INTEGER;
      Exit;
    end;
  end
  else begin
    //try boolean
    if (Trim(Value)='F') OR (Trim(Value)='T') OR (Trim(Value)='False') OR (Trim(Value)='True') then begin
      Result := TYPE_BOOLEAN;
      Exit;
    end;
  end;
end;

procedure TImportTemplateCSVTAB.btnGetFromFileClick(Sender: TObject);
begin
  inherited;
  if cboTemplate.Text = '' then Exit;
  if Trim(FileName) = '' then Exit;
  DeleteOldTemplateLines;
  CreateFieldsFromFile;
end;

procedure TImportTemplateCSVTAB.DeleteOldTemplateLines;
begin
  while not qryTemplateLines.Eof do begin
    qryTemplateLines.Delete;
  end;
end;

procedure TImportTemplateCSVTAB.qryTemplateLinesNewRecord(
  DataSet: TDataSet);
begin
  inherited;
  qryTemplateLines.FieldByName('TemplateID').AsInteger := qryTemplate.FieldByName('AdvImpCSVTABtemplID').AsInteger;
end;

initialization
  RegisterClassOnce(TImportTemplateCSVTAB);

end.
