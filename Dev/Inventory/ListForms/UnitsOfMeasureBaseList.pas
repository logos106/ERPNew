unit UnitsOfMeasureBaseList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DNMAction, DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TUnitsOfMeasureBaseListGUI = class(TBaseListingGUI)
    LinkTomultipleProducts: TMenuItem;
    ActLinktoMultipleProducts: TDNMAction;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure ActLinktoMultipleProductsUpdate(Sender: TObject);
    procedure ActLinktoMultipleProductsExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure DoonGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
  Protected
    Procedure CreateUOM(Sender:TObject);
  public
    { Public declarations }
  end;


implementation

uses ProductListExpressForm, BusobjProductProperties, BusObjBase,
  CommonDbLib, CommonLib, AppEnvironment, CompanyPrefObj, FastFuncs, BusobjUOM,
  tcConst;

{$R *.dfm}

{ TUnitsOfMeasureBaseListGUI }

procedure TUnitsOfMeasureBaseListGUI.CreateUOM(Sender: TObject);
var
  I, ctr:Integer;
  UOM:TUnitOfMeasure;
begin
  if TwwDBGrid(Sender).SelectedList.Count = 0 then exit;

  UOM:=TUnitOfMeasure.create(Self);
  try
    UOM.connection := TMyDacDataConnection.create(UOM);
    UOM.Connection.Connection := GetNewMyDacConnection(self);
    UOM.Connection.BeginTransaction;
    try
      With TwwDBGrid(Sender).Datasource.Dataset do begin
        ShowProgressbar(WAITMSG , TwwDBGrid(Sender).SelectedList.Count );
        try
            ctr:=0;
            for i := 0 to TwwDBGrid(Sender).SelectedList.Count - 1 do begin
              GotoBookmark(TwwDBGrid(Sender).SelectedList.Items[i]);
              if fieldbyname('PARTSID').asInteger <> 0 then begin
                UOM.CreateUOM(Qrymain.fieldbyname('UnitName').asString, Qrymain.fieldbyname('Multiplier').asFloat, fieldbyname('PARTSID').asInteger, qryMain.fieldbyname('BaseUnitID').asInteger );
                ctr:= ctr+1;
              end;
              StepProgressbar;
            end;
        finally
          HideProgressbar;
          if ctr>0 then MessageDlgXP_Vista(inttostr(Ctr)+' UOMs Created', mtInformation, [mbOK], 0);
        end;
      end;
      UOM.Connection.CommitTransaction;
    Except
        UOM.Connection.RollbackTransaction;
    end;
  finally
      FreeandNil(UOM);
  end;

  RefreshQuery;
end;

procedure TUnitsOfMeasureBaseListGUI.ActLinktoMultipleProductsUpdate(Sender: TObject);
begin
  inherited;
    ActLinktoMultipleProducts.Enabled := (grdMain.SelectedList.Count <= 1) and (qryMain.fieldbyname('UnitID').asInteger<>0);
end;

procedure TUnitsOfMeasureBaseListGUI.ActLinktoMultipleProductsExecute(
  Sender: TObject);
begin
  inherited;
   with TProductListExpressGUI(GetComponentByClassName('TProductListExpressGUI', true)) do begin
        FormStyle := fsMdiChild;
        ExpresslistPopup('Create UOM' , CreateUOM);
        BringToFront;
  end;
end;

procedure TUnitsOfMeasureBaseListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  if Qrymain.Findfield('Weight') <> nil then Qrymain.Findfield('Weight').OnGetText := DoonGetText;
  if Qrymain.Findfield('Height') <> nil then Qrymain.Findfield('Height').OnGetText := DoonGetText;
  if Qrymain.Findfield('Width')<> nil then Qrymain.Findfield('Width').OnGetText := DoonGetText;
  if Qrymain.Findfield('Length')<> nil then Qrymain.Findfield('Length').OnGetText := DoonGetText;
  if Qrymain.Findfield('Volume')<> nil then Qrymain.Findfield('Volume').OnGetText := DoonGetText;
end;

procedure TUnitsOfMeasureBaseListGUI.DoonGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin

  if Sysutils.SameText(sender.Fieldname, 'Weight') then if sender.AsString <> '' then Text := sender.AsString +' ' + appenv.CompanyPrefs.UOMWeightUOM;
  if Sysutils.SameText(sender.Fieldname, 'Height') then if sender.AsString <> '' then Text := sender.AsString +' ' + appenv.CompanyPrefs.UOMVolumeDimensionUOM;
  if Sysutils.SameText(sender.Fieldname, 'Length') then if sender.AsString <> '' then Text := sender.AsString +' ' + appenv.CompanyPrefs.UOMVolumeDimensionUOM;
  if Sysutils.SameText(sender.Fieldname, 'Width')  then if sender.AsString <> '' then Text := sender.AsString +' ' + appenv.CompanyPrefs.UOMVolumeDimensionUOM;
  if Sysutils.SameText(sender.Fieldname, 'Volume') then if sender.AsString <> '' then Text := sender.AsString +' ' + appenv.CompanyPrefs.UOMVolumeDimensionUOM;


end;

end.
