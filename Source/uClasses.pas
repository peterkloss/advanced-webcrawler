unit uClasses;

interface

uses Classes, IdURI, StrUtils;

type
  //record for URL data
  TLinkRec = record
    BaseUrl: string;  // base url
    Url: string;      // url
    Outter: Boolean;  // outter or iner URL
    Short: Boolean;   // short link
    Processed: Boolean;
  end;

  PLinkRec = ^TLinkRec;

  // array for URLs based on TList
  TLinkArray = class
  private
    FLinkList: TList;
    function GetItem(Index: integer): TLinkRec;
    procedure SetItem(Index: Integer; Value: TLinkRec);
    function GetCount: integer;
    function GetCountNP: integer;
    function getUrlNoProcessed:TLinkRec;
    function getIndexNoProcessed:integer;
  public
    procedure Add(rec: TLinkRec);
    procedure Delete(idx: Integer);
    procedure MarkProcessed(idx: Integer);
    procedure SaveToFile(FileName: string; StrDelim:AnsiChar = ' ');
    procedure SaveToFileByType(FileName: string; aInner:boolean ;StrDelim:AnsiChar = ' ');
    procedure Clear;
    constructor Create;
    destructor Destroy;
    property Items[Index: integer]: TLinkRec read GetItem write SetItem;
    property Count: integer read GetCount;
    property CountNoProc: integer read GetCountNP;
    property GetNextLink: TLinkRec read getUrlNoProcessed;
    property GetNextLinkIndex: integer read getIndexNoProcessed;
  end;

//XOR encryption
function Encrypt(const InString: AnsiString; StartKey, MultKey, AddKey: Integer):AnsiString;
//XOR decryption
function Decrypt(const InString: AnsiString; StartKey, MultKey, AddKey: Integer):AnsiString;

implementation

function Encrypt(const InString: AnsiString; StartKey, MultKey, AddKey: Integer):AnsiString;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(InString) do
  begin
    Result := Result + AnsiChar(Byte(InString[I]) xor (StartKey shr 8));
    StartKey := (Byte(Result[I]) + StartKey) * MultKey + AddKey;
  end;
end;

{$R-}
{$Q-}
function Decrypt(const InString: AnsiString; StartKey, MultKey, AddKey: Integer):AnsiString;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(InString) do
  begin
    Result := Result + AnsiChar(Byte(InString[I]) xor (StartKey shr 8));
    StartKey := (Byte(InString[I]) + StartKey) * MultKey + AddKey;
  end;
end;
{$R+}
{$Q+}

{ TLinkArray }

procedure TLinkArray.Add(rec: TLinkRec);
var
  ARecord: PLinkRec;
  i, p: Integer;
  flag: boolean;
  lnk1, lnk2: string;
begin
  flag:=true;
  i:=0;
  while flag and (i<FLinkList.Count) do
  begin
    {
    p:=Pos('?',rec.url);
    if p>0 then lnk1:=LeftStr(rec.url, p-1)
    else lnk1:=rec.Url;
    lnk2:=Items[i].Url;
    p:=Pos('?',lnk2);
    if p>0 then lnk2:=LeftStr(lnk2, p-1);
    if lnk1=lnk2 then flag:=false;
    }
    if rec.url=Items[i].Url then flag:=false;
    Inc(i);
  end;
  if flag then
  begin
    New(ARecord);
    ARecord^.BaseUrl:=rec.BaseUrl;
    ARecord^.Url:=rec.Url;
    ARecord^.Outter:=rec.Outter;
    ARecord^.Short:=rec.Short;
    ARecord^.Processed:=rec.Processed;
    FLinkList.Add(ARecord);
  end;
end;

procedure TLinkArray.Clear;
var
  i: integer;
  ARecord: PLinkRec;
begin
 for i := 0 to (FLinkList.Count - 1) do
   begin
     ARecord := FLinkList.Items[i];
     Dispose(ARecord);
   end;
   FLinkList.Clear;
end;

constructor TLinkArray.Create;
begin
  FLinkList:=TList.Create;
end;

procedure TLinkArray.Delete(idx: Integer);
var
  ARecord: PLinkRec;
begin
  ARecord := FLinkList.Items[idx];
  Dispose(ARecord);
  FLinkList.Delete(idx);
