unit InactiveReportTemplates;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ImgList, Menus, AdvMenus, DataState, DB,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, DNMSpeedButton,
  Grids, Wwdbigrd, Wwdbgrid, MemDS, StdCtrls, Shader, DNMPanel;

type
  TInactiveReportTemplatesGUI = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    btnClose: TDNMSpeedButton;
    qryTemplates: TERPQuery;
    qryTemplatesTemplName: TWideStringField;
    qryTemplatesTemplID: TIntegerField;
    qryTemplatesTypeName: TWideStringField;
    qryTemplatesTemplateClass: TWideStringField;
    qryTemplatesSQLString: TWideMemoField;
    qryTemplatesDesignTimeSQLString: TWideMemoField;
    qryTemplatesEmployeeID: TIntegerField;
    qryTemplatesEditable: TWideStringField;
    qryTemplatesDefaultTemplate: TWideStringField;
    qryTemplatesTypeID: TIntegerField;
    qryTemplatesReportOnFc: TWideStringField;
    qryTemplatesGlobalref: TWideStringField;
    qryTemplatesActive: TWideStringField;
    dsTemplates: TDataSource;
    grdTemplates: TwwDBGrid;
    Bevel1: TBevel;
    procedure btnCloseClick(Sender: TObject);
    procedure grdTemplatesDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    LockMsg:String;
    function LockTemplate(Const Value:Boolean):boolean;
  public
    { Public declarations }
  end;

implementation

uses CommonLib, FastFuncs, UserLockObj, UserLockBaseObj, CommonDbLib;

{$R *.dfm}

procedure TInactiveReportTemplatesGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;
procedure TInactiveReportTemplatesGUI.grdTemplatesDblClick(Sender: TObject);
begin
  inherited;
  if qryTemplatesTemplID.asInteger = 0 then exit;
  if qryTemplatesActive.asBoolean = True then exit;
  if MessageDlgXP_Vista('Do You Wish to Restore ' +Trim(qryTemplatesTemplName.asString) +'?' , mtConfirmation , [mbyes, mbno] , 0) = mrno then exit;
  if not LockTemplate(True) then begin
    MessageDlgXP_Vista(LockMsg, mtWarning, [mbOk] , 0);
    exit;
  end;
  try
    With CommonDbLib.TempMyScript do try
      Sql.Add('UPDATE tbltemplates set Active = "T" WHERE TemplID=' + IntToStr(qryTemplatesTemplID.asInteger) + ';');
      Execute;
      qryTemplates.refresh;
      ModalResult := mrOk; 
    finally
        Free;
    end;
  finally
    LockTemplate(False)
  end;
end;

function TInactiveReportTemplatesGUI.LockTemplate(const Value: Boolean): boolean;
var
  UserLockObj :TUserLock;
begin
result := True;
UserLockObj := TUserLock.create(Self);
try
if Value then
  result := UserLockObj.Lock('tbltemplates' , qryTemplatesTemplID.asInteger , 'Restore Template')
else
  UserLockObj.unLock('tbltemplates' , qryTemplatesTemplID.asInteger , 'Restore Template');
  if not result then LockMsg := UserLock.LockMessage;
finally
  FreeandNil(UserLockObj);
end;

end;

procedure TInactiveReportTemplatesGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TInactiveReportTemplatesGUI.FormShow(Sender: TObject);
begin
  inherited;
  qryTemplates.open;
  grdTemplates.hint := 'Double Click on the Template to Restore';
  grdTemplates.Showhint := true;
end;

initialization
  RegisterClassOnce(TInactiveReportTemplatesGUI);

end.
