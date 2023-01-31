unit CustPaymentDevList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustPaymentList, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TCustPaymentDevListGUI = class(TCustPaymentListGUI)
    DNMSpeedButton1: TDNMSpeedButton;
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
  end;

implementation

uses BusObjPayments, CommonLib;

{$R *.dfm}

procedure TCustPaymentDevListGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  IterateProcno := 1;
  IterateSelectedRecords;
end;

procedure TCustPaymentDevListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  EnableMultiselect('');
end;

procedure TCustPaymentDevListGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
var
  CustPayments :TCustPayments;
begin
  inherited;
    if iterateprocno = 1 then begin
       CustPayments := TCustPayments.CreateWithNewConn(Self);
       try
          CustPayments.Load(qryMainPaymentID.asInteger);
          if CustPayments.count =0 then exit;
          if CustPayments.deleted then exit;
          CustPayments.connection.begintransaction;
          try
            CustPayments.Deleted := True;
            if not CustPayments.Save then begin
              CustPayments.connection.Rollbacktransaction;
              Exit;
            end;
            CustPayments.connection.Committransaction;
          except
            on E:Exception do begin
              CustPayments.connection.Rollbacktransaction;
            end;
          end;

       finally
        freeandnil(CustPayments);
       end;
    end;
end;
initialization
  RegisterClassOnce(TCustPaymentDevListGUI);

end.
