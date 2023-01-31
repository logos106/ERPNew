unit MagentoListBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ERPEDIListBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel , utBaseCoreService,ERPEDIBase;

type
  TMagentoListBaseGUI = class(TERPEDIListBaseGUI)
    pnlExtraButtons: TDNMPanel;
    btnSynch: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  Protected
    Procedure DoEDIAutocheck(Sender:TObject); Override;
    procedure SynchTransactions;Virtual;abstract;
    procedure StopSynch;Overload;
    Function ModuleCaption :String;Override;
    Procedure InitCodeEDI;Override;
    Function HasEDICredentials :Boolean ; Override;
    Function MakeCoreServiceObj :TBaseCoreService; Override;
    function CreateERPEDISynchObj: TERPEDIBase; Override;
  public
    Procedure OpenPreferance;Override;
    Procedure RefreshQuery;Override;
  end;


implementation

uses utCoreEDIConst, AppEnvironment, utMagentoService, Preferences,
  ErpSynchMagento;

{$R *.dfm}

{ TMagentoListBaseGUI }

procedure TMagentoListBaseGUI.DoEDIAutocheck(Sender: TObject);
begin
  inherited;
  InitTimers(false);
  if SameText(btnSynch.Caption, fsSynchCaption) then begin
    btnSynch.Caption := 'Stop Synch';
    SynchTransactions;
    StopSynch;
  end
  else begin
    StopSynch;
  end;
end;
procedure TMagentoListBaseGUI.StopSynch;
begin
  StopSynch(btnSynch);
end;

procedure TMagentoListBaseGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fsSynchCaption:=btnSynch.caption;
end;

procedure TMagentoListBaseGUI.FormShow(Sender: TObject);
begin
  InitializeCoreEDIObj ;
  inherited;
end;

function TMagentoListBaseGUI.HasEDICredentials: Boolean;
begin
  Result := Appenv.companyprefs.MagentoEnabled ;
end;

procedure TMagentoListBaseGUI.initCodeEDI;
begin
  inherited;
end;

function TMagentoListBaseGUI.MakeCoreServiceObj: TBaseCoreService;
begin
  result := TMagentoCoreService.Create;
end;
function TMagentoListBaseGUI.CreateERPEDISynchObj: TERPEDIBase;
begin
  result := TErpSynchMagento.create;
end;


function TMagentoListBaseGUI.ModuleCaption: String;
begin
  Result := Servicename_Magento;
end;

procedure TMagentoListBaseGUI.OpenPreferance;
begin
  inherited;
  OpenPrefform('EDI and Integration' ,  'chkEnableMagento', 0 , True, 'Magento' , 'pnlMagentoConfig' ,
                    'Changes made here will not take affect unless the Application is Restarted.');

end;

procedure TMagentoListBaseGUI.RefreshQuery;
begin
  inherited;
end;

end.
