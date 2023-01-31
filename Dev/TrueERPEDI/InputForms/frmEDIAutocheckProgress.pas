unit frmEDIAutocheckProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, ComCtrls, AdvProgr, ExtCtrls, Menus, StdCtrls, DNMPanel, ERPEDIListBase;

type
  TfmEDIAutocheckProgress = class(TfrmBaseGUI)
    pnlRequerytmr: TPanel;
    Shape1: TShape;
    lblhint: TLabel;
    lblcheckPref: TLabel;
    pbRequery: TAdvProgress;
    tmrCheckOrdersTrack: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure tmrCheckOrdersTrackTimer(Sender: TObject);
    procedure lblcheckPrefClick(Sender: TObject);
  private
    fdSearch: TDateTime;
    fdNextsynch: TDateTime;
    fDoEvent: TNotifyEvent;
    fEdiform: TERPEDIListBaseGUI;
    fbAutocheck: Boolean;
    fsModuleCaption: String;
    fiCheckinterval: Integer;
    fShowLogAutomessage: boolean;
    procedure SetAutocheck(const Value: Boolean);
  public
    Property DoEvent: TNotifyEvent read fDoEvent write fDoEvent;
    Property EdiForm: TERPEDIListBaseGUI read fEdiform write fEdiform;
    Property AutoCheck: Boolean read fbAutocheck write SetAutocheck;
    Property ModuleCaption: String read fsModuleCaption write fsModuleCaption;
    Property CheckInterval: Integer read fiCheckinterval write fiCheckinterval;
    procedure InitTimers(DoEnable: Boolean);
    procedure DoEDICheckEvent;
    property ShowLogAutomessage: boolean read fShowLogAutomessage write fShowLogAutomessage;
    Class Function MakeEDIAutocheckProgress(Aowner: TComponent; aDoEvent: TNotifyEvent;
      ParentPanel: TPanel;
      aAutocheck: Boolean; aModuleCaption: String; aCheckinterval: Integer)
      : TfmEDIAutocheckProgress;
  end;

implementation

uses tcConst, CommonLib, LogLib, dateutils, LogDialog, AppEnvironment;

{$R *.dfm}

procedure TfmEDIAutocheckProgress.FormCreate(Sender: TObject);
begin
  inherited;
  fShowLogAutomessage := true;
  fdSearch := 0;
  fdNextsynch := 0;
  fDoEvent := nil;
  fEdiform := nil;
  fbAutocheck := False;
  fsModuleCaption := '';
  fiCheckinterval := 1000;
  if owner is TERPEDIListBaseGUI then
    fEdiform := TERPEDIListBaseGUI(owner);
end;

Procedure TfmEDIAutocheckProgress.DoEDICheckEvent;
begin
  InitTimers(False);
  try
    if assigned(fDoEvent) then begin
      fdSearch := now;
      fdNextsynch := incminute(fdSearch, 10);
      fEdiform.LoginList('=========================================');
      fEdiform.LoginList('Synchronizing with ' + fsModuleCaption);
      try
        if ShowLogAutomessage then
          fEdiform.LoginList('Checking for New ' + fsModuleCaption + '  Orders');
        Processingcursor(True);
        try
          { New Orders }
          fEdiform.LoginList('Synchronizing with ' + fsModuleCaption + '  : ' +
            FormatDatetime('hh:nn AM/PM', now));
          fDoEvent(fEdiform);
        finally
          Processingcursor(False);
          if ShowLogAutomessage then begin
            fEdiform.LoginList('Finished Checking Orders from ' + ModuleCaption);
            fEdiform.LoginList('=========================================');
          end;
        end;
      finally
        fEdiform.HideProgressbar;
      end;
    end;
  finally
    InitTimers(True);
  end;
end;

