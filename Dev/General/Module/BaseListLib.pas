unit BaseListLib;

interface
  uses ERPdbComponents, Wwdbgrid,classes , menus;

type
  TProcWithERPQuery   = Procedure (Qty :TERPQuery) of Object;

  procedure IterateselectedRecords(Sender: TwwDbGrid; REcProc : TProcWithERPQuery; UseProgressbar :Boolean = True; ProgressbarPosition:Integer =0);
  Procedure NewMenuItem(Sender : TComponent; menucaption:String; HasSeperator:Boolean; Menuclick:TNotifyEvent); Overload;
  Procedure NewMenuItem(Sender : TComponent; menucaption:String; HasSeperator:Boolean; Menuclick:TNotifyEvent; var mnuSep:TMenuItem; var mnu:TMenuItem);Overload;
  function  NewMenuItem(Sender : TComponent; menuCaption: String;  MenuEvent: TNotifyEvent; hasSeparator: Boolean; PopupMenu : TPopupMenu; menuhint:String='') : TMenuItem;Overload;
  function  NewMenuItem(Sender : TComponent; menuCaption: String;  MenuEvent: TNotifyEvent; hasSeparator: Boolean; PopupMenu : TPopupMenu; menuhint:String; var mnuSep:TMenuItem; var mnu:TMenuItem) : TMenuItem;Overload;

implementation

uses db, tcConst , ProgressDialog, BaseListingForm , sysutils ;



function  NewMenuItem(Sender : TComponent; menuCaption: String;  MenuEvent: TNotifyEvent; hasSeparator: Boolean; PopupMenu : TPopupMenu; menuhint:String; var mnuSep:TMenuItem; var mnu:TMenuItem) : TMenuItem;
var
  amnu: TMenuItem;
  CountMenuItems:Integer;
  FoundMenuItem:Boolean;
begin
  Result := nil;
  if not (Assigned(PopupMenu)) then exit;

  {Search if menu exists }
  FoundMenuItem := False;
  CountMenuItems := 0;
  while (CountMenuItems < PopupMenu.Items.Count) and (FoundMenuItem = false) do begin
    if PopupMenu.Items[CountMenuItems].Caption = menuCaption then begin
      FoundMenuItem := true;
      if not PopupMenu.Items[CountMenuItems].visible then PopupMenu.Items[CountMenuItems].visible := true;
      Result := PopupMenu.Items[CountMenuItems];
      Break;
    end
    else Inc(CountMenuItems);
  end;


  if not FoundMenuItem then begin
      if hasSeparator then begin
        amnu := TMenuItem.Create(Sender);
        mnuSep := amnu;
        amnu.Caption := '-';
        PopupMenu.Items.Add(amnu);
      end;

      amnu := TMenuItem.Create(Sender);
      Result := amnu;
      mnu := amnu;
      amnu.Caption := menuCaption;
      amnu.OnClick := MenuEvent;
      if menuhint <> '' then amnu.hint :=  menuhint;
      PopupMenu.Items.Add(amnu);
      Result := amnu;
  end;

end;
function NewMenuItem(Sender : TComponent; menuCaption: String;  MenuEvent: TNotifyEvent; hasSeparator: Boolean; PopupMenu : TPopupMenu; menuhint:String='') : TMenuItem;
var
  mnuSep:TMenuItem;
  mnu:TMenuItem;
begin
  Result := NewMenuItem(Sender ,menuCaption,MenuEvent,hasSeparator,PopupMenu ,menuhint,mnuSep,mnu);
end;
Procedure NewMenuItem(Sender : TComponent; menucaption:String; HasSeperator:Boolean; Menuclick:TNotifyEvent; var mnuSep:TMenuItem; var mnu:TMenuItem);
begin
  mnuSep := nil;
  mnu := nil;
  if not(Sender is TBaseListingGUI) then exit;

  if Assigned(TBaseListingGUI(Sender).grdmain.popupmenu) then begin
    NewMenuItem(TBaseListingGUI(Sender),menuCaption,Menuclick,HasSeperator,TBaseListingGUI(Sender).grdmain.popupmenu ,'',mnuSep,mnu);
  end;
end;

Procedure NewMenuItem(Sender : TComponent; menucaption:String; HasSeperator:Boolean; Menuclick:TNotifyEvent);
var
  mnuSep:TMenuItem;
  mnu:TMenuItem;
begin
  NewMenuItem(Sender ,menucaption,HasSeperator,Menuclick,mnuSep,mnu);
end;

procedure IterateselectedRecords(Sender: TwwDbGrid; RecProc : TProcWithERPQuery; UseProgressbar :Boolean = True; ProgressbarPosition:Integer =0);
var
  i: integer;
  Abort: boolean;
  bm:TBookmark;
  ds:TERPQuery;
  Baselist:TBaseListingGUI;
  Function SelectedRecords:Integer ; begin  result := Sender.SelectedList.Count; end;
begin
  Abort := false;
  try
    ds:= TERPQuery(Sender.datasource.DataSet);
  Except
    on E:Exception do begin
      Exit;
    end;
  end;

  try
    Baselist:= TBaseListingGUI(Sender.Owner);
  Except
    on E:Exception do begin
      Exit;
    end;
  end;


  if SelectedRecords > 0 then begin
    if UseProgressbar then begin
      DoShowProgressbar(Sender.SelectedList.Count , WAITMSG);
      if ProgressbarPosition >0 then ProgressDialogInst.top :=ProgressbarPosition;
    end;
    try
      bm := ds.GetBookmark;
      try
            for i := 0 to SelectedRecords - 1 do begin
              ds.GoToBookmark(sender.SelectedList.Items[i]);
              RecProc(ds);
              DoStepProgressbar;
            end;
      finally
        ds.GotoBookmark(bm);
        ds.FreeBookmark(bm);
      end;
    finally
      if UseProgressbar then DoHideProgressbar;
    end;
  end;
end;

end.
