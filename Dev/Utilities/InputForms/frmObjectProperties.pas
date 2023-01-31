unit frmObjectProperties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase, busobjobjectproperties, Buttons, Wwdbigrd, Grids, Wwdbgrid;

type
  TfmObjectProperties = class(TBaseInputGUI)
    qryObjectProperties: TERPQuery;
    dsObjectProperties: TDataSource;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    grdTransactions: TwwDBGrid;
    qryObjectPropertiesID: TIntegerField;
    qryObjectPropertiesGlobalref: TWideStringField;
    qryObjectPropertiesObjClassname: TWideStringField;
    qryObjectPropertiesPropertyName: TWideStringField;
    qryObjectPropertiesRequired: TWideStringField;
    qryObjectPropertiesmstimestamp: TDateTimeField;
    qryObjectPropertiesmsupdateSiteCode: TWideStringField;
    mnu: TAdvPopupMenu;
    mnuProperties: TMenuItem;
    qryObjectPropertiesPropertyUserName: TWideStringField;
    ExportSelectedRecords1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mnuPropertiesClick(Sender: TObject);
    procedure ExportSelectedRecords1Click(Sender: TObject);
  private
    ObjectProperties: TObjectProperties;
    fsObjectName: String;
    function SaveRecord: Boolean;
    procedure setObjectName(const Value: String);
    procedure PopulateProperties;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Property ObjectName:String read fsObjectName write setObjectName;
  end;

  Procedure PopulateObjectProperties(objName:String; AOwner:TComponent);
implementation

uses CommonLib, Clipbrd, TypInfo, BusObjConst;

{$R *.dfm}

Procedure PopulateObjectProperties(objName:String; AOwner:TComponent);
var
  form :TComponent;
begin
  form := GetcomponentByclassname('TfmObjectProperties' , true , AOwner);
  if form = nil then exit;
  if not(form is TfmObjectProperties) then exit;
  TfmObjectProperties(form).ObjectName := Objname;
  if AOwner is Tform then TfmObjectProperties(form).color :=TForm(AOwner).Color;
  TfmObjectProperties(form).ShowModal;
end;
procedure TfmObjectProperties.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmObjectProperties.SaveRecord :Boolean;
begin
  result:= False;
  ObjectProperties.PostDB;
  if not(ObjectProperties.Save) then exit;
  Result:= True;
end;

procedure TfmObjectProperties.setObjectName(const Value: String);
var
  obj :TComponent;
begin
  fsObjectName := Value;
  obj := Getcomponentbyclassname(fsObjectName);
  try
    if obj = nil then exit;
    if not (Obj is TBusobj) then exit;
    TitleLabel.Caption := TBusobj(Obj).XMLNodeName +' Validation';
    Self.Caption := TitleLabel.Caption +' Validation';
  finally
    Freeandnil(Obj);
  end;
end;

procedure TfmObjectProperties.PopulateProperties;
var
  obj :TComponent;
  iIndex, Propcount : integer;
  PropList: PPropList ;
  ST:Tstringlist;
  s:String;
begin
  obj := Getcomponentbyclassname(fsObjectName);
  try
    if obj = nil then exit;
    if not (Obj is TBusobj) then exit;
    TitleLabel.Caption := TBusobj(Obj).XMLNodeName;
    Self.Caption := TitleLabel.Caption;

    if devmode then begin
        Propcount:= GetPropList(PTypeInfo(obj.ClassInfo) , PropList);
        if (not(Assigned(PropList))) or (Propcount = 0 ) then Exit;
        St:= TStringlist.Create;
        try
          for iIndex := 0 to Propcount-1 do begin
            s:= string(Proplist[iIndex].name);
            if (Sametext(s , 'GlobalRef'))
                or (Sametext(s , TBusobj(obj).IDFieldName))
                or (Sametext(s , 'msTimeStamp'))
                or (Sametext(s , 'msUpdateSiteCode'))
                or (Sametext(s , 'Name'))
                or (Sametext(s , 'tag'))
                or (Sametext(s , 'ID'))
                or (Sametext(s , 'Count'))
                or (Sametext(s , 'KeyValue')) then else
            if ((PropType( obj ,s) in [tkClass, tkMethod, tkArray, tkRecord, tkInterface])) then else
              st.Add('insert ignore into tblObjectProperties (ObjClassname , PropertyName , PropertyUserName) Values (' + Quotedstr(fsObjectName)+',' + Quotedstr(s)+',' + Quotedstr(s)+');');
          end;
          if st.Count >0 then begin
             ExecuteSQLinconnection(st.text);
             ObjectProperties.closedb;
             ObjectProperties.openDB;
          end;
        finally
          Freeandnil(st);
        end;
    end;
  finally
    FreeandNil(obj);
  end;
end;

procedure TfmObjectProperties.mnuPropertiesClick(Sender: TObject);
begin
  inherited;
  PopulateProperties;
end;

procedure TfmObjectProperties.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  ObjectProperties.Connection.CommitTransaction;
  Self.Close;

end;

procedure TfmObjectProperties.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     inherited ;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TObjectProperties then TObjectProperties(Sender).Dataset  := qryObjectProperties;
     end;
end;

procedure TfmObjectProperties.ExportSelectedRecords1Click(Sender: TObject);
var
  s:String;
  i:Integer;
begin
  inherited;
    s:= '';
    if grdTransactions.SelectedList.Count > 0 then begin
        s:= 'delete from tblObjectProperties  where  ObjClassname = ' +quotedstr(qryObjectPropertiesObjClassname.AsString)+';';
        for i := 0 to grdTransactions.SelectedList.Count - 1 do begin
          grdTransactions.datasource.dataset.GotoBookmark(grdTransactions.SelectedList.Items[i]);
          s:= s +  'insert ignore into tblObjectProperties (ObjClassname , PropertyName , PropertyUserName) ' +
                   ' Values (' + Quotedstr(qryObjectPropertiesObjClassname.AsString)+',' +
                                  Quotedstr(qryObjectPropertiesPropertyName.AsString)+',' +
                                  Quotedstr(qryObjectPropertiesPropertyUserName.AsString)+');'
        end;
    end;
    Clipboard.asText := s;
end;

procedure TfmObjectProperties.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmObjectProperties.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if ObjectProperties.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          ObjectProperties.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;

procedure TfmObjectProperties.FormCreate(Sender: TObject);
begin
  inherited;
  ObjectProperties := TObjectProperties.CreateWithNewConn(Self);
  ObjectProperties.Connection.connection := Self.MyConnection;
  ObjectProperties.BusObjEvent := DoBusinessObjectEvent;
end;
procedure TfmObjectProperties.FormShow(Sender: TObject);
begin
  inherited;
  //ObjectProperties.Load(KeyID);
  ObjectProperties.LoadSelect('ObjClassname =' +quotedstr(ObjectName));
  ObjectProperties.connection.BeginTransaction;
  if ObjectProperties.count=0 then ObjectProperties.new;
  openQueries;

  if devmode then begin
    popupmenu := mnu;
    grdTransactions.Options := grdTransactions.Options +[dgMultiselect];
  end;
end;

initialization
  RegisterClassOnce(TfmObjectProperties);

end.

