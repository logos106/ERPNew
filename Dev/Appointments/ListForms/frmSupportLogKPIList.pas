unit frmSupportLogKPIList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TfmSupportLogKPIList = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainSupportLogID: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainContact: TWideStringField;
    qryMainDateCreated: TDateTimeField;
    qryMainModule: TWideStringField;
    qryMainType: TWideStringField;
    qryMainIssue: TWideMemoField;
    qryMainSolution: TWideMemoField;
    qryMainCallTime: TWideStringField;
    qryMainFinished: TWideStringField;
    qryMainEnteredBy: TWideStringField;
    qryMainVersion: TWideStringField;
    qryMainCallSecs: TIntegerField;
    qryMainAssignedto: TWideStringField;
    qryMainMessagesID: TIntegerField;
    qryMainMessageDate: TDateTimeField;
    qryMainMessageDetails: TWideMemoField;
    qryMainMessageType: TWideStringField;
    qryMainMessageMins: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure qryMainMessageMinsGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

var
  fmSupportLogKPIList: TfmSupportLogKPIList;

implementation

{$R *.dfm}

uses
  CommonFormLib;

{ TfmSupportLogKPIList }

procedure TfmSupportLogKPIList.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('SupportLogID, MessagesID');
end;

procedure TfmSupportLogKPIList.grdMainDblClick(Sender: TObject);
var
  field: TField;
begin
  field :=  grdMain.SelectedField;
  if Assigned(field) then begin
    if SameText(field.FieldName,'MessagesID') or
        SameText(field.FieldName,'MessageDate') or
        SameText(field.FieldName,'MessageDetails') or
        SameText(field.FieldName,'MessageType') or
        SameText(field.FieldName,'MessageMins') then
      CommonFormLib.OpenERPForm('TfrmMessagesGUI',qryMainMessagesID.AsInteger)
    else begin
      if not (SameText(field.FieldName,'Issue') or SameText(field.FieldName,'Solution')) then
        CommonFormLib.OpenERPForm('TPhSupportLogGUI',qryMainSupportLogID.AsInteger)
    end;
  end;
end;

procedure TfmSupportLogKPIList.qryMainMessageMinsGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
var
  days: string;
begin
  if not Sender.IsNull then begin
    days := IntToStr(Abs(Trunc(Sender.AsInteger/1440)));
    while Length(days) < 3 do
      days := '0' + days;
    if (Sender.AsInteger/1440) < 0 then
      days := '- ' + days;
    Text := days + ' ' + FormatDateTime('hh:nn',Frac(Sender.AsInteger / 1440));
  end
  else
    Text := ''
end;

procedure TfmSupportLogKPIList.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').asDateTime := FilterDatefrom;
  qryMain.Params.ParamByName('txtto').AsDateTime   := FilterDateTo;
  inherited;
end;

initialization
  RegisterClass(TfmSupportLogKPIList);

end.
