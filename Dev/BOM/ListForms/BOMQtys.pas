unit BOMQtys;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TBOMQtysGUI = class(TBaseListingGUI)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Tablename :String;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CommonDbLib, tcDataUtils, tcConst, LogLib;

{$R *.dfm}

{ TBOMQtysGUI }

procedure TBOMQtysGUI.FormCreate(Sender: TObject);
begin
  tablename := GetUserTemporaryTableName('BOMQty');
  Qrymain.sql.text :='select * from '+ tablename ;
  inherited;

end;

procedure TBOMQtysGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  inherited;

end;

procedure TBOMQtysGUI.RefreshQuery;
var
    fiBOMLevels:Integer;
    i:Integer;
  function createtableSQL:string;
  var
    ctr:Integer;
  begin
    result := 'Create table ' + tablename +'(	ID 					INT(11) 		NOT NULL AUTO_INCREMENT,';
    for ctr:= 1 to fiBOMLEvels do begin
	        result := result + 'ProctreeId' +trim(inttostr(ctr))+' 	INT(11) 		NULL DEFAULT 0,';
          result := result + 'ptpId'      +trim(inttostr(ctr))+' 	INT(11) 		NULL DEFAULT 0,';
	        result := result + 'Quantity'   +trim(inttostr(ctr))+' 	DOUBLE 			NULL DEFAULT 0,';
          result := result + 'totalQty'   +trim(inttostr(ctr))+' 	DOUBLE 			NULL DEFAULT 0,';
          result := result + 'ptpQty'     +trim(inttostr(ctr))+' 	DOUBLE 			NULL DEFAULT 0,';
          result := result + 'ptppqa'     +trim(inttostr(ctr))+' 	DOUBLE 			NULL DEFAULT 0,';
          result := result + 'ppgpqa'     +trim(inttostr(ctr))+' 	DOUBLE 			NULL DEFAULT 0,';
	        result := result + 'caption'    +trim(inttostr(ctr))+' 	VARCHAR(50) NULL DEFAULT "",';
	        result := result + 'Level'      +trim(inttostr(ctr))+' 	INT(11) 		NULL DEFAULT 0,';
          result := result + 'Selected'   +trim(inttostr(ctr))+' 	ENUM("T","F") default "F",';
    end;
    result := result + 'PRIMARY KEY (ID)';
    for ctr:= 1 to fiBOMLEvels do
      result := result + ',INDEX ProctreeId'+trim(inttostr(ctr))+' (ProctreeId'+trim(inttostr(ctr))+' 	)';

    result := result + ') ENGINE=MyIsam;';
  end;
begin
  fiBOMLEvels := BOMTreeLevels;

  With Scriptmain do begin
    SQL.add('drop table if exists ' + tablename +';');
    SQL.add(createtableSQL);
    SQL.add('insert ignore into '+ tablename +' (ProctreeId' +trim(inttostr(fiBOMLEvels))+','+
                                                'Quantity'   +trim(inttostr(fiBOMLEvels))+','+
                                                'totalQty'   +trim(inttostr(fiBOMLEvels))+','+
                                                'caption'    +trim(inttostr(fiBOMLEvels))+','+
                                                'selected'    +trim(inttostr(fiBOMLEvels))+','+
                                                'Level'      +trim(inttostr(fiBOMLEvels))+')'+
          ' select PT.ProctreeId, PT.Quantity, PT.totalQty  , PT.Caption , if(PTP.inputtype<>"itOption" or PT.selected="T","T" , "F") as Selected,  PT.`Level` '+
          ' from tblproctree PT '+
          ' left join tblproctree PTC on PT.ProcTreeId = PTC.ParentId '+
          ' inner join tblproctree PTP on PT.parentId = PTP.proctreeId ' +
          ' inner join tblsaleslines sl on sl.saleLineId = PT.masterId '+
          ' inner join tblsales s on s.saleId = sl.saleId and s.Converted ="T" '+
          ' where ifnull(PTC.ProcTreeId,0)=0 and PT.MasterType <> "mtProduct";');
    for i:= fiBOMLEvels downto 1 do begin

      if i < fiBOMLEvels then begin // lowest level is already inserted outside the loop
        SQL.add('update '+ tablename +' T inner join tblproctree PT on T.ProctreeId' +trim(inttostr(i+1))+' 	 = PT.ProcTreeId inner join tblproctree ptp on PT.ParentId = ptp.ProcTreeId ' +
              ' Set T.ProctreeId' +trim(inttostr(i))+' 	 = ptp.ProcTreeId, ' +
              ' T.quantity'       +trim(inttostr(i))+' 	 = ptp.quantity, ' +
              ' T.totalQty'       +trim(inttostr(i))+' 	 = ptp.totalQty, ' +
              ' T.caption'        +trim(inttostr(i))+' 	 = ptp.caption, ' +
              ' T.level'          +trim(inttostr(i))+' 	 = ptp.level;');
        SQL.add('update '+ tablename +' T inner join tblproctree PTP on T.ProcTreeId' +trim(inttostr(i))+' 	 = PTP.ProcTreeId '+
            ' Set T.Selected' +trim(inttostr(i+1))+' 	 =  if(PTP.inputtype<>"itOption" or PT.selected="T","T" , "F");');
      end;

        SQL.add('update '+ tablename +' T inner join tblproctreepart PTP on T.ProctreeId' +trim(inttostr(i))+' 	 = PTP.ProcTreeId '+
                            ' Set T.ptpId' +trim(inttostr(i))+' = PTP.ProctreePartId,'+
                            ' T.ptpQty' +trim(inttostr(i))+' = PTP.qty;');
    end;
    showProgressbar(WAITMSG , SQL.count);
    try
      clog(SQL.text);
      Execute;
    finally
      Hideprogressbar;
    end;
  end;

  inherited;

end;
initialization
  RegisterClassOnce(TBOMQtysGUI);

end.
