unit ConfigGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvGroupBox, slstbox, AdvOfficeTabSet,
  AdvOfficeTabSetStylers, AdvPageControl, ComCtrls, ImgList, EllipsLabel,
  AdvPanel, ExtCtrls, DNMSpeedButton, paramchklist, ParamListbox,
  paramtreeview, Menus, Buttons, DB, MemDS, DBAccess, MyAccess, AdvEdit,
  advlued, AdvGlassButton;

type
  TConfig = class(TForm)
    ImageList1: TImageList;
    AdvPanel1: TAdvPanel;
    AdvPageControl2: TAdvPageControl;
    AdvTabSheet4: TAdvTabSheet;
    AdvTabSheet5: TAdvTabSheet;
    AdvPanelStyler1: TAdvPanelStyler;
    OptionsParams: TParamTreeview;
    ExcludeCheckList: TParamCheckList;
    btnCancel: TDNMSpeedButton;
    btnSave: TDNMSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    ExcludeDBList: TStringList;
    procedure SetOptions;
    procedure LoadOptions;
    procedure SetExcludeCheckList;
    procedure LoadExcludeCheckList;
  public
    { Public declarations }
  end;

var
  Config: TConfig;

implementation

uses
  EmailFaxServerUnit, EmailFaxServerLib, FastFuncs;


{$R *.dfm}

procedure TConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 EmailFaxServer.INI_Options.Load;
 Action := cafree;
end;

procedure TConfig.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TConfig.FormShow(Sender: TObject);
begin
  LoadOptions;
end;

procedure TConfig.FormCreate(Sender: TObject);
begin
  Inherited;
  If Assigned(Self.Owner) Then
    TEmailFaxServer(Self.Owner).mnuSendNow.Enabled := False;
  TrayIcon.PopupMenu := nil;
  Self.Caption := Self.Caption + ' (v'+GetFileVersion(Application.ExeName)+')';
  ExcludeDBList := TStringList.Create;
end;

procedure TConfig.FormDestroy(Sender: TObject);
begin
  FreeAndNil(ExcludeDBList);
  If Assigned(Self.Owner) Then begin
    TEmailFaxServer(Self.Owner).mnuSendNow.Enabled := True;
    TrayIcon.PopupMenu := TEmailFaxServer(Self.Owner).PopupMenu;
  end;
  Inherited;
  Config := Nil;
  RefreshMemoryUsage;
end;

procedure TConfig.btnSaveClick(Sender: TObject);
begin
  SetOptions;
  EmailFaxServer.INI_Options.Save;
  Self.Close;
end;

procedure TConfig.SetOptions;
begin
  {General}
  EmailFaxServer.INI_Options.MySQLServer := OptionsParams.Parameter['MySQLServer'];
  EmailFaxServer.INI_Options.Mode := OptionsParams.Parameter['Mode'];
  SetExcludeCheckList;
  EmailFaxServer.INI_Options.ExcludeDBList.Text := ExcludeDBList.Text;
  {Email}
  EmailFaxServer.INI_Options.TryForDays := OptionsParams.Parameter['TryForDays'];
  {Fax}
  EmailFaxServer.INI_Options.Comport := OptionsParams.Parameter['Comport'];
  EmailFaxServer.INI_Options.FaxName := OptionsParams.Parameter['FaxName'];
end;

procedure TConfig.LoadOptions;
begin
  OptionsParams.Items[0].Expanded := True;
  OptionsParams.Items[1].Expanded := True;
  {General}
  OptionsParams.Parameter['MySQLServer'] := EmailFaxServer.INI_Options.MySQLServer;
  OptionsParams.Parameter['Mode'] :=  EmailFaxServer.INI_Options.Mode;
  ExcludeDBList.Text := EmailFaxServer.INI_Options.ExcludeDBList.Text;
  LoadExcludeCheckList;
  {Email}
  OptionsParams.Parameter['TryForDays'] := EmailFaxServer.INI_Options.TryForDays;
  {Fax}
  OptionsParams.Parameter['Comport'] := EmailFaxServer.INI_Options.Comport;
  OptionsParams.Parameter['FaxName'] := EmailFaxServer.INI_Options.FaxName;
end;


procedure TConfig.LoadExcludeCheckList;
Var
  AllDBs: TStringList;
  Test,I: Integer;
  UpdaterConnection,UpdaterConnection2: TMyConnection;
begin
  ExcludeCheckList.Comment[0] := true;
  UpdaterConnection := EmailFaxServerLib.CreateDBConnection(nil,'');
  If not Assigned(UpdaterConnection) then Exit;
  Try
    AllDBs := EmailFaxServerLib.GetDBList(UpdaterConnection);
    Try
      for I := 0 to AllDBs.Count-1 do Begin
        UpdaterConnection2 := EmailFaxServerLib.CreateDBConnection(nil,AllDBs[I]);
        Try
          If FastFuncs.SameText(AllDBs[I],'erpnewdb') or
             FastFuncs.SameText(AllDBs[I],'mysql') or
             FastFuncs.SameText(AllDBs[I],'pbxmonitor') or
             FastFuncs.SameText(AllDBs[I],'services') or
             FastFuncs.SameText(AllDBs[I],'serverupdates') or
             (EmailFaxServerLib.TablesCount(UpdaterConnection2,AllDBs[I])<300) then Continue;
          ExcludeCheckList.AddItem(' '+AllDBs[I],nil);
        finally
          UpdaterConnection2.Disconnect;
          FreeAndNil(UpdaterConnection2);
        end;
      end;
    finally
      FreeAndNil(AllDBs);
    end;
  finally
    UpdaterConnection.Disconnect;
    FreeAndNil(UpdaterConnection);
  end;
  for I := 0 to ExcludeDBList.Count-1 do Begin
    Test := ExcludeCheckList.Items.IndexOf(' '+ExcludeDBList[I]);
    If (Test > -1) then
       ExcludeCheckList.Checked[Test] := True;
  end;
end;

procedure TConfig.SetExcludeCheckList;
Var
   I: Integer;
begin
  ExcludeDBList.Clear;
  for I := 0 to ExcludeCheckList.Items.Count-1 do Begin
    If ExcludeCheckList.Checked[I] then
      ExcludeDBList.Add(FastFuncs.Trim(ExcludeCheckList.Items[I]));
  end;
end;

procedure TConfig.FormPaint(Sender: TObject);
begin
  PerformPaints;
end;

initialization

end.






