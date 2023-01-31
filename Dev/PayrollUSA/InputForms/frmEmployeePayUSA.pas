unit frmEmployeePayUSA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmEmployeePayFrm, DB, ImageScroll, ProgressDialog, MemDS, DBAccess,
  MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts,
  SelectionDialog, Menus, ExtCtrls, wwdbedit, Wwdotdot, Wwdbcomb,
  DNMSpeedButton, StdCtrls, wwcheckbox, wwdbdatetimepicker, Mask, DBCtrls,
  DNMPanel, AdvPicture, Shader, BusObjBase;

type
  TfmEmployeePayUSA = class(TfrmEmployeePay)
  private
    procedure W_4FormBeforeShow(Sender: TObject);
    procedure W_4FormSave(Sender: TObject);
  Protected
    Procedure AddSubforms;Override;
    procedure SetupActiveFrmBusObjs;Override;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure ShowSubFormOnMainbuttonclick(Sender: TObject; sFormClassName:String);Override;
    function PopupSubform(sFormClassName:String):boolean; Override;
  public
  end;

implementation

uses CommonLib, FormFactory, AppEnvironment, frmPayW_4, tcTypes, CommonFormLib;

{$R *.dfm}

{ TfmEmployeePayUSA }

procedure TfmEmployeePayUSA.AddSubforms;
begin
  inherited;
    if AppEnv.RegionalOptions.RegionType = rUSA then begin
      Newsubform('W-4' ,'TfmPayW_4'      );
    end;

end;

procedure TfmEmployeePayUSA.DoBusinessObjectEvent(const Sender: TDatasetBusObj;
  const EventType, Value: string);
begin
  inherited;
end;

function TfmEmployeePayUSA.PopupSubform(sFormClassName: String): boolean;
begin
  if sametext(sFormClassName, 'TfmPayW_4') then begin
    Result := True;
    Exit;
  end;
  Result := inherited PopupSubform(sFormClassName);
end;

procedure TfmEmployeePayUSA.SetupActiveFrmBusObjs;
begin
  inherited;
  if fSourceform.ClassName = 'TfmPayW_4' then begin
    with TfmPayW_4(fSourceForm) do begin
    end;
  end
end;

procedure TfmEmployeePayUSA.ShowSubFormOnMainbuttonclick(Sender: TObject; sFormClassName:String);
begin
  if sametext(sFormClassName, 'TfmPayW_4') then begin
    if OpenERPFormModal('TfmPayW_4', 0, W_4FormBeforeShow, False,W_4FormSave) = mrok then begin

    end;
    Exit;
  end;
  inherited;
end;
procedure TfmEmployeePayUSA.W_4FormBeforeShow(Sender: TObject);
begin
  if sender is TfmPayW_4 then begin
      TfmPayW_4(SendeR).TransConnection := TERPConnection(Pay.connection.connection);
      TfmPayW_4(SendeR).EmployeeId := Pay.EmployeeId;
  end;
end;
procedure TfmEmployeePayUSA.W_4FormSave(Sender: TObject);
begin

end;
initialization
  RegisterClassOnce(TfmEmployeePayUSA);
  FormFact.RegisterMe(TfmEmployeePayUSA, 'TfrmPaySummary1_*=PayID');
end.
