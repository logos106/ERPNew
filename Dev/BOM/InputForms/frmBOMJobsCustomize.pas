unit frmBOMJobsCustomize;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, Shader, ExtCtrls, DNMPanel, Menus, StdCtrls,
  ComCtrls, TreeList, DB, MemDS, DBAccess, MyAccess, ERPdbComponents ,BaseInputForm,
  ProgressDialog, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Grids, Wwdbigrd, Wwdbgrid;

type


  TfmBOMJobsCustomize = class(TBaseInputGUI)
    DNMPanel2: TDNMPanel;
    DNMPanel4: TDNMPanel;
    Shader1: TShader;
    titleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    btnCancel: TDNMSpeedButton;
    btnSave: TDNMSpeedButton;
    btnSelectAll: TDNMSpeedButton;
    Qrycolumns: TERPQuery;
    dscolumns: TDataSource;
    QrycolumnsID: TIntegerField;
    QrycolumnsFieldname: TWideStringField;
    QrycolumnsVisible: TWideStringField;
    QrycolumnsCaption: TWideStringField;
    wwDBGrid1: TwwDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure QrycolumnsVisibleChange(Sender: TField);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    TableName:String;
    function getSaleIDVisible :Boolean;
    function getDueDateVisible :Boolean;
    function getProductNameVisible :Boolean;
    function getQuantityVisible :Boolean;
    function getCaptionVisible :Boolean;
    function getProcessVisible :Boolean;
    function getDurationVisible :Boolean;
    function getSetupDurationVisible :Boolean;
    function getBreakDownDurationVisible :Boolean;
    function getToBeScheduledVisible :Boolean;

    function getSaleIDCaption:String;
    function getDueDateCaption:String;
    function getProductNameCaption:String;
    function getQuantityCaption:String;
    function getCaptionCaption:String;
    function getProcessCaption:String;
    function getDurationCaption:String;
    function getSetupDurationCaption:String;
    function getBreakDownDurationCaption:String;
    function getToBeScheduledCaption:String;
    function getHeirarchyLvlCaption:String;
    function getHeirarchyDurCaption:String;

    Procedure SetSaleIDVisible (Const Value:Boolean);
    Procedure SetDueDateVisible (Const Value:Boolean);
    Procedure SetProductNameVisible (Const Value:Boolean);
    Procedure SetQuantityVisible (Const Value:Boolean);
    Procedure SetCaptionVisible (Const Value:Boolean);
    Procedure SetProcessVisible (Const Value:Boolean);
    Procedure SetDurationVisible (Const Value:Boolean);
    Procedure SetSetupDurationVisible (Const Value:Boolean);
    Procedure SetBreakDownDurationVisible (Const Value:Boolean);
    Procedure SetToBeScheduledVisible (Const Value:Boolean);
    Procedure SetSaleIDCaption (Const Value:String);
    Procedure SetDueDateCaption (Const Value:String);
    Procedure SetProductNameCaption (Const Value:String);
    Procedure SetQuantityCaption (Const Value:String);
    Procedure SetCaptionCaption (Const Value:String);
    Procedure SetProcessCaption (Const Value:String);
    Procedure SetDurationCaption (Const Value:String);
    Procedure SetSetupDurationCaption (Const Value:String);
    Procedure SetBreakDownDurationCaption (Const Value:String);
    Procedure SetToBeScheduledCaption (Const Value:String);
    Procedure SetHeirarchyLvlCaption (Const Value:String);
    Procedure SetHeirarchyDurCaption (Const Value:String);
    function ReadVisible(const Fieldname: String): Boolean;
    procedure WriteVisible(const Fieldname: String; const Value: Boolean);
    function ReadCaption(const Fieldname: String): String;
    procedure WriteCaption(const Fieldname, Value: String);
  public
    Property SaleIDvisible:Boolean read getSaleIDVisible Write SetSaleIDvisible;
    Property DueDatevisible:Boolean read getDueDateVisible Write SetDueDatevisible;
    Property ProductNamevisible:Boolean read getProductNameVisible Write SetProductNamevisible;
    Property Quantityvisible:Boolean read getQuantityVisible Write SetQuantityvisible;
    Property Captionvisible:Boolean read getCaptionVisible Write SetCaptionvisible;
    Property Processvisible:Boolean read getProcessVisible Write SetProcessvisible;
    Property Durationvisible:Boolean read getDurationVisible Write SetDurationvisible;
    Property SetupDurationvisible:Boolean read getSetupDurationVisible Write SetSetupDurationvisible;
    Property BreakDownDurationvisible:Boolean read getBreakDownDurationVisible Write SetBreakDownDurationvisible;
    Property ToBeScheduledVisible:Boolean read getToBeScheduledVisible Write SetToBeScheduledVisible;
    Property SaleIDCaption:String  read getSaleIDCaption Write SetSaleIDCaption;
    Property DueDateCaption:String  read getDueDateCaption Write SetDueDateCaption;
    Property ProductNameCaption:String  read getProductNameCaption Write SetProductNameCaption;
    Property QuantityCaption:String  read getQuantityCaption Write SetQuantityCaption;
    Property CaptionCaption:String  read getCaptionCaption Write SetCaptionCaption;
    Property ProcessCaption:String  read getProcessCaption Write SetProcessCaption;
    Property DurationCaption:String  read getDurationCaption Write SetDurationCaption;
    Property SetupDurationCaption:String  read getSetupDurationCaption Write SetSetupDurationCaption;
    Property BreakDownDurationCaption:String  read getBreakDownDurationCaption Write SetBreakDownDurationCaption;
    Property ToBeScheduledCaption:String  read getToBeScheduledCaption Write SetToBeScheduledCaption;
    Property HeirarchyLvlCaption:String  read getHeirarchyLvlCaption Write SetHeirarchyLvlCaption;
    Property HeirarchyDurCaption:String  read getHeirarchyDurCaption Write SetHeirarchyDurCaption;
    class Procedure  CallBOMJobsCustomize(AOwner :Tform);
  end;


