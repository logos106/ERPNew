unit PhoneSupportLogList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TPhoneSupportLogListGUI = class(TBaseListingGUI)
    qryMainDetails: TLargeintField;
    qryMainSupportLogID: TIntegerField;
    qryMaincompany: TWideStringField;
    qryMainFromEmployeeName: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainpsdate: TDateTimeField;
    qryMainFlowwoup: TWideStringField;
    qryMainIssue: TWideMemoField;
    qryMainSolution: TWideMemoField;
    qryMainFinished: TWideStringField;
    qryMainCustomField1: TWideStringField;
    qryMainCustomField2: TWideStringField;
    qryMainCustomField3: TWideStringField;
    qryMainCustomField4: TWideStringField;
    qryMainCustomField5: TWideStringField;
    qryMainCustomField6: TWideStringField;
    qryMainCustomField7: TWideStringField;
    qryMainCustomField8: TWideStringField;
    qryMainCustomField9: TWideStringField;
    qryMainCustomField10: TWideStringField;
    qryMainSupportLogGlobalRef: TWideStringField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
  Protected
       procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery; Override;
  end;


implementation

uses CommonLib, Busobjcustomfields;

{$R *.dfm}

procedure TPhoneSupportLogListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Qrymaindetails.asinteger =1 then begin
    Afont.Style :=Afont.Style +[fsbold];
  end else if Qrymaindetails.asinteger >1 then begin
    if sametext(Field.FieldName , qrymaincompany.FieldName) or
      sametext(Field.FieldName , qrymainIssue.FieldName) then
      Afont.Color := abrush.Color;
  end;
end;
procedure TPhoneSupportLogListGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;

end;

procedure TPhoneSupportLogListGUI.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid(qryMainDetails.FieldName);
    RemoveFieldfromGrid(qryMainSupportLogID.FieldName);
    SetUpcustomFields('CustomField1,CustomField2,CustomField3,CustomField4,CustomField5,CustomField6,CustomField7,CustomField8,CustomField9,CustomField10',ltSupportLines);
end;

initialization
  RegisterClassOnce(TPhoneSupportLogListGUI);

end.
