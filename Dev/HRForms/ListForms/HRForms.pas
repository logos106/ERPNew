unit HRForms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  HRFormsLib, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup;

type
  THRFormsGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainformtype: TWideStringField;
    qryMainName: TWideStringField;
    qryMainTemplate: TWideStringField;
    qryMainTYPE: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainLanguage: TWideStringField;
    btnHowTo: TDNMSpeedButton;
    optOutputtype: TwwRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure btnHowToClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Function Outputtype:TOutputtype;
  Protected
    procedure SetGridColumns; override;
  public
  end;


implementation

uses CommonLib, CommonFormLib, DocReaderObj;

{$R *.dfm}

procedure THRFormsGUI.btnHowToClick(Sender: TObject);
begin
  inherited;
  TDocReaderObj.ShowERPHelp(nil, Self, true, 'HR Forms');
end;

procedure THRFormsGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmHRForm' , 0);
end;

procedure THRFormsGUI.cmdPrintClick(Sender: TObject);
begin
  if Assigned(fOnGridDataSelect) then else
  if chkAdvancedPrinting.checked and (qryMainID.asInteger<>0) then begin
    TPrintHRForm.PrintTemplate(0, self, nil,qryMainID.asInteger, Outputtype);
    exit;
  end;
  inherited;

end;

procedure THRFormsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := false;
end;

procedure THRFormsGUI.FormShow(Sender: TObject);
begin
  inherited;
  chkAdvancedPrinting.Top := 1;
  chkAdvancedPrinting.Left := 5;
end;

function THRFormsGUI.Outputtype: TOutputtype;
begin
       if optOutputtype.itemindex = 0 then result := otPrint
  else if optOutputtype.itemindex = 1 then result := otPreview
  else result := otEmail;
end;

procedure THRFormsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainID.fieldname);
  RemoveFieldfromGrid(qryMainformtype.fieldname);
end;

initialization
  RegisterClassOnce(THRFormsGUI);

end.