implementation

uses CommonDbLib, DbSharedObjectsObj, BOMJobs;

{$R *.dfm}

procedure TfmBOMJobsCustomize.btnCancelClick(Sender: TObject);
begin
  inherited;
  Canceldb(qrycolumns);
  if fsModal in Self.FormState then ModalResult := mrCancel
  else Close;
end;

procedure TfmBOMJobsCustomize.btnSaveClick(Sender: TObject);
begin
  inherited;
  Postdb(qrycolumns);
  if fsModal in Self.FormState then ModalResult := mrOk
  else Close;
end;

procedure TfmBOMJobsCustomize.btnSelectAllClick(Sender: TObject);
var
  Script :TERPScript;
begin
  inherited;
  closedb(Qrycolumns);
  Script := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
  try
    Script.SQL.Clear;
    Script.SQL.Add('update '+ tablename +' Set visible ="T"');
    Script.Execute;
  finally
    DbSharedObj.ReleaseObj(Script);
    Opendb(Qrycolumns);
  end;
end;

class procedure TfmBOMJobsCustomize.CallBOMJobsCustomize(AOwner: Tform);
var
  Form :TfmBOMJobsCustomize;
begin
    form := TfmBOMJobsCustomize.Create(AOwner);
    try
      form.ShowModal;
      if form.ModalResult = mrok then begin
        if Assigned(form.Owner) and (form.Owner is TBOMJobsGUI) then begin
              TBOMJobsGUI(form.Owner).SaleIDvisible           := form.SaleIDVisible;
              TBOMJobsGUI(form.Owner).DueDatevisible         := form.DueDateVisible;
              TBOMJobsGUI(form.Owner).ProductNamevisible      := form.ProductNameVisible;
              TBOMJobsGUI(form.Owner).Quantityvisible         := form.QuantityVisible;
              TBOMJobsGUI(form.Owner).Captionvisible          := form.CaptionVisible;
              TBOMJobsGUI(form.Owner).Processvisible          := form.ProcessVisible;
              TBOMJobsGUI(form.Owner).Durationvisible         := form.DurationVisible;
              TBOMJobsGUI(form.Owner).SetupDurationvisible    := form.SetupDurationVisible;
              TBOMJobsGUI(form.Owner).BreakDownDurationvisible:= form.BreakDownDurationVisible;
              TBOMJobsGUI(form.Owner).ToBeScheduledVisible    := form.ToBeScheduledVisible;
              TBOMJobsGUI(form.Owner).SaleIDCaption           := form.SaleIDCaption;
              TBOMJobsGUI(form.Owner).DueDateCaption         := form.DueDateCaption;
              TBOMJobsGUI(form.Owner).ProductNameCaption      := form.ProductNameCaption;
              TBOMJobsGUI(form.Owner).QuantityCaption         := form.QuantityCaption;
              TBOMJobsGUI(form.Owner).CaptionCaption          := form.CaptionCaption;
              TBOMJobsGUI(form.Owner).ProcessCaption          := form.ProcessCaption;
              TBOMJobsGUI(form.Owner).DurationCaption         := form.DurationCaption;
              TBOMJobsGUI(form.Owner).SetupDurationCaption    := form.SetupDurationCaption;
              TBOMJobsGUI(form.Owner).BreakDownDurationCaption:= form.BreakDownDurationCaption;
              TBOMJobsGUI(form.Owner).ToBeScheduledCaption    := form.ToBeScheduledCaption;
              TBOMJobsGUI(form.Owner).HeirarchyLvlCaption     := form.HeirarchyLvlCaption;
              TBOMJobsGUI(form.Owner).HeirarchyDurCaption     := form.HeirarchyDurCaption;

