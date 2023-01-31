unit TermsListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TTermsListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainTermsID: TIntegerField;
    qryMainTerms: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainDays: TWideStringField;
    qryMainDaysAmount: TLargeintField;
    qryMainEOM: TWideStringField;
    qryMainEOMDays: TLargeintField;
    qryMainEOMPlus: TWideStringField;
    qryMainEOMPlusDays: TLargeintField;
    qryMainPP: TWideStringField;
    qryMainInstallments: TLargeintField;
    qryMainPPDEsc: TWideStringField;
    qryMainProgressPaymentDaysAfterfirstPay: TLargeintField;
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib, Forms, CommonFormLib;

{$R *.dfm}                           

procedure TTermsListGUI.cmdNewClick(Sender: TObject);
begin
  OpenERPForm('TfmTerms' , 0);
(*var
  Form: TComponent;
begin
  inherited;
  DisableForm;
  try
    Form := GetComponentByClassName('TfrmTerms');
    if Assigned(Form) then begin
      with TfrmTerms(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
    //  MainForm.TermsClick(Sender);
  finally
    EnableForm;
  end;*)
end;

procedure TTermsListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  KeyIdfieldname := QrymainTermsID.Fieldname;
  KeyNamefieldname :=Qrymainterms.Fieldname;
end;

procedure TTermsListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
    if SameText(Field.Fieldname , qryMainDaysAmount.fieldname    ) then if qryMainDays.asBoolean   = False then  AFont.color := ABrush.color;

    if SameText(Field.Fieldname , qryMainEOMDays.fieldname       ) then if qryMainEOM.asBoolean    = False then  AFont.color := ABrush.color;

    if SameText(Field.Fieldname , qryMainEOMPlusDays.fieldname   ) then if qryMainEOMPlus.asBoolean= False then  AFont.color := ABrush.color;

    if SameText(Field.Fieldname , qryMainInstallments.fieldname  ) or
       SameText(Field.Fieldname , qryMainPPDEsc.fieldname        ) Or
       SameText(Field.Fieldname , qryMainProgressPaymentDaysAfterfirstPay.fieldname  ) then  if qryMainPP.asBoolean    = False then  AFont.color := ABrush.color;

end;

initialization
  RegisterClassOnce(TTermsListGUI);
end.
