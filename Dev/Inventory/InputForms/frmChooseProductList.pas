unit frmChooseProductList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls,
  DNMSpeedButton, Shader, DNMPanel , ImageDLLLib, DnMAction;

type
  TfmChooseProductList = class(TBaseForm)
    tmrCheckShowProductListtypeSelectionPref: TTimer;
    DNMPanel1: TDNMPanel;
    cmdCancel: TDNMSpeedButton;
    chkShowProductListtypeSelection: TCheckBox;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnl1: TDNMPanel;
    pnl3: TDNMPanel;
    pnl2: TDNMPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkShowProductListtypeSelectionClick(Sender: TObject);
  private
    btn_1  : TERPMainSwitchButton;
    btn_2  : TERPMainSwitchButton;
    btn_3  : TERPMainSwitchButton;
    ActExpressList : TDnMAction;
    ActQuantityList : TDnMAction;
    ActDetailsList : TDnMAction;

    btnActExpressList : TDnMAction;
    btnActQuantityList : TDnMAction;
    btnActDetailsList : TDnMAction;
    procedure btnclick(Sender: TObject);
    procedure SetShowProductListtypeSelection(const Value: Boolean);
    function ActionCaption: String;
  Public
    Property ShowProductListtypeSelection :Boolean write SetShowProductListtypeSelection;
  end;

implementation

uses CommonLib, AppEnvironment, dmMainGUI, tcConst , CommonFormLib,
  ProgressDialog, MAIN;


{$R *.dfm}

procedure TfmChooseProductList.chkShowProductListtypeSelectionClick(Sender: TObject);
begin
  inherited;
  ShowProductListtypeSelection := chkShowProductListtypeSelection.checked;
end;

procedure TfmChooseProductList.cmdCancelClick(Sender: TObject);
begin
  inherited;
             if sametext(CallingActionName , ActExpressList.Name) then btn_1.click
        else if sametext(CallingActionName , ActQuantityList.Name) then btn_2.click
        else if sametext(CallingActionName , ActDetailsList.Name) then btn_3.click;
        Self.close;
end;

procedure TfmChooseProductList.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  btnActExpressList.visible := False;
  btnActQuantityList.visible := False;
  btnActDetailsList.visible := False;

end;
procedure TfmChooseProductList.btnclick(Sender: TObject);
begin
  DisableForm;
  try
    if (sender is   TERPMainSwitchButton) and Assigned(TERPMainSwitchButton(Sender).dnmaction) then TERPMainSwitchButton(Sender).dnmaction.execute;
         if Sender = btn_1 then AppEnv.Employee.ProductListType := 'E'
    else if Sender = btn_2 then AppEnv.Employee.ProductListType := 'Q'
    else if Sender = btn_3 then AppEnv.Employee.ProductListType := 'D'
    else exit;
    Self.closewait;
  finally
    Enableform;
  end;
end;
procedure TfmChooseProductList.FormCreate(Sender: TObject);
begin

  ActExpressList := dtmMainGUI.actInventProductsProductsExpressList;
  ActQuantityList:= dtmMainGUI.actProductQtylist;
  ActDetailsList := dtmMainGUI.actInventProductsProductsList;

  btnActExpressList := dtmMainGUI.actInventProductsProductsExpressList1;
  btnActQuantityList:= dtmMainGUI.actProductQtylist1;
  btnActDetailsList := dtmMainGUI.actInventProductsProductsList1;

  btnActExpressList.visible := True;
  btnActQuantityList.visible := True;
  btnActDetailsList.visible := True;

  Self.fbIgnoreAccessLevels := true;
  inherited;
  btn_1	    := TERPMainSwitchButton.create(Self);  With btn_1  do begin  Name := MakeName(Self,'btn_1'); Parent := pnl1;align := alclient ; alignWithmargins := True; Margins.left := 3; Margins.right := 3; Margins.top := 3;Margins.bottom := 3; DnmAction := btnActExpressList ; onclick := btnclick; end;
  btn_2	    := TERPMainSwitchButton.create(Self);  With btn_2  do begin  Name := MakeName(Self,'btn_1'); Parent := pnl2;align := alclient ; alignWithmargins := True; Margins.left := 3; Margins.right := 3; Margins.top := 3;Margins.bottom := 3; DnmAction := btnActQuantityList ; onclick := btnclick; end;
  btn_3	    := TERPMainSwitchButton.create(Self);  With btn_3  do begin  Name := MakeName(Self,'btn_1'); Parent := pnl3;align := alclient ; alignWithmargins := True; Margins.left := 3; Margins.right := 3; Margins.top := 3;Margins.bottom := 3; DnmAction := btnActDetailsList ; onclick := btnclick; end;
end;

procedure TfmChooseProductList.FormShow(Sender: TObject);
begin
  processingcursor(true);
  try
    chkShowProductListtypeSelection.checked := true;
    inherited;
    Showcontrolhint(btn_1, lbl1.caption);
    Showcontrolhint(btn_2, lbl2.caption);
    Showcontrolhint(btn_3, lbl3.caption);

       if sametext(CallingActionName  , ActExpressList.Name)  then Showcontrolhint(cmdCancel, 'Choose the List or Choose "Close" for '+ ActionCaption)
  else if sametext(CallingActionName  , ActQuantityList.Name) then Showcontrolhint(cmdCancel, 'Choose the List or Choose "Close" for '+ ActionCaption)
  else if sametext(CallingActionName  , ActDetailsList.Name)  then Showcontrolhint(cmdCancel, 'Choose the List or Choose "Close" for '+ ActionCaption);

  finally
    processingcursor(False);
  end;

end;

function TfmChooseProductList.ActionCaption:String;
begin
       if sametext(CallingActionName  , ActExpressList.Name)  then REsult := btnActExpressList.caption
  else if sametext(CallingActionName  , ActQuantityList.Name) then REsult := btnActQuantityList.caption
  else if sametext(CallingActionName  , ActDetailsList.Name)  then REsult := btnActDetailsList.caption
  else REsult := '';

end;

procedure TfmChooseProductList.SetShowProductListtypeSelection(const Value: Boolean);
begin
       if sametext(CallingActionName  , ActExpressList.Name)  then AppEnv.Employee.ShowProductListtypeSelectionforExpress := Value
  else if sametext(CallingActionName  , ActQuantityList.Name) then AppEnv.Employee.ShowProductListtypeSelectionforQtylist := Value
  else if sametext(CallingActionName  , ActDetailsList.Name)  then AppEnv.Employee.ShowProductListtypeSelectionforDetails := Value
  else AppEnv.Employee.ShowProductListtypeSelection := Value;
end;

initialization
  RegisterClassOnce(TfmChooseProductList);

end.
