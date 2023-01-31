unit frmInvalidAccountnames;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, Shader, DNMPanel, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, DNMSpeedButton, DAScript, MyScript;

type
  TfmInvalidAccountnames = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtWrongAccName: TEdit;
    edtchangeToAccName: TEdit;
    DNMSpeedButton1: TDNMSpeedButton;
    ERPScript1: TERPScript;
    DNMSpeedButton2: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure edtchangeToAccNameDblClick(Sender: TObject);
    procedure ERPScript1Error(Sender: TObject; E: Exception; SQL: string;
      var Action: TErrorAction);
    procedure ERPScript1BeforeExecute(Sender: TObject; var SQL: string;
      var Omit: Boolean);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  fiAccountID:Integer;

  fsAccountname :String;
  fsWrongAccountname :String;
    procedure SelectAccount(Sender: TwwDbGrid);
    procedure MakeSQL(cmd :TERPScript);
    procedure MakeSQLForIDs(cmd: TERPScript);
  public
    { Public declarations }
  end;

implementation

uses CommonFormLib, CommonDbLib, DbSharedObjectsObj, LogLib, CommonLib, tcConst;

{$R *.dfm}

const
  InvalidAccountnamesPrefname = 'InvalidAccountnames';
procedure TfmInvalidAccountnames.DNMSpeedButton1Click(Sender: TObject);
var
  cmd :TERPScript;
