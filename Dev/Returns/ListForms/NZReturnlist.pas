unit NZReturnlist;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 07/09/05  1.00.01 IJB  Modified to use new filtering on base listing.
 }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable , ReturnListBase, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TNZReturnlistGUI = class(TReturnListBaseGUI)
    qryMainID: TIntegerField;
    qryMainBasSheetDesc: TWideStringField;
    qryMainActive: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainTab4_type: TWideStringField;
    qryMainTab4From: TDateField;
    qryMainTab4To: TDateField;
    qryMainDone: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btndeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib, frmNZReturn, NZTransReturnList, CommonFormLib, CommonDbLib,tcConst,
  SharedObjs;

{$R *.dfm}

procedure TNZReturnlistGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;
end;

procedure TNZReturnlistGUI.btndeleteClick(Sender: TObject);
var
  Option:Word;
  fstablename :String;
begin
  inherited;
  Option := MessageDlgXP_Vista('Select the delete option', mtConfirmation, [], 0 , nil , '' , '' , False, nil, 'All from Summary, All Selected, All , Cancel');
  if option = 103 then exit;
  with CommonDbLib.TempMyScript do try
      fsTablename := ERPFIXTablenameforCurVersion('tblnzreturns');
      SQL.Add('Create table if not exists    ' + fsTablename +' like tblnzreturns;');
      SQL.Add('insert ignore into    ' + fsTablename +' select * from tblnzreturns;');

      fsTablename := ERPFIXTablenameforCurVersion('tblnzreportlines');
      SQL.Add('create table  if not exists    ' + fsTablename +' like tblnzreportlines;');
      SQL.Add('insert ignore into    ' + fsTablename +' select * from tblnzreportlines;');

    if option = 100 then begin
      SQL.Add('delete from    tblnzreturns where ID in (Select NZID from tblnzreportlines);');
      SQL.Add('delete from    tblnzreturns where Active ="F";');
      SQL.Add('truncate       tblnzreportlines;');
    end else if option = 101 then begin
      if SelectedIDs('ID') = '' then exit;
      SQL.Add('delete from    tblnzreturns where ID in (' + SelectedIDs('ID') + ');');
      SQL.Add('delete from    tblnzreportlines where NZID  not in (Select id from tblnzreturns);');
    end else begin
      SQL.Add('truncate tblnzreturns ;');
      SQL.Add('truncate tblnzreportlines;');
    end;
      showProgressbar(waitMSG, 3);
      try
        stepProgressbar;
        execute;
        stepProgressbar;
        btnRequery.Click;
      finally
        HideProgressbar;
      end;
  finally
    free;
 end;

end;

procedure TNZReturnlistGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmNZReturn');
  if Assigned(Form) then begin
    with TfmNZReturn(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TNZReturnlistGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenErpListform('TNZTransReturnListGUI' , beforeOpenDetails);
end;

procedure TNZReturnlistGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;

end;

initialization
  RegisterClassOnce(TNZReturnlistGUI);
end.
