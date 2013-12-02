unit uLibs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, ShellAPI, ShlObj, ActiveX, Forms;

procedure SaveStringToFile(const Filename, Data: AnsiString);

function AdvSelectDirectory(const Caption: string; const Root: WideString;
   var Directory: string; EditBox: Boolean = False; ShowFiles: Boolean = False;
   AllowCreateDirs: Boolean = True): Boolean;

function DescSort(List: TStringList; Index1, Index2: Integer): Integer;

implementation

function DescSort(List: TStringList; Index1, Index2: Integer): Integer;
begin
  if List[Index1]<List[Index2] then
  begin
    Result := 1;
    Exit;
  end;
  if List[Index1]=List[Index2] then
    Result := 0
  else
    Result := -1;
end;

// for debugging
procedure SaveStringToFile(const Filename, Data: AnsiString);
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(Filename, fmCreate);
  try
    fs.WriteBuffer(Pointer(Data)^, Length(Data));
  finally
    fs.Free;
  end;
end;

//function for Directory select
function AdvSelectDirectory(const Caption: string; const Root: WideString;
   var Directory: string; EditBox: Boolean = False; ShowFiles: Boolean = False;
   AllowCreateDirs: Boolean = True): Boolean;

  function SelectDirCB(Wnd: HWND; uMsg: UINT; lParam, lpData: lParam): Integer;stdcall;
  begin
    case uMsg of
      BFFM_INITIALIZED: SendMessage(Wnd, BFFM_SETSELECTION, Ord(True), Integer(lpData));
    end;
    Result := 0;
  end;

 var
   WindowList: Pointer;
   BrowseInfo: TBrowseInfo;
   Buffer: PChar;
   RootItemIDList, ItemIDList: PItemIDList;
   ShellMalloc: IMalloc;
   IDesktopFolder: IShellFolder;
   Eaten, Flags: LongWord;
 const
  BIF_USENEWUI = $0040;
  BIF_NOCREATEDIRS = $0200;
begin
   Result := False;
   if not DirectoryExists(Directory) then
     Directory := '';
   FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
   if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then
   begin
     Buffer := ShellMalloc.Alloc(MAX_PATH);
     try
       RootItemIDList := nil;
       if Root <> '' then
       begin
         SHGetDesktopFolder(IDesktopFolder);
         IDesktopFolder.ParseDisplayName(Application.Handle, nil,
           POleStr(Root), Eaten, RootItemIDList, Flags);
       end;
       OleInitialize(nil);
       with BrowseInfo do
       begin
         hwndOwner := Application.Handle;
         pidlRoot := RootItemIDList;
         pszDisplayName := Buffer;
         lpszTitle := PChar(Caption);
         // defines how the dialog will appear:
        // legt fest, wie der Dialog erscheint:
        ulFlags := BIF_RETURNONLYFSDIRS or BIF_USENEWUI or
           BIF_EDITBOX * Ord(EditBox) or BIF_BROWSEINCLUDEFILES * Ord(ShowFiles) or
           BIF_NOCREATEDIRS * Ord(not AllowCreateDirs);
         lpfn    := @SelectDirCB;
         if Directory <> '' then
           lParam := Integer(PChar(Directory));
       end;
       WindowList := DisableTaskWindows(0);
       try
         ItemIDList := ShBrowseForFolder(BrowseInfo);
       finally
         EnableTaskWindows(WindowList);
       end;
       Result := ItemIDList <> nil;
       if Result then
       begin
         ShGetPathFromIDList(ItemIDList, Buffer);
         ShellMalloc.Free(ItemIDList);
         Directory := Buffer;
       end;
     finally
       ShellMalloc.Free(Buffer);
     end;
   end;
end;

end.
