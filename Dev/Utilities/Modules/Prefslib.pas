unit Prefslib;

interface

uses Forms, classes, dnmpanel;

type
  TPrefsGUIObj = class(TComponent)
    Private
      fs1, fs2, fs3:String;
    function GroupDescofPanel(pnl: TDnmPanel): string;
    Protected
    Public
      procedure ondblclickevent(Sender:TObject);
      (*procedure AssignDblclicks(Prefform :Tform);*)
  end;


  function  PrefsGUIObj : TPrefsGUIObj;

implementation

uses stdctrls , WwDBDateTimePicker, WwDBEdit,WwCheckbox , WwDBSpin,WwDBLook,WwRadiogroup,WwDBComb,WwDBGrid,DBCtrls, AdvOfficeSelectors,AdvTrackBar,AdvEdit,ExtCtrls,ComCtrls,ERPdbComponents,AdvSpin,AdvOfficeButtons,CheckLst,DBAdvEd,ERPDbLookupCombo,MaskEdEx,
  LogLib,SysUtils,Dialogs, graphics;

var
    fPrefsGUIObj : TPrefsGUIObj;

function  PrefsGUIObj : TPrefsGUIObj;
begin
   if fPrefsGUIObj  = nil then fPrefsGUIObj := TPrefsGUIObj.Create(Application);
   result := fPrefsGUIObj;
