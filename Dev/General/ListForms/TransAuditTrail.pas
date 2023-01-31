unit TransAuditTrail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, Mask, wwdbedit, Wwdotdot,
  DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TTransAuditTrailGUI = class(TBaseListingGUI)
    qryMainPrintedFrom: TWideStringField;
    qryMainPrintedby: TWideStringField;
    qryMainDescription: TWideMemoField;
    qryMainCategory: TLargeintField;
    qryMainPrintdate: TDateTimeField;
    qryMaincDescription: TStringField;
    qryMainTemplatename: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure qryMainCalcFields(DataSet: TDataSet);
  private
    fiDocId: Integer;
    fsDocName: String;
    fsTransGlobalref: String;
    fsFormname: String;
    fsDocDescription: String;
    { Private declarations }
  Protected
    procedure IntQrymainParams;Virtual;
    Procedure SetGridColumns;Override;
  public
    Property DocName : String read fsDocName write fsDocName;
    Property DocDescription : String read fsDocDescription write fsDocDescription;
    Property DocId :Integer read fiDocId write fiDocId;
    Property TransGlobalref :String read fsTransGlobalref write fsTransGlobalref;
    Property Formname:String read fsFormname write fsFormname;

    Procedure RefreshQuery;override;
  end;


implementation

uses CommonLib, BusObjPrintDoc, MemoDialog, StringUtils;

{$R *.dfm}

{ TTransAuditTrialGUI }

procedure TTransAuditTrailGUI.FormShow(Sender: TObject);
var
  lString : string;
begin
  inherited;
  if Pos(' ', DocDescription) > 0 then
    lString := DocDescription
  else
    lString := StringUtils.SeparateWords(DocDescription);

  TitleLabel.Caption := lString + ' - ' + inttostr(docID);
  Self.Caption :=   'Audit Trail - ' + lString + '(' + inttostr(docID) + ')';
end;

procedure TTransAuditTrailGUI.grdMainDblClick(Sender: TObject);
begin
if qrymainCategory.asInteger = 1 then
  inherited
else
  TfrmMemoDialog.Memopopup(QrymainDescription.asString, 'Details');
end;

procedure TTransAuditTrailGUI.qryMainCalcFields(DataSet: TDataSet);
var
  st:TStringlist;
begin
  inherited;
  //if qryMaincDescription.asString = '' then
    if qrymainCategory.asInteger = 1 then begin
      if Qrymaintemplatename.asString <> '' then
          qryMaincDescription.asString:= 'Template : ' +Qrymaintemplatename.asString;
    end else begin
      St:= TStringlist.create;
      try
        st.text := QrymainDescription.asString;
        if st.count > 1 then
          qryMaincDescription.asString:= '.....[Double Click For Details]';
      finally
        Freeandnil(st);
      end;
    end;

end;

procedure TTransAuditTrailGUI.RefreshQuery;
begin
    IntQrymainParams;
    inherited;
end;
Procedure TTransAuditTrailGUI.IntQrymainParams;
begin
    Qrymain.Params.Parambyname('DocName').asString := DocName;
    Qrymain.Params.Parambyname('DocDescription').asString := DocDescription;
    Qrymain.Params.Parambyname('DocId').asInteger:= DocId;
    Qrymain.Params.Parambyname('TransGlobalref').asString := TransGlobalref;
    Qrymain.Params.Parambyname('Formname').asString := Formname;
end;
procedure TTransAuditTrailGUI.SetGridColumns;
begin
  inherited;
  //RemoveFieldfromGrid('description');
  RemoveFieldfromGrid('Category');
  RemoveFieldfromGrid('TemplateName');
end;

initialization
  RegisterClassOnce(TTransAuditTrailGUI);

end.
