unit frmAllocationSrjobnoExtender;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, DNMSpeedButton, StdCtrls, wwdblook, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, ExtCtrls, DNMPanel, DB, DBAccess, MyAccess,ERPdbComponents,
  MemDS, SelectionDialog, Menus;

type
  TfmAllocationSrjobnoExtender = class(TBaseForm)
    DNMPanel3: TDNMPanel;
    DNMPanel4: TDNMPanel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    lblSelect: TLabel;
    QrySerialNumbers: TERPQuery;
    QrySerialNumbersSerialNo: TWideStringField;
    QrySerialNumbersDepartmentID:TIntegerField;
    dsSerialNumbers: TDataSource;
    grdmain: TwwDBGrid;
    lblNote: TLabel;
    cmdNew: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure grdmainKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdNewClick(Sender: TObject);
  private
    fiproductId: Integer;
    fOnListSelect: TNotifyEvent;
    fsSearchData:String;
    Procedure DoSearch;
  public
    Property ProductID :Integer read fiproductId write fiProductID;
    Property OnListSelect :TNotifyEvent REad fOnListSelect Write fOnListSelect;
    Class Procedure SerialNoList(AOwner:TComponent; fiProductID:Integer ;OnSelect :TNotifyEvent=nil);
  end;


implementation

uses CommonLib, frmAllocation, busobjPQA, FastFuncs, BaseInputForm;

{$R *.dfm}

procedure TfmAllocationSrjobnoExtender.FormShow(Sender: TObject);
begin
  inherited;
  if (Assigned(Self.Owner)) then begin
    if (Self.Owner is TfmAllocation) then begin
      Self.Top      := TfmAllocation(Self.Owner).top;
      Self.Left     := TfmAllocation(Self.Owner).Left+TfmAllocation(Self.Owner).Width;
      Self.height   := TfmAllocation(Self.Owner).height;
      Self.Color    := TfmAllocation(Self.Owner).color;
      //grdmain.Height:= btnCompleted.top - 10;
      QrySerialNumbers.connection :=TfmAllocation(Self.Owner).PQA.Connection.connection;
    end;
  end;
  With QrySerialNumbers do begin
    if active then close;
    SQL.clear;
    SQL.add( 'SELECT ClassId  departmentID, Serialno FROM tblSerialnumbers ' +
                    ' where (ifnull(ProductId,0) = ' +IntToStr(ProductID) +' or ifnull(ProductId,0) = 0 )' +
                    ' and Active = "T" ' +
                    ' and Serialno not in (Select ifnull(Value,"") from tblPQADEtails where tblPQADEtails.PQAType =' + QuotedStr(TPQASN.PQADetailtype)+ ' )'+
                    ' Order by Serialno');
    open;
  end;
end;

procedure TfmAllocationSrjobnoExtender.FormCreate(Sender: TObject);
begin
  inherited;
  fiproductId := 0;
end;

class procedure TfmAllocationSrjobnoExtender.SerialNoList(
  AOwner: TComponent; fiProductID:Integer ;OnSelect: TNotifyEvent);
var
  Form :TComponent;
begin
    form := GetComponentByClassName('TfmAllocationSrjobnoExtender' , true, AOwner , False);
    if not assigned(Form) then exit;
    TfmAllocationSrjobnoExtender(Form).OnListSelect  := Onselect;
    TfmAllocationSrjobnoExtender(Form).ProductID := fiProductID;
    TfmAllocationSrjobnoExtender(Form).Showmodal;
end;

procedure TfmAllocationSrjobnoExtender.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmAllocationSrjobnoExtender.btnCompletedClick(Sender: TObject);
begin
  inherited;
    if assigned(fOnListSelect) then fOnListSelect(grdmain);
    Self.Close;
end;

procedure TfmAllocationSrjobnoExtender.grdmainDblClick(Sender: TObject);
begin
  inherited;
    if assigned(fOnListSelect) then fOnListSelect(grdmain);
    Self.Close;
end;

procedure TfmAllocationSrjobnoExtender.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
end;

procedure TfmAllocationSrjobnoExtender.FormPaint(Sender: TObject);
begin
//  inherited;

end;


procedure TfmAllocationSrjobnoExtender.DoSearch;
begin

  if   fsSearchData  = '' then exit;
  QrySerialNumbers.Locate('Serialno', fsSearchData , [loCaseInsensitive, loPartialKey]);
  grdmain.UnselectAll;
  grdmain.SelectRecord;
end;

procedure TfmAllocationSrjobnoExtender.grdmainKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  function SearchCharpressed:Boolean;
  begin
      result := ((Key>=32) and (Key<= 126)) 
  end;
begin
  inherited;
  if (Key = VK_DELETE) and (Shift = [ssAlt]) then begin
    fsSearchData := '';
    QrySerialNumbers.First;
  end else if SearchCharpressed then begin 
    fsSearchData:=fsSearchData +Chr(Key);
    DoSearch;
  end;

end;

procedure TfmAllocationSrjobnoExtender.cmdNewClick(Sender: TObject);
var
  Form : TComponent;
  bm:Tbookmark;
begin
  inherited;
  Form := GetComponentByClassName('TfmSerialjobNumbers');
  if Assigned(Form) then
      TBaseInputGUI(Form).showmodal;
      try
        bm:= QrySerialNumbers.getBookmark;
        try
          if QrySerialNumbers.active then QrySerialNumbers.close;
          QrySerialNumbers.open;
        finally
            QrySerialNumbers.Gotobookmark(bm);
            QrySerialNumbers.Freebookmark(bm);
        end;
      Except
          // kill the exception if book mark caused exception
      end;


end;

initialization
  RegisterClassOnce(TfmAllocationSrjobnoExtender);

end.
