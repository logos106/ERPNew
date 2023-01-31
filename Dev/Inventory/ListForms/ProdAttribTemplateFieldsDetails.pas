unit ProdAttribTemplateFieldsDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  MatrixObj;

type
  TProdAttribTemplateFieldsDetailsGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainGroupname: TWideStringField;
    qryMainPAG_ID: TIntegerField;
    qryMainSeqno: TIntegerField;
    qryMainName: TWideStringField;
    qryMainValue: TWideStringField;
    qryMainIsX: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainXAttribName: TWideStringField;
    qryMainYAttribName: TWideStringField;
    qryMainTemplatefieldName: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
  private
    fMatrixsale : TMatrixsale;
    function Matrixsale :TMatrixsale;
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CommonDbLib;

{$R *.dfm}
{ TProdAttribTemplateFieldsDetailsGUI }

procedure TProdAttribTemplateFieldsDetailsGUI.FormCreate(Sender: TObject);
begin
  fMatrixsale := nil;
  Matrixsale.MakeMatrixTables;
  with ScriptMain do begin
    SQL.clear;
    SQL.Add( 'alter table  ' + Matrixsale.Matrixtablename+'names  Add column XAttribName varchar(255);');
    SQL.Add( 'alter table  ' + Matrixsale.Matrixtablename+'names  Add column YAttribName varchar(255);');
    SQL.Add( 'alter table  ' + Matrixsale.Matrixtablename+'names  Add column Active enum("T","F") default "T";');
    Execute;
  end;
  closedb(Qrymain);
  Qrymain.SQL.text :='select * from ' + Matrixsale.Matrixtablename+'names order by PAG_ID, Seqno';
  inherited;
end;

procedure TProdAttribTemplateFieldsDetailsGUI.FormDestroy(Sender: TObject);
begin
  FreeandNil(fMatrixsale);
  inherited;
end;

function TProdAttribTemplateFieldsDetailsGUI.Matrixsale: TMatrixsale;
begin
  if fMatrixsale = nil then begin
    fMatrixsale := TMatrixsale.create(Self);
  end;
  result := fMatrixsale;
end;

procedure TProdAttribTemplateFieldsDetailsGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  if QrymainSeqno.asInteger =0 then
        QrymainTemplatefieldName.asString :=    'xName'
  else  QrymainTemplatefieldName.asString :=    'ExValue' + trim(Inttostr(QrymainSeqno.asInteger));
end;

procedure TProdAttribTemplateFieldsDetailsGUI.RefreshQuery;
begin
  closeDB(Qrymain);
  Matrixsale.EmptyTables;
  with TempMyquery do try
    SQL.add('select PAG.pag_id as PAG_ID, PAG.Name as NAme from tblproductattributegroups PAG ');
    open;
    if recordcount >0 then begin
      first;
      while Eof = False do begin
        Matrixsale.NamesRec(FieldByname('PAG_ID').asInteger);
        Next;
      end;
    end;
  finally
    ClosenFree;
  end;
  with ScriptMain do begin
    SQL.clear;
    SQL.add('update  ' + Matrixsale.Matrixtablename+'names  T inner join  tblproductattributegroups PAG on PAG.PAG_ID = T.PAG_ID' +
            ' left join tblproductattributenames as XAttrib on  XAttrib.PAN_ID = PAG.`XAxisAttribute` ' +
            ' Left join tblproductattributenames as YAttrib on  YAttrib.PAN_ID = PAG.`YAxisAttribute`  ' +
            ' Set  ' +
                ' T.XAttribName = XAttrib .Name ,  ' +
                ' T.YAttribName = YAttrib .Name ,  ' +
                ' T.active = PAG.Active');
    Execute;
  end;
  inherited;
end;

procedure TProdAttribTemplateFieldsDetailsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainID.FieldName);
  RemoveFieldfromGrid(QrymainPAG_ID.FieldName);
  RemoveFieldfromGrid(QrymainSEQNo.FieldName);
  RemoveFieldfromGrid(QrymainValue.FieldName);
end;

initialization
  RegisterClassOnce(TProdAttribTemplateFieldsDetailsGUI);

end.

