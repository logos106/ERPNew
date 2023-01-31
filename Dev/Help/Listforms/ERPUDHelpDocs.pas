unit ERPUDHelpDocs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ERPPDFDocs, DADump, MyDump, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TERPUDHelpDocsGUI = class(TERPPDFDocsGUI)
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
  private
    fiformContextId: Integer;
    fiContextId: Integer;
    DoNewIfblank:Boolean;
    fsControlCaption: String;
    fsFormCaption: String;
    procedure initEDERPHelpDoc(Sender: TObject);
  Protected
    procedure SetGridColumns; Override;
  public
    Property ContextId :Integer read fiContextId write fiContextId;
    Property formContextId :Integer read fiformContextId write fiformContextId ;
    Property FormCaption :String read fsFormCaption write fsFormCaption;
    Property ControlCaption :String read fsControlCaption write fsControlCaption;
    Procedure RefreshQuery;Override;
    class Procedure showListFor(AOwner:TComponent; aControlHelpcontextID,aformhelpcontext: Integer;aFormCaption , aControlCaption:String);
  end;

implementation

uses CommonFormLib, CommonLib, FrmUDERPHelpDoc;

{$R *.dfm}

procedure TERPUDHelpDocsGUI.cmdNewClick(Sender: TObject);
begin
  OpenERPFormModal('TfmUDERPHelpDoc' , 0 , initEDERPHelpDoc);
end;
procedure TERPUDHelpDocsGUI.initEDERPHelpDoc(Sender: TObject);
begin
  if sender is TfmUDERPHelpDoc then begin
    TfmUDERPHelpDoc(Sender).FormCaption := fsFormCaption;
    TfmUDERPHelpDoc(Sender).ControlCaption := fsControlCaption;
    TfmUDERPHelpDoc(Sender).formContextId := fiformContextId;
    TfmUDERPHelpDoc(Sender).ControlContextID := fiContextId;
    TfmUDERPHelpDoc(Sender).formshow(TfmUDERPHelpDoc(Sender));
  end;
end;
procedure TERPUDHelpDocsGUI.FormCreate(Sender: TObject);
begin
  inherited;
    fiformContextId:=0;
    fiContextId:=0;
    DoNewIfblank := False;
end;

procedure TERPUDHelpDocsGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if DoNewIfblank then begin
    if qrymain.RecordCount =0 then
      cmdNew.Click;
    DoNewIfblank := False;
  end;
end;

procedure TERPUDHelpDocsGUI.RefreshQuery;
begin
  qrymain.parambyname('ContextId').asInteger := ContextId;
  qrymain.parambyname('formContextId').asInteger := formContextId;
  inherited;
end;
procedure TERPUDHelpDocsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainactionname.fieldname);
end;

class procedure TERPUDHelpDocsGUI.showListFor(AOwner:TComponent; aControlHelpcontextID,aformhelpcontext: Integer;aFormCaption , aControlCaption:String);
begin
  with TERPUDHelpDocsGUI.Create(AOwner) do try
    formContextId:=aformhelpcontext;
    ContextId:=aControlHelpcontextID;
    FormCaption := aFormCaption;
    ControlCaption := aControlCaption;
    DoNewIfblank:= true;
    ShowModal;
  finally
    Free;
  end;
end;

initialization
  RegisterClassOnce(TERPUDHelpDocsGUI);
end.
