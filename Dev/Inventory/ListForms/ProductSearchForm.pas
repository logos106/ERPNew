unit ProductSearchForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, wwdblook,  Shader,
  kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TProductSearchGUI = class(TBaseListingGUI)
    cboUOM: TwwDBLookupCombo;
    qryUnits: TERPQuery;
    qryUnitsUnitID: TIntegerField;
    qryUnitsUnitName: TWideStringField;
    qryUnitsUnitDescription: TWideStringField;
    Button1: TDNMSpeedButton;
    qryMainSelected: TWideStringField;
    qryMainPartsId: TIntegerField;
    qryMainPartName: TWideStringField;
    qryMainPartType: TWideStringField;
    qryMainQty: TFloatField;
    qryMainUOM: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
    procedure edtSearchEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtSearchExit(Sender: TObject);
    procedure edtSearchKeyPress(Sender: TObject; var Key: char);
    procedure qryMainQtyChange(Sender: TField);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    TableName: string;
    OldSearchText: string;
    tmpSearchText: string;
    fSearchfor: string;
  protected
    procedure RefreshQuery; override;
  public
    property SearchFor: string read fSearchFor write fSearchFor;
  end;

  //var
  //  ProductSearchGUI: TProductSearchGUI;

implementation

uses FastFuncs,StrUtils, CommonDbLib, CommonLib;

{$R *.dfm}
procedure TProductSearchGUI.RefreshQuery;
begin
  if OldSearchText = edtSearch.Text then begin
    if Qrymain.Active = false then Qrymain.Open;
    Exit;
  end;
  with TERPQuery.Create(self) do try
      Connection := QryMain.Connection;
      SQL.add('Select PartsID , PartName, PartType, ');
      {if SearchFor = 'Sales' then SQL.add(' unitofMeasureSales as UOM')
      else SQL.add('unitofMeasure as UOM');}
      SQL.add('from tblParts ');
      SQL.add('where Active = ''T'' and ' + tmpSearchText);
      Open;
      QryMain.First;
      while QryMain.Eof = false do begin
        if Locate('PartsID', qryMainPartsId.AsInteger, []) = false then QryMain.Delete
        else QryMain.Next;
      end;
      First;
      while Eof = false do begin
        if QryMain.Locate('PartsId', FieldByName('PartsID').AsInteger, []) = false then begin
          QryMain.Append;
          qryMainSelected.AsString := 'F';
          qryMainPartsId.AsInteger := FieldByName('PartsId').AsInteger;
          qryMainPartName.AsString := FieldByName('PartName').AsString;
          qryMainPartType.AsString := FieldByName('PartType').AsString;
          qryMainUOM.AsString := FieldByName('UOM').AsString;
          if qryMainUOM.AsString = '' then qryMainUOM.AsString := 'Units';
          qryMainQty.AsFloat := 0;
          Qrymain.POST;
        end;
        Next;
      end;
    finally
      if Active then Close;
      Free;
    end;
end;

procedure TProductSearchGUI.FormShow(Sender: TObject);
var
  ctr: integer;
begin
  fbIgnoreAccessLevels := true;
  TableName := CreateUserTemporaryTable('tmp_ProductSearch');
  with QryMain do begin
    if Active then Close;
    SQL.Clear;
    SQL.add('Select * from ' + TableName);
  end;
  inherited;
  if qryUnits.Active = false then qryUnits.Open;
  {searching available only on product type and product name }
  for ctr := cboFilter.Items.Count - 1 downto 0 do if (cboFilter.Items[ctr] <> 'Product') and
      (cboFilter.Items[ctr] <> 'Product Type') then cboFilter.Items.Delete(ctr);
    {cboFilter.Items.Delete(4);
    cboFilter.Items.Delete(3);
    cboFilter.Items.Delete(0);}
  cboFilter.ItemIndex := 0;
end;

procedure TProductSearchGUI.btnGoClick(Sender: TObject);
var
  sFieldName: string;
begin
  Processingcursor(True);
  try
    if (edtSearch.Text <> '') and (cboFilter.Text <> '') then begin
      sFieldName := TField(cboFilter.Items.Objects[cboFilter.ItemIndex]).FieldName;
      tmpSearchText := edtSearch.Text;
      if not (AnsiContainsText(tmpSearchText, '*') or AnsiContainsText(tmpSearchText, '%')) and not Empty(tmpSearchText) then tmpSearchText := Trim(tmpSearchText) + '%';
      tmpSearchText := sFieldName + ' like ' + QuotedStr(tmpSearchText);
      RefreshQuery;
    end;
  except
    Processingcursor(False);
  end;
end;

procedure TProductSearchGUI.edtSearchEnter(Sender: TObject);
begin
  inherited;
  OldSearchText := edtSearch.Text;
end;

procedure TProductSearchGUI.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
end;

procedure TProductSearchGUI.edtSearchExit(Sender: TObject);
begin
  //  inherited;
end;

procedure TProductSearchGUI.edtSearchKeyPress(Sender: TObject; var Key: char);
begin
  //  inherited;
end;

procedure TProductSearchGUI.qryMainQtyChange(Sender: TField);
begin
  inherited;
  if QryMainQty.AsFloat <> 0 then begin
    if QryMain.State in [dsEdit, dsInsert] then else Qrymain.Edit;
    qryMainSelected.AsString := 'T';
  end;
end;

procedure TProductSearchGUI.FormDestroy(Sender: TObject);
begin
  with Qrymain do begin
    if Active then Close;
    SQL.Clear;
    SQL.add('drop table if exists ' + tablename);
    Execute;
  end;
  inherited;
end;

procedure TProductSearchGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
