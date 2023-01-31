unit SerialJobNumbers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SerialNumbers, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TSerialJobNumbersGUI = class(TSerialNumbersGUI)
    qryMainused: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
  Protected
    procedure CreateTemptable;Override;
    Procedure MakeQrymain;Override;
    function CreatetableSQL:String;override;
  public
    Procedure RefreshQuery; Override;
  end;

implementation

uses CommonLib, ProductQtyLib, Barcodeconst, AppEnvironment, busobjPQA, LogLib,
  CommonFormLib;

{$R *.dfm}
{ TSerialJobNumbersGUI }

procedure TSerialJobNumbersGUI.cmdNewClick(Sender: TObject);
begin
//  inherited;
  OpenERPForm('TfmSerialjobNumbers' , 0);
end;

function TSerialJobNumbersGUI.CreatetableSQL: String;
begin
  REsult := 'DROP TABLE IF EXISTS ' + fsTablename +'; ' +
            ' CREATE TABLE ' + fsTablename +' ( ' +
              ' ID int(11) NOT NULL AUTO_INCREMENT, ' +
              ' PartsId int(11) NOT NULL DEFAULT 0, ' +
              ' DepartmentID int(11) DEFAULT NULL, ' +
              ' UOMID bigint(20) DEFAULT NULL, ' +
              ' UOM varchar(50) NOT NULL DEFAULT "", ' +
              ' UOMMultiplier double NOT NULL DEFAULT 0, ' +
              ' gLevel bigint(20) NOT NULL DEFAULT 0, ' +
              ' ProductName varchar(60) DEFAULT NULL, ' +
              ' ProductColumn1 varchar(255) DEFAULT NULL, ' +
              ' ProductColumn2 varchar(255) DEFAULT NULL, ' +
              ' ProductColumn3 varchar(255) DEFAULT NULL, ' +
              ' PartsDescription varchar(255) DEFAULT NULL, ' +
              ' Classname varchar(255) DEFAULT NULL, ' +
              ' Batchnumber varchar(100) DEFAULT NULL, ' +
              ' TruckLoadNo varchar(10) DEFAULT NULL, ' +
              ' cBatchExpiryDate varchar(10) DEFAULT NULL, ' +
              ' BatchExpiryDate datetime DEFAULT NULL, ' +
              ' ExpiryDate datetime DEFAULT NULL, ' +
              ' binLocation varchar(30) DEFAULT NULL, ' +
              ' Binnumber varchar(30) DEFAULT NULL, ' +
              ' Serialnumber varchar(100) DEFAULT NULL, ' +
              ' DEscription varchar(100) DEFAULT NULL, ' +
              ' Transdate datetime DEFAULT NULL, ' +
              ' allocType varchar(50) DEFAULT NULL, ' +
              ' Status varchar(50) DEFAULT NULL, ' +
              ' PRIMARY KEY (ID) ' +
              ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;';
end;

procedure TSerialJobNumbersGUI.CreateTemptable;
begin
  inherited;
end;

procedure TSerialJobNumbersGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
  grpFilters.visible := False;
end;

procedure TSerialJobNumbersGUI.MakeQrymain;
begin
//  inherited;
  CloseDB(Qrymain);
  Qrymain.sql.clear;
  Qrymain.sql.add('select');
  Qrymain.sql.add('P.partsID          as PArtsId,');
  Qrymain.sql.add('T.DepartmentID     as DepartmentID,');
  Qrymain.sql.add('T.UOMID            as UOMID,');
  Qrymain.sql.add('T.UOM              as UOM,');
  Qrymain.sql.add('T.UOMMultiplier    as UOMMultiplier ,');
  Qrymain.sql.add('P.PARTNAME         as ProductName ,');
  Qrymain.sql.add('T.gLevel           as gLevel,');
  Qrymain.sql.add(Firstcolumn + '     as ProductColumn1,');
  Qrymain.sql.add(Secondcolumn + '    as ProductColumn2,');
  Qrymain.sql.add(Thirdcolumn + '     as ProductColumn3,');
  Qrymain.sql.add('P.PARTSDESCRIPTION as PartsDescription,');
  Qrymain.sql.add('C.classname        as classname,');
  Qrymain.sql.add('T.Batchnumber      as Batchnumber ,');
  Qrymain.sql.add('T.TruckLoadNo      as TruckLoadNo ,');
  Qrymain.sql.add('DATE_FORMAT(T.Expirydate , ' + QuotedStr('%d/%m/%Y') +') as cBatchExpiryDate ,');
  Qrymain.sql.add('T.Expirydate       as BatchExpiryDate ,');
  Qrymain.sql.add('T.binLocation      as binLocation,');
  Qrymain.sql.add('T.Binnumber        as Binnumber,');
  Qrymain.sql.add('T.serialnumber     as serialnumber,');
  Qrymain.sql.add('T.DEscription      as DEscription,');
  Qrymain.sql.add('T.Transdate      as Transdate,');
  Qrymain.SQL.add('concat(' +Quotedstr(Barcode_Prefix_PQASN)+',''-'' ,P.PartsId,''-'' ,T.Serialnumber) as BOMSerialnumber , ');
  Qrymain.sql.add('ifnull(T.status, T.alloctype)  as allocType,');
  Qrymain.sql.add('if(ifnull(transDate,0)=0, "F" , "T") as used');
  Qrymain.sql.add('from '+fsTablename+' T');
  Qrymain.sql.add('inner join tblparts P on P.partsId = T.PartsId');
  Qrymain.sql.add('inner join tblclass C on C.classid = T.DepartmentID');
  Qrymain.sql.add('inner join tblserialnumbers S on T.serialnumber = S.SerialNo and T.partsId = S.ProductId');
  Qrymain.sql.add('Where (T.DepartmentId = :DepartmentId or :DepartmentId=0) ');
  Qrymain.sql.add('and (T.PartsId = :ProductId or :ProductId=0) ');
end;

procedure TSerialJobNumbersGUI.RefreshQuery;
begin
    Qrymain.parambyname('DepartmentId').asInteger := 0;
    Qrymain.parambyname('ProductId').asInteger := 0;
  inherited;
end;

initialization
  RegisterClassOnce(TSerialJobNumbersGUI);

end.