(*              commondblib.closedb(TBOMJobsGUI(form.Owner).Qrymain);
              commondblib.Opendb(TBOMJobsGUI(form.Owner).Qrymain);*)
              TBOMJobsGUI(form.Owner).SetGridColumns;
        end;
      end;

    finally
      freeandNil(form);
    end;
end;

procedure TfmBOMJobsCustomize.FormCreate(Sender: TObject);
var
  Script :TERPScript;
begin
  inherited;
  Tablename := commondblib.GetUserTemporaryTableName('BOMJobsCustomize');
  Script := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
  try
    Script.SQL.Clear;
    Script.SQL.Add('Drop table if exists ' +tablename +';');
    Script.SQL.Add('CREATE TABLE ' +tablename +' ( ' +
	                  ' ID INT NOT NULL AUTO_INCREMENT, ' +
	                  ' FieldName VARCHAR(100) NULL DEFAULT NULL, ' +
	                  ' Visible ENUM("T","F") NULL DEFAULT "T", ' +
	                  ' Caption VARCHAR(100) NULL DEFAULT NULL, ' +
	                  ' PRIMARY KEY (ID) ' +
	                  ' ) COLLATE="utf8_general_ci" ENGINE=MyISAM ;');
    Script.SQL.Add('insert into ' +tablename +' (FieldName, Visible, Caption) Values ("SaleID"                , "T" , "Sale #");' );
    Script.SQL.Add('insert into ' +tablename +' (FieldName, Visible, Caption) Values ("DueDate"               , "T" , "Due Date");' );
    Script.SQL.Add('insert into ' +tablename +' (FieldName, Visible, Caption) Values ("ProductName"           , "T" , "Product Name");' );
    Script.SQL.Add('insert into ' +tablename +' (FieldName, Visible, Caption) Values ("Quantity"              , "T" , "Quantity");' );
    Script.SQL.Add('insert into ' +tablename +' (FieldName, Visible, Caption) Values ("HeirarchyLvl"          , "T" , "Level #");' );
    Script.SQL.Add('insert into ' +tablename +' (FieldName, Visible, Caption) Values ("Caption"               , "T" , "    Caption");' );
    Script.SQL.Add('insert into ' +tablename +' (FieldName, Visible, Caption) Values ("Process"               , "T" , "    Process");' );
    Script.SQL.Add('insert into ' +tablename +' (FieldName, Visible, Caption) Values ("HeirarchyDur"          , "T" , "    Level Duration #");' );
    Script.SQL.Add('insert into ' +tablename +' (FieldName, Visible, Caption) Values ("Duration"              , "T" , "        Job");' );
    Script.SQL.Add('insert into ' +tablename +' (FieldName, Visible, Caption) Values ("SetupDuration"         , "T" , "        Set Up");' );
    Script.SQL.Add('insert into ' +tablename +' (FieldName, Visible, Caption) Values ("BreakDwonDuration"     , "T" , "        Breakdown");' );
    Script.SQL.Add('insert into ' +tablename +' (FieldName, Visible, Caption) Values ("ToBeScheduled"         , "T" , "        To Schedule");' );
    Script.Execute;
  finally
    DbSharedObj.ReleaseObj(Script);
  end;
  Qrycolumns.SQL.Text := 'Select * from '+ tablename;

