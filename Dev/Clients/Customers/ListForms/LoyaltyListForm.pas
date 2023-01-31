unit LoyaltyListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList,
  Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls,
  ExtCtrls, DBAccess, MyAccess,ERPdbComponents, MemDS, wwDialog, Wwlocate, SelectionDialog,
  DNMPanel, wwdbdatetimepicker, ProgressDialog,  wwdblook,
  Shader, kbmMemTable, DAScript, MyScript;

type
  TLoyaltyListGUI = class(TBaseListingGUI)
    qryMainCusID: TIntegerField;
    qryMainRef_Date: TDateTimeField;
    qryMainReferenceTxt: TWideStringField;
    qryMainLoyaltyProgram: TWideStringField;
    qryMainCompany: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  LoyaltyListGUI: TLoyaltyListGUI;

implementation

uses
  CommonLib;

{$R *.dfm}

procedure TLoyaltyListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  LoyaltyListGUI := nil;
end;

procedure TLoyaltyListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TLoyaltyListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TLoyaltyListGUI.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TLoyaltyListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TLoyaltyListGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('CusId');
end;

initialization
  RegisterClassOnce(TLoyaltyListGUI);
end.
