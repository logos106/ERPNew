unit frmStockAdjustEntryalloc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmAllocation, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts, Shader, StdCtrls,
  wwdblook, Buttons, Wwdbigrd, Grids, Wwdbgrid, DNMSpeedButton, ExtCtrls,
  DNMPanel, wwcheckbox, busobjpqa, baseformform, ImgList, ProgressDialog;

type
  TfmStockAdjustEntryalloc = class(TfmAllocation)
    procedure btncloseClick(Sender: TObject);
  private
  public
    Class Function DoBinBatchform(PQA :TPQA; Sender:TBaseForm; IsLocked:Boolean = False;openFormanyway:Boolean =False) :Boolean; override;
    Class Procedure getAllocationform(Sender:TBaseForm; var form:TfmAllocation); override;
  Protected
    Procedure CreateAllocObjects; override;
    Procedure LoadAllocObjects; override;
    Function SAAllocationTables:String ; Override;
  end;

implementation

uses CommonLib, BusobjStockAdjustEntry, ProductQtyLib;


{$R *.dfm}

procedure TfmStockAdjustEntryalloc.CreateAllocObjects;
begin
  PQABatch:=TStockAdjustEntryPQABatch.create(Self);
  PQABins :=TStockAdjustEntryPQABins.create(Self);
  PQASN   :=TStockAdjustEntryPQASN.create(Self);

  PQABatch.PQA := fPQA;
  PQABins.PQA := fPQA;
  PQASN.PQA := fPQA;

  PQABatch.SQL:=  'Select * from ' + ReadPQADetailTablename + ' where PQAType = '+QuotedStr(TPQABatch.pqadetailtype) +  ' and  PQAID = ' + IntToStr(PQA.ID);
  PQABins.SQL :=  'Select * from ' + ReadPQADetailTablename + ' where PQAType = '+QuotedStr(TPQABins.pqadetailtype)  +  ' and  PQAID = ' + IntToStr(PQA.ID);
  PQASN.SQL   :=  'Select * from ' + ReadPQADetailTablename + ' where PQAType = '+QuotedStr(TPQASn.pqadetailtype)    +  ' and  PQAID = ' + IntToStr(PQA.ID);
end;


procedure TfmStockAdjustEntryalloc.btncloseClick(Sender: TObject);
begin
    PQABatch.PostDB;
    PQAbins.PostDB;
    PQASn.PostDB;
    PQA.Refreshall;
    PQABatch.dirty := False;
    PQAbins.dirty := FAlse;
    PQASN.dirty := False;
    //inherited; : this does the validation of the qty. for stock adjustment it doesn't need to
    Self.close;
end;

procedure TfmStockAdjustEntryalloc.LoadAllocObjects;
begin
  if isbatch  then TStockAdjustEntryPQABatch(PQABatch).Load;
  if isbin    then TStockAdjustEntryPQABins(PQAbins).Load;
  if issn     then TStockAdjustEntryPQASN(PQASn).Load;
end;

function TfmStockAdjustEntryalloc.SAAllocationTables: String;
begin
  REsult := AllocationTables(ReadPQAtablename ,  ReadPQADetailTablename);
end;

class function TfmStockAdjustEntryalloc.DoBinBatchform(PQA: TPQA;Sender: TBaseForm; IsLocked :Boolean = False;openFormanyway:Boolean =False): Boolean;
begin
  Result := inherited DoBinBatchform(PQA,Sender);
end;

class procedure TfmStockAdjustEntryalloc.getAllocationform(Sender: TBaseForm; var form: TfmAllocation);
begin
    form := TfmStockAdjustEntryalloc(GetComponentByClassType(TfmStockAdjustEntryalloc , False , Sender));
end;

end.
