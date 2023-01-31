unit BaseInputDoorLookups;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, 
  DNMSpeedButton, StdCtrls, Shader, DNMPanel, ActnList, DNMAction, BusobjDoorLookups,
  Mask, wwcheckbox, wwdbedit, Wwdotdot, Wwdbcomb, MemDS, wwdblook,
  wwclearbuttongroup, wwradiogroup;

type
  TBaseInputdoorLookupGUI = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdSave: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    lsTDNMSpeedButtonActions: TActionList;
    actSave: TDNMAction;
    actCancel: TDNMAction;
    cmdnew: TDNMSpeedButton;
    actNew: TDNMAction;
    wwCheckBox1: TwwCheckBox;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure cmdnewClick(Sender: TObject);
    procedure actNewUpdate(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    fsGlobalref :String;
    Procedure RefreshDBData;
  Protected
    DBData: TBusobjDoorLookups;
    Procedure DoFieldOnChange(Const Propname :String); virtual;
    (*Procedure LoadLookupItems(Sender :TwwDBComboBox; Lookuptable :TERPQuery; lookupfield:String);*)
    procedure RollbackTransaction;
    procedure CommitAndNotify;
    Procedure LoadLookupTableParams; virtual;
    procedure LookupcomboCloseUp(Sender: TObject; LookupTable,FillTable: TDataSet; modified: Boolean); //virtual;
    Procedure comboBoxloseup(Sender: TwwDBComboBox; Select: Boolean); //virtual;
    Procedure Datachanged(sender :TObject); //virtual;
    procedure ComboBoxCloseUp(Sender: TwwDBComboBox; Select: Boolean); //virtual;
  public
    Property Globalref :String Read fsGlobalref Write fsGlobalref;

  end;

implementation

uses CommonLib, TypInfo , DBCtrls ;


{$R *.dfm}
Procedure TBaseInputdoorLookupGUI.Datachanged(sender :TObject);
begin
    if Sender is TwwDBEdit then begin
        SetPropValue(dbdata,    TwwDbEdit(Sender).DataField , TwwDbEdit(Sender).Text);
        DoFieldOnChange(TwwDbEdit(Sender).DataField);
    end else if Sender is TwwRadioGroup then begin
        SetPropValue(dbdata,    TwwRadioGroup(Sender).DataField , TwwRadioGroup(Sender).Value);
        DoFieldOnChange(TwwRadioGroup(Sender).DataField);
    end else if Sender is TwwCheckBox then begin
        SetPropValue(dbdata,    TwwCheckBox(Sender).DataField , TwwCheckBox(Sender).checked);
        DoFieldOnChange(TwwCheckBox(Sender).DataField);
    end else if Sender is TwwDBComboBox then begin
        SetPropValue(dbdata,    TwwDBComboBox(Sender).DataField , TwwDBComboBox(Sender).Text);
        DoFieldOnChange(TwwDBComboBox(Sender).DataField);
    end else if Sender is TwwDBLookupCombo then begin
        SetPropValue(dbdata,    TwwDBLookupCombo(Sender).DataField , TwwDBLookupCombo(Sender).Text);
        DoFieldOnChange(TwwDBLookupCombo(Sender).DataField);
    end;
end;
procedure TBaseInputdoorLookupGUI.RefreshDBData;
var
  ctr:Integer;

    Function IsReadOnlyProperty(Const Propname :String):Boolean ;
    Var
      PropInfo: PPropInfo;
    begin
        PropInfo := GetPropInfo(DbData, Propname);
        result := not (Assigned( PropInfo.SetProc)) ;
    end;
begin
    for ctr := 0 to ComponentCount-1 do begin
        if Components[ctr] is  TwwDBEdit then begin
            TwwDBEdit(Components[ctr]).Text          := VarToStr(getPropvalue(DBData , TwwDbEdit(Components[ctr]).DataField));
            TwwDBEdit(Components[ctr]).Enabled       := not(IsReadOnlyProperty(TwwDbEdit(Components[ctr]).DataField));
        end else if components[ctr] is TwwRadioGroup then begin
            TwwRadioGroup(Components[ctr]).Value     := VarToStr(getPropvalue(DBData , TwwRadioGroup(Components[ctr]).DataField));
            TwwRadioGroup(Components[ctr]).Enabled   := not(IsReadOnlyProperty(TwwRadioGroup(Components[ctr]).DataField));
        end else if Components[ctr] is TwwCheckBox then begin
            TwwCheckBox(Components[ctr]).Checked     := VarToStr(getPropvalue(DBData , TwwCheckBox(Components[ctr]).DataField)) = 'True';
            TwwCheckBox(Components[ctr]).Enabled     := not(IsReadOnlyProperty(TwwCheckBox(Components[ctr]).DataField));
        end else if Components[ctr] is  TwwDBComboBox then begin
            TwwDBComboBox(Components[ctr]).Value     := VarToStr(getPropvalue(DBData , TwwDBComboBox(Components[ctr]).DataField));
            TwwDBComboBox(Components[ctr]).Enabled   := not(IsReadOnlyProperty(TwwDBComboBox(Components[ctr]).DataField));
        end else if Components[ctr] is  TwwDBLookupCombo then begin
            TwwDBLookupCombo(Components[ctr]).Text   := VarToStr(getPropvalue(DBData , TwwDBLookupCombo(Components[ctr]).DataField));
            TwwDBLookupCombo(Components[ctr]).Enabled:= not(IsReadOnlyProperty(TwwDBLookupCombo(Components[ctr]).DataField));

        end;
    end;
end;
procedure TBaseInputdoorLookupGUI.FormCreate(Sender: TObject);
var
    ctr:Integer;
begin
  inherited;
    // dbdata should be created in the descendants in form create before inherited
    // eg. frmdoorCompDet.
    DBData.Storer.connection := Myconnection;

    for ctr := 0 to ComponentCount-1 do begin
        if Components[ctr] is  TwwDBEdit then begin
            TwwDBEdit(Components[ctr]).OnExit           := Datachanged;
        end else  if Components[ctr] is  TwwCheckBox then begin
            TwwCheckBox(Components[ctr]).OnClick        := Datachanged;
        end else  if Components[ctr] is  TwwDBComboBox then begin
            TwwDBComboBox(Components[ctr]).OnExit       := Datachanged;
            TwwDBComboBox(Components[ctr]).oncloseup    := ComboBoxCloseUp;
        end else  if Components[ctr] is TwwRadioGroup then begin
            TwwRadioGroup(Components[ctr]).Onclick := Datachanged;
        end else  if Components[ctr] is  TwwDBLookupCombo then begin
            TwwDBLookupCombo(Components[ctr]).OnExit    := Datachanged;
            TwwDBLookupCombo(Components[ctr]).oncloseup := LookupcomboCloseUp;
        end;
    end;
end;

Procedure TBaseInputdoorLookupGUI.comboBoxloseup(Sender: TwwDBComboBox; Select: Boolean);
begin
    {to force exit for propery update}
    SetFocusedControl(cmdSave);
    SetFocusedControl(TwwDBLookupCombo(Sender));
end;
procedure TBaseInputdoorLookupGUI.ComboBoxCloseUp(Sender: TwwDBComboBox; Select: Boolean);
begin
    {to force exit for propery update}
    SetFocusedControl(cmdSave);
    SetFocusedControl(TwwDBComboBox(Sender));
end;
procedure TBaseInputdoorLookupGUI.LookupcomboCloseUp(Sender: TObject; LookupTable,FillTable: TDataSet; modified: Boolean);
begin
    {to force exit for propery update}
    SetFocusedControl(cmdSave);
    SetFocusedControl(TwwDBLookupCombo(Sender));
end;
procedure TBaseInputdoorLookupGUI.FormDestroy(Sender: TObject);
begin
    Freeandnil(DBData);
  inherited;

end;
procedure TBaseInputdoorLookupGUI.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
    Procedure SaveData;
    begin
        if DBData.Save then begin
            CommitAndNotify;
            CanClose:= true;
        end;
    end;
    Procedure Canceldata;
    begin
        RollbackTransaction;
        DBData.Dirty:= false;
        CanClose:= true;
    end;
    Procedure Cancelclose;
    begin
        CanClose:= false;
        cmdCancel.enabled := true;
    end;

begin
    CanClose:= false;
    if DBData.Dirty then begin
        case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes,mbNo,mbCancel], 0) of
            mrYes : SaveData;
            mrNo  : CancelData;
            mrCancel:Cancelclose;
        end;
    end else begin
        CanClose:= true;
    end;
