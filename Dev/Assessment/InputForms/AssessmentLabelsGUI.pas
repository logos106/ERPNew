unit AssessmentLabelsGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB, StdCtrls,
  Mask, DBCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel,
  kbmMemTable, wwdblook,
  DBAccess, MyAccess,ERPdbComponents, DataState, wwcheckbox, Menus, AdvMenus, MemDS, Grids, Wwdbigrd,
  Wwdbgrid, Shader, wwdbedit, Wwdotdot, Wwdbcomb, ImgList;

type
  TAssessmentLabelsGUI = class(TBaseInputGUI)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    tblMaster: TERPQuery;
    DSMaster: TDataSource;
    grdData: TwwDBGrid;
    tblMasterLabel: TWideStringField;
    tblMasterActive: TWideStringField;
    Bevel1: TBevel;
    tblMasterLabelId: TIntegerField;
    tblMasterOtherOption: TWideStringField;
    chkOtherOpt: TwwCheckBox;
    tblMasterCategory: TWideStringField;
    cboCategory: TwwDBComboBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;    
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
    function SaveData: Boolean;
  protected
  public
    { Public declarations }
  end;


implementation

uses
  FormFactory, DNMExceptions, CommonLib;

{$R *.dfm}

procedure TAssessmentLabelsGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TAssessmentLabelsGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TAssessmentLabelsGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      if tblMaster.Active then begin
        if not (tblMaster.State in [dsBrowse]) then begin
          tblMaster.Post;
          Notify;
        end;
        CloseQueries;
      end;

      OpenQueries;

      BeginTransaction;

      if KeyID = 0 then begin
        tblMaster.Append;
      end else begin
        EditNoAbort(tblMaster);
      end;


    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;  


procedure TAssessmentLabelsGUI.btnSaveClick(Sender: TObject);
begin
  inherited;
  if not SaveData then Exit;
  Close;
end;

function TAssessmentLabelsGUI.SaveData: Boolean;
begin
  Result := true;
  try
    if tblMaster.Active then begin
      if not (tblMaster.State in [dsBrowse]) then begin
        tblMaster.Post;
        Notify;
      end;
    end;
    CommitTransaction;
  except
    Result := false;
  end;
end;

initialization
  RegisterClassOnce(TAssessmentLabelsGUI);
  with FormFact do begin
    RegisterMe(TAssessmentLabelsGUI, 'TAssessmentLabelsListGUI_*=ID');
  end;
end.
