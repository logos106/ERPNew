unit RollaBlindItemPriceList;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 22/05/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, DNMSpeedButton;

type
  TRollaBlindItemPriceListGUI = class(TBaseListingGUI)
    qryMainItemPriceID: TIntegerField;
    qryMainGlobalRef: TStringField;
    qryMainItemNumber: TStringField;
    qryMainColourCode: TStringField;
    qryMainHeading: TStringField;
    qryMainDescription: TStringField;
    qryMainDescription2: TStringField;
    qryMainLength: TStringField;
    qryMainColour: TStringField;
    qryMainUnit: TStringField;
    qryMainList: TFloatField;
    qryMainKanga: TFloatField;
    qryMainGroup: TFloatField;
    qryMainExport: TFloatField;
    qryMainBranch: TFloatField;
    qryMainCost: TFloatField;
    qryMainSheetID: TIntegerField;
    qryMainFlag: TStringField;
    qryMainmsTimeStamp: TDateTimeField;
    lblGroupHeading: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure actExecuteFilterExecute(Sender: TObject);
    procedure actClearFilterExecute(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  CommonLib, RollaBlindItemPrice, Forms;

procedure TRollaBlindItemPriceListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := True;
  inherited;
  LabelGridFromFieldNames := False;
end;

procedure TRollaBlindItemPriceListGUI.actExecuteFilterExecute(
  Sender: TObject);
begin
  inherited;
  lblGroupHeading.Caption := qryMain.FieldByName('Heading').AsString;
end;

procedure TRollaBlindItemPriceListGUI.actClearFilterExecute(
  Sender: TObject);
begin
  inherited;
  lblGroupHeading.Caption := '';
end;

procedure TRollaBlindItemPriceListGUI.cmdNewClick(Sender: TObject);
var
  TmpComp: TComponent;
begin
  inherited;
  TmpComp := GetComponentByClassName('TRollaBlindItemPriceGUI');

  if Assigned(TmpComp) then begin
    with TRollaBlindItemPriceGUI(TmpComp) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

initialization
  RegisterClassOnce(TRollaBlindItemPriceListGUI);
finalization
  UnRegisterClass(TRollaBlindItemPriceListGUI);
end.
