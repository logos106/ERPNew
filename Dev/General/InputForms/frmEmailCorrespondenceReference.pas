unit frmEmailCorrespondenceReference;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmCorrespondenceReference, ActnList, DB, ProgressDialog, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState,
  SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, wwcheckbox, Mask, wwdbedit,
  DNMSpeedButton, Shader, DNMPanel, BusObjCorrespondenceReference, DBCtrls;

type
  TfmEmailCorrespondenceReference = class(TfmCorrespondenceReference)
    procedure FormCreate(Sender: TObject);
  private
    EmailCorrespondenceReference: TEmailCorrespondenceReference;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  BusObjBase, FormFactory;

procedure TfmEmailCorrespondenceReference.FormCreate(Sender: TObject);
begin
  inherited;
  EmailCorrespondenceReference:= TEmailCorrespondenceReference.Create(self);
  EmailCorrespondenceReference.Connection := TMyDacDataConnection.Create(EmailCorrespondenceReference);
  EmailCorrespondenceReference.Connection.MyDacConnection := MyConnection;
  EmailCorrespondenceReference.BusObjEvent := DoBusinessObjectEvent;
  CorrespondenceReference := EmailCorrespondenceReference;
end;

initialization
  RegisterClass(TfmEmailCorrespondenceReference);
  with FormFact do begin
    // register all columns on course list form to open this form on DblClick
    RegisterMe(TfmEmailCorrespondenceReference, 'TEmailCorrespondenceReferenceListGUI_*=Id');
    //RegisterControl(TfmEmailCorrespondenceReference, 'Email_cboCorrespondencetype=ID');
  end;


end.
