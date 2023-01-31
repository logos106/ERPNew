unit RollaBlindColourData;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 18/05/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseRollaBlindInput, DB, MemDS, DBAccess, MyAccess, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts,  DNMSpeedButton, ExtCtrls,
  DNMPanel, StdCtrls, wwclearbuttongroup, wwradiogroup, wwdblook, Grids,
  Wwdbigrd, Wwdbgrid, DBCtrls;

type
  TRollaBlindColourDataGUI = class(TBaseRollaBlindInputGUI)
    qryProfileType: TMyQuery;
    qryProfileColours: TMyQuery;
    grpStandard: TwwRadioGroup;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    dsProfileType: TDataSource;
    qryProfileTypeProfileType: TStringField;
    Label1: TLabel;
    Label2: TLabel;
    dsProfileColours: TDataSource;
    qryProfileColoursColourCode: TStringField;
    lstProfileType: TDBLookupListBox;
    lstColourCode: TDBLookupListBox;
    Label5: TLabel;
    cboProfileType: TwwDBLookupCombo;
    Label6: TLabel;
    cboColourCode: TwwDBLookupCombo;
    qryColourCode: TMyQuery;
    StringField1: TStringField;
    procedure FormShow(Sender: TObject);
    procedure lstProfileTypeClick(Sender: TObject);
    procedure lstColourCodeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}

procedure TRollaBlindColourDataGUI.FormShow(Sender: TObject);
begin
  OpenQueries;
  qryProfileColours.Close;
  qryProfileColours.SQL.Text := 'SELECT * FROM tblrollaprofilecolours WHERE ProfileType = ''' + qryProfileType.FieldByName('ProfileType').AsString + ''' GROUP BY ColourCode';
  qryProfileColours.Open;
  inherited;
end;

procedure TRollaBlindColourDataGUI.lstProfileTypeClick(Sender: TObject);
begin
  inherited;
  qryProfileColours.Close;
  qryProfileColours.SQL.Text := 'SELECT * FROM tblrollaprofilecolours WHERE ProfileType = ''' + qryProfileType.FieldByName('ProfileType').AsString + ''' GROUP BY ColourCode';
  qryProfileColours.Open;
end;

procedure TRollaBlindColourDataGUI.lstColourCodeClick(Sender: TObject);
begin
  inherited;
  qryMain.Locate('ProfileType;ColourCode', VarArrayOf([lstProfileType.SelectedItem, lstColourCode.SelectedItem]), [loCaseInsensitive]);
end;

initialization
  RegisterClassOnce(TRollaBlindColourDataGUI);
finalization
  UnRegisterClass(TRollaBlindColourDataGUI);
end.
