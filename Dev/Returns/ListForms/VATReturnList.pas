unit VATReturnList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton,  wwdblook,
  Shader, kbmMemTable , ReturnListBase, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TVATReturnListGUI = class(TReturnListBaseGUI)
    qryMainID: TIntegerField;
    qryMainVATDesc: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainPeriod: TWideStringField;
    qryMainPeriodFrom: TDateField;
    qryMainPeriodTo: TDateField;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainDone: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btndeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses BaseInputForm, CommonLib, Forms, VATTransReturnList, CommonFormLib, CommonDbLib,tcConst,
  SharedObjs;

{$R *.dfm}

procedure TVATReturnListGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenErpListform('TVATTransReturnListGUI' , beforeOpenDetails);
end;

procedure TVATReturnListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;
end;

procedure TVATReturnListGUI.btndeleteClick(Sender: TObject);
var
  Option:Word;
  fstablename :String;
begin
  inherited;
  Option := MessageDlgXP_Vista('Select the delete option', mtConfirmation, [], 0 , nil , '' , '' , False, nil, 'All from Summary, All Selected, All , Cancel');
  if option = 103 then exit;
  with CommonDbLib.TempMyScript do try
      fsTablename := ERPFIXTablenameforCurVersion('tblvatreturns');
      SQL.Add('Create table if not exists    ' + fsTablename +' like tblvatreturns;');
      SQL.Add('insert ignore into    ' + fsTablename +' select * from tblvatreturns;');

      fsTablename := ERPFIXTablenameforCurVersion('tblvatreportlines');
      SQL.Add('create table  if not exists    ' + fsTablename +' like tblvatreportlines;');
      SQL.Add('insert ignore into    ' + fsTablename +' select * from tblvatreportlines;');

    if option = 100 then begin
      SQL.Add('delete from    tblvatreturns where ID in (Select VATID from tblvatreportlines);');
      SQL.Add('delete from    tblvatreturns where Active ="F";');
      SQL.Add('truncate       tblvatreportlines;');
    end else if option = 101 then begin
      if SelectedIDs('ID') = '' then exit;
      SQL.Add('delete from    tblvatreturns where ID in (' + SelectedIDs('ID') + ');');
      SQL.Add('delete from    tblvatreportlines where VATID  not in (Select id from tblvatreturns);');
    end else begin
      SQL.Add('truncate tblvatreturns ;');
      SQL.Add('truncate tblvatreportlines;');
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

procedure TVATReturnListGUI.cmdNewClick(Sender: TObject);
var
  Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmVATReturn');
  if Assigned(Form) then begin
    with TBaseInputGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;  
end;

initialization
  RegisterClassOnce(TVATReturnListGUI);

end.
