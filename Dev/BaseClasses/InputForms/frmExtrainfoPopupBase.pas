unit frmExtrainfoPopupBase;

interface

Uses TypesLib,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, DNMSpeedButton, StdCtrls, Shader, DNMPanel,
  DB, DBAccess, MyAccess, ERPdbComponents  , BusObjBase, BaseFormForm, MemDS,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ProgressDialog;

type
  TfmExtrainfoPopupBase = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DataSource: TDataSource;
    btnCompleted: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    chkHide: TCheckBox;
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Ownercaption:String;

    function Save: boolean;
  Protected
    Formobj :TBusobj;
    form :TfmExtrainfoPopupBase;
    doPrint :TGeneralProc;
    Procedure InitForm(Ownerform: TBaseForm;  busobj :TBusobj; PrintAction :TGeneralProc);
  public
    class Procedure  DoExtrainfoPopup(Ownerform: TBaseForm;  busobj :TBusobj; PrintAction :TGeneralProc =nil);virtual;   Abstract;
  end;

implementation

uses CommonLib;

{$R *.dfm}
{ TfmExtrainfoPopupBase }
procedure TfmExtrainfoPopupBase.btnCloseClick(Sender: TObject);
begin
  inherited;
  Formobj.Canceldb;
  Formobj.connection.RollbackNestedTransaction;
  Self.close;
end;

procedure TfmExtrainfoPopupBase.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if Save then self.close;
end;
Function TfmExtrainfoPopupBase.Save :boolean;
begin
  Result := true;
  try
    Formobj.PostDB;
    Formobj.connection.commitNestedTransaction;
  Except
    on E:Exception do begin
      MessageDlgXP_Vista('Save Failed ' + chr(13) + e.Message, mtWarning, [mbOK], 0);
      Result := False;
    end;
  end;
end;


procedure TfmExtrainfoPopupBase.btnPrintClick(Sender: TObject);
begin
  inherited;
  if not Save then exit;
  if Assigned(doPrint) then begin
    Self.close;
    doPrint;
  end else begin
    Self.close;
  end;
end;


procedure TfmExtrainfoPopupBase.FormCreate(Sender: TObject);
begin
  inherited;
  DoPrint:= nil;
  self.SavedAccessLevel := self.AccessLevel;
  self.AccessLevel := 1;
end;

procedure TfmExtrainfoPopupBase.FormDestroy(Sender: TObject);
begin
  inherited;
  if AccessLevel <> SavedAccessLevel then
    AccessLevel := SavedAccessLevel;
end;

procedure TfmExtrainfoPopupBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then Begin
    btnClose.click;
  end else inherited;
end;

procedure TfmExtrainfoPopupBase.FormShow(Sender: TObject);
begin
  inherited;
  Openqueries;
  if Accesslevel = 5 then
    MessageDlgXP_Vista('You have ''Read-only'' access to ' + Ownercaption +' and the same for ' + TitleLabel.caption, mtInformation, [mbOK], 0);
end;

procedure TfmExtrainfoPopupBase.InitForm(Ownerform: TBaseForm;  busobj :TBusobj; PrintAction :TGeneralProc);
  function Ownerformcaption(Ownerform: TBaseForm): String;
  var
    comp: Tcomponent;
  begin
    Comp := Ownerform.findcomponent('TitleLabel');
    if (comp <> nil) and (Comp is TLabel) then
      result := TLabel(comp).Caption
    else
      REsult :=Ownerform.Caption;
  end;
begin
      Formobj           := busobj;
      Ownercaption      := Ownerformcaption(Ownerform);
      Caption           := Ownercaption;
      DataSource.Dataset:= busobj.Dataset;
      Doprint           := PrintAction;
      btnPrint.enabled  := Assigned(DoPrint);
      busobj.connection.BeginTransaction;      // just to make sure the connection is in transaction - just incase - before starting nested transaction
      busobj.connection.BeginNestedTransaction;
      showModal;
end;

end.

