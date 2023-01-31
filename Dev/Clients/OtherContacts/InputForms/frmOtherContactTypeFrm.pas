

unit frmOtherContactTypeFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, Mask, DBCtrls, ExtCtrls, BaseInputForm, 
  kbmMemTable, DNMSpeedButton, MemDS, DBAccess, MyAccess,ERPdbComponents, Shader, DNMPanel,
  Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ImgList;

type
  TfrmOtherContactType = class(TBaseInputGUI)
    frmOtherContactTypeSrc: TDataSource;
    OtherType: TDBEdit;
    PaymentMethod_Label: TLabel;
    cmdOk: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    qryOtherContactType: TERPQuery;
    memQryOtherContactType: TkbmMemTable;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    OTID: integer;                          
    
  end;

implementation
 
uses FormFactory, AuditObj, frmOtherContactFrm, CommonLib, DNMExceptions;

{$R *.DFM}

//var
//  frmOtherContactType: TfrmOtherContactType;

procedure TfrmOtherContactType.cmdCancelClick(Sender: TObject);
begin                                           
  Self.Close;
end;                           

procedure TfrmOtherContactType.cmdOkClick(Sender: TObject);
begin
  try
    if not Empty(OtherType.Text) then begin
      qryOtherContactType.Post;

      Notify;
      Self.Close;
    end else begin
      CommonLib.MessageDlgXP_Vista('Description cannot be blank.', mtWarning, [mbOK], 0);
      SetControlFocus(OtherType);
    end;
  except
    on e: Exception do begin
      Audit.AddEntry(e, Self);
      CommonLib.MessageDlgXP_Vista(e.Message + Chr(13) + 'Errors occured in ' + Self.ClassName, mtWarning, [mbOK], 0);
      Self.Close; {Don't open the form if errors occur, too risky!!}
    end;
  end;
end;

procedure TfrmOtherContactType.cmdNewClick(Sender: TObject);
begin
  qryOtherContactType.Insert;
  SetControlFocus(OtherType);
end;

procedure TfrmOtherContactType.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseQueries;
  inherited;  
  Action := caFree;
end;

procedure TfrmOtherContactType.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      if qryOtherContactType.Active then begin
        qryOtherContactType.Post;
        Notify;
        CloseQueries;
      end;

      qryOtherContactType.ParamByName('OTID').asInteger := KeyID;
      OpenQueries;

      if KeyID > 0 then begin
        qryOtherContactType.Edit;
      end else begin
        qryOtherContactType.Insert;
        if Self.Owner is TfrmOtherContact then begin
          qryOtherContactType.FieldByName('OtherType').AsString :=
            TfrmOtherContact(Self.Owner).cboContactType.Text;
        end;
      end;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
    SetControlFocus(OtherType);
  finally
    EnableForm;
  end;  
end;

initialization
  RegisterClassOnce(TfrmOtherContactType);
  with FormFact do begin
    RegisterMe(TfrmOtherContactType, 'TOtherContactTypeListGUI_*=OtherTypeID');
    RegisterControl(TfrmOtherContactType, 'TfrmOtherContact_cboContactType=OtherContactType');
  end;
end.
