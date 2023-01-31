unit FrmUDERPHelpDoc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrmERPHelpDoc, DB, ProgressDialog, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, wwclearbuttongroup, wwradiogroup, Mask, wwdbedit,
  DNMSpeedButton, Shader, DNMPanel , busobjbase, DBCtrls;

type
  TfmUDERPHelpDoc = class(TFmERPHelpDoc)
    OptHelpFor: TwwRadioGroup;
    qryERPHelpDocsContextId: TIntegerField;
    qryERPHelpDocsDocument: TBlobField;
    procedure FormCreate(Sender: TObject);
    procedure OptHelpForClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
    fiControlContextID: Integer;
    fiFormContextID: Integer;
    fsControlCaption: String;
    fsFormCaption: String;
    procedure setControlCaption(const Value: String);
    procedure setFormCaption(const Value: String);
    { Private declarations }
  Protected
    procedure NewBusObjinstance;Override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Property FormContextID:Integer read fiFormContextID write fiFormContextID;
    Property ControlContextID:Integer read fiControlContextID write fiControlContextID;
    Property FormCaption :String read fsFormCaption write setFormCaption;
    Property ControlCaption :String read fsControlCaption write setControlCaption;
    procedure Doformshow;
    procedure Dosavenclose;
    procedure DoCancelclose;
    Function Choosefile:Boolean;Override;
  end;


implementation

uses busobjUDErpHelpDocs, FormFactory, DocReaderObj, BusObjConst, CommonLib;

{$R *.dfm}

{ TfmUDERPHelpDoc }

procedure TfmUDERPHelpDoc.FormCreate(Sender: TObject);
begin
  inherited;
  fiControlContextID:=0;
  fiFormContextID:=0;
  fsControlCaption:='';
  fsFormCaption:='';

end;

procedure TfmUDERPHelpDoc.FormShow(Sender: TObject);
begin
  inherited;
  cmdNew.enabled := (fiFormContextID<>0) and (fiControlContextID<>0);
end;

procedure TfmUDERPHelpDoc.NewBusObjinstance;
begin
  {$WARNINGS OFF}
  DocReaderObj := TUDErpHelpDocs.CreateWithNewConn(Self);
  DocReaderObj.Connection.connection := Self.MyConnection;
  DocReaderObj.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}

end;
procedure TfmUDERPHelpDoc.OptHelpForClick(Sender: TObject);
begin
  inherited;
  if OptHelpFor.itemIndex =0 then
       TUDErpHelpDocs(DocReaderObj).ContextId := fiFormContextID
  else TUDErpHelpDocs(DocReaderObj).ContextId := fiControlContextID;
end;

procedure TfmUDERPHelpDoc.setControlCaption(const Value: String);
begin
  fsControlCaption := Value;
  while OptHelpFor.items.count <2 do OptHelpFor.items.add('');
  OptHelpFor.items[1] := Value;
end;

procedure TfmUDERPHelpDoc.setFormCaption(const Value: String);
begin
  fsFormCaption := Value;
  while OptHelpFor.items.count <1 do OptHelpFor.items.add('');
  OptHelpFor.items[0] := Value;
end;

function TfmUDERPHelpDoc.Choosefile: Boolean;
begin
  inherited;
end;

procedure TfmUDERPHelpDoc.cmdNewClick(Sender: TObject);
begin
//  inherited;

end;

procedure TfmUDERPHelpDoc.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     inherited;
     if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterInsert ) then begin
        TUDErpHelpDocs(DocReaderObj).contextID:= fiFormContextID;
     end;
end;
procedure TfmUDERPHelpDoc.DoCancelclose;
begin
  DocReaderObj.Dirty  := False;
  cmdCancel.click;
end;

procedure TfmUDERPHelpDoc.Doformshow;
begin
  Formshow(Self);
end;

procedure TfmUDERPHelpDoc.Dosavenclose;
begin
    cmdClose.click;
end;

initialization
  RegisterClassOnce(TfmUDERPHelpDoc);
  with FormFact do begin
    {$IFDEF DevMode}
    RegisterMe(TFmERPHelpDoc, 'TfmUDERPHelpDoc_*=ID');
    {$ENDIF}
  end;

end.
