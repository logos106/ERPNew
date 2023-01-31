unit ManufactureGUILib;

interface

uses UserLockObj,Forms;

 procedure OpenTree( aOwner:Tform; aTreeRootId , aSaleID:Integer; Userlock:TUserLock;FormCatpion:String);

implementation

uses frmProcTreeEdit, TreeFrame;
procedure OpenTree( aOwner:Tform; aTreeRootId , aSaleID:Integer; Userlock:TUserLock;FormCatpion:String);
var
  TreeForm: TfmProcTreeEdit;
  SalesRecLocked:Boolean;
begin
  SalesRecLocked:= False;
  TreeForm:= TfmProcTreeEdit.Create(aOwner);
  try
    { does not use this but set here to stop "read-only" message from poping up }
    TreeForm.KeyID:= 1;
    { need all of the following to allow editing and saving of Info column in tree }
    TreeForm.TransConnection:= TreeForm.MyConnection;
    TreeForm.TransConnection.Connect;
    TreeForm.TransConnection.StartTransaction;
    TreeForm.Tree.TransConnection:= TreeForm.TransConnection;
    TreeForm.Tree.ProcessTreeID:= aTreeRootId; ;
    TreeForm.Tree.TreeMode:= tmTemplate ;
    TreeForm.Tree.vstProcessPart.Visible:= true;

    if not(Userlock.Lock('tblsales' ,aSaleID , FormCatpion)) then begin
      TreeForm.AccessLevel:= 5;
    end else begin
      SalesRecLocked:= True;
    end;
    TreeForm.ShowModal;
  finally
    if SalesRecLocked then
      Userlock.unLock('tblsales' ,asaleID , FormCatpion);
    TreeForm.Free;
  end;
end;
end.
