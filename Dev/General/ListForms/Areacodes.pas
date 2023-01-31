unit Areacodes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox;

type
  TAreacodesGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainGlobalref: TWideStringField;
    qryMainAreacode: TWideStringField;
    qryMainAreaName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainmsUpdateSitecode: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
    fsAreaIdstoSelect: String;
    { Private declarations }
  public
    Property AreaIdstoSelect :String read fsAreaIdstoSelect Write fsAreaIdstoSelect;
    Procedure RefreshQuery;override;
  end;


implementation

uses CommonFormLib, CommonLib, IntegerListObj, AppEnvironment;

{$R *.dfm}

procedure TAreacodesGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmAreaCode' ,0, nil, nil);
end;

procedure TAreacodesGUI.FormCreate(Sender: TObject);
begin
  Self.Caption := replacestr(Self.Caption , 'Area' , AppEnv.CompanyPrefs.Areacolumnname);
  inherited;
  fbhideIDFields   := True;
  fbHideSitefields:= True;
  fsAreaIdstoSelect := '';
end;
procedure TAreacodesGUI.RefreshQuery;
var
  fAreaIdstoSelect :TIntegerlist;
  ctr:Integer;
begin
  inherited;
  if fsAreaIdstoSelect <> '' then begin
    fAreaIdstoSelect :=TIntegerlist.Create;
    try
      fAreaIdstoSelect.CommaText:=fsAreaIdstoSelect;
      for ctr:= 0 to fAreaIdstoSelect.Count-1 do
        if Qrymain.Locate('ID', fAreaIdstoSelect[ctr],[]) then
          Grdmain.SelectRecord;
    finally
      Freeandnil(fAreaIdstoSelect);
      fsAreaIdstoSelect:= '';
    end;
  end;

end;

initialization
  RegisterClassOnce(TAreacodesGUI);

end.