end;

procedure TfmBOMJobsCustomize.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  inherited;

end;

procedure TfmBOMJobsCustomize.FormShow(Sender: TObject);
begin
  inherited;
  OpenQueries;
  if Assigned(Owner) and (Owner is TBOMJobsGUI) then begin
    SaleIDvisible := TBOMJobsGUI(Owner).SaleIDVisible;
    DueDatevisible := TBOMJobsGUI(Owner).DueDateVisible;
    ProductNamevisible := TBOMJobsGUI(Owner).ProductNameVisible;
    Quantityvisible := TBOMJobsGUI(Owner).QuantityVisible;
    Captionvisible := TBOMJobsGUI(Owner).CaptionVisible;
    Processvisible := TBOMJobsGUI(Owner).ProcessVisible;
    Durationvisible := TBOMJobsGUI(Owner).DurationVisible;
    SetupDurationvisible := TBOMJobsGUI(Owner).SetupDurationVisible;
    BreakDownDurationvisible := TBOMJobsGUI(Owner).BreakDownDurationVisible;
    ToBeScheduledVisible := TBOMJobsGUI(Owner).ToBeScheduledVisible;
    SaleIDCaption := TBOMJobsGUI(Owner).SaleIDCaption;
    DueDateCaption := TBOMJobsGUI(Owner).DueDateCaption;
    ProductNameCaption := TBOMJobsGUI(Owner).ProductNameCaption;
    QuantityCaption := TBOMJobsGUI(Owner).QuantityCaption;
    CaptionCaption := TBOMJobsGUI(Owner).CaptionCaption;
    ProcessCaption := TBOMJobsGUI(Owner).ProcessCaption;
    DurationCaption := TBOMJobsGUI(Owner).DurationCaption;
    SetupDurationCaption := TBOMJobsGUI(Owner).SetupDurationCaption;
    BreakDownDurationCaption := TBOMJobsGUI(Owner).BreakDownDurationCaption ;
    ToBeScheduledCaption := TBOMJobsGUI(Owner).ToBeScheduledCaption ;
    HeirarchyLvlCaption := TBOMJobsGUI(Owner).HeirarchyLvlCaption ;
    HeirarchyDurCaption := TBOMJobsGUI(Owner).HeirarchyDurCaption ;
  end;
