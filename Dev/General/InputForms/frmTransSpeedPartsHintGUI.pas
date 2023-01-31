unit frmTransSpeedPartsHintGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseHintForm, SelectionDialog, AppEvnts, DB, StdCtrls,
  Buttons, DNMSpeedButton, ExtCtrls, wwcheckbox;

type
  TTransSpeedPartsHintGUI = class(TBaseHintGUI)
    BitBtn2: TDNMSpeedButton;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    SnapshotOpenStateProductComboInv: boolean;
    SnapshotOpenStateProductComboSales: boolean;
    SnapshotOpenStateProductComboPO: boolean;
    SnapshotOpenStateProductList: boolean;
    SnapshotOpenStateSuburbs: boolean;    
  public
    { Public declarations }
    OpenedHintOwner: TObject;
  end;

implementation
   
uses 
  DataSnapshotObj, DNMLib, AppEnvironment, CommonLib;

{$R *.dfm}
 
procedure TTransSpeedPartsHintGUI.BitBtn2Click(Sender: TObject);
begin
  inherited;
  if OpenedHintOwner.ClassName = 'TPurchaseGUI' then begin
    AppEnv.Employee.UseSnapshotProductComboPO := true;
  end else begin
    AppEnv.Employee.UseSnapshotProductComboSales := true;
  end;

  //////////////////////////////
  //Snapshot Initialization
  if Assigned(DataSnapshot) and not (AppEnv.Employee.UseSnapshotProductComboInv) and not (AppEnv.Employee.UseSnapshotSuburbs) and not
    (AppEnv.Employee.UseSnapshotProductList) and not (AppEnv.Employee.UseSnapshotProductComboSales) and
    not (AppEnv.Employee.UseSnapshotProductComboPO) then begin
    DataSnapshot.Destroy;
    DataSnapshot := nil;
  end;

  if (AppEnv.Employee.UseSnapshotProductComboInv) or (AppEnv.Employee.UseSnapshotSuburbs) or
    (AppEnv.Employee.UseSnapshotProductList) or (AppEnv.Employee.UseSnapshotProductComboSales) or
    (AppEnv.Employee.UseSnapshotProductComboPO) then begin
    TDataSnapshotObj.Instance;
  end;

  if (not SnapshotOpenStateProductComboSales and AppEnv.Employee.UseSnapshotProductComboSales) or
    (not SnapshotOpenStateProductComboPO and AppEnv.Employee.UseSnapshotProductComboPO) or
    (not SnapshotOpenStateProductComboInv and AppEnv.Employee.UseSnapshotProductComboInv) then begin
    if ((AppEnv.Employee.UseSnapshotProductComboSales) or (AppEnv.Employee.UseSnapshotProductComboPO) or
      (AppEnv.Employee.UseSnapshotProductComboInv)) and not (GetKeyState(VK_SHIFT) < 0) then begin
      DataSnapshot.PopulateMe(stProductListCombos);
    end;
  end;

  if not SnapshotOpenStateSuburbs and AppEnv.Employee.UseSnapshotSuburbs then begin
    if (AppEnv.Employee.UseSnapshotSuburbs) then begin
      DataSnapshot.PopulateMe(stSuburbs);
    end;
  end;

  Application.ProcessMessages;
  Self.Close;
end;

procedure TTransSpeedPartsHintGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  AppEnv.Employee.ShowFormSpeedNotification := not (chkDontShowHint.Checked);
  inherited;
//  TransSpeedPartsHintGUI := nil;
end;

procedure TTransSpeedPartsHintGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TTransSpeedPartsHintGUI.FormShow(Sender: TObject);
begin
  inherited;
  SnapshotOpenStateProductComboSales := AppEnv.Employee.UseSnapshotProductComboSales;
  SnapshotOpenStateProductComboPO := AppEnv.Employee.UseSnapshotProductComboPO;
  SnapshotOpenStateProductList := AppEnv.Employee.UseSnapshotProductList;
  SnapshotOpenStateProductComboInv := AppEnv.Employee.UseSnapshotProductComboInv;
  SnapshotOpenStateSuburbs := AppEnv.Employee.UseSnapshotSuburbs;  
end;

initialization
  RegisterClassOnce(TTransSpeedPartsHintGUI);

end.