begin
  inherited;
  if (trim(fsWrongAccountname) ='') then exit;
  if (trim(fsAccountname) ='') then exit;
  if MessageDlgXP_vista('REplace ' + quotedstr(fsWrongAccountname) +' with '+ quotedstr(fsAccountname) +' ?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;

  clog('');
  logtext('Accountname : '+ quotedstr(fsWrongAccountname) +',' + 'replacewith : '+ quotedstr(fsAccountname));

  cmd := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
  try
    cmd.BeforeExecute := ERPScript1BeforeExecute;
    cmd.OnError := ERPScript1Error;
    cmd.SQL.Clear;
    MakeSQL(cmd );
    MakeSQLForIDs(cmd );
    showProgressbar(WAITMSG , cmd.SQL.count);
    try
      cmd.Execute;
    finally
      HideProgressbar;
    end;

  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
  MessageDlgXP_Vista('Update finished', mtInformation, [mbOK], 0);
  SetcontrolFocus(edtWrongAccName);
end;
Procedure TfmInvalidAccountnames.MakeSQLForIDs(cmd :TERPScript);
begin
    cmd.SQL.Add('update tblsaleslines     SL inner join tblchartofaccounts C on SL.ASSETACCNT = C.Accountname     set 	SL.ASSETACCNTID = C.AccountId;');
    cmd.SQL.Add('update tblsaleslines     SL inner join tblchartofaccounts C on SL.COGSACCNT = C.Accountname      set 	SL.COGSACCNTID  = C.AccountId;');
    cmd.SQL.Add('update tblsaleslines     SL inner join tblchartofaccounts C on SL.INCOMEACCNT = C.Accountname    set 	SL.INCOMEACCNTID= C.AccountId;');

    cmd.SQL.Add('update tblpurchaselines  SL inner join tblchartofaccounts C on SL.ASSETACCNT = C.Accountname     set 	SL.ASSETACCNTID = C.AccountId;');
    cmd.SQL.Add('update tblpurchaselines  SL inner join tblchartofaccounts C on SL.COGSACCNT = C.Accountname      set 	SL.COGSACCNTID  = C.AccountId;');
    cmd.SQL.Add('update tblpurchaselines  SL inner join tblchartofaccounts C on SL.INCOMEACCNT = C.Accountname    set 	SL.INCOMEACCNTID= C.AccountId;');

    cmd.SQL.Add('update tblstockadjustentrylines  SL inner join tblchartofaccounts C on SL.Accountname = C.Accountname    set 	SL.AccountId= C.AccountId;');
    cmd.SQL.Add('update tblstockmovementlines  SL inner join tblchartofaccounts C on SL.Accountname = C.Accountname    set 	SL.AccountId= C.AccountId;');
    cmd.SQL.Add('update tblstocktransferentry  SL inner join tblchartofaccounts C on SL.Accountname = C.Accountname    set 	SL.AccountId= C.AccountId;');
    cmd.SQL.Add('update tblstockadjustentry  SL inner join tblchartofaccounts C on SL.Accountname = C.Accountname    set 	SL.AccountId= C.AccountId;');
    cmd.SQL.Add('update tblstockmovementlines SML  INNER JOIN tblparts P ON P.PARTSID = SML.ProductID INNER JOIN tblchartofaccounts COA ON COA.AccountName = P.ASSETACCNT SET SML.AssetAccountID = COA.AccountID where ifnull(SML.AssetAccountID,0)=0 ;');
    cmd.SQL.Add('update tblgeneraljournaldetails  SL inner join tblchartofaccounts C on SL.Accountname = C.Accountname    set 	SL.AccountId= C.AccountId;');
    cmd.SQL.Add('update tblbankdepositlines  SL inner join tblchartofaccounts C on SL.Accountname = C.Accountname    set 	SL.AccountId= C.AccountId;');
    cmd.SQL.Add('update tblabadetailrecord  SL inner join tblchartofaccounts C on SL.Accountname = C.Accountname    set 	SL.AccountId= C.AccountId;');
    cmd.SQL.Add('update tblaccountpostingdetail  SL inner join tblchartofaccounts C on SL.Accountname = C.Accountname    set 	SL.AccountId= C.AccountId;');
    cmd.SQL.Add('update tblachinfo       SL inner join tblchartofaccounts C on SL.ImmediateDestination_Accountname = C.Accountname    set 	SL.ImmediateDestination_AccountID= C.AccountId;');
    cmd.SQL.Add('update tblallowances       SL inner join tblchartofaccounts C on SL.Accountname = C.Accountname    set 	SL.AccountId= C.AccountId;');
    cmd.SQL.Add('update tblassethire        SL inner join tblchartofaccounts C on SL.HireIncomeAccountName = C.Accountname    set 	SL.HireIncomeAccountId= C.AccountId;');
    cmd.SQL.Add('update tblbankstatementline       SL inner join tblchartofaccounts C on SL.Accountname = C.Accountname    set 	SL.AccountId= C.AccountId;');
    cmd.SQL.Add('update tblclients       SL inner join tblchartofaccounts C on SL.DefaultAPAccountname = C.Accountname    set 	SL.DefaultAPAccountId= C.AccountId;');
    cmd.SQL.Add('update tblclients       SL inner join tblchartofaccounts C on SL.DefaultARAccountName = C.Accountname    set 	SL.DefaultARAccountID= C.AccountId;');
    cmd.SQL.Add('update tbldeductions       SL inner join tblchartofaccounts C on SL.Accountname = C.Accountname    set 	SL.AccountId= C.AccountId;');
    cmd.SQL.Add('update tblequipment       SL inner join tblchartofaccounts C on SL.HireIncomeAccountName = C.Accountname    set 	SL.HireIncomeAccountID= C.AccountId;');
    cmd.SQL.Add('update tblexpenseclaimline       SL inner join tblchartofaccounts C on SL.Accountname = C.Accountname    set 	SL.AccountId= C.AccountId;');
    cmd.SQL.Add('update tblfixedassets       SL inner join tblchartofaccounts C on SL.FixedAssetCostAccountName = C.Accountname    set 	SL.FixedAssetCostAccountID= C.AccountId;');
    cmd.SQL.Add('update tblfixedassets       SL inner join tblchartofaccounts C on SL.ClearingAccountName = C.Accountname    set 	SL.ClearingAccountId= C.AccountId;');
    cmd.SQL.Add('update tblfixedassets       SL inner join tblchartofaccounts C on SL.FixedAssetDepreciationAccountName = C.Accountname    set 	SL.FixedAssetDepreciationAccountID= C.AccountId;');
    cmd.SQL.Add('update tblfixedassets       SL inner join tblchartofaccounts C on SL.FixedAssetCostAccountName2 = C.Accountname    set 	SL.FixedAssetCostAccountID2= C.AccountId;');
    cmd.SQL.Add('update tblfixedassets       SL inner join tblchartofaccounts C on SL.ClearingAccountName2 = C.Accountname    set 	SL.ClearingAccountID2= C.AccountId;');
    cmd.SQL.Add('update tblfixedassets       SL inner join tblchartofaccounts C on SL.FixedAssetDepreciationAccountName2 = C.Accountname    set 	SL.FixedAssetDepreciationAccountId2= C.AccountId;');
    cmd.SQL.Add('update tblfixedassets       SL inner join tblchartofaccounts C on SL.FixedAssetDepreciationAssetAccountName = C.Accountname    set 	SL.FixedAssetDepreciationAssetAccountID= C.AccountId;');
    cmd.SQL.Add('update tblfixedassets       SL inner join tblchartofaccounts C on SL.FixedAssetDepreciationAssetAccountName2 = C.Accountname    set 	SL.FixedAssetDepreciationAssetAccountID2= C.AccountId;');
    cmd.SQL.Add('update tblnonerppurchaselines       SL inner join tblchartofaccounts C on SL.Accountname = C.Accountname    set 	SL.AccountId= C.AccountId;');
    cmd.SQL.Add('update tblpaystransactions       SL inner join tblchartofaccounts C on SL.Accountname = C.Accountname    set 	SL.AccountId= C.AccountId;');
    cmd.SQL.Add('update tblselectedaccountsforreprots       SL inner join tblchartofaccounts C on SL.Accountname = C.Accountname    set 	SL.AccountId= C.AccountId;');
    cmd.SQL.Add('update tbltgaaccount      SL inner join tblchartofaccounts C on SL.Accountname = C.Accountname    set 	SL.AccountId= C.AccountId;');
    cmd.SQL.Add('update tbltgaaccount      SL inner join tblchartofaccounts C on SL.Accountname = C.Accountname    set 	SL.AccountId= C.AccountId;');

end;
Procedure TfmInvalidAccountnames.MakeSQL(cmd :TERPScript);
begin
    cmd.SQL.Add('update tblchartofaccounts set 	Accountname	='+quotedstr(fsAccountname)+'  Where Accountname	='+quotedstr(fsWrongAccountname)+';');
    cmd.SQL.Add('update tblchartofaccounts set 	Level1	='+quotedstr(fsAccountname)+'  Where Level1	='+quotedstr(fsWrongAccountname)+';');
    cmd.SQL.Add('update tblchartofaccounts set 	Level2	='+quotedstr(fsAccountname)+'  Where Level2	='+quotedstr(fsWrongAccountname)+';');
    cmd.SQL.Add('update tblchartofaccounts set 	Level3	='+quotedstr(fsAccountname)+'  Where Level3	='+quotedstr(fsWrongAccountname)+';');
    cmd.SQL.Add('update tblchartofaccounts set 	Level4	='+quotedstr(fsAccountname)+'  Where Level4	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblparts          set 	ASSETACCNT	  ='+quotedstr(fsAccountname)+'  Where ASSETACCNT	  ='+quotedstr(fsWrongAccountname)+';');
    cmd.SQL.Add('update tblparts          set 	COGSACCNT	    ='+quotedstr(fsAccountname)+'  Where COGSACCNT	  ='+quotedstr(fsWrongAccountname)+';');
    cmd.SQL.Add('update tblparts          set 	INCOMEACCNT	  ='+quotedstr(fsAccountname)+'  Where INCOMEACCNT	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblsaleslines     set 	ASSETACCNT	  ='+quotedstr(fsAccountname)+'  Where ASSETACCNT	  ='+quotedstr(fsWrongAccountname)+';');
    cmd.SQL.Add('update tblsaleslines     set 	COGSACCNT	    ='+quotedstr(fsAccountname)+'  Where COGSACCNT	  ='+quotedstr(fsWrongAccountname)+';');
    cmd.SQL.Add('update tblsaleslines     set 	INCOMEACCNT	  ='+quotedstr(fsAccountname)+'  Where INCOMEACCNT	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblpurchaselines  set 	ASSETACCNT	  ='+quotedstr(fsAccountname)+'  Where ASSETACCNT	  ='+quotedstr(fsWrongAccountname)+';');
    cmd.SQL.Add('update tblpurchaselines  set 	COGSACCNT	    ='+quotedstr(fsAccountname)+'  Where COGSACCNT	  ='+quotedstr(fsWrongAccountname)+';');
    cmd.SQL.Add('update tblpurchaselines  set 	INCOMEACCNT	  ='+quotedstr(fsAccountname)+'  Where INCOMEACCNT	='+quotedstr(fsWrongAccountname)+';');


    cmd.SQL.Add('update tblpurchaselines  set 	ASSETACCNT	  ='+quotedstr(fsAccountname)+'  Where ASSETACCNT	  ='+quotedstr(fsWrongAccountname)+';');
    cmd.SQL.Add('update tblpurchaselines  set 	COGSACCNT	    ='+quotedstr(fsAccountname)+'  Where COGSACCNT	  ='+quotedstr(fsWrongAccountname)+';');
    cmd.SQL.Add('update tblpurchaselines  set 	INCOMEACCNT	  ='+quotedstr(fsAccountname)+'  Where INCOMEACCNT	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblstockadjustentrylines  set 	Accountname	='+quotedstr(fsAccountname)+'  Where Accountname	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblstockmovementlines     set 	Accountname	='+quotedstr(fsAccountname)+'  Where Accountname	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblstocktransferentry     set 	Accountname	='+quotedstr(fsAccountname)+'  Where Accountname	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblstockadjustentry       set 	Accountname	='+quotedstr(fsAccountname)+'  Where Accountname	='+quotedstr(fsWrongAccountname)+';');


    cmd.SQL.Add('update tblgeneraljournaldetails       set 	Accountname	='+quotedstr(fsAccountname)+'  Where Accountname	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblbankdepositlines       set 	Accountname	='+quotedstr(fsAccountname)+'  Where Accountname	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblabadetailrecord       set 	Accountname	='+quotedstr(fsAccountname)+'  Where Accountname	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblaccountpostingdetail       set 	Accountname	='+quotedstr(fsAccountname)+'  Where Accountname	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblachinfo       set 	ImmediateDestination_Accountname	='+quotedstr(fsAccountname)+'  Where ImmediateDestination_Accountname	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblallowances       set 	Accountname	='+quotedstr(fsAccountname)+'  Where Accountname	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblassethire       set 	HireIncomeAccountName	='+quotedstr(fsAccountname)+'  Where HireIncomeAccountName	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblbalancesheet       set 	Accountname	='+quotedstr(fsAccountname)+'  Where Accountname	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblbankstatementline       set 	Accountname	='+quotedstr(fsAccountname)+'  Where Accountname	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblclients       set 	DefaultAPAccountName	='+quotedstr(fsAccountname)+'  Where DefaultAPAccountName	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblclients       set 	DefaultARAccountName	='+quotedstr(fsAccountname)+'  Where DefaultARAccountName	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tbldeductions       set 	Accountname	='+quotedstr(fsAccountname)+'  Where Accountname	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblequipment       set 	HireIncomeAccountName	='+quotedstr(fsAccountname)+'  Where HireIncomeAccountName	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblexpenseclaimline       set 	AccountName	='+quotedstr(fsAccountname)+'  Where AccountName	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblfixedassets       set 	FixedAssetCostAccountName	='+quotedstr(fsAccountname)+'  Where FixedAssetCostAccountName	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblfixedassets       set 	ClearingAccountName	='+quotedstr(fsAccountname)+'  Where ClearingAccountName	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblfixedassets       set 	FixedAssetDepreciationAccountName	='+quotedstr(fsAccountname)+'  Where FixedAssetDepreciationAccountName	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblfixedassets       set 	FixedAssetCostAccountName2	='+quotedstr(fsAccountname)+'  Where FixedAssetCostAccountName2	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblfixedassets       set 	ClearingAccountName2	='+quotedstr(fsAccountname)+'  Where ClearingAccountName2	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblfixedassets       set 	FixedAssetDepreciationAccountName2	='+quotedstr(fsAccountname)+'  Where FixedAssetDepreciationAccountName2	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblfixedassets       set 	FixedAssetDepreciationAssetAccountName	='+quotedstr(fsAccountname)+'  Where FixedAssetDepreciationAssetAccountName	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblfixedassets       set 	FixedAssetDepreciationAssetAccountName2	='+quotedstr(fsAccountname)+'  Where FixedAssetDepreciationAssetAccountName2	='+quotedstr(fsWrongAccountname)+';');


    cmd.SQL.Add('update tblnonerppurchaselines       set 	AccountName	='+quotedstr(fsAccountname)+'  Where AccountName	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblpaysplit       set 	AccountName	='+quotedstr(fsAccountname)+'  Where AccountName	='+quotedstr(fsWrongAccountname)+';');
    cmd.SQL.Add('update tblpaysplit       SL inner join tblchartofaccounts C on SL.Accountname = C.Accountname    set 	SL.AccountNo= C.AccountNumber;');

    cmd.SQL.Add('update tblpayssplits       set 	AccountName	='+quotedstr(fsAccountname)+'  Where AccountName	='+quotedstr(fsWrongAccountname)+';');
    cmd.SQL.Add('update tblpayssplits       SL inner join tblchartofaccounts C on SL.Accountname = C.Accountname    set 	SL.AccountNo= C.AccountNumber;');

    cmd.SQL.Add('update tblpaystransactions       set 	AccountName	='+quotedstr(fsAccountname)+'  Where AccountName	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblselectedaccountsforreprots       set 	AccountName	='+quotedstr(fsAccountname)+'  Where AccountName	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tblstockadjustmentimportexport      set 	AccountName	='+quotedstr(fsAccountname)+'  Where AccountName	='+quotedstr(fsWrongAccountname)+';');
    cmd.SQL.Add('update tblstockadjustmentimportexport      SL inner join tblchartofaccounts C on SL.Accountname = C.Accountname    set 	SL.AccountGroup= C.AccountGroup;');

    cmd.SQL.Add('update tbltgaaccount      set 	AccountName	='+quotedstr(fsAccountname)+'  Where AccountName	='+quotedstr(fsWrongAccountname)+';');

    cmd.SQL.Add('update tbltgaaccount      set 	AccountName	='+quotedstr(fsAccountname)+'  Where AccountName	='+quotedstr(fsWrongAccountname)+';');


end;
procedure TfmInvalidAccountnames.DNMSpeedButton2Click(Sender: TObject);
var
  qry: TERPQuery;
  cmd :TERPScript;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
  qry.SQL.Clear;

  qry.SQL.Add('Select "Licences, Registrations & Accreditations"    Correct, "Licences & Registrations" as Wrong union all');
  qry.SQL.Add('Select "Project Despatch - To be Invoiced"           Correct, "Broken Hill Project Despatch - To be Invoice" as Wrong union all');
  qry.SQL.Add('Select "Capital WIP"                                 Correct, "Capita Wip" as Wrong union all');
  qry.SQL.Add('Select "Advance Payment – 1"                         Correct, "Advance Payments Recvd" as Wrong union all');
  qry.SQL.Add('Select "Advance Payment – 2"                         Correct, "Advance Payment -Broken Hill Project" as Wrong union all');
  qry.SQL.Add('Select "Advance Payment – 3"                         Correct, "Advance Payment -3" as Wrong union all');
  qry.SQL.Add('Select "Advance Payment – 4"                         Correct, "Advance Payment-Hall Longmore Holdings" as Wrong union all');
  qry.SQL.Add('Select "General Accruals"                            Correct, "General Suspense" as Wrong union all');
  qry.SQL.Add('Select "Intercompany Holdings"                       Correct, "Cashpool" as Wrong union all');
  qry.SQL.Add('Select "Business Loan"                               Correct, "ANZ Business Loan" as Wrong union all');
  qry.SQL.Add('Select "Material Variance3"                          Correct, "Material Varinace3" as Wrong union all');
  qry.SQL.Add('Select "Material Variance"                           Correct, "Material Varinace" as Wrong union all');
  qry.SQL.Add('Select "Raw Materials"                               Correct, "Raw Materiuals" as Wrong union all');

  qry.SQL.Add('Select "Capital WIP"                                 Correct, "ASSET Clearing" as Wrong union all');
  qry.SQL.Add('Select "Product Testing"                             Correct, "Cost of Test Equipment" as Wrong union all');
  qry.SQL.Add('Select "Project Consumables"                         Correct, "Long Lead Project Expense" as Wrong union all');
  qry.SQL.Add('Select "Material Variances"                          Correct, "Material Variance Other" as Wrong union all');
  qry.SQL.Add('Select "General Accruals"                            Correct, "Recharge Expense Business unit" as Wrong union all');
  qry.SQL.Add('Select "General Accruals"                            Correct, "Recharges Expense Head Office" as Wrong union all');
  qry.SQL.Add('Select "Advance Payment - 1"                         Correct, "Rent Received in Advance" as Wrong union all');
  qry.SQL.Add('Select "Sales - Other"                               Correct, "Sales - Freight Recovery" as Wrong union all');
  qry.SQL.Add('Select "Maintenance Plant"                           Correct, "Tool Materials" as Wrong union all');
  qry.SQL.Add('Select "General Accruals"                            Correct, "WIP Consignment Labour" as Wrong');
  qry.open;
  qry.first;
  clog('');
  cmd := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
  try
    cmd.BeforeExecute := ERPScript1BeforeExecute;
    cmd.OnError := ERPScript1Error;
    cmd.SQL.Clear;
    showProgressbar(WAITMSG , qry.recordcount);
    try
        While qry.EOf = False do begin
          fsWrongAccountname :=qry.Fieldbyname('Wrong').asString;
          fsAccountname :=qry.Fieldbyname('Correct').asString;
          logtext('Accountname : '+ quotedstr(fsWrongAccountname) +',' + 'replacewith : '+ quotedstr(fsAccountname));
          MakeSQL(cmd );
          StepProgressbar;
          qry.Next;
        end;
        MakeSQLForIDs(cmd );
    finally
      HideProgressbar;
    end;
    showProgressbar(WAITMSG, cmd.SQL.count);
    try
      cmd.Execute;
    finally
      HideProgressbar;
    end;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;

  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
  MessageDlgXP_Vista('Update finished', mtWarning, [mbOK], 0);
  SetcontrolFocus(edtWrongAccName);
end;

procedure TfmInvalidAccountnames.edtchangeToAccNameDblClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselectModal('TChartOfAccountsListExpressGUI' , SelectAccount);
end;
procedure TfmInvalidAccountnames.SelectAccount(Sender: TwwDbGrid);
begin
  inherited;
  fsWrongAccountname := trim(edtWrongAccName.Text);
  fsAccountname:= Sender.Datasource.dataset.fieldbyname('AccountName').AsString;
  edtchangeToAccName.text := fsAccountname;
  fiAccountID:= Sender.Datasource.dataset.fieldbyname('AccountId').asInteger;
end;
procedure TfmInvalidAccountnames.ERPScript1BeforeExecute(Sender: TObject;
  var SQL: string; var Omit: Boolean);
begin
  inherited;
  StepProgressbar;
end;

procedure TfmInvalidAccountnames.ERPScript1Error(Sender: TObject; E: Exception;
  SQL: string; var Action: TErrorAction);
begin
  inherited;
  LogText(SQL);
  LogText(E.Message);
  LogText('==================================================================================');
  Action :=  eaContinue ;
end;

procedure TfmInvalidAccountnames.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmInvalidAccountnames.FormShow(Sender: TObject);
begin
  inherited;
  if not GuiPrefs.Active then GuiPrefs.Active := true;
  OpenQueries;
end;
initialization
  RegisterClassOnce(TfmInvalidAccountnames);

end.
