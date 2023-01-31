unit frmAppointmentCancellationReasons;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 01/02/06  1.00.00 IJB  Initial version.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, (*frmSimpleTypes, *)DB, MemDS, DBAccess, MyAccess,ERPdbComponents, DataState,
  SelectionDialog, AppEvnts,  Grids, Wwdbigrd, Wwdbgrid, StdCtrls,
  Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, Menus, AdvMenus, frmSimpleTypes,
  Shader, ImgList, ProgressDialog;

type
  TfmAppointmentCancellationReasons = class(TfmSimpleTypes)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAppointmentCancellationReasons: TfmAppointmentCancellationReasons;

implementation

uses Forms, CommonLib, tcconst;

{$R *.dfm}

procedure TfmAppointmentCancellationReasons.FormCreate(Sender: TObject);
begin
  TypeToShow:= SimpleTypes_AppointmentCancellationType;
  inherited;
  //TitleLabel.Caption := Caption;
  //
end;

procedure TfmAppointmentCancellationReasons.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

initialization

  RegisterClassOnce(TfmAppointmentCancellationReasons);

end.