end;
Procedure TfmBOMJobsCustomize.WriteVisible(const Fieldname:String; const Value:Boolean);
begin
  if not Qrycolumns.active then exit;
  if Qrycolumns.locate('fieldname' , Fieldname , []) then begin
    EditDB(Qrycolumns);
    Qrycolumns.fieldbyname('visible').asBoolean := Value;
    PostDB(Qrycolumns);
  end;

end;
function TfmBOMJobsCustomize.ReadVisible(const Fieldname:String):Boolean;
begin
  Result := False;
  if not Qrycolumns.active then exit;
  if Qrycolumns.locate('fieldname' , Fieldname , []) then
    REsult :=Qrycolumns.fieldbyname('visible').asBoolean;
end;
Procedure TfmBOMJobsCustomize.WriteCaption(const Fieldname:String; const Value:String);
begin
  if Value = '' then exit;
  if not Qrycolumns.active then exit;
  if Qrycolumns.locate('fieldname' , Fieldname , []) then begin
    EditDB(Qrycolumns);
    Qrycolumns.fieldbyname('Caption').asString := Value;
    PostDB(Qrycolumns);
  end;

end;
function TfmBOMJobsCustomize.ReadCaption(const Fieldname:String):String;
begin
  Result := '';
  if not Qrycolumns.active then exit;
  if Qrycolumns.locate('fieldname' , Fieldname , []) then
    REsult :=Qrycolumns.fieldbyname('Caption').asString;
end;
procedure TfmBOMJobsCustomize.QrycolumnsVisibleChange(Sender: TField);
begin
  inherited;
  if QrycolumnsVisible.AsBoolean=False then
    if sametext(QrycolumnsFieldname.AsString  , 'HeirarchyLvlCaption') or
      sametext(QrycolumnsFieldname.AsString  , 'HeirarchyDurCaption') then QrycolumnsVisible.AsBoolean:= True;
end;

function TfmBOMJobsCustomize.getSaleIDVisible :Boolean;       begin Result := ReadVisible('SaleID'); end;
function TfmBOMJobsCustomize.getDueDateVisible :Boolean;     begin Result := ReadVisible('DueDate'); end;
function TfmBOMJobsCustomize.getProductNameVisible :Boolean;  begin Result := ReadVisible('ProductName'); end;
function TfmBOMJobsCustomize.getQuantityVisible :Boolean;     begin Result := ReadVisible('Quantity'); end;
function TfmBOMJobsCustomize.getCaptionVisible :Boolean;      begin Result := ReadVisible('Caption'); end;
function TfmBOMJobsCustomize.getProcessVisible :Boolean;      begin Result := ReadVisible('Process'); end;
function TfmBOMJobsCustomize.getDurationVisible :Boolean;     begin Result := ReadVisible('Duration'); end;
function TfmBOMJobsCustomize.getSetupDurationVisible :Boolean;begin Result := ReadVisible('SetupDuration'); end;
function TfmBOMJobsCustomize.getBreakDownDurationVisible :Boolean;begin Result := ReadVisible('BreakDwonDuration'); end;
function TfmBOMJobsCustomize.getToBeScheduledVisible :Boolean;begin Result := ReadVisible('ToBeScheduled'); end;
function TfmBOMJobsCustomize.getSaleIDCaption:String;       begin Result := ReadCaption('SaleID');end;
function TfmBOMJobsCustomize.getDueDateCaption:String;     begin Result := ReadCaption('DueDate');end;
function TfmBOMJobsCustomize.getProductNameCaption:String;  begin Result := ReadCaption('ProductName');end;
function TfmBOMJobsCustomize.getQuantityCaption:String;     begin Result := ReadCaption('Quantity');end;
function TfmBOMJobsCustomize.getCaptionCaption:String;      begin Result := ReadCaption('Caption');end;
function TfmBOMJobsCustomize.getProcessCaption:String;      begin Result := ReadCaption('Process');end;
function TfmBOMJobsCustomize.getDurationCaption:String;     begin Result := ReadCaption('Duration');end;
function TfmBOMJobsCustomize.getSetupDurationCaption:String;begin Result := ReadCaption('SetupDuration');end;
function TfmBOMJobsCustomize.getBreakDownDurationCaption:String;begin Result := ReadCaption('BreakDwonDuration');end;
function TfmBOMJobsCustomize.getToBeScheduledCaption:String;begin Result := ReadCaption('ToBeScheduled');end;
function TfmBOMJobsCustomize.getHeirarchyLvlCaption:String;begin Result := ReadCaption('HeirarchyLvl');end;
function TfmBOMJobsCustomize.getHeirarchyDurCaption:String;begin Result := ReadCaption('HeirarchyDur');end;

