unit StockToFixedAssetList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TStockToFixedAssetListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainStockToFixedAssetID: TIntegerField;
    qryMainCreationDate: TDateTimeField;
    qryMainProcessDate: TDateTimeField;
    qryMainProcessed: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainmsUpdateSiteCode: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
  private
  protected
    procedure RefreshQuery; override;
    procedure ApplyQueryFilter; override;
  public
  end;

implementation

{$R *.dfm}

uses
  CommonLib, BaseInputForm;

{ TStockToFixedAssetListGUI }

procedure TStockToFixedAssetListGUI.ApplyQueryFilter;
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {Active}
        GroupFilterString := '(Active = "T")';
      end;
    1:
      begin {Inactive}
        GroupFilterString := '(Active = "F")';
      end;
    2:
      begin {All}
        GroupFilterString := '';
      end;
  end;
  inherited;
end;

procedure TStockToFixedAssetListGUI.cmdNewClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  DisableForm;
  try
    inherited;
    tmpComponent := GetComponentByClassName('TfmStockToFixedAsset');
    If not Assigned(tmpComponent) then Exit;
    with TBaseInputGUI(tmpComponent) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  finally
    EnableForm;
  end;
end;

procedure TStockToFixedAssetListGUI.RefreshQuery;
begin
  if chkIgnoreDates.Checked then begin
    qryMain.ParamByName('DateFrom').AsDate := 0;
    qryMain.ParamByName('DateTo').AsDate := MaxDateTime;
  end
  else begin
    qryMain.ParamByName('DateFrom').AsDate := dtFrom.Date;
    qryMain.ParamByName('DateTo').AsDate := dtTo.Date;
  end;

  inherited;
end;

initialization
  RegisterClass(TStockToFixedAssetListGUI);

end.
