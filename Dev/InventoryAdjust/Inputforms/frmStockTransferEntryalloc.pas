unit frmStockTransferEntryalloc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmAllocation, DB, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, Shader, DNMSpeedButton, StdCtrls,
  wwcheckbox, wwdblook, Buttons, Wwdbigrd, Grids, Wwdbgrid, DNMPanel , busobjPQA, BaseFormForm;

type
  TfmStockTransferEntryalloc = class(TfmAllocation)
  private
  public
    Class Function DoBinBatchform(PQA :TPQA; Sender:TBaseForm; IsLocked:Boolean = False;openFormanyway:Boolean =False) :Boolean; override;
    Class Procedure getAllocationform(Sender:TBaseForm; var form:TfmAllocation); override;
  Protected
    Procedure CreateAllocObjects; override;
    Procedure LoadAllocObjects; override;
  end;


implementation

uses busobjstockTransferentry, CommonLib ;


{$R *.dfm}

{ TfmStockTransferEntryalloc }

procedure TfmStockTransferEntryalloc.CreateAllocObjects;
begin
  PQABatch:=TSTEPQABatch.create(Self);
  PQABins :=TSTEPQABins.create(Self);
  PQASN   :=TSTEPQASN.create(Self);

  PQABatch.PQA := fPQA;
  PQABins.PQA := fPQA;
  PQASN.PQA := fPQA;

  PQABatch.SQL:=  'Select * from tblstocktransferentrypqadetails where PQAType = '+QuotedStr(TPQABatch.pqadetailtype) +  ' and  PQAID = ' + IntToStr(PQA.ID);
  PQABins.SQL :=  'Select * from tblstocktransferentrypqadetails where PQAType = '+QuotedStr(TPQABins.pqadetailtype)  +  ' and  PQAID = ' + IntToStr(PQA.ID);
  PQASN.SQL   :=  'Select * from tblstocktransferentrypqadetails where PQAType = '+QuotedStr(TPQASn.pqadetailtype)    +  ' and  PQAID = ' + IntToStr(PQA.ID);
end;

class function TfmStockTransferEntryalloc.DoBinBatchform(PQA: TPQA; Sender: TBaseForm; IsLocked, openFormanyway: Boolean): Boolean;
begin
  Result := inherited DoBinBatchform(PQA,Sender);
end;

class procedure TfmStockTransferEntryalloc.getAllocationform(Sender: TBaseForm; var form: TfmAllocation);
begin
  inherited;
    form := TfmStockTransferEntryalloc(GetComponentByClassType(TfmStockTransferEntryalloc , False , Sender));

end;

procedure TfmStockTransferEntryalloc.LoadAllocObjects;
begin
  if isbatch  then TSTEPQABatch(PQABatch).Load;
  if isbin    then TSTEPQABins(PQAbins).Load;
  if issn     then TSTEPQASN(PQASn).Load;
end;

end.

