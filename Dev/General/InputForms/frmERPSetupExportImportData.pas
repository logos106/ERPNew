unit frmERPSetupExportImportData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,frmExportImportData, frmExportOptionsFrm, DB, MemDS, DBAccess,
  MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState,
  SelectionDialog, AppEvnts, StdCtrls, Shader, ExtCtrls, DNMPanel,
  DNMSpeedButton, ComCtrls, wwclearbuttongroup, wwradiogroup,
  AdvProgressBar, HTMLDialog, HTMLabel, ProgressDialog;

const
  DefaultExports :array [1..4] of string = ('Account' , 'Customer','Product','Supplier');
type
  TERPSetupMode = (tsmNone =0, tsmExport=1, tsmImport=2);

  TfmERPSetupExportImportData = class(TfmExportImportData)
    lblhint: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
  private
    fERPSetupMode: TERPSetupMode;
    count :Integer;
    procedure SetERPSetupMode(const Value: TERPSetupMode);
    Procedure SelectnextDefaultItem;
    procedure InitImport(Sender: TObject);
    function DatamapingID(const DatamapingName,
      DataMappingtype: String): Integer;
    { Private declarations }
  public
    Property ERPSetupMode:TERPSetupMode read fERPSetupMode write SetERPSetupMode default tsmNone;
    Function DoExport:boolean;Override;
    Function DoImport:boolean;Override;
    Function ListOpened:boolean; Override;
  end;


implementation

uses SystemLib,CommonLib, FastFuncs, frmImportDataMapping, BusObjectListObj,
  CommonDbLib;

{$R *.dfm}
{ TfmERPSetupExportImportData }

procedure TfmERPSetupExportImportData.SetERPSetupMode(const Value: TERPSetupMode);
var
  ctr:Integer;
begin
  if fERPSetupMode = Value then exit;
  fERPSetupMode := Value;
  lblhint.Caption := '';
  for ctr := low(DefaultExports) to high(DefaultExports) do begin
    if ctr <> 1 then lblhint.Caption:=lblhint.Caption +',';
    lblhint.Caption:= lblhint.Caption + Quotedstr(DefaultExports[ctr]);
  end;

  if value = tsmExport then begin
    HighlightControl(btnExport);
    MessageDlgXP_Vista('This Will Now Export ' + IntToStr(high(DefaultExports))+
      ' Examples of Data of ' +chr(13) +
      lblhint.Caption+chr(13) +
      ' to "'+Commonlib.TempDir+'".'+chr(13) +chr(13) +
      'It Will Do These One At a Time.' , mtInformation, [mbok],0);

    lblhint.caption := 'Please Make Sure You Export ' +lblhint.caption;
  end else  if value = tsmImport then begin
    HighlightControl(btnImport);

    MessageDlgXP_Vista('This Will Now Import the ' + IntToStr(high(DefaultExports))+
      ' Sample Data Files Created Earlier From the Export -' +chr(13) +
      lblhint.Caption+chr(13) +
      ' From "'+Commonlib.TempDir+'".'+chr(13) +chr(13) +
      'It Will Do These One At a Time.' , mtInformation, [mbok],0);
    lblhint.Caption := 'Please Make Sure You Import All Files Required ';
    lblhint.visible := True;
  end;
end;

procedure TfmERPSetupExportImportData.FormCreate(Sender: TObject);
begin
  inherited;
  count:=1;
end;

procedure TfmERPSetupExportImportData.SelectnextDefaultItem;
var
  ctr:Integer;
begin
  rgOption.Itemindex:= -1;
  txtFileName.text := '';
  if count > high(DefaultExports) then begin
    HighlightControl(btnCancel);
    exit;
  end;
  for ctr := 0 to rgOption.Items.count -1 do
      if Sysutils.SameText(rgOption.Items[ctr] , DefaultExports[count]) then begin
          rgOption.Itemindex := ctr;
          break;
      end;
end;

procedure TfmERPSetupExportImportData.FormShow(Sender: TObject);
begin
  inherited;
  SelectnextDefaultItem;
end;

procedure TfmERPSetupExportImportData.btnImportClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  DisableForm;
  try
    //inherited;
    tmpComponent := GetComponentByClassName('TfmImportDataMapping');
    If not Assigned(tmpComponent) then Exit;
    with TfmImportDataMapping(tmpComponent) do begin
      AttachObserver(Self);
      InitImport := Self.InitImport;
      KeyId := DatamapingID(rgOption.Items[rgOption.ItemIndex] , BusObjectListObj.TBusObjInfoList.Inst.ItemByName[rgOption.Items[rgOption.ItemIndex]].Name);
      SavencloseonImport:=True;
      HighlightControl(btnImport);
      HighlightextraControl1(btnTest);
      showcontrolHint(btnImport, 'Select this to Import data and close this form to get back to the list of options for data import');
      showcontrolHint(btnTest, 'Select this option to test importing to find out if any error in the data');
      ShowModal;
    end;
  finally
    EnableForm;
  end;
  count := count+1;
  SelectnextDefaultItem;
end;
function TfmERPSetupExportImportData.DatamapingID(const DatamapingName, DataMappingtype:String):Integer;
begin
  with TempMyquery do try
      SQL.Add('select ImportDataMapID from tblImportDataMap');
      SQL.Add('where Active = "T"');
      SQL.Add('and typename =' +Quotedstr(DataMappingtype));
      SQL.Add('and ImportName = ' + QuotedStr(DatamapingName));
      open;
      REsult:= Fieldbyname('ImportDataMapID').AsInteger
  finally
    ClosenFree;
  end;
end;
procedure TfmERPSetupExportImportData.InitImport(Sender: TObject);
begin
  if not(Sender is TfmImportDataMapping) then exit;
  With TfmImportDataMapping(Sender) do begin
    InitNewMaping(rgOption.Items[rgOption.ItemIndex] , BusObjectListObj.TBusObjInfoList.Inst.ItemByName[rgOption.Items[rgOption.ItemIndex]].Name, Self.txtFileName.Text , true);
    btnRefresh.Click;
    UnMapfields(pdtDateTime);
  end;
end;

function TfmERPSetupExportImportData.DoExport: boolean;
begin
  result := inherited DoExport;
  if not result then exit;
  count := count+1;
  SelectnextDefaultItem;
end;

function TfmERPSetupExportImportData.DoImport: boolean;
begin
  result := inherited DoImport;
  if not result then exit;
  count := count+1;
  SelectnextDefaultItem;
end;

function TfmERPSetupExportImportData.ListOpened: boolean;
begin
  REsult := False;
end;

initialization
  RegisterClassOnce(TfmERPSetupExportImportData);

end.
