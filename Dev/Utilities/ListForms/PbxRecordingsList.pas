unit PbxRecordingsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls, StdCtrls, ExtCtrls, DNMPanel, wwdblook, MPlayer, ToolWin,
  MemDS, DBAccess, MyAccess, wwdbdatetimepicker, ProgressDialog,
  CustomInputBox, Shader;

type
  TPBXRecordingsListGUI = class(TBaseListingGUI)
    Panel4: TPanel;
    MediaPlayer1: TMediaPlayer;
    procedure qryMainAfterScroll(DataSet: TDataSet);
    procedure MediaPlayer1Notify(Sender: TObject);
    procedure MediaPlayer1Click(Sender: TObject; Button: TMPBtnType; var DoDefault: boolean);
    procedure grdMainDblClick(Sender: TObject); reintroduce;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function LoadPlayerWithFile: boolean;
  protected
    procedure RefreshQuery; override;

  public
    { Public declarations }
  end;

//var
//  PBXRecordingsListGUI: TPBXRecordingsListGUI;

implementation

uses
  DNMLib,  AppEnvironment, CommonLib;


{$R *.dfm}

{ TPBXRecordingsListGUI }

procedure TPBXRecordingsListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').AsDate := dtFrom.DateTime;
  qryMain.Params.ParamByName('txtto').AsDate := dtTo.DateTime;
  inherited;
end;

procedure TPBXRecordingsListGUI.qryMainAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if MediaPlayer1.Mode = mpPlaying then begin
    MediaPlayer1.Stop;
  end;
end;

procedure TPBXRecordingsListGUI.MediaPlayer1Notify(Sender: TObject);
begin
  inherited;
(*
  CommonLib.MessageDlgXP_Vista('Got here');
  MediaPlayer1.Notify := true;
*)
end;


procedure TPBXRecordingsListGUI.MediaPlayer1Click(Sender: TObject; Button: TMPBtnType; var DoDefault: boolean);
begin
  case Button of
    btPlay:
      begin
        if LoadPlayerWithFile() then begin
          MediaPlayer1.EnabledButtons := [btStop, btPause];
          DoDefault := true;
        end else begin
          DoDefault := false;
        end;
      end;
    btStop:
      begin
        MediaPlayer1.Rewind;
        MediaPlayer1.EnabledButtons := [btPlay];
        DoDefault := true;
      end;
    btPause:
      begin
        MediaPlayer1.EnabledButtons := [btPlay, btPause, btStop];
        DoDefault := true;
      end;
  end;
end;

procedure TPBXRecordingsListGUI.grdMainDblClick(Sender: TObject);
begin
  if LoadPlayerWithFile() then begin
    MediaPlayer1.EnabledButtons := [btStop, btPause];
    MediaPlayer1.Play;
  end;
end;

function TPBXRecordingsListGUI.LoadPlayerWithFile: boolean;
var
  sFileName: string;
begin
  sFileName := AppEnv.CompanyPrefs.RecordingDirectory + '\' + qryMain.FieldByName('Reference').AsString + '.wav';
  if (not Empty((qryMain.FieldByName('Reference').AsString))) and FileExists(sFileName) then begin
    MediaPlayer1.Close;
    MediaPlayer1.FileName := sFileName;
    MediaPlayer1.Open;
    Result := true;
  end else begin
    CommonLib.MessageDlgXP_Vista('Could not Locate Recording File', mtError, [mbOK], 0);
    Result := false;
  end;
end;

procedure TPBXRecordingsListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  PBXRecordingsListGUI := nil;
end;

procedure TPBXRecordingsListGUI.FormShow(Sender: TObject);
var
  sTemplateFile: string;
begin
  inherited;
  sTemplateFile := AppEnv.CompanyPrefs.RecordingDirectory + '\' + 'template.wav';

  if not FileExists(sTemplateFile) then begin
    if not CreateNewWaveFile(sTemplateFile) then begin
      CommonLib.MessageDlgXP_Vista('Could not Create Template Wave file', mtError, [mbOK], 0);
      Exit;
    end;
  end;

  try
    MediaPlayer1.FileName := sTemplateFile;
    MediaPlayer1.Open;
    MediaPlayer1.EnabledButtons := [btPlay];
  except
  end;
end;

end.