procedure TfmEDIAutocheckProgress.tmrCheckOrdersTrackTimer(Sender: TObject);

  function NextSynchAt: String;
  begin
    if minutesbetween(fdNextsynch, now) > 0 then
      result := 'Next Synch in ' + inttostr(minutesbetween(fdNextsynch, now)) + ' Minute(s).  '
    else
      result := 'Next Synch in ' + inttostr(Secondsbetween(fdNextsynch, now)) + ' Second(s).  ';
  end;

  function LastSynchAt: String;
  begin
    if fdSearch > 0 then
      result := 'List was Synchronized at ' +
        quotedstr(FormatDatetime('hh:nn am/pm', fdSearch)) + '.  '
    else
      result := 'Auto Synch  is Enabled.  '
  end;

begin
  inherited;
  pnlRequerytmr.parent.visible := True;
  if (screen.activeform = fEdiform) then begin
    pbRequery.Stepit;
    if fdNextsynch <= now then begin
          if not Appenv.companyprefs.MagentoEnabled then DoEDICheckEvent;
    end;
    ShowControlHint(pbRequery, LastSynchAt + NextSynchAt);
  end
  else begin
    if pbRequery.position = 0 then
      pbRequery.Stepit;
    ShowControlHint(pbRequery,
      'Auto Synchronization is on Hold as the Report is Not Currenctly Focused');
  end;
  lblhint.caption := pbRequery.hint;
  lblhint.refresh;
  // fEdiform.LoginList(lblhint.caption);
end;

Procedure TfmEDIAutocheckProgress.InitTimers(DoEnable: Boolean);
begin
  if Autocheck = False then
    exit;

  if DoEnable then begin
    pnlRequerytmr.parent.visible := False;
    tmrCheckOrdersTrack.Interval := CheckInterval;
    tmrCheckOrdersTrack.enabled := True;
    SetcontrolFocus(fEdiform.grdmain);
    fEdiform.bringtofront;
  end
  else begin
    tmrCheckOrdersTrack.enabled := False;
    pnlRequerytmr.parent.visible := False;
  end;
end;

procedure TfmEDIAutocheckProgress.lblcheckPrefClick(Sender: TObject);
begin
  inherited;
  fEdiform.OpenPreferance;
end;

class Function TfmEDIAutocheckProgress.MakeEDIAutocheckProgress(Aowner: TComponent;
  aDoEvent: TNotifyEvent; ParentPanel: TPanel;
  // aLeft :Integer;
  aAutocheck: Boolean; aModuleCaption: String; aCheckinterval: Integer): TfmEDIAutocheckProgress;
begin
  result := TfmEDIAutocheckProgress.Create(Aowner);
  ParentPanel.visible := True;
  result.pnlRequerytmr.parent := ParentPanel;
  result.ModuleCaption := aModuleCaption;
  result.Autocheck := aAutocheck;
  result.Checkinterval := aCheckinterval;
  result.fDoEvent := aDoEvent;
  result.tmrCheckOrdersTrack.enabled := aAutocheck;
end;

procedure TfmEDIAutocheckProgress.SetAutocheck(const Value: Boolean);
begin
  fbAutocheck := Value;
  if not Value then begin
    lblhint.caption := 'Preference to "Auto Check for Orders in List" is Disabled.' + NL +
      'This can be Changed from Preferences(EDI)';
    lblhint.align := alclient;
    lblhint.Wordwrap := True;
    pbRequery.visible := False;
  end
  else begin
    lblhint.align := alnone;
    lblhint.Wordwrap := False;
    pbRequery.visible := True;
    lblhint.caption := 'Preference to "Auto Check for Orders in List" is Enabled.' + NL +
      'The List will be zychronized in 1 Minute';
    lblhint.top := pbRequery.top + pbRequery.height + 1;
    lblhint.left := 1;
    lblhint.width := lblcheckPref.left - 1;
    tmrCheckOrdersTrack.Interval := fiCheckinterval;
    fdNextsynch := incsecond(now, 10);
  end;
end;

end.
