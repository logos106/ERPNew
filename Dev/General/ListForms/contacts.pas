unit contacts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TcontactsGUI = class(TBaseListingGUI)
    qryMaincompany: TWideStringField;
    qryMaincontactname: TWideStringField;
    qryMainfirstname: TWideStringField;
    qryMainmiddlename: TWideStringField;
    qryMainlastname: TWideStringField;
    qryMainphone: TWideStringField;
    qryMainmobile: TWideStringField;
    qryMainaltphone: TWideStringField;
    qryMaincategory: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fsStringtosearch:String;
  public
    Property Stringtosearch :string read fsStringtosearch write fsStringtosearch;
  end;

implementation

uses CommonLib, tcConst, DbSharedObjectsObj, CommonDbLib;

{$R *.dfm}
procedure TcontactsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  SearchMode:= smFullList;
  fsStringtosearch := '';
end;

procedure TcontactsGUI.FormShow(Sender: TObject);
const
  fieldstosaerch : array [1..8] of string = ('company' , 'contactname' , 'firstname' , 'middlename' , 'lastname' , 'phone' , 'mobile' , 'altphone');
var
  i1, i2:Integer;
  s:String;
  Qry:TERPQuery;
begin
  inherited;
  if Stringtosearch <> '' then begin
(*  Qrymain.disablecontrols;
  try*)
    DoShowProgressbar(  length( Stringtosearch)*high(fieldstosaerch), WAITMSG, '', false);
    try
      for i1 := 0 to length( Stringtosearch)-1 do begin
        for i2 := low(fieldstosaerch) to high(fieldstosaerch) do begin
          if qrymain.Locate(fieldstosaerch[i2], copy(Stringtosearch,1, length(Stringtosearch)-i1) , [loCaseInsensitive, loPartialKey]) then begin
              grdmain.setactivefield(fieldstosaerch[i2]);
              edtSearch.text := copy(Stringtosearch,1, length(Stringtosearch)-i1);
              exit;
          end;
          if qrymain.Locate(fieldstosaerch[i2], copy(Stringtosearch,i1, Length(Stringtosearch)) , [loCaseInsensitive, loPartialKey]) then begin
              grdmain.setactivefield(fieldstosaerch[i2]);
              edtSearch.text := copy(Stringtosearch,i1, Length(Stringtosearch));
            exit;
          end;
        end;
          s:= '';
          for i2 := low(fieldstosaerch) to high(fieldstosaerch) do begin
            if i2 >low(fieldstosaerch)  then s:= s +' OR';
            s:= s +'  '    +fieldstosaerch[i2] +' like ' +quotedstr('%' +copy(Stringtosearch,1, length(Stringtosearch)-i1));
            s:= s +'  or ' +fieldstosaerch[i2] +' like ' +quotedstr('%' +copy(Stringtosearch,i1, Length(Stringtosearch)));
          end;
        //with SharedQryobj do begin
        Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
          try
              With Qry do begin
                SQL.Clear;
                SQL.Add('Select * from (' +Qrymain.sQL.text+') as aaa where '+s);
                open;
                if recordcount >0 then begin
                    Qrymain.Locate('category;Company;contactname' , vararrayof([fieldbyname('category').AsString, fieldbyname('Company').AsString, fieldbyname('contactname').AsString]), []);
                    edtSearch.text := copy(Stringtosearch,i1, Length(Stringtosearch));
                    exit;
                end;
              end;
          finally
            DbSharedObj.ReleaseObj(Qry);
          end;
        DoStepProgressbar(fieldstosaerch[i1]);
      end;
      finally
        DoHideProgressbar;
      end;
      edtSearch.text :=  Stringtosearch;

(*
  finally
    Qrymain.enablecontrols;
  end;*)

  end;
end;

initialization
  RegisterClassOnce(TcontactsGUI);

end.

