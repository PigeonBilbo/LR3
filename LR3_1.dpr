program LR3_1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type mas = array of integer;

function Downcase(x:char):char;
begin
  if (ord(x)>64) and (ord(x)<91) then
  Downcase:=chr(ord(x)+32)
  else
  Downcase:=x;
end;

procedure Print(a:mas;b:mas;var f:text);
var i,j,n:integer;
begin;
n:=length(b);
for I := 0 to n-2 do
begin
  for j:=b[i] to b[i+1]-1 do
  write (f,a[j],' ');
writeln(f);
end;
end;

procedure NewRow(a:mas; var b:mas);
var m,n:integer;
  i: Integer;
begin
m:=length(a);
n:=length(b);
setlength(b,n+1);
b[n]:=m-1;
end;

procedure DelRow(n:integer; var a:mas; var b:mas);
var ns,ks,delta:integer;
i,j,k,m:integer;
begin
m:=length(b);
k:=length(a);
ks:=b[n];
ns:=b[n-1];
delta:=ks-ns;
i:=0;

if m-n>0 then
begin
while ns+delta+i<k do
  begin
  a[ns+i]:=a[ns+delta+i];
  i:=i+1;
  end;
setlength(a,k-delta);
for j:=0 to m-n-2 do
b[n+j]:=b[n+j-1]+b[n+j+1]-b[n+j];
setlength(b,m-1);
end

else if m-n=0 then
setlength(b,m-1);
end;

procedure AddElem(n:integer;x:integer;var a:mas; var b:mas);

var m,k,i,t:integer;
ks,ns,per:integer;
begin
t:=0;
m:=length(b);
k:=length(a);
setlength(a,k+1);                            //n - номер строки
ks:=b[n];                                    //x - вставляемый элемент
ns:=b[n-1];
while t<k-ks do
  begin
  a[k-t]:=a[k-t-1];
  t:=t+1;
  end;
a[ks]:=x;
t:=ks;
ks:=n-1;
while t>ns do
 if a[t]<a[t-1] then
 begin
   per:=a[t-1];
   a[t-1]:=a[t];
   a[t]:=per;
   t:=t-1;
 end
 else
 t:=t-1;


for I:=n to m-1 do
  b[i]:=b[i]+1;

end;

procedure DelElemByNum(n,m:integer; var a:mas; var b:mas);
var p,k,i,t:integer;
ns:integer;
begin
t:=0;
p:=length(b);
k:=length(a);
ns:=b[n-1];                                                         //n-номер строки
while t<k-2 do                                                      //m-номер элемента
  begin
  a[ns+m+t]:=a[ns+m+t+1];
  t:=t+1;
  end;
for I:=n to p-1 do
  b[i]:=b[i]-1;
setlength(a,k-1);
end;

procedure DelElemByValue(n,x:integer; var a:mas; var b:mas);

    function kolsovp(a:mas; x,m,n:integer):integer;
    var i,k:integer;
    begin
    k:=0;
    for I := m to n do
      if a[i]=x then
      k:=k+1;
    kolsovp:=k;
    end;

    function poisk (a:mas; x,m,n:integer):integer;
    var i:integer;
    begin
    i:=m;
    while (a[i]<>x) and (i<n) do
    i:=i+1;
    poisk:=i;
    end;

var k,i,m:integer;
ns:integer;
begin
ns:=b[n-1];
k:=kolsovp(a,x,b[n-1],b[n]);
if k<>0 then
for I := 1 to k do
begin
m:=poisk(a,x,b[n-1],b[n])-ns;
DelElemByNum(n,m,a,b);
end
else
writeln('This value(',x,') don''t exist in that array');
end;

procedure ObrVhKom(st:string; var kom:string; var x,y:integer; var fl:boolean);
var i,j,l,kch,nch:integer;
a,b:string;
begin
fl:=true;
kom:='';
x:=0;
y:=0;
j:=1;
kch:=0;
nch:=0;
for i:= 1 to length(st) do begin
 if (ord(st[j-1])<123) and (ord(st[j-1])>64) and (ord(st[j])<58) and (ord(st[j])>47) then
 nch:=J;
 if st[j]=' ' then begin
 if (ord(st[j-1])<58) and (ord(st[j-1])>47) and (ord(st[j+1])<58) and (ord(st[j+1])>47) and (kch<>0) then
 fl:=false;

 if (ord(st[j-1])<58) and (ord(st[j-1])>47) and (ord(st[j+1])<58) and (ord(st[j+1])>47) and (kch=0) then
 kch:=J;
 delete(st,j,1);
 end
 else
 j:=j+1;
end;

if fl=true then
begin
  if nch=0 then
  kom:=copy(st,1,length(st))
  else
  begin
  kom:=copy(st,1,(nch-1));
  if kch=0 then
  a:=copy(st,nch,(length(st)-nch+1))
  else
  begin
  a:=copy(st,nch,kch-nch);
  b:=copy(st,kch,(length(st)-kch+1));
  end;
  end;
  for I := 1 to length(kom) do
  kom[i]:=Downcase(kom[i]);
  if (kom='addelem') and (b='') then
  fl:=false;
  if (kom='delelembynum') and (b='') then
  fl:=false;
  if (kom='delelembyvalue') and (b='') then
  fl:=false;

  if a<>'' then
  x:=strtoint(a);
  if b<>'' then
  y:=strtoint(b);
end;
end;


var
a,b:mas;
f1,f2:text;
fl:boolean;
vdoh,vydoh,kom,st:string;
x,y:integer;
begin
vdoh:=paramstr(1);
vydoh:=paramstr(2);
assignfile(f1,vdoh);
reset(f1);
assignfile (f2,vydoh);
rewrite(f2);
setlength(a,2);
setlength(b,1);
b[0]:=1;
while not(eof(f1)) do begin
readln(f1,st);
ObrVhKom (st,kom,x,y,fl);
    if fl=true then begin
    if (kom='newrow') then
    NewRow(a,b)

    else
    if (kom='print') then
    Print(a,b,f2)

    else
    if (kom='delrow') then
    if (x<length(b)) and (x>0) then
    DelRow(x,a,b)
    else
    writeln('COMMANDE ERROR ',st)

    else
    if (kom='addelem') then
    if (x<length(b)) and (x>0) then
    AddElem(x,y,a,b)
    else
    writeln('COMMANDE ERROR ',st)

    else
    if (kom='delelembynum') then

    if (y<(b[x]-b[x-1])) and (y>0) and (x<length(b)) and (x>0) then
    DelElemByNum(x,y,a,b)
    else
    writeln('COMMAND ERROR ',st)

    else
    if (kom='delelembyvalue') then
    if (x<length(b)) and (x>0) then
    DelElemByValue(x,y,a,b)

    else
    writeln('WRONG COMMAND ',st);
    end
    else
if fl=false then
writeln('WRONG COMMAND ',st);
end;
closefile(f1);
closefile(f2);
end.
