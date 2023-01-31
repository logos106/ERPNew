unit frmLetterCorrespondenceReference;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmCorrespondenceReference, ActnList, DB, ProgressDialog, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState,
  SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, wwcheckbox, Mask, wwdbedit,
  DNMSpeedButton, Shader, DNMPanel, BusObjCorrespondenceReference, DBCtrls;

type
  TfmLetterCorrespondenceReference = class(TfmCorrespondenceReference)
    procedure FormCreate(Sender: TObject);
  private
    LetterCorrespondenceReference: TLetterCorrespondenceReference;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses
  BusObjBase, FormFactory;

procedure TfmLetterCorrespondenceReference.FormCreate(Sender: TObject);
begin
  inherited;
  LetterCorrespondenceReference:= TLetterCorrespondenceReference.Create(self);
  LetterCorrespondenceReference.Connection := TMyDacDataConnection.Create(LetterCorrespondenceReference);
  LetterCorrespondenceReference.Connection.MyDacConnection := MyConnection;
  LetterCorrespondenceReference.BusObjEvent := DoBusinessObjectEvent;
  CorrespondenceReference := LetterCorrespondenceReference;
end;

initialization
  RegisterClass(TfmLetterCorrespondenceReference);
  with FormFact do begin
    // register all columns on course list form to open this form on DblClick
    RegisterMe(TfmLetterCorrespondenceReference, 'TLetterCorrespondenceReferenceListGUI_*=Id');
    //RegisterControl(TfmLetterCorrespondenceReference, 'Letter_cboCorrespondencetype=ID');
  end;

end.
