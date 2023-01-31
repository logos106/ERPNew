unit ERPChangesBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ERPMessages, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,
  CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList,
  AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TERPChangesBaseGUI = class(TERPMessagesGUI)
    qryMainClientCode: TWideStringField;
    qryMainEstimatedHrs: TFloatField;
    qryMainPercentageDone: TFloatField;
    cmdEmail: TDNMSpeedButton;
    procedure btnPhoneClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdEmailClick(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
    function GetReportTypeID: integer; Override;
    Function Email_subject :String;Override;
    Function Email_body    :String;Override;
  public
  end;


implementation

uses ERPMessageTypes, CommonLib, CommonFormLib, DbSharedObjectsObj, tcDataUtils,
  ERPLib, tcConst;

{$R *.dfm}
Function TERPChangesBaseGUI.Email_subject :String;
begin
  REsult := 'Updated List of Additions/Changes';
end;
Function TERPChangesBaseGUI.Email_body    :String;
begin
  REsult := 'Please find Attached the Updated List of Additions/Changes that You have Requested. '+NL+NL+
            'These can Also be Viewed in TrueERP Under the "Show Me" Button on the Main Menu Screen';
end;

procedure TERPChangesBaseGUI.btnPhoneClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TERPChangesBaseGUI.FormCreate(Sender: TObject);
begin
  inherited;
  if IsERPCustomEnabled  then begin
    EnableMultiSelect('Select Items to Email');
    cmdEmail.enabled := True;
  end else begin
    cmdEmail.enabled := False;
  end;
end;
function TERPChangesBaseGUI.GetReportTypeID: integer;
begin
       if Tasktype =ERPMESSAGE_Website then result := TemplateTypeID('ERP Web Changes')
  else if Tasktype=ERPMESSAGE_Bug      then result := TemplateTypeID('ERP Changes')
  else if Tasktype=ERPMESSAGE_Tablet   then result := TemplateTypeID('Tablet Changes')
  else result := 0;
end;

procedure TERPChangesBaseGUI.cmdEmailClick(Sender: TObject);
var
  fsIds:String;
//  fsClientIDs:String;
  Qry : TERPQuery;
begin
  inherited;
  if grdmain.SelectedList.Count =0 then begin
    MessageDlgXP_vista('Please Choose The entries to be Emailed', mtInformation, [mbOK], 0);
    Exit;
  end;
  fsIds:= SelectedIds('ID');
  if fsIds = '' then begin
    MessageDlgXP_vista('Please Choose The entries to be Emailed', mtInformation, [mbOK], 0);
    Exit;
  end;




  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Qrymain.Connection);
  try
    Qry.sql.text := 'Select Distinct clientId , clientCode , Email '+
                    ' from tblclients where ifnull("clientCode", "")<> "" and  '+
                    ' clientCode in (Select distinct clientCode  '+
                                      ' from erpdocumentaion.tbltasks  '+
                                      ' where ifnull("clientCode", "")<> ""  '+
                                      ' and ID in (' + fsIds+')) order by clientCode';
    Qry.open;
    if Qry.recordcount =0 then begin
      MessageDlgXP_vista('None of the Selected Records are linked to Any customer.'+NL+NL+'Please Choose Entries Linked to Customer to Email.', mtInformation, [mbOK], 0);
      Exit;
    end;
    Qry.first;
    ReportSQLSupplied := false;
    While Qry.EOF = False do begin
      if Qry.fieldbyname('Email').asString <> '' then begin
        AddresstoEmail := Qry.fieldbyname('Email').asString;
        TemplateSQL := '~|||~Where T.clientCode =  ' + Quotedstr(Qry.fieldbyname('clientCode').asString) +' and T.Id in (' +fsIds+') Order by T.msTimeStamp';
        LoadTemplate(False,False , False, true);
      end;
      Qry.Next;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;


end;

procedure TERPChangesBaseGUI.SetGridColumns;
begin
  inherited;
end;

initialization
  RegisterClassOnce(TERPChangesBaseGUI);

end.
