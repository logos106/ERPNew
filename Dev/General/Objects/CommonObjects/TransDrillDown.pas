unit TransDrillDown;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 09/08/05 1.00.01  DSP  Creates the appropiate form to match the transaction
                        type label passed, and populates it for the specified
                        transaction number.
 23/08/05 1.00.02  DSP  Added 'Refund' to TransTypeList.

}

interface

uses
  BaseInputForm;

type
  TTransDrillDown = class(TObject)
  private
    FDetailForm: TBaseInputGUI;
    function GetClassName(const LabelName: string): string;
  public
    constructor Create;
    function Execute(const LabelName: string; const TransID: integer; const ModalForm: boolean = false): boolean;
    property DetailForm: TBaseInputGUI read FDetailForm;
  end;

  TTransRec = record
    LabelName: string;
    ClassName: string;
  end;

implementation

uses
  Forms, SysUtils, Dialogs, BaseClassFuncs, FastFuncs, CommonLib, CommonDbLib,
  Controls;

const
  cMaxTransTypes = 11;
  TransTypeList: array[1..cMaxTransTypes] of TTransRec =
    ((LabelName: 'Cash Sale'; ClassName: 'TCashSaleGUI'),
    (LabelName: 'Cheque'; ClassName: 'TfmCheque'),
    (LabelName: 'Cheque Deposit'; ClassName: 'TfmCheque'),
    (LabelName: 'Customer Payment'; ClassName: 'TfmCustPayments'),
    (LabelName: 'Customer Prepayment'; ClassName: 'TfmCustPrepayments'),
    (LabelName: 'Deposit Entry'; ClassName: 'TDepositEntryGUI'),
    (LabelName: 'Prepayment'; ClassName: 'TfmCustPrepayments'),
    (LabelName: 'Refund'; ClassName: 'TRefundGUI'),
    (LabelName: 'Supplier Payment'; ClassName: 'TfmSuppPayments'),
    (LabelName: 'Supplier Prepayment'; ClassName: 'TfmSuppPrepayments'),
    (LabelName: 'POS Cash Sale'; ClassName: 'TPOSCashSaleGUI'));

constructor TTransDrillDown.Create;
begin
  inherited; 
  FDetailForm := nil;
end;

function TTransDrillDown.Execute(const LabelName: string; const TransID: integer;
  const ModalForm: boolean = false): boolean;
var
  ClassName: string;
begin
  Result := false;
  ClassName := GetClassName(LabelName);

  if ClassName <> '' then begin
    FDetailForm := GetBaseInputByClassName(ClassName, true);

    if Assigned(DetailForm) then begin
      if DetailForm.KeyID > 0 then begin
        { form was already open .. }
        if fsModal in DetailForm.FormState then DetailForm.ModalResult := mrCancel
        else DetailForm.Close;
        Application.ProcessMessages;
        if FormStillOpen(ClassName) then
          exit;
        FDetailForm := GetBaseInputByClassName(ClassName, true);
        if not Assigned(DetailForm) then
          exit;
      end;



      DetailForm.KeyID := TransID;
      Application.ProcessMessages;

      if ModalForm and (not DetailForm.Visible) then begin
        DetailForm.Position := poScreenCenter;
        DetailForm.ShowModal;
      end else begin
        DetailForm.FormStyle := fsMDIChild;
        DetailForm.BringToFront;
      end;

      Result := true;
    end;
  end;

  if Result = false then CommonLib.MessageDlgXP_Vista('No information is available for this Transaction Type', mtInformation, [mbOK], 0);
end;

function TTransDrillDown.GetClassName(const LabelName: string): string;
var
  TransIndex: integer;
  FoundMatch: boolean;
begin
  FoundMatch := false;
  TransIndex := Low(TransTypeList);

  while (TransIndex <= High(TransTypeList)) and (FoundMatch = false) do begin
    if Sysutils.SameText(LabelName, TransTypeList[TransIndex].LabelName) then FoundMatch := true
    else Inc(TransIndex);
  end;

  if FoundMatch then Result := TransTypeList[TransIndex].ClassName
  else Result := '';
end;

end.
