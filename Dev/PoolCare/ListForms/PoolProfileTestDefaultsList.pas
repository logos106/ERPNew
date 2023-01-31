unit PoolProfileTestDefaultsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls, ProgressDialog, kbmMemTable, CustomInputBox,
  wwdblook, Shader;

type
  TPoolTestDefaultsListGUI = class(TBaseListingGUI)
    qryMainDefaultTestId: TIntegerField;
    qryMainValuetypeID: TIntegerField;
    qryMainCategory: TStringField;
    qryMainSubstance: TStringField;
    qryMainMinimum: TFloatField;
    qryMainMaximum: TFloatField;
    qryMainDecreasePartNo: TStringField;
    qryMainDecreaseDose: TFloatField;
    qryMainDecreaseRslt: TFloatField;
    qryMainIncreasePartNo: TStringField;
    qryMainIncreaseDose: TFloatField;
    qryMainIncreaseRslt: TFloatField;
    qryMainTargetValue: TFloatField;
    qryMainType: TStringField;
    qryMainIncreasePartID: TIntegerField;
    qryMainDecreasePartID: TIntegerField;
    procedure grpFiltersClick(Sender: TObject); override;
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    //class function Instance: TBaseListingGUI;
    { Public declarations }
  end;

//var
//  PoolTestDefaultsListGUI: TPoolTestDefaultsListGUI;

implementation

uses FastFuncs,frmPoolProfileTestDefaults, CommonLib, Forms;

{$R *.dfm}

procedure TPoolTestDefaultsListGUI.grpFiltersClick(Sender: TObject);
begin
  inherited;
  if grpFilters.ItemIndex = 3 then qryMain.Filtered := false
  else begin
    qryMain.Filter   := 'ValuetypeID = ' + FastFuncs.IntToStr(grpFilters.ItemIndex);
    qryMain.Filtered := true;
  end;
end;

procedure TPoolTestDefaultsListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if ErrorOccurred then Exit;
  with qryMain do if Active = false then Open;
  grpFilters.ItemIndex := 0;
end;

procedure TPoolTestDefaultsListGUI.grdMainDblClick(Sender: TObject);
Var Form : TComponent;
begin
  Form := GetComponentByClassName('TfmPoolProfileTestDefaults');
  if Assigned(Form) then begin
    with TfmPoolProfileTestDefaults(Form) do begin
      KeyId := qryMain.FieldByName('DefaultTestID').AsInteger;
      lblType.Alignment := taRightJustify;
      if QryMain.FieldByName('ValueTypeId').AsInteger = 0 then begin
        lblType.Caption := 'Construction';
        TitleLabel.Caption := 'Construction - Water Test Defaults';
      end;
      if QryMain.FieldByName('ValueTypeId').AsInteger = 1 then begin
        lblType.Caption := 'Sanitizer';
        TitleLabel.Caption := 'Sanitizer - Water Test Defaults';
      end;
      if QryMain.FieldByName('ValueTypeId').AsInteger = 2 then begin
        lblType.Alignment := taLeftJustify;
        lblType.Left := lblSubstance.Left;
        lblType.Caption := 'Any Construction/Sanitizer';
        edtName.Visible := false;
        TitleLabel.Caption := 'Common - Water Test Defaults';
      end;
      edtName.Text      := qryMain.FieldByName('Category').AsString;
      edtSubstance.Text := qryMain.FieldByName('Substance').AsString;
      FormStyle         := fsMdiChild;
      BringToFront;
    end;
  end;  
end;

procedure TPoolTestDefaultsListGUI.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;
  inherited;
end;

initialization
  RegisterClassOnce(TPoolTestDefaultsListGUI);
end.