end;
procedure TBaseInputdoorLookupGUI.RollbackTransaction;
begin
    if MyConnection.InTransaction then
        MyConnection.Rollback;
end;
procedure TBaseInputdoorLookupGUI.CommitAndNotify;
begin
    if MyConnection.InTransaction then
        MyConnection.Commit;
end;
Procedure TBaseInputdoorLookupGUI.LoadLookupTableParams;
begin
    //descendants will inherit
end;
procedure TBaseInputdoorLookupGUI.FormShow(Sender: TObject);
var
    ctr:Integer;
begin
    inherited;
    DBData.ObjInstGlobalref := Globalref;
    DBData.Storer.Load(DBData);
    LoadLookupTableParams;
    for ctr := 0 to ComponentCount-1 do begin
        if Components[ctr] is  TERPQuery then begin
            if not(Assigned(TERPQuery(Components[ctr]).Connection)) then TERPQuery(Components[ctr]).Connection := MyConnection;
            if TERPQuery(Components[ctr]).active = False then TERPQuery(Components[ctr]).open;
        end;
    end;
    RefreshDBData;
    DBData.Dirty := False;

end;


procedure TBaseInputdoorLookupGUI.actSaveExecute(Sender: TObject);
begin
    inherited;
    Application.ProcessMessages;
    if DBData.Validatedata then
        if DBData.Save then
            self.close;