end;
(*procedure TPrefsGUIObj.AssignDblclicks(Prefform :Tform);
var
  ctr:Integer;
begin
  for ctr := 0 to Prefform.componentcount-1 do begin
           if Prefform.components[ctr] is TLabel               then TLabel(Prefform.components[ctr]).ondblclick               :=  ondblclickevent
    else   if Prefform.components[ctr] is TwwDBDateTimePicker  then TwwDBDateTimePicker(Prefform.components[ctr]).ondblclick  :=  ondblclickevent
    else   if Prefform.components[ctr] is TwwDateComboButton   then TwwDateComboButton(Prefform.components[ctr]).ondblclick   :=  ondblclickevent
    else   if Prefform.components[ctr] is TwwDBEdit            then TwwDBEdit(Prefform.components[ctr]).ondblclick            :=  ondblclickevent
    //else   if Prefform.components[ctr] is TwwCheckBox          then TwwCheckBox(Prefform.components[ctr]).ondblclick          :=  ondblclickevent
    else   if Prefform.components[ctr] is TwwDBSpinEdit        then TwwDBSpinEdit(Prefform.components[ctr]).ondblclick        :=  ondblclickevent
    else   if Prefform.components[ctr] is TwwDBLookupCombo     then TwwDBLookupCombo(Prefform.components[ctr]).ondblclick     :=  ondblclickevent
    else   if Prefform.components[ctr] is TwwPopupGrid         then TwwPopupGrid(Prefform.components[ctr]).ondblclick         :=  ondblclickevent
    else   if Prefform.components[ctr] is TwwRadioGroup        then TwwRadioGroup(Prefform.components[ctr]).onclick        :=  ondblclickevent
    //else   if Prefform.components[ctr] is TGroupButton         then TGroupButton(Prefform.components[ctr]).ondblclick         :=  ondblclickevent
    else   if Prefform.components[ctr] is TwwDBComboBox        then TwwDBComboBox(Prefform.components[ctr]).ondblclick        :=  ondblclickevent
    //else   if Prefform.components[ctr] is TwwPopupListbox      then TwwPopupListbox(Prefform.components[ctr]).onclick      :=  ondblclickevent
    else   if Prefform.components[ctr] is TwwDBGrid            then TwwDBGrid(Prefform.components[ctr]).ondblclick            :=  ondblclickevent
    else   if Prefform.components[ctr] is TDBMemo              then TDBMemo(Prefform.components[ctr]).ondblclick              :=  ondblclickevent
    else   if Prefform.components[ctr] is TAdvOfficeColorSelector then TAdvOfficeColorSelector(Prefform.components[ctr]).OnClick :=  ondblclickevent
    else   if Prefform.components[ctr] is TAdvTrackBar         then TAdvTrackBar(Prefform.components[ctr]).OnClick         :=  ondblclickevent
    //else   if Prefform.components[ctr] is TDBCheckBox          then TDBCheckBox(Prefform.components[ctr]).OnClick          :=  ondblclickevent
    else   if Prefform.components[ctr] is TEdit                then TEdit(Prefform.components[ctr]).ondblclick                :=  ondblclickevent
    else   if Prefform.components[ctr] is TDBAdvEdit           then TDBAdvEdit(Prefform.components[ctr]).OnDblClick           :=  ondblclickevent
    else   if Prefform.components[ctr] is TCheckBox            then TCheckBox(Prefform.components[ctr]).OnClick           :=  ondblclickevent
    else   if Prefform.components[ctr] is TRadioGroup          then TRadioGroup(Prefform.components[ctr]).OnClick          :=  ondblclickevent
    else   if Prefform.components[ctr] is TListView            then TListView(Prefform.components[ctr]).ondblclick            :=  ondblclickevent
    else   if Prefform.components[ctr] is TGroupBox            then TGroupBox(Prefform.components[ctr]).ondblclick            :=  ondblclickevent
    else   if Prefform.components[ctr] is TComboBox            then TComboBox(Prefform.components[ctr]).ondblclick            :=  ondblclickevent
    else   if Prefform.components[ctr] is TAdvEdit             then TAdvEdit(Prefform.components[ctr]).ondblclick             :=  ondblclickevent
    else   if Prefform.components[ctr] is TERPDbLookupCombo    then TERPDbLookupCombo(Prefform.components[ctr]).OnDblClick    :=  ondblclickevent
    else   if Prefform.components[ctr] is TAdvSpinEdit         then TAdvSpinEdit(Prefform.components[ctr]).ondblclick         :=  ondblclickevent
    else   if Prefform.components[ctr] is TAdvSpinButton       then TAdvSpinButton(Prefform.components[ctr]).OnDownClick       :=  ondblclickevent
    else   if Prefform.components[ctr] is TAdvOfficeRadioGroup then TAdvOfficeRadioGroup(Prefform.components[ctr]).ondblclick :=  ondblclickevent
    else   if Prefform.components[ctr] is TMaskEditEx          then TMaskEditEx(Prefform.components[ctr]).onclick          :=  ondblclickevent
    else   if Prefform.components[ctr] is TRadioButton         then TRadioButton(Prefform.components[ctr]).ondblclick         :=  ondblclickevent
    else   if Prefform.components[ctr] is TDBComboBox          then TDBComboBox(Prefform.components[ctr]).ondblclick          :=  ondblclickevent
    else   if Prefform.components[ctr] is TCheckListBox        then TCheckListBox(Prefform.components[ctr]).ondblclick        :=  ondblclickevent;



  end;

end;*)
procedure TPrefsGUIObj.ondblclickevent(Sender:TObject);
begin
           if Sender is TLabel               then fs1:= TLabel(Sender).Caption
    else   if Sender is TwwDBDateTimePicker  then fs2 := TwwDBDateTimePicker(Sender).datafield
    else   if Sender is TwwDateComboButton   then fs2 := inputbox('enter Value' ,'', TwwDateComboButton(Sender).name)
    else   if Sender is TwwDBEdit            then fs2 := TwwDBEdit(Sender).datafield
    else   if Sender is TwwCheckBox          then fs2 := TwwCheckBox(Sender).datafield
    else   if Sender is TwwDBSpinEdit        then fs2 := TwwDBSpinEdit(Sender).datafield
    else   if Sender is TwwDBLookupCombo     then fs2 := TwwDBLookupCombo(Sender).datafield
    else   if Sender is TwwPopupGrid         then fs2 := TwwPopupGrid(Sender).datafield
    else   if Sender is TwwRadioGroup        then fs2 := TwwRadioGroup(Sender).datafield
    //else   if Sender is TGroupButton         then fs2 := TGroupButton(Sender).datafield
    else   if Sender is TwwDBComboBox        then fs2 := TwwDBComboBox(Sender).datafield
    else   if Sender is TwwPopupListbox      then fs2 := inputbox('enter Value' ,'', TwwPopupListbox(Sender).name)
    else   if Sender is TwwDBGrid            then fs2 := inputbox('enter Value' ,'', TwwDBGrid(Sender).name)
    else   if Sender is TDBMemo              then fs2 := TDBMemo(Sender).datafield
    else   if Sender is TAdvOfficeColorSelector then fs2 := inputbox('enter Value' ,'', TAdvOfficeColorSelector(Sender).name)
    else   if Sender is TAdvTrackBar         then fs2 := inputbox('enter Value' ,'', TAdvTrackBar(Sender).name)
    else   if Sender is TDBCheckBox          then fs2 := TDBCheckBox(Sender).datafield
    else   if Sender is TEdit                then fs2 := inputbox('enter Value' ,'', TEdit(Sender).name)
    else   if Sender is TDBAdvEdit           then fs2 := TDBAdvEdit(Sender).datafield
    //else   if Sender is TCheckBox            then fs2 := TCheckBox(Sender).datafield
    else   if Sender is TRadioGroup          then fs2 := inputbox('enter Value' ,'', TRadioGroup(Sender).name)
    else   if Sender is TListView            then fs2 := inputbox('enter Value' ,'', TListView(Sender).name)
    //else   if Sender is TButton              then fs2 := TButton(Sender).datafield
    else   if Sender is TGroupBox            then fs2 := inputbox('enter Value' ,'', TGroupBox(Sender).name)
    else   if Sender is TComboBox            then fs2 := inputbox('enter Value' ,'', TComboBox(Sender).name)
    else   if Sender is TAdvEdit             then fs2 := inputbox('enter Value' ,'', TAdvEdit(Sender).name)
    else   if Sender is TERPDbLookupCombo    then fs2 := TERPDbLookupCombo(Sender).datafield
    else   if Sender is TAdvSpinEdit         then fs2 := inputbox('enter Value' ,'', TAdvSpinEdit(Sender).name)
    //else   if Sender is TAdvSpinButton       then fs2 := TAdvSpinButton(Sender).datafield
    else   if Sender is TAdvOfficeRadioGroup then fs2 := inputbox('enter Value' ,'', TAdvOfficeRadioGroup(Sender).name)
    else   if Sender is TMaskEditEx          then fs2 := inputbox('enter Value' ,'', TMaskEditEx(Sender).name)
    //else   if Sender is TRadioButton         then fs2 := TRadioButton(Sender).datafield
    else   if Sender is TDBComboBox          then fs2 := TDBComboBox(Sender).datafield
    else   if Sender is TCheckListBox        then fs2 := inputbox('enter Value' ,'', TCheckListBox(Sender).name)
    else ;

   if Sender is TLabel then begin
      fs3 := '';
      if Assigned(TLabel(Sender).parent) and (TLabel(Sender).parent is TDNMPanel) then
        fs3 :=  GroupDescofPanel(TDNMPanel(TLabel(Sender).parent));
      logtext ('union all select ' +quotedstr(TLabel(sender).Owner.classname) +' as page, ' +
                                    quotedstr(fs3) +' as groupdesc, ' +
                                    quotedstr(fs1) +' as caption, ' +
                                    quotedstr(fs2)+' as fieldname');
      fs1:= '';
      fs2:= '';
    end;
end;

  function TPrefsGUIObj.GroupDescofPanel(pnl:TDnmPanel):string;
  var
    ctr:Integer;
  begin
    for ctr := 0 to pnl.componentcount-1 do begin
      if pnl.components[ctr] is TLabel then
        if (TLabel(pnl.components[ctr]).Font.Color = clMaroon) and
           (fsUnderline in TLabel(pnl.components[ctr]).Font.Style) and
           (fsBold in TLabel(pnl.components[ctr]).Font.Style) then begin
              Result :=TLabel(pnl.components[ctr]).caption;
              exit;
         end;
    end;

    for ctr := 0 to pnl.owner.componentcount-1 do begin
      if pnl.owner.components[ctr] is TLabel then
        if  Assigned(TLabel(pnl.owner.components[ctr]).parent) and
          (TLabel(pnl.owner.components[ctr]).parent = pnl) and
          (TLabel(pnl.owner.components[ctr]).Font.Color = clMaroon) and
          (fsUnderline in TLabel(pnl.owner.components[ctr]).Font.Style) and
          (fsBold in TLabel(pnl.owner.components[ctr]).Font.Style) then begin
              Result :=TLabel(pnl.owner.components[ctr]).caption;
              exit;
         end;
    end;

  end;
end.
