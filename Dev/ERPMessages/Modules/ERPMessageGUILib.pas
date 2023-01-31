unit ERPMessageGUILib;

interface

Uses Classes;




Procedure ShowERPTip(Const tipID:Integer =0);
Procedure ShowPopups(ShowViewed :Boolean);


implementation



uses
  frmERPMessageTip, frmERPMessagePopup, ERPMessageLib, ERPMessageTypes,
  CommonLib, sysutils, dialogs, tcConst;

Procedure ShowPopups(ShowViewed :Boolean);
var
  s, sh:String;
begin
  Try
    s:= NextERPMessage(mtpopup,sh,  False, ShowViewed , 0, iif(devmode , ERPPopupIntervalDevmode , ERPPopupInterval));
    if s='' then exit;
    ShowERPpopup(ShowViewed);
  Except
    on E:Exception do begin
        if devmode then MessageDlgXP_Vista('The ERP Uitls Service is not updated.  Please restart the Service.' +E.message, mtWarning, [mbOK], 0);
    end;
  End;
end;

Procedure ShowERPTip(Const tipID:Integer =0);
var
  form :TfmERPMessageTip;
  s, sh:String;
begin
  try
    s:= NextERPMessage(mtTip,sh,  False, true,TipID);
    if s='' then exit;

    form := TfmERPMessageTip(getcomponentbyclassname('TfmERPMessageTip' , true));
    if not(Assigned(form)) then exit;
    form.tipId := TipId;
    form.showModal;
  Except
    on E:Exception do begin
        if devmode then MessageDlgXP_Vista('The ERP Uitls Service is not updated.  Please restart the Service.' +E.message, mtWarning, [mbOK], 0);
    end;
  End;
end;



end.
