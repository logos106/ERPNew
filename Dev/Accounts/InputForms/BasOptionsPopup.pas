unit BasOptionsPopup;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 ??/??/?? 1.00.01  ???  Initial Version
 19/12/05 1.00.02  AL   Removed "Instance", added RegisterClass *Task306*
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwdblook, wwcheckbox, ExtCtrls, DB,  Buttons, DNMSpeedButton,
  wwclearbuttongroup, wwradiogroup, DNMPanel, ComCtrls,AdvOfficeStatusBar, BaseInputForm, MemDS,
  DBAccess, MyAccess,ERPdbComponents, DataState, SelectionDialog, AppEvnts, Menus, AdvMenus, Shader,
  ImgList, ProgressDialog;

type
  TfrmBASoptionsGUI = class(TBaseInputGUI)
    btnCompleted: TDNMSpeedButton;
    lblAccMethod: TLabel;
    btnClose: TDNMSpeedButton;
    lblClassTitle: TLabel;
    cboClassQry: TERPQuery;
    DNMPanel1: TDNMPanel;
    cboClass: TwwDBLookupCombo;
    Label1: TLabel;
    chkAllClass: TwwCheckBox;
    DNMPanel2: TDNMPanel;
    AccMethod: TwwRadioGroup;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cboClassQryClassID: TIntegerField;
    cboClassQryClassName: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure AccMethodChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure chkAllClassClick(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
  private
    { Private declarations }
    fsAccMethod: string;
    fsClassName: string;
    fbAll: boolean;
    fbISfirstReturn: boolean;
  public
    { Public declarations }
    property AccountMethod: string read fsAccMethod write fsAccMethod;
    property Department: string read fsClassName write fsClassName;
    property All: boolean read fbAll write fbAll;
    Property ISfirstReturn :boolean read fbISfirstReturn write fbISfirstReturn ;
    //Property ISfirstReturn :boolean read fbISfirstReturn write fbISfirstReturn;
  end;

implementation

uses  CommonLib, AppEnvironment, tcTypes, ReturnsBase, frmVATReturn;

{$R *.dfm}
                                                  
procedure TfrmBASoptionsGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;

  inherited;
end;

procedure TfrmBASoptionsGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    If fsAccMethod = '' then
      fsAccMethod := 'Accrual';
    AccMethod.Value := fsAccMethod;;
    cboClass.Text := fsClassName;
    chkAllClass.Checked := fbAll;
    if chkAllClass.Checked = true then begin
      cboClass.Enabled := false;
    end else begin
      cboClass.Enabled := true;
    end;
    AccMethod.Enabled := IsfirstReturn;
    lblAccMethod.Enabled := IsfirstReturn;
  finally
    EnableForm;
  end;  
end;

procedure TfrmBASoptionsGUI.AccMethodChange(Sender: TObject);
begin
  fsAccMethod := AccMethod.Value;
end;

procedure TfrmBASoptionsGUI.FormCreate(Sender: TObject);
begin
  fbISfirstReturn:= True;
  if (AppEnv.RegionalOptions.RegionType = rNZ) then begin
    Caption:= 'GST Options';
    TitleLabel.caption := 'GST Options';
  end;
  inherited;
  cboClassQry.Open;
end;

procedure TfrmBASoptionsGUI.btnCompletedClick(Sender: TObject);
var
  Form :TComponent;
begin
  form :=FindExistingComponent('TfmBASReturn');
  if not(assigned(Form)) then form := FindExistingComponent('TfmNZReturn');
  if not(assigned(Form)) then form := FindExistingComponent('TfmVATReturn');
  if not(assigned(Form))  then exit;

  if form is TReturnsBaseGUI then begin
      TReturnsBaseGUI(Form).Return.AccMethod:= fsAccMethod;
      If not TReturnsBaseGUI(Form).NoCashBasis then Begin
        cboClassQry.Locate('ClassName', fsClassName, [loCaseInsensitive]);
        TReturnsBaseGUI(Form).Return.ClassID := cboClassQry.FieldByName('ClassID').AsInteger;
        if TReturnsBaseGUI(Form).Return.ClassID = 0 then fbAll := true;
        TReturnsBaseGUI(Form).Return.AllClass := fbAll;
        if TReturnsBaseGUI(Form).BtnRefresh.Enabled then TReturnsBaseGUI(Form).BtnRefresh.Click;
      end else begin
        TReturnsBaseGUI(Form).Return.Canceldb;
      end;
      Self.Close;
  end else if form is  TfmVATReturn then begin
     TfmVATReturn(Form).VATReturn.AccMethod := fsAccMethod;
      cboClassQry.Locate('ClassName', fsClassName, [loCaseInsensitive]);
      TfmVATReturn(Form).VATReturn.ClassID := cboClassQry.FieldByName('ClassID').AsInteger;
      if TfmVATReturn(Form).VATReturn.ClassID = 0 then fbAll := true;
      TfmVATReturn(Form).VATReturn.AllClass := fbAll;
      if (TfmVATReturn(Form).VATReturn.AccMethod= 'Cash') then begin
        TfmVATReturn(Form).PrepareCashBasis;
        If TfmVATReturn(Form).NoCashBasis then Begin
          Self.Close;
          Exit;
        end;
        TfmVATReturn(Form).lblMethod.caption :=  'Accounting Method Cash';
      end else begin
        TfmVATReturn(Form).lblMethod.caption :=  'Accounting Method Non-Cash (Accruals)';
      end;
      if TfmVATReturn(Form).BtnRefresh.Enabled then TfmVATReturn(Form).BtnRefresh.Click;
      Self.Close;
  end;
  (* If Assigned(FindExistingComponent('TBASReportGUI')) then
    with TBASReportGUI(FindExistingComponent('TBASReportGUI')) do begin
      if (AppEnv.RegionalOptions.RegionType = rNZ) then begin
        tblMasterNZAccMethod.AsString := fsAccMethod;
        If not NoCashBasis then Begin
          cboClassQry.Locate('ClassName', fsClassName, [loCaseInsensitive]);
          tblMasterNZClassID.AsInteger := cboClassQry.FieldByName('ClassID').AsInteger;
          if tblMasterNZClassID.AsInteger = 0 then fbAll := true;
          tblMasterNZAllClass.AsBoolean := fbAll;
          if BtnRefresh.Enabled then BtnRefresh.Click;
        end else begin
          tblMasterNZ.Cancel;
        end;
      end
      else begin
        tblMasterAccMethod.AsString := fsAccMethod;
        If not NoCashBasis then Begin
          cboClassQry.Locate('ClassName', fsClassName, [loCaseInsensitive]);
          tblMasterClassID.AsInteger := cboClassQry.FieldByName('ClassID').AsInteger;
          if tblMasterClassID.AsInteger = 0 then fbAll := true;
          tblMasterAllClass.AsBoolean := fbAll;
          if BtnRefresh.Enabled then BtnRefresh.Click;
        end else begin
          tblMaster.Cancel;
        end;
      end;
      Self.Close;
    end;

  If Assigned(FindExistingComponent('TfmVATReturn')) then
    with TfmVATReturn(FindExistingComponent('TfmVATReturn')) do begin
      tblMasterAccMethod.AsString := fsAccMethod;
      cboClassQry.Locate('ClassName', fsClassName, [loCaseInsensitive]);
      tblMasterClassID.AsInteger := cboClassQry.FieldByName('ClassID').AsInteger;
      if tblMasterClassID.AsInteger = 0 then fbAll := true;
      tblMasterAllClass.AsBoolean := fbAll;
      if (tblMasterAccMethod.AsString = 'Cash') then begin
        PrepareCashBasis;
        If NoCashBasis then Begin
          Self.Close;
          Exit;
        end;
        lblMethod.caption :=  'Accounting Method Cash';
      end else begin
        lblMethod.caption :=  'Accounting Method Non-Cash (Accruals)';
      end;
      if BtnRefresh.Enabled then BtnRefresh.Click;
      Self.Close;
    end; *)
end;

procedure TfrmBASoptionsGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfrmBASoptionsGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;
  if chkAllClass.Checked = true then begin
    cboClass.Enabled := false;
  end else begin
    cboClass.Enabled := true;
  end;
  fbAll := chkAllClass.Checked;
end;

procedure TfrmBASoptionsGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  fsClassName := cboClass.Text;
end;

initialization
  RegisterClassOnce(TfrmBASoptionsGUI);

end.

