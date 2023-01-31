unit CommentsLib;

interface

type
  TCommentsType = (ctGeneral=1, ctTreeComments=2);


Function CommentsTypeToStr(const Value : TCommentsType):String;
Function StrToCommentsType(const Value : String):TCommentsType;


implementation
Function CommentsTypeToStr(const Value : TCommentsType):String;
begin
   result := 'ctGeneral';
   if value = ctGeneral then result := 'ctGeneral'
   else if Value = ctTreeComments then result := 'ctTreeComments';
end;
Function StrToCommentsType(const Value : String):TCommentsType;
begin
   result := ctGeneral;
   if value = 'ctGeneral' then result := ctGeneral
   else if Value = 'ctTreeComments' then result := ctTreeComments;

end;

end.
