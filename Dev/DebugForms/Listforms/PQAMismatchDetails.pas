unit PQAMismatchDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TPQAMismatchDetailsGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainPQAID: TIntegerField;
    qryMainTransLineID: TIntegerField;
    qryMainTransType: TWideStringField;
    qryMainTransDate: TDateTimeField;
    qryMainAlloctype: TWideStringField;
    qryMainIsBO: TWideStringField;
    qryMainQty: TFloatField;
    qryMainUOMQty: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainUOMMultiplier: TFloatField;
    qryMainUOMID: TIntegerField;
    qryMainDepartmentID: TIntegerField;
    qryMainProductID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainTransID: TLargeintField;
    qryMainReserved: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainMatrixRef: TWideMemoField;
    btndelete: TDNMSpeedButton;
    procedure btndeleteClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
  private
    fiTransLineId: Integer;
    fiTransId: Integer;
    fsTranstype: STring;

    { Private declarations }
  public
    Property TransId     :Integer read fiTransId      write fiTransId;
    Property TransLineId :Integer read fiTransLineId  write fiTransLineId;
    Property Transtype   :STring  read fsTranstype    write fsTranstype;

    Procedure RefreshQuery;override;
  end;


implementation



uses CommonLib, CommonDbLib;
{$R *.dfm}

{ TPQAMismatchDetailsGUI }


procedure TPQAMismatchDetailsGUI.btndeleteClick(Sender: TObject);
var
  st:TStringList;
begin
  inherited;
  st:= TStringlist.create;
  try
    st.add('insert ignore into erpfix_pqa_fixed '+
            ' (`GlobalRef`, `PQAID`, `TransLineID`, `TransType`, `TransDate`, `Alloctype`, `IsBO`, `Qty`, `UOMQty`, `UOM`, `UOMMultiplier`, `UOMID`, `DepartmentID`, `ProductID`, `ProductName`, `Active`, `TransID`, `Reserved`, `msTimeStamp`, `MatrixRef`)'+
            ' Select `GlobalRef`, `PQAID`, `TransLineID`, `TransType`, `TransDate`, `Alloctype`, `IsBO`, `Qty`, `UOMQty`, `UOM`, `UOMMultiplier`, `UOMID`, `DepartmentID`, `ProductID`, `ProductName`, `Active`, `TransID`, `Reserved`, `msTimeStamp`, `MatrixRef` '+
            ' from tblPQa where PQAId = ' +inttostr(QrymainPQAId.asInteger)+';');
    st.add('delete from tblPQa where PQAId = ' +inttostr(QrymainPQAId.asInteger)+';');
    ExecuteSQL(st.text);
    RefreshQuery;
  finally
    freeandnil(st);
  end;
end;

procedure TPQAMismatchDetailsGUI.grdMainDblClick(Sender: TObject);
begin
//  inherited;
  if MessageDlgxp_vista('Do You Wish To Delete this PQA record?', mtConfirmation, [mbYes, mbNo], 0) = mryes then
    btndelete.Click;
end;

procedure TPQAMismatchDetailsGUI.RefreshQuery;
begin
  closedb(Qrymain);
  Qrymain.Parambyname('TransID').asInteger := transId;
  Qrymain.Parambyname('TranslineID').asInteger := TransLineID;
  Qrymain.Parambyname('transtype').asString := transtype;
  inherited;

end;
initialization
  RegisterClassOnce(TPQAMismatchDetailsGUI);

end.

