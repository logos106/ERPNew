unit PrintedHRForms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  HRFormsLib, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, IntegerListObj ,DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TPrintedHRFormsGUI = class(TBaseListingGUI)
    pnlNewHrform: TDNMPanel;
    qryMainId: TIntegerField;
    qryMainHRFID: TIntegerField;
    qryMainHRFormname: TWideStringField;
    qryMainPrintedOn: TDateTimeField;
    qryMainLanguage: TWideStringField;
    optOutputtype: TRadioGroup;
    btnNewHrform: TDNMSpeedButton;
    btnHowTo: TDNMSpeedButton;
    qryMainPreviews: TLargeintField;
    qryMainemails: TLargeintField;
    qryMainPrints: TLargeintField;
    btnOpen: TDNMSpeedButton;
    qryMainTemplate: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNewHrformClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure btnOpenClick(Sender: TObject);
    procedure btnHowToClick(Sender: TObject);
  private
    fireferenceID: Integer;
    fsFilenamePrefix :String;
    Function Outputtype:TOutputtype;
    procedure RePrintDoc;
  Protected
    aHRIds : TIntegerList;
    procedure OpenArec(Sender: TObject);
    procedure PrintHRTemplate(const ID: Integer);
    procedure initHRFormsList(Sender: TObject);Virtual; abstract;
    procedure OnSelectHRForms(Sender: TwwDbGrid);Virtual;
    procedure SetupFormInPanel; Override;
    procedure SetGridColumns; Override;
  public
    Property referenceID :Integer read fireferenceID write fireferenceID;
    Procedure RefreshQuery;Override;
  end;


implementation

uses ShellAPI, CommonFormLib, CommonLib, DbSharedObjectsObj, CommonDbLib, SystemLib,
  DNMLib, DocReaderObj, BusObjPrintDoc;

{$R *.dfm}

procedure TPrintedHRFormsGUI.btnHowToClick(Sender: TObject);
begin
  inherited;
  TDocReaderObj.ShowERPHelp(nil, Self, true, 'HR Forms');
end;

procedure TPrintedHRFormsGUI.btnNewHrformClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormultiselectModal('THRFormsGUI',initHRFormsList, OnSelectHRForms);
end;

procedure TPrintedHRFormsGUI.btnOpenClick(Sender: TObject);
begin
  inherited;
  if (qryMainHRFID.asInteger>0) then begin
    OpenArec(nil);
    Exit;
  end;
end;

procedure TPrintedHRFormsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  aHRIds := TIntegerList.Create;
  fsFilenamePrefix :='HRForms_' +  GetTemporaryTableNameSuffix;
end;

procedure TPrintedHRFormsGUI.FormDestroy(Sender: TObject);
begin
  DeleteFiles(Wintempdir,fsFilenamePrefix+'*.*');
  FreeandNil(aHRIds);
  inherited;
end;

procedure TPrintedHRFormsGUI.grdMainDblClick(Sender: TObject);
begin
  //inherited;
  OpenArec(nil);
end;

procedure TPrintedHRFormsGUI.OnSelectHRForms(Sender: TwwDbGrid);
var
  ds:Tdataset;
begin
    ds := Sender.DataSource.DataSet;
    if ds.findfield('ID') = nil then exit;
    aHRIds.Clear;
    commonlib.SelectedIds(sender ,'ID' , aHRIds);
    PrintHRTemplate(0);
    RefreshQuery;
end;

procedure TPrintedHRFormsGUI.PrintHRTemplate(const ID:Integer);
begin
    if aHRIds.Count > 0 then
    TPrintHRForm.PrintTemplate(ID, Self, referenceID,  aHRIds , Outputtype);
end;
procedure TPrintedHRFormsGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
end;

procedure TPrintedHRFormsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainId.fieldname);
  RemoveFieldfromGrid(qryMainHRFID.fieldname);
end;

procedure TPrintedHRFormsGUI.SetupFormInPanel;
begin
  inherited;
    pnlNewHrform.visible := TRue;
    optOutputtype.Parent:=pnlNewHrform;    optOutputtype.Align := altop;    optOutputtype.AlignWithmargins:= True;    optOutputtype.Margins.left:= 1;    optOutputtype.Margins.top:= 3;    optOutputtype.Margins.bottom := 3;    optOutputtype.Margins.Right := 1;
    optOutputtype.columns := 1;
    optOutputtype.height := 100;
    optOutputtype.top :=0;
    btnNewHrform.top :=0;
    btnOpen.top :=0;
    btnHowTo.top :=0;
end;
Procedure TPrintedHRFormsGUI.RePrintDoc;
var
  fPrintDoc : TBusObjPrintDoc;
begin
  fPrintDoc := TBusObjPrintDoc.Create(self);
  Try
    fPrintDoc.Printdoc(Self.Classname,   QrymainID.AsInteger, dtMain, Self.Classname ,dotPreview, qryMainTemplate.aSString);
  finally
    Freeandnil(fPrintDoc);
  end;

end;
procedure TPrintedHRFormsGUI.OpenArec(Sender: TObject);
begin
  TDocReaderObj.ShowHRForm(nil,self,QrymainID.AsInteger , 'PDF');
  ReprintDoc;
(*var
  fsfilename:String;
  bs:TStream;
  Qry :TERPQuery;
begin
    Qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      qry.sql.text :=' Select HRFormId , Referencetxt , ReferenceData from tblreference where refId = ' + inttostr(QrymainID.AsInteger);
      OpenDB(Qry);
      if Qry.recordcount =0 then exit;

      fsfilename:= Wintempdir+getOutGoingFileName(fsFilenamePrefix , qry.FieldByName('Referencetxt').AsString + ' #' + inttostr(qry.FieldByName('HRFormId').asInteger)+'_'+ formatdateTime('yyyymmddhhnnsszz',now), '.PDF');
      bs := Qry.CreateBlobStream((Qry.findfield('ReferenceData') as TBlobField), bmRead);
      try
          with TFileStream.Create(fsfilename, fmCreate) do
            try
              CopyFrom(bs, bs.Size)
            finally
              Free
            end;
            sleep(500);
      finally
        Freeandnil(bs);
      end;
      ShellExecute(0,'open',PChar(fsFilename),nil,nil,SW_NORMAL)
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(Qry);
    end;*)
end;

function TPrintedHRFormsGUI.Outputtype: TOutputtype;
begin
       if optOutputtype.itemindex = 0 then result := otPrint
  else if optOutputtype.itemindex = 1 then result := otPreview
  else result := otEmail;
end;

end.
