unit BOMProgressBuilds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TBOMProgressBuildsGUI = class(TBaseListingGUI)
    qryMainsaleId: TIntegerField;
    qryMainsaledate: TDateField;
    qryMainsaleLineId: TIntegerField;
    qryMainproductname: TWideStringField;
    qryMaincaption: TWideMemoField;
    qryMainsubProductName: TWideStringField;
    qryMainproctreeId: TIntegerField;
    qryMainproctreepartId: TIntegerField;
    qryMainTreepartuomtotalqty: TFloatField;
    qryMainbuiltdate: TDateTimeField;
    qryMainbuildstatus: TWideStringField;
    qryMainbuiltqty: TFloatField;
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure Fixit;
  public
  end;


implementation

uses BusobjProctree, busobjProcProgress, LogLib, CommonLib, tcConst,
  AppEnvironment, ProcProgressLib;



{$R *.dfm}


procedure TBOMProgressBuildsGUI.Fixit;
var
  proctree : Tproctree;
  returnProcProgID:Integer;
  aPPGMsg:String;
begin
  proctree := Tproctree.CreateWithNewConn(Self);
  try
    proctree.load(Qrymainproctreeid.asInteger);
    if proctree.ProcTreePart.Count >0 then begin
      if proctree.ProcTreePart.ManufacturedProgress.Count >0 then begin
        if proctree.children.Count >0 then begin
          proctree.ProcTreePart.ManufacturedProgress.first;
          While proctree.ProcTreePart.ManufacturedProgress.eof = false do begin
            proctree.children.First;
            While proctree.children.EOF = false do begin
                if proctree.children.ProcTreePart.ManufacturingProgress.Locate('inprocprogressid' , proctree.ProcTreePart.ManufacturedProgress.ID , []) = False then begin
                  logtext(quotedstr('not found') +',' + inttostr(Proctree.ID)+',' + inttostr(Proctree.ProcTreePart.ID)+',' + inttostr(proctree.children.ProcTreePart.ManufacturedProgress.ID)+',' +Quotedstr(Proctree.caption)+',' +
                                                         '0,' +inttostr(proctree.children.ID)+',' + inttostr(proctree.children.ProcTreePart.ID)+',' + Quotedstr(proctree.children.caption)+','+
                                                        floattostr(proctree.cost)+','+floattostr(proctree.children.cost) );
                  proctree.children.DoBuildaQty(dqtOk , proctree.ProcTreePart.ManufacturedProgress.Progressdate , returnProcProgID,aPPGMsg);
                  proctree.children.ProcTreePart.ManufacturingProgress.New;
                  proctree.children.ProcTreePart.ManufacturingProgress.EmployeeId := Appenv.employee.EmployeeId;
                  proctree.children.ProcTreePart.ManufacturingProgress.InProcProgressId :=  proctree.ProcTreePart.ManufacturedProgress.ID;
                  proctree.children.ProcTreePart.ManufacturingProgress.Progressdate :=  proctree.ProcTreePart.ManufacturedProgress.Progressdate ;
                  proctree.children.ProcTreePart.ManufacturingProgress.Alloctype := 'OUT';

                  proctree.children.ProcTreePart.ManufacturingProgress.Qty := proctree.children.Quantity;//proctree.children.ProcTreePart.Qty;
                  proctree.children.ProcTreePart.ManufacturingProgress.BuildStatus := proctree.ProcTreePart.ManufacturedProgress.Buildstatus;
                  proctree.children.ProcTreePart.ManufacturingProgress.PostDB;
                end else begin
(*                  logtext(quotedstr('found') +',' + inttostr(Proctree.ID)+',' + inttostr(Proctree.ProcTreePart.ID)+',' + inttostr(proctree.children.ProcTreePart.ManufacturedProgress.ID)+',' + Quotedstr(Proctree.caption)+',' +
                                                          inttostr(proctree.children.ProcTreePart.ManufacturingProgress.ID)+',' +inttostr(proctree.children.ID)+',' + inttostr(proctree.children.ProcTreePart.ID)+',' + Quotedstr(proctree.children.caption)+','+
                                                        floattostr(proctree.cost)+','+floattostr(proctree.children.cost) );*)
                end;
                proctree.children.Next;
            end;
            proctree.ProcTreePart.ManufacturedProgress.Next;
          end;
        end;
      end;
    end;
  finally
    freeandnil(proctree);
  end;

end;

procedure TBOMProgressBuildsGUI.FormShow(Sender: TObject);
begin
  inherited;
  cmdNew.Enabled := True;
end;

procedure TBOMProgressBuildsGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  clog('');
  if Qrymain.recordcount =0 then exit;
  Qrymain.First;
  doshowprogressbar(qrymain.recordcount, waitmsg);
  try
    While Qrymain.Eof = False do begin
      Fixit;
      Qrymain.next;
      dostepprogressbar(inttostr(qrymain.recno)+' of ' + inttostr(qrymain.recordcount));
    end;
  finally
    Dohideprogressbar;
  end;
end;
initialization
  RegisterClassOnce(TBOMProgressBuildsGUI);

end.