end;

destructor TLinkArray.Destroy;
var
  i: integer;
  ARecord: PLinkRec;
begin
 for i := 0 to (FLinkList.Count - 1) do
   begin
     ARecord := FLinkList.Items[i];
     Dispose(ARecord);
   end;
   FLinkList.Free;
end;

function TLinkArray.GetCount: integer;
begin
  result:=FLinkList.Count;
end;

function TLinkArray.GetCountNP: integer;
var
  i, cnt: integer;
  lnk: TLinkRec;
begin
  cnt:=0;
  for i:=0 to FLinkList.Count-1 do
  begin
    lnk:=Items[i];
    if not lnk.Outter then
      if not lnk.Processed then
        Inc(cnt);
  end;
  Result:=cnt;
end;

function TLinkArray.getIndexNoProcessed: integer;
var
  i: Integer;
  flag: boolean;
  lnk: TLinkRec;
begin
  Result:=-1;
  flag:=true;
  i:=0;
  while flag and (i<FLinkList.Count) do
  begin
    lnk:=Items[i];
    if not lnk.Outter then
      if not lnk.Processed then
      begin
        flag:=false;
        Result:=i;
      end;
    Inc(i);
  end;
  if flag then Result:=-1;
end;

function TLinkArray.GetItem(Index: integer): TLinkRec;
var
  ARecord: PLinkRec;
begin
  ARecord := FLinkList.Items[index];
  Result.BaseUrl:=ARecord^.BaseUrl;
  Result.Url:=ARecord^.Url;
  Result.Outter:=ARecord^.Outter;
  Result.Short:=ARecord^.Short;
  Result.Processed:=ARecord^.Processed;
end;

function TLinkArray.getUrlNoProcessed: TLinkRec;
var
  i: Integer;
  flag: boolean;
  lnk: TLinkRec;
begin
  flag:=true;
  i:=0;
  while flag and (i<FLinkList.Count) do
  begin
    lnk:=Items[i];
    if not lnk.Outter then
      if not lnk.Processed then
      begin
        flag:=false;
        Result:=lnk;
      end;
    Inc(i);
  end;
end;

procedure TLinkArray.MarkProcessed(idx: Integer);
var
  ARecord: PLinkRec;
begin
  ARecord := FLinkList.Items[Idx];
  ARecord^.Processed:=True;
end;

procedure TLinkArray.SaveToFile(FileName: string; StrDelim: AnsiChar);
var
  i: Integer;
  str: AnsiString;
  lnk: TLinkRec;
  F: TextFile;
begin
  AssignFile(F, FileName);
  ReWrite(F);
  for i:=0 to FLinkList.Count-1 do
  begin
    lnk:=Items[i];
    str:=lnk.BaseUrl+StrDelim+lnk.Url+StrDelim;
{
    if lnk.Outter then str:=str+'0'+StrDelim else str:=str+'1'+StrDelim;
    if lnk.Short then str:=str+'0'+StrDelim else str:=str+'1'+StrDelim;
    if lnk.Processed then str:=str+'+' else str:=str+'-';
}
    WriteLn(F, str);
  end;
  CloseFile(F);
end;

procedure TLinkArray.SaveToFileByType(FileName: string; aInner: boolean;
  StrDelim: AnsiChar);
var
  i: Integer;
  str: AnsiString;
  lnk: TLinkRec;
  F: TextFile;
begin
  AssignFile(F, FileName);
  ReWrite(F);
  for i:=0 to FLinkList.Count-1 do
  begin
    lnk:=Items[i];
    if lnk.Outter<>aInner then
    begin
      str:=lnk.BaseUrl+StrDelim+lnk.Url+StrDelim;
      WriteLn(F, str);
    end;
  end;
  CloseFile(F);
end;

procedure TLinkArray.SetItem(Index: Integer; Value: TLinkRec);
var
  ARecord: PLinkRec;
begin
  ARecord := FLinkList.Items[Index];
  ARecord^.BaseUrl:=Value.BaseUrl;
  ARecord^.Url:=Value.Url;
  ARecord^.Outter:=Value.Outter;
  ARecord^.Short:=Value.Short;
  ARecord^.Processed:=Value.Processed;
end;

end.
