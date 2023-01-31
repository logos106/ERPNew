unit CompareTextUnit;

interface

function CompareText_Sha_Pas_5_d(const S1, S2: string): Integer;

implementation
{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
function CompareText_Sha_Pas_5_d(const S1, S2: string): integer;
var
  c1, c2, d, q, Save: integer;
  p: pIntegerArray;
label
  past, find;
begin;
  d:=integer(@pchar(pointer(s1))[-4]);
  c1:=0;
  c2:=0;
  p:=@pchar(pointer(s2))[-4];
  if d<>-4 then c1:=pinteger(d)^;          //c1 = length of s1
  if p<>pointer(-4) then c2:=pinteger(p)^; //c2 = length of s2
  d:=(d-integer(p)) shr 2;                 //d = distance(s1-s2) div 4
  q:=c1;
  c1:=c1-c2;
  if c1>0 then q:=c2;                      //q = min length
  Save:=c1;                    //Save result for equal data
  if q<=0 then begin;
    Result:=c1;
    exit;
    end;
  q:=q+integer(p);

  repeat;
    c1:=p[d+1];                            //dword from s1
    c2:=p[1];                              //dword from s2
    inc(integer(p),4);
    c1:=c1 xor c2;
    if c1<>0 then begin;                   //test the difference
      //all bits of each byte must be 0, except bit5 (weight $20)
      if (c1 and integer($DFDFDFDF))<>0 then goto find;

      //bit5 can be 1 for letters only
      c1:=c1 + c1;                         //$00 or $40
      c1:=c1 + c1;                         //$00 or $80
      if (c1 and c2)<>0 then goto find;    //if not letter
      c2:=c2 and $5F5F5F5F;                //$41..$5A
      c2:=c2   + $3F3F3F3F;                //$80..$99
      c2:=c2 and $7F7F7F7F;                //$00..$19
      c2:=c2   + $66666666;                //$66..$7F
      if (c1 and c2)<>0 then goto find;    //if not letter
      end;
    until cardinal(p)>=cardinal(q);
past:
  Result:=Save;
  exit;

  repeat; //find mismatched characters
    if cardinal(p)>=cardinal(q+4) then goto past;
find:
    c1:=byte(p[d]);
    c2:=byte(p[0]);
    inc(integer(p));
    c1:=c1-ord('a');
    c2:=c2-ord('a');
    if cardinal(c1)<=ord('z')-ord('a') then c1:=c1-(ord('a')-ord('A'));
    if cardinal(c2)<=ord('z')-ord('a') then c2:=c2-(ord('a')-ord('A'));
    until c1<>c2;
  Result:=c1-c2;
end;
{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
{$IFDEF SaveR} {$R+} {$UNDEF SaveR} {$ENDIF}

end.