Procedure TfmBOMJobsCustomize.setSaleIDVisible (Const Value:Boolean);       begin WriteVisible('SaleID', Value); end;
Procedure TfmBOMJobsCustomize.setDueDateVisible (Const Value:Boolean);     begin WriteVisible('DueDate', Value); end;
Procedure TfmBOMJobsCustomize.setProductNameVisible (Const Value:Boolean);  begin WriteVisible('ProductName', Value); end;
Procedure TfmBOMJobsCustomize.setQuantityVisible (Const Value:Boolean);     begin WriteVisible('Quantity', Value); end;
Procedure TfmBOMJobsCustomize.setCaptionVisible (Const Value:Boolean);      begin WriteVisible('Caption', Value); end;
Procedure TfmBOMJobsCustomize.setProcessVisible (Const Value:Boolean);      begin WriteVisible('Process', Value); end;
Procedure TfmBOMJobsCustomize.setDurationVisible (Const Value:Boolean);     begin WriteVisible('Duration', Value); end;
Procedure TfmBOMJobsCustomize.setSetupDurationVisible (Const Value:Boolean);begin WriteVisible('SetupDuration', Value); end;
Procedure TfmBOMJobsCustomize.setBreakDownDurationVisible (Const Value:Boolean);begin WriteVisible('BreakDwonDuration', Value); end;
Procedure TfmBOMJobsCustomize.setToBeScheduledVisible (Const Value:Boolean);begin WriteVisible('ToBeScheduled', Value); end;

Procedure TfmBOMJobsCustomize.setSaleIDCaption (Const Value:String);       begin WriteCaption('SaleID', Value); end;
Procedure TfmBOMJobsCustomize.setDueDateCaption (Const Value:String);     begin WriteCaption('DueDate', Value); end;
Procedure TfmBOMJobsCustomize.setProductNameCaption (Const Value:String);  begin WriteCaption('ProductName', Value); end;
Procedure TfmBOMJobsCustomize.setQuantityCaption (Const Value:String);     begin WriteCaption('Quantity', Value); end;
Procedure TfmBOMJobsCustomize.setCaptionCaption (Const Value:String);      begin WriteCaption('Caption', Value); end;
Procedure TfmBOMJobsCustomize.setProcessCaption (Const Value:String);      begin WriteCaption('Process', Value); end;
Procedure TfmBOMJobsCustomize.setDurationCaption (Const Value:String);     begin WriteCaption('Duration', Value); end;
Procedure TfmBOMJobsCustomize.setSetupDurationCaption (Const Value:String);begin WriteCaption('SetupDuration', Value); end;
Procedure TfmBOMJobsCustomize.setBreakDownDurationCaption (Const Value:String);begin WriteCaption('BreakDwonDuration', Value); end;
Procedure TfmBOMJobsCustomize.setToBeScheduledCaption (Const Value:String);begin WriteCaption('ToBeScheduled', Value); end;
Procedure TfmBOMJobsCustomize.setHeirarchyLvlCaption (Const Value:String);begin WriteCaption('HeirarchyLvl', Value); end;
Procedure TfmBOMJobsCustomize.setHeirarchyDurCaption (Const Value:String);begin WriteCaption('HeirarchyDur', Value); end;
end.
