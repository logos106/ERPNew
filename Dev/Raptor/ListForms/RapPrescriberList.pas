unit RapPrescriberList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, DNMSpeedButton, MyScript;

type
  TRapPrescriberListGUI = class(TBaseListingGUI)
    qryMainDisplayCat: TLargeIntField;
    qryMainPrescriberID: TIntegerField;
    qryMainPrescriberName: TStringField;
    qryMainPrescriberCode: TStringField;
    qryMainPrescriberType: TStringField;
    qryMainProvidernum: TStringField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Procedure REfreshQuery; override;
  end;


implementation

uses FastFuncs,CommonLib, BaseInputForm;

{$R *.dfm}
Procedure TRapPrescriberListGUI.REfreshQuery;
begin
        qrymain.disablecontrols;
        try
                inherited;
        finally
            qrymain.Enablecontrols;
        end;
end;
procedure TRapPrescriberListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
    if Qrymain.fieldByname('DisplayCat').asInteger = 1 then begin
        AFont.Style := AFont.Style + [fsBold];
        AFont.Color := clMaroon;
        if (FastFuncs.SameText(Field.Fieldname , 'PrescriberName')) or (FastFuncs.SameText(Field.Fieldname , 'Providernum')) then
            else Afont.Color := ABrush.Color;
    end else begin
        if (FastFuncs.SameText(Field.Fieldname , 'PrescriberName')) or (FastFuncs.SameText(Field.Fieldname , 'Providernum')) then
            Afont.Color := ABrush.Color;
    end;

end;
procedure TRapPrescriberListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmRapPrescriber');
  if Assigned(Form) then begin
    with TBaseInputGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;



procedure TRapPrescriberListGUI.FormCreate(Sender: TObject);
begin
  inherited;
    LabelGridFromFieldNames := False;
end;

initialization
  RegisterClassOnce(TRapPrescriberListGUI);

end.
