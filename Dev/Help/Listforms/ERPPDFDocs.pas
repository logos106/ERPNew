unit ERPPDFDocs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  DADump, MyDump, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TERPPDFDocsGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainDescription: TWideStringField;
    qryMainFiletype: TWideStringField;
    DumpSQL: TMyDump;
    qryMainactionname: TWideStringField;
    qryMainModulename: TWideStringField;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
  private
  Protected
    procedure SetGridColumns; Override;
  public
  end;


implementation

uses CommonLib, DocReaderObj, CommonFormLib, ERPLib;

{$R *.dfm}

{ TBaseListingGUI1 }

procedure TERPPDFDocsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := false;
end;

procedure TERPPDFDocsGUI.grdMainDblClick(Sender: TObject);
begin
//  inherited;
 if DoOnGridDataSelect(grdmain) then exit;

 TDocReaderObj.ShowERPHelp(nil, Self, true, qryMainDescription.asString);
end;

procedure TERPPDFDocsGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  if devmode then
    qryMainactionname.asString := makename('act_' + qryMainDescription.asString ,'.pdf');
end;

procedure TERPPDFDocsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainid.fieldname);
  RemoveFieldfromGrid(qryMainFiletype.fieldname);
  if not devmode then RemoveFieldfromGrid(qryMainactionname.fieldname);
end;
initialization
  RegisterClassOnce(TERPPDFDocsGUI);


end.