end;

procedure TBaseInputdoorLookupGUI.actCancelExecute(Sender: TObject);
begin
    inherited;
    Self.close;
end;
Procedure TBaseInputdoorLookupGUI.DoFieldOnChange(Const Propname :String);
begin
    // descendants should override it if required
end;
(*Procedure TBaseInputdoorLookupGUI.LoadLookupItems(Sender :TwwDBComboBox; Lookuptable :TERPQuery ; lookupfield:String);
var
    LookupFields, curfield:String;
    itemtext :STring;
begin
    if Lookuptable.active = False then begin
        if not(Assigned(Lookuptable.connection)) then Lookuptable.connection := Self.MyConnection;
        Lookuptable.open;
    end;
    Sender.Items.clear;
    if Lookuptable.recordcount = 0 then Exit;
    Lookuptable.first;
    itemtext := '';
    while Lookuptable.eof = False do begin
        Lookupfields := Lookupfield;
           while LookupFields<> '' do begin
                if FastFuncs.PosEx('~' , Lookupfields) <> 0 then begin
                    curfield := copy(Lookupfields, 1, FastFuncs.PosEx('~' , Lookupfields)-1);
                    Lookupfields := replaceStr(lookupfield , curfield+'~' , '')
                end else begin
                    curfield :=Lookupfields;
                    Lookupfields := '';
                end;
                if itemtext<>'' then itemtext := itemtext + '-' ;
                itemtext :=itemtext + Lookuptable.fieldByname(curfield).asString;
           end;
           Sender.Items.add(itemText);
           Lookuptable.next
    end;
end;*)

procedure TBaseInputdoorLookupGUI.cmdnewClick(Sender: TObject);
begin
  inherited;
    if Dbdata.dirty then begin
        if not(DBData.ValidateData) then exit;
        if not(DBData.Save) then Exit;
    end;
    DBData.New;
    RefreshDBData;
end;

procedure TBaseInputdoorLookupGUI.actNewUpdate(Sender: TObject);
begin
  inherited;
    ActNew.enabled := True;
end;

procedure TBaseInputdoorLookupGUI.actNewExecute(Sender: TObject);
begin
  inherited;
    if DBData.IsDirty then
        if not DBData.Save then exit;

    DBData.New;
    RefreshDBData;
end;

procedure TBaseInputdoorLookupGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    Action := caFree;
    inherited;

end;

end.
