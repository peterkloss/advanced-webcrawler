unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RegExpr, StdCtrls, IdZLibCompressorBase,
  IdCompressorZLib, IdCookieManager, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, StrUtils, uClasses, IdURI, ActnList,
  ComCtrls, Buttons, ExtCtrls, ShellAPI, ShlObj, ActiveX, Registry,
  IdAntiFreezeBase, IdAntiFreeze, Spin, uParams, Grids,
  CheckLst, DB, DBClient, DBGrids, HTTPApp, IdCookie, XPMan,
  uGroupsEdit, uValueEdit, uFormsSQL, uFormsXSS, uLibs, ImgList;

const
  // basic set for extensions
  IgnoreExtSetConst = '.png .ico .jpg .jpeg .gif .doc .pdf .avi .mp4 .zip .rar .swf .css .wmv .wma .mp3 .rss';
  ProgramName = 'WebCrawler';
  ExtraGroupsDef = 'Banners;Captcha;Tracking software;';

  // key for XOR Encrypt/Decrypt
  StartKey = 639;
  MultKey = 59427;
  AddKey = 12538;

type
  TSortType = (gstNone, gstAsc, gstDesc);

  TfrmMain = class(TForm)
    IdHTTP: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    ActionList1: TActionList;
    acStop: TAction;
    acStart: TAction;
    IdCookies: TIdCookieManager;
    IdAntiFreeze1: TIdAntiFreeze;
    cdsForms: TClientDataSet;
    cdsParams: TClientDataSet;
    OpenDialog1: TOpenDialog;
    cdsLinks: TClientDataSet;
    cdsLinkParams: TClientDataSet;
    PanelCrawler: TPanel;
    Memo: TMemo;
    Panel15: TPanel;
    Label4: TLabel;
    Label15: TLabel;
    edHost: TEdit;
    btStop: TBitBtn;
    btStart: TBitBtn;
    Panel16: TPanel;
    Label1: TLabel;
    LabelCount: TLabel;
    Label2: TLabel;
    LabelNP: TLabel;
    Label3: TLabel;
    LabelProc: TLabel;
    sgResult: TStringGrid;
    XPManifest1: TXPManifest;
    PanelTop: TPanel;
    sbtnCrawler: TSpeedButton;
    sbtnVulner: TSpeedButton;
    sbtnSettings: TSpeedButton;
    PanelVulner: TPanel;
    Panel17: TPanel;
    Label17: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    sbtnFormsLinksCross: TSpeedButton;
    sbtnFormsLinksSQL: TSpeedButton;
    pgBar: TProgressBar;
    btnVulnerStart: TBitBtn;
    cbxCheckSQL: TCheckBox;
    cbxCheckCross: TCheckBox;
    cmbCross: TComboBox;
    cmbSQL: TComboBox;
    MemoVulnerOut: TMemo;
    PanelSetup: TPanel;
    pgcSettings: TPageControl;
    TabSheet12: TTabSheet;
    rgDelimiter: TRadioGroup;
    edDelimiterChar: TEdit;
    TabSheet13: TTabSheet;
    Splitter1: TSplitter;
    GroupBox1: TGroupBox;
    clbSQLs: TCheckListBox;
    Panel3: TPanel;
    btnUnCheckSQL: TButton;
    btnCheckSQL: TButton;
    GroupBox2: TGroupBox;
    clbFTypes: TCheckListBox;
    Panel4: TPanel;
    btnFTypesSQLUnCheck: TButton;
    btnFTypesSQLCheck: TButton;
    Panel2: TPanel;
    Label8: TLabel;
    btFileSql: TSpeedButton;
    btFileResp: TSpeedButton;
    Label9: TLabel;
    Label12: TLabel;
    Label10: TLabel;
    edSQLFile: TEdit;
    edRespFile: TEdit;
    btnRespShow: TBitBtn;
    cbxMethodSQL: TComboBox;
    cbxRepSqlFormat: TComboBox;
    TabSheet1: TTabSheet;
    Splitter2: TSplitter;
    Panel6: TPanel;
    Label11: TLabel;
    btnOpenX: TSpeedButton;
    Label13: TLabel;
    Label14: TLabel;
    edXSSFile: TEdit;
    cbxRepXSSFormat: TComboBox;
    cbxMethodXSS: TComboBox;
    GroupBox3: TGroupBox;
    clbXSS: TCheckListBox;
    Panel7: TPanel;
    btnUncheckXSS: TButton;
    btnCheckXSS: TButton;
    GroupBox4: TGroupBox;
    clbFTypesX: TCheckListBox;
    Panel8: TPanel;
    btnFTypesXSSUnCheck: TButton;
    btnFTypesXSSCheck: TButton;
    TabSheet14: TTabSheet;
    Label5: TLabel;
    rgDomainCheck: TRadioGroup;
    SpinEditLevel: TSpinEdit;
    Label16: TLabel;
    cbxShowFilter: TComboBox;
    GroupBox5: TGroupBox;
    edOutDir: TEdit;
    btFolder: TSpeedButton;
    GroupBox6: TGroupBox;
    cmbOutFormat: TComboBox;
    GroupBox7: TGroupBox;
    cbxDomainOpt: TCheckBox;
    cbxDateTimeOpt: TCheckBox;
    cbxUniqValues: TCheckBox;
    cbxUniqForms: TCheckBox;
    GroupBox8: TGroupBox;
    cbxBasicAuth: TCheckBox;
    cbxAuth: TCheckBox;
    Label26: TLabel;
    edAuthUser: TEdit;
    Label27: TLabel;
    edAuthPass: TEdit;
    Label24: TLabel;
    edLoginURL: TEdit;
    Label25: TLabel;
    edLogoutURL: TEdit;
    rbParse: TRadioButton;
    rbManual: TRadioButton;
    edParam: TEdit;
    GroupBox9: TGroupBox;
    MemoExt: TMemo;
    GroupBox10: TGroupBox;
    cbxExCommentsOpt: TCheckBox;
    cbxExEMailsOpt: TCheckBox;
    cbxExExternalOpt: TCheckBox;
    cbxExFormsOpt: TCheckBox;
    cbxExImagesOpt: TCheckBox;
    cbxExRobots: TCheckBox;
    cbxExCookiesOpt: TCheckBox;
    cbxExCSSOpt: TCheckBox;
    cbxExScriptOpt: TCheckBox;
    cbxExFilesOpt: TCheckBox;
    Button4: TButton;
    Button5: TButton;
    GroupBox11: TGroupBox;
    cbxExExtra: TCheckBox;
    btGEdit: TSpeedButton;
    sgOpt: TStringGrid;
    BitBtnAdd: TBitBtn;
    BitBtnEdit: TBitBtn;
    BitBtnDelete: TBitBtn;
    Panel1: TPanel;
    Panel5: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    LabelVulnerName: TLabel;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure acStopExecute(Sender: TObject);
    procedure acStartExecute(Sender: TObject);
    procedure btFolderClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rgDelimiterClick(Sender: TObject);
    procedure rgDomainCheckClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbxShowFilterChange(Sender: TObject);
    procedure btnUnCheckSQLClick(Sender: TObject);
    procedure btnCheckSQLClick(Sender: TObject);
    procedure btFileSqlClick(Sender: TObject);
    procedure btFileRespClick(Sender: TObject);
    procedure btnRespShowClick(Sender: TObject);
    procedure btnFTypesSQLUnCheckClick(Sender: TObject);
    procedure btnFTypesSQLCheckClick(Sender: TObject);
    procedure btnOpenXClick(Sender: TObject);
    procedure btnUncheckXSSClick(Sender: TObject);
    procedure btnCheckXSSClick(Sender: TObject);
    procedure btnFTypesXSSUnCheckClick(Sender: TObject);
    procedure btnFTypesXSSCheckClick(Sender: TObject);
    procedure sbtnCrawlerClick(Sender: TObject);
    procedure sbtnVulnerClick(Sender: TObject);
    procedure sbtnSettingsClick(Sender: TObject);
    procedure cmbSQLChange(Sender: TObject);
    procedure cmbCrossChange(Sender: TObject);
    procedure BitBtnAddClick(Sender: TObject);
    procedure BitBtnEditClick(Sender: TObject);
    procedure BitBtnDeleteClick(Sender: TObject);
    procedure btGEditClick(Sender: TObject);
    procedure sbtnFormsLinksCrossClick(Sender: TObject);
    procedure sbtnFormsLinksSQLClick(Sender: TObject);
    procedure btnVulnerStartClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure sgResultFixedCellClick(Sender: TObject; ACol, ARow: Integer);
    procedure SortStringGrid(ACol: Integer);
    procedure sgResultDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    Links: TLinkArray;
    Images, Emails, Forms, Files, Comments, Cookies, Robots, Extras: TStringList;
    ImagesUrl, EmailsUrl, FormsUrl, FilesUrl, CommentsUrl, CookiesUrl: TStringList;
    ExtDomains: TStringList;
    //Host, Domain: string;
    Host: string;
    CurDomain: string;
    StopCrawl: Boolean;
    StopTestSQL, StopTestXSS: Boolean;
    IgnoreExtSet: string;
    DelimiterChar: AnsiChar;
    RobotsFlag: Boolean;
    ExtraData: TStringList;
    //LoginURL, LogoutURL: string;
    ExtraGroups: string;
    ResponseList: TStringList;
    FilePrefix: string;
    //ExtraGroupsStr: string;
    Groups: TStringList;
    SortColumn: Integer;
    SortType: TSortType;
    IsFirstPage: Boolean;
    procedure Log(msg: string);
    procedure DoCrawlUrl(addr:string);
    procedure DoCrawl;
    function GetDomain(lnk: string): string;
    function GetDomainEx(url: string): string;
    function CheckLink(lnk:string): Boolean;
    procedure DoClear;
    function CheckDomain(aDom1, aDom2: string; aLevel: integer): Boolean;
    procedure LoadExtraData;
    function DoAuth: string;
    function GetDataFromURL(var url: string; follow: Boolean = True): string;
    function NormalizeLink(BaseUrl, Link: string): string;
    procedure MergeAndCheckList(aUnique:boolean;var aStrListVal, aStrListUrl,
      aStrListOut: TStringList);
    procedure DecodeCookieParam(expr: string; i: integer);
    procedure InitFormDataSets;
    procedure InitLinksDataSets;
    function DeAmpUrl(Url:string):string;
    function DeQuote(Val: string): string;
    function PrepareParam(url: string; param: TStringList): string;
    procedure PrepareVulnerabilityTest;
    procedure DoTestSQLVulnerability;
    procedure DoTestXSSVulnerability;
  end;

var
  frmMain: TfrmMain;

implementation

uses uRespForm;

{$R *.dfm}

//procedure for URL crawling
procedure TfrmMain.DoCrawlUrl(addr:string);
var
  curl_res, str, ws: string;
  url, uhst: string;
  re, re2: TRegExpr;
  n, i: integer;
  lnk: TLinkRec;
  isCSS,isFile: Boolean;
  fname: string;
  rbx: string;
  r: Integer;
  eGrp, eName, eTip, eVal: string;
begin
  Log('<---- '+addr+' ---->');
  re:=TRegExpr.Create;
  re2:=TRegExpr.Create;
  url:=addr;

  // go to URl
  try
    if cbxBasicAuth.Checked then
    begin
      with IdHTTP.Request do
      begin
        Username:=edAuthUser.Text;
        Password:=edAuthPass.Text;
        BasicAuthentication:=True;
      end;
    end
    else
    begin
      with IdHTTP.Request do
      begin
        Username:='';
        Password:='';
        BasicAuthentication:=False;
      end;
    end;

    IdHTTP.Request.AcceptEncoding:='identity';
    curl_res:=IdHTTP.Get(url);
    addr:=IdHTTP.URL.URI;
    if IsFirstPage then CurDomain:=GetDomain(addr);
    //    SaveStringToFile('dump.txt', curl_res);
  except on E:Exception do
    begin
      Log(E.Message);
      curl_res:='';
    end;
  end;

  // check redirection based on meta-tag
  if curl_res<>'' then
  begin

    // get current domain
    //CurDomain:=GetDomain(addr);

    re.Expression:='(?is)meta http-equiv=['',"]refresh['',"] content=['',"](.*?)[,|;]*url=(.*?)['',"]';
    str:='';
    if re.Exec(curl_res) then
    begin
      str:=Trim(re.Match[1]);
      url:=Trim(re.Match[2]);
      re2.Expression:='http*://*';
      if (str='0') or (str='0;') then //redirect
      begin
        if not re2.Exec(url) then
          url:=addr+'/'+url;

        lnk.BaseUrl:=addr;
        lnk.Url:=url;
        lnk.Short:=False;
        lnk.Processed:=true;

        if IsFirstPage then
        begin
          lnk.Outter:=false;
          CurDomain:=GetDomain(url);
        end
        else
        begin
          uhst:=GetDomain(url);
          if CheckDomain(uhst, CurDomain, SpinEditLevel.Value) then
            lnk.Outter:=false
          else
            lnk.Outter:=true;
        end;

        Links.Add(lnk);

        if not lnk.Outter then
          DoCrawlUrl(url);
      end
      else
      begin
        if Pos('?', url)<>1 then
        begin
          url:=AnsiLowerCase(url);
          if not re2.Exec(url) then
            url:=addr+'/'+url;
          lnk.BaseUrl:=addr;
          lnk.Url:=url;
          lnk.Outter:=false;
          lnk.Short:=False;
          lnk.Processed:=false;
          Links.Add(lnk);
        end;
      end;
    end;

    IsFirstPage:=false;

    //robots.txt
    if cbxExRobots.Checked then
    begin
      if not RobotsFlag then
      begin
        rbx:='';
        try
          rbx:=IdHTTP.Get(CurDomain+'/robots.txt');
        except
          rbx:='';
        end;
        if rbx<>'' then
        begin
          Robots.Add(addr);
          Robots.Add(rbx);
        end;
        RobotsFlag:=True;
      end;
    end;

    //emails
    re.Expression:='(?is)(\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b)';
    str:='';
    if re.Exec(curl_res) then
    begin
      repeat
        str:=Trim(re.Match[1]);
        Emails.Add(str);
        EmailsUrl.Add(addr)
      until not re.ExecNext;
    end;

    //links
    re.Expression:='(?is)<a(.*?)href=(.*?)[>|<]';
    str:='';
    if re.Exec(curl_res) then
    begin
      repeat
        str:=Trim(re.Match[1]);
        str:=Trim(re.Match[2]);
        n:=Pos('#', str);
        if n>0 then str:=LeftStr(str, n-1);
        str:=StringReplace(str, '''', '', [rfReplaceAll]);
        str:=StringReplace(str, '"', '', [rfReplaceAll]);
        n:=Pos(' ', str);
        if n>0 then str:=LeftStr(str, n-1);

        if Pos('mailto:', str)>0 then
        begin
          // email
          str:=StringReplace(str, 'mailto:', '', []);
          Emails.Add(str);
          EmailsUrl.Add(addr);
          str:='';
        end;

        if str<>'' then
        begin
          lnk.BaseUrl:=addr;
          lnk.Url:=DeAmpUrl(str);
          lnk.Outter:=False;
          // check for knowns files
          isFile:=CheckLink(str);
          if isFile then
          begin
            Files.Add(str);
            FilesUrl.Add(addr);
          end;
          lnk.Processed:=isFile;

          // check for short or full link
          if Pos('http', str)<>1 then
          begin
            lnk.Short:=True;
            lnk.Outter:=false;
            if Pos('javascript:', str)>0 then lnk.Processed:=true;
            if Pos(' ', str)>0 then lnk.Processed:=true;
          end
          else
          begin
            lnk.Short:=false;
            uhst:=GetDomain(str);

            //check for domain level
            if CheckDomain(uhst, CurDomain, SpinEditLevel.Value) then
            begin
              lnk.Outter:=False;
              if Pos('javascript:', str)>0 then lnk.Outter:=true;
              if Pos(' ', str)>0 then lnk.Outter:=true;
            end
            else
            begin
              lnk.Outter:=true;
            end;
          end;
          Links.Add(lnk);
        end;
      until not re.ExecNext;
    end;

    // frame and iframe extraction
    re.Expression:='(?is)frame(.*?)src="([^"]*)"[^>]*>';
    str:='';
    if re.Exec(curl_res) then
    begin
      repeat
        str:=Trim(re.Match[2]);
        n:=Pos('#', str);
        if n>0 then str:=LeftStr(str, n-1);

        if str<>'' then
        begin
          lnk.BaseUrl:=addr;
          lnk.Url:=str;
          lnk.Outter:=False;
          lnk.Processed:=false;

          if Pos('http', str)<>1 then
          begin
            lnk.Short:=True;
            lnk.Outter:=false;
            if Pos('javascript:', str)>0 then lnk.Processed:=true;
            if Pos(' ', str)>0 then lnk.Processed:=true;
          end
          else
          begin
            lnk.Short:=false;
            uhst:=GetDomain(str);

            if CheckDomain(uhst, CurDomain, SpinEditLevel.Value) then
            begin
              lnk.Outter:=False;
              if Pos('javascript:', str)>0 then lnk.Outter:=true;
              if Pos(' ', str)>0 then lnk.Outter:=true;
            end
            else
            begin
              lnk.Outter:=true;
            end;
          end;
          Links.Add(lnk);
        end;
      until not re.ExecNext;
    end;

    // tag "link" extraction
    re.Expression:='(?is)<link(.*?)href="([^"]*)"[^>]*>';
    str:='';
    if re.Exec(curl_res) then
    begin
      repeat
        isCSS:=false;
        ws:=Trim(re.Match[1]);
        str:=Trim(re.Match[2]);
        if AnsiContainsStr(ws, 'stylesheet') or
          AnsiContainsStr(ws, '/css') or AnsiContainsStr(str, '.css')
        then isCSS:=true;
        if isCSS then
        begin
          if cbxExCSSOpt.Checked then
          begin
            Files.Add(str);
            FilesUrl.Add(addr);
          end;
        end
        else
        begin
          Files.Add(str);
          FilesUrl.Add(addr);
        end;
      until not re.ExecNext;
    end;

    // tag "img" extraction
    if cbxExImagesOpt.Checked then
    begin
      //images
      re.Expression:='(?is)<img\s+src="([^"]*)"[^>]*>';
      str:='';
      if re.Exec(curl_res) then
      begin
        repeat
          str:=re.Match[1];
          Images.Add(str);
          ImagesUrl.Add(addr);
        until not re.ExecNext;
      end;
    end;

    // tag "script" extraction
    if cbxExScriptOpt.Checked then
    begin
      //scripts
      //  <script type="text/javascript" src="src.php"></script>
      re.Expression:='(?is)<script(.*?)src="([^"]*)"[^>]*></script>';
      str:='';
      if re.Exec(curl_res) then
      begin
        repeat
          str:=re.Match[2];
          Files.Add(str);
          FilesUrl.Add(addr);
        until not re.ExecNext;
      end;
    end;

    // forms extraction
    if cbxExFormsOpt.Checked then
    begin
      //    <form.*>
      re.Expression:='(?is)[^'',"]<form(.*?)>(.*?)<\/form>';
      str:='';
      fname:='';
      if re.Exec(curl_res) then
      begin
        repeat
          str:=re.Match[1];
          fname:='<form'+str+'>';
          //Forms.Add(addr+fname);
          str:=re.Match[2];
          ws := str;
          re2.Expression := '(?is)<input\s+(.*?)>';
          if re2.Exec(ws) then
          begin
            repeat
              str := re2.Match[1];
              Forms.Add(fname+DelimiterChar+'<input '+str+'>');
              FormsUrl.Add(addr);
            until not re2.ExecNext;
          end;
        until not re.ExecNext;
      end;
    end;

    //comments extraction
    if cbxExCommentsOpt.Checked then
    begin
      //comments
      re.Expression:='(?is)<!--(.*?)-->';
      str:='';
      if re.Exec(curl_res) then
      begin
        repeat
          str:=re.Match[1];
          Comments.Add(str);
          CommentsUrl.Add(addr)
        until not re.ExecNext;
      end;
    end;

    // cookie extraction
    if cbxExCookiesOpt.Checked then
    begin
      for i:=0 to IdCookies.CookieCollection.Count-1 do
      begin
        ws:=idCookies.CookieCollection.Items[i].CookieText;
        Cookies.Add(ws);
        CookiesUrl.Add(addr)
      end;
    end;

    // extra data exctraction
    if cbxExExtra.Checked then
    begin
      for r := 1 to sgOpt.RowCount-1 do
      begin
        with sgOpt do
        begin
          eGrp:=Cells[0,r];
          eName:=Cells[1,r];
          eTip:=Cells[2,r];
          eVal:=Cells[3,r];
        end;
        if eTip='RE' then
        begin
          re.Expression:=eVal;
          str:='';
          if re.Exec(curl_res) then
          begin
            repeat
              str:=re.Match[1];
              Extras.Add(eGrp+': '+eName+DelimiterChar+addr+DelimiterChar+str);
            until not re.ExecNext;
          end;
        end;
        if eTip='KW' then
        begin
          if Pos(eVal, curl_res)>0 then
            Extras.Add(eGrp+': '+eName+DelimiterChar+addr);
        end;
      end;
    end;
  end;
  re.free;
  re2.Free;
end;

procedure TfrmMain.DoTestSQLVulnerability;
var
  i, j, k, l, m, id: Integer;
  url, purl, str, resp, msg: string;
  param: TStringList;
  Domain: string;
  f: Boolean;
  Report: TStringList;
  RespCode: integer;
  StrTypes: string;
begin
  StopTestSQL:=false;

  Report:=TStringList.Create;

  MemoVulnerOut.Lines.Clear;
  param:=TStringList.Create;

  pgBar.Max:=frmFormsSQL.clbFormsSQL.Items.Count+frmFormsSQL.clbLinksSQL.Items.Count;
  pgBar.Position:=0;

  for i := 0 to clbFTypes.Items.Count-1 do
    if clbFTypes.Checked[i] then str:=str+clbFTypes.Items[i]+';';

  for i := 0 to frmFormsSQL.clbFormsSQL.Items.Count-1 do
  begin
    pgBar.StepIt;
    if frmFormsSQL.clbFormsSQL.Checked[i] then
    begin
      id:=i;
      if cdsForms.Locate('ID', id, []) then
      begin
        MemoVulnerOut.Lines.Add('');
        msg:='Test: '+cdsForms.FieldByName('Name').AsString;
        MemoVulnerOut.Lines.Add(msg);
        LabelVulnerName.Caption:=msg;
        if cbxRepSqlFormat.ItemIndex=1 then
        begin
          Report.Add('');
          Report.Add(msg);
        end;

        Domain:=GetDomainEx(cdsForms.FieldByName('URL').AsString);

        url:=cdsForms.FieldByName('Action').AsString;
        if Pos('http', url)<=0 then url:=Domain+url;

        for j := 0 to clbSQLs.Count-1 do
        begin
          if clbSQLs.Checked[j] then
          begin
            //MemoOut.Lines.Add('Check e'+cdsForms.FieldByName('Name').AsString+ ' Expr='+clbSqls.Items[j]);
            //add field
            param.Clear;
            cdsParams.First;
            while not cdsParams.Eof do
            begin
              if cdsParams.FieldByName('ID_F').AsInteger=id then
              begin
                if Pos(LowerCase(cdsParams.FieldByName('Type').AsString), StrTypes)>0 then
                  str:=cdsParams.FieldByName('Name').AsString+'='+clbSQLs.Items[j]
                else
                  str:=cdsParams.FieldByName('Name').AsString+'='+cdsParams.FieldByName('Value').AsString;
                if param.IndexOf(str)=-1 then
                  param.Add(str);
              end;
              cdsParams.Next;
            end;
            str:='';
            msg:='Check injection "'+clbSQLs.Items[j]+'"';
            l:=MemoVulnerOut.Lines.Add(msg);
            if cbxRepSqlFormat.ItemIndex=1 then
            begin
              m:=Report.Add(msg);
            end;
            if LowerCase(cdsForms.FieldByName('Method').AsString)='get' then
            begin
              purl:=PrepareParam(url, param);
              try
                resp:=IdHTTP.Get(purl);
              except
                resp:=IdHTTP.ResponseText;
              end;
            end
            else
            begin
              try
                resp:=IdHTTP.Post(url, param);
              except
                resp:=IdHTTP.ResponseText;
              end;
            end;
            RespCode:=IdHTTP.ResponseCode;
            f:=false;
            for k:=0 to ResponseList.Count-1 do
            begin
              str:=ResponseList[k];
              if Pos(str, resp)>0 then
              begin
                if cbxRepSqlFormat.ItemIndex=1 then
                begin
                  Report[m]:=Report[m]+' - INJECTION';
                  Report.Add('Injection='+clbSQLs.Items[j]+' Response='+str);
                end
                else
                begin
                  Report.Add('Injection in FORM '+cdsForms.FieldByName('Name').AsString+' URL='+url);
                  Report.Add('Injection='+clbSQLs.Items[j]+' Response='+str);
                  Report.Add('POST:');
                  Report.AddStrings(param);
                  Report.Add('');
                end;
                f:=True;
              end;
            end;

            if f then
              MemoVulnerOut.Lines[l]:=msg+' - INJECTION'
            else
              MemoVulnerOut.Lines[l]:=msg+' - PASSED';

            if (RespCode>=500) and (RespCode<510) then
            begin
              f:=true;
              // http error
              MemoVulnerOut.Lines[l]:=msg+' - INJECTION';
              Report.Add('HTTP Error = '+resp);
              if cbxRepSqlFormat.ItemIndex=0 then
              begin
                Report.Add('Injection in FORM '+cdsForms.FieldByName('Name').AsString+' URL='+url);
                Report.Add('Injection='+clbSQLs.Items[j]);
                Report.Add('Params:');
                Report.AddStrings(param);
                Report.Add('');
              end;
            end;

            if not f and (cbxRepSqlFormat.ItemIndex=1) then
              Report[m]:=Report[m]+' - PASSED';
          end;
          if StopTestSQL then Break;
          Application.ProcessMessages;
        end;
      end;
    end;
    if StopTestSQL then Break;
  end;

  for i := 0 to frmFormsSQL.clbLinksSQL.Items.Count-1 do
  begin
    pgBar.StepIt;
    if frmFormsSQL.clbLinksSQL.Checked[i] then
    begin
      id:=i;
      if cdsLinks.Locate('ID', id, []) then
      begin
        MemoVulnerOut.Lines.Add('');
        msg:='Test: '+cdsForms.FieldByName('Name').AsString;
        MemoVulnerOut.Lines.Add(msg);
        LabelVulnerName.Caption:=msg;
        if cbxRepSqlFormat.ItemIndex=1 then
        begin
          Report.Add('');
          Report.Add(msg);
        end;

        url:=cdsLinks.FieldByName('URL').AsString;

        for j := 0 to clbSQLs.Count-1 do
        begin
          if clbSQLs.Checked[j] then
          begin
            //MemoOut.Lines.Add('Check e'+cdsForms.FieldByName('Name').AsString+ ' Expr='+clbSqls.Items[j]);
            //add field
            param.Clear;
            cdsLinkParams.First;
            while not cdsLinkParams.Eof do
            begin
              if cdsLinkParams.FieldByName('ID_F').AsInteger=id then
              begin
                str:=cdsLinkParams.FieldByName('Name').AsString+'='+clbSQLs.Items[j];
                if param.IndexOf(str)=-1 then
                  param.Add(str);
              end;
              cdsLinkParams.Next;
            end;
            str:='';
            msg:='Check injection "'+clbSQLs.Items[j]+'"';
            l:=MemoVulnerOut.Lines.Add(msg);
            if cbxRepSqlFormat.ItemIndex=1 then
            begin
              m:=Report.Add(msg);
            end;
            purl:=PrepareParam(url, param);
            try
              resp:=IdHTTP.Get(purl);
            except
              resp:=IdHTTP.ResponseText;
            end;
            RespCode:=IdHTTP.ResponseCode;
            f:=false;
            for k:=0 to ResponseList.Count-1 do
            begin
              str:=ResponseList[k];
              if Pos(str, resp)>0 then
              begin
                if cbxRepSqlFormat.ItemIndex=1 then
                begin
                  Report[m]:=Report[m]+' - INJECTION';
                  Report.Add('Injection='+clbSQLs.Items[j]+' Response='+str);
                end
                else
                begin
                  Report.Add('Injection in LINK '+cdsLinks.FieldByName('Name').AsString+' URL='+url);
                  Report.Add('Injection='+clbSQLs.Items[j]+' Response='+str);
                  Report.Add('POST:');
                  Report.AddStrings(param);
                  Report.Add('');
                end;
                f:=True;
              end;
            end;
            if f then
              MemoVulnerOut.Lines[l]:=msg+' - INJECTION'
            else
              MemoVulnerOut.Lines[l]:=msg+' - PASSED';

            if (RespCode>=500) and (RespCode<510) then
            begin
              f:=true;
              // http error
              MemoVulnerOut.Lines[l]:=msg+' - INJECTION (HTTP ERROR)';
              Report.Add('HTTP Error = '+resp);
              if cbxRepSqlFormat.ItemIndex=0 then
              begin
                Report.Add('Injection in LINK '+url);
                Report.Add('Injection='+clbSQLs.Items[j]);
                Report.Add('Params:');
                Report.AddStrings(param);
                Report.Add('');
              end;
            end;

            if not f and (cbxRepSqlFormat.ItemIndex=1) then
              Report[m]:=Report[m]+' - PASSED';
          end;
          if StopTestSQL then Break;
          Application.ProcessMessages;
        end;
      end;
    end;
    if StopTestSQL then Break;
  end;

  MemoVulnerOut.Lines.Clear;
  MemoVulnerOut.Lines.Add('List of SQL-INJECTION:');
  if cbxRepSqlFormat.ItemIndex=0 then
  begin
    if Report.Count=0 then
      MemoVulnerOut.Lines.Add('Not found')
    else
      MemoVulnerOut.Lines.AddStrings(Report);
  end
  else
    MemoVulnerOut.Lines.AddStrings(Report);

  Report.SaveToFile(FilePrefix+'sql_report.txt');
  Report.Free;
end;

procedure TfrmMain.DoTestXSSVulnerability;
var
  i, j, k, l, m, id: Integer;
  url, purl, str, estr, resp, msg: string;
  param: TStringList;
  Domain: string;
  f: Boolean;
  Report: TStringList;
  RespCode: Integer;
  StrTypes: string;
begin
  StopTestXSS:=false;

  Report:=TStringList.Create;

  MemoVulnerOut.Lines.Clear;
  param:=TStringList.Create;
  pgBar.Max:=frmFormsXSS.clbFormsXSS.Items.Count + frmFormsXSS.clbLinksXSS.Items.Count;
  pgBar.Position:=0;

  for i := 0 to clbFTypesX.Items.Count-1 do
    if clbFTypesX.Checked[i] then str:=str+clbFTypesX.Items[i]+';';

  for i := 0 to frmFormsXSS.clbFormsXSS.Items.Count-1 do
  begin
    pgBar.StepIt;
    if frmFormsXSS.clbFormsXSS.Checked[i] then
    begin
      id:=i;
      if cdsForms.Locate('ID', id, []) then
      begin
        MemoVulnerOut.Lines.Add('');
        msg:='Test: '+cdsForms.FieldByName('Name').AsString;
        MemoVulnerOut.Lines.Add(msg);
        LabelVulnerName.Caption:=msg;
        if cbxRepXSSFormat.ItemIndex=1 then
        begin
          Report.Add('');
          Report.Add(msg);
        end;

        Domain:=GetDomainEx(cdsForms.FieldByName('URL').AsString);

        url:=cdsForms.FieldByName('Action').AsString;
        if Pos('http', url)<=0 then url:=Domain+url;

        for j := 0 to clbXSS.Count-1 do
        begin
          if clbXSS.Checked[j] then
          begin
            //MemoOut.Lines.Add('Check e'+cdsForms.FieldByName('Name').AsString+ ' Expr='+clbSqls.Items[j]);
            //add field
            param.Clear;
            cdsParams.First;
            while not cdsParams.Eof do
            begin
              if cdsParams.FieldByName('ID_F').AsInteger=id then
              begin
                if Pos(LowerCase(cdsParams.FieldByName('Type').AsString), StrTypes)>0 then
                  str:=cdsParams.FieldByName('Name').AsString+'='+clbXSS.Items[j]
                else
                  str:=cdsParams.FieldByName('Name').AsString+'='+cdsParams.FieldByName('Value').AsString;
                if param.IndexOf(str)=-1 then
                  param.Add(str);
              end;
              cdsParams.Next;
            end;
            str:='';
            msg:='Check injection "'+clbXSS.Items[j]+'"';
            l:=MemoVulnerOut.Lines.Add(msg);
            if cbxRepXSSFormat.ItemIndex=1 then
            begin
              m:=Report.Add(msg);
            end;
            if LowerCase(cdsForms.FieldByName('Method').AsString)='get' then
            begin
              url:=PrepareParam(url, param);
              try
                resp:=IdHTTP.Get(url);
              except
                resp:=IdHTTP.ResponseText;
              end;
              RespCode:=IdHTTP.ResponseCode;
            end
            else
            begin
              try
                resp:=IdHTTP.Post(url, param);
              except
                resp:=IdHTTP.ResponseText;
              end;
              RespCode:=IdHTTP.ResponseCode;
            end;
            //SaveStringToFile('dump1.txt',resp);
            f:=false;
            str:=clbXSS.Items[j];
            estr:=HTTPEncode(clbXSS.Items[j]);
            if (Pos(str, resp)>0) or (Pos(estr, resp)>0) then
            begin
              if cbxRepXSSFormat.ItemIndex=1 then
              begin
                Report[m]:=Report[m]+' - INJECTION';
                Report.Add('Injection='+str);
              end
              else
              begin
                Report.Add('Injection in FORM '+cdsForms.FieldByName('Name').AsString+' URL='+url);
                Report.Add('Injection='+clbXSS.Items[j]+' Response='+str);
                Report.Add('POST:');
                Report.AddStrings(param);
                Report.Add('');
              end;
              f:=True;
            end;

            if f then
              MemoVulnerOut.Lines[l]:=msg+' - INJECTION'
            else
              MemoVulnerOut.Lines[l]:=msg+' - PASSED';

            {
            if (RespCode>=500) and (RespCode<510) then
            begin
              f:=true;
              // http error
              MemoVulnerOut.Lines[l]:=msg+' - INJECTION (HTTP ERROR)';
              Report.Add('HTTP Error = '+resp);
              if cbxRepXSSFormat.ItemIndex=0 then
              begin
                Report.Add('Injection in FORM '+cdsForms.FieldByName('Name').AsString+' URL='+url);
                Report.Add('Injection='+clbXSS.Items[j]);
                Report.Add('POST:');
                Report.AddStrings(param);
                Report.Add('');
              end;
            end;
            }
            if not f and (cbxRepXSSFormat.ItemIndex=1) then
              Report[m]:=Report[m]+' - PASSED';

          end;
          if StopTestXSS then Break;
          Application.ProcessMessages;
        end;
      end;
    end;
    if StopTestXSS then Break;
  end;

  for i := 0 to frmFormsXSS.clbLinksXSS.Items.Count-1 do
  begin
    pgBar.StepIt;
    if frmFormsXSS.clbLinksXSS.Checked[i] then
    begin
      id:=i;
      if cdsLinks.Locate('ID', id, []) then
      begin
        MemoVulnerOut.Lines.Add('');
        msg:='Test: '+cdsLinks.FieldByName('Name').AsString;
        MemoVulnerOut.Lines.Add(msg);
        LabelVulnerName.Caption:=msg;
        if cbxRepXSSFormat.ItemIndex=1 then
        begin
          Report.Add('');
          Report.Add(msg);
        end;

        //Domain:=GetDomainEx(cdsForms.FieldByName('URL').AsString);

        url:=cdsLinks.FieldByName('Url').AsString;

        for j := 0 to clbXSS.Count-1 do
        begin
          if clbXSS.Checked[j] then
          begin
            //MemoOut.Lines.Add('Check e'+cdsForms.FieldByName('Name').AsString+ ' Expr='+clbSqls.Items[j]);
            //add field
            param.Clear;
            cdsLinkParams.First;
            while not cdsLinkParams.Eof do
            begin
              if cdsLinkParams.FieldByName('ID_F').AsInteger=id then
              begin
                str:=cdsLinkParams.FieldByName('Name').AsString+'='+clbXSS.Items[j];
                if param.IndexOf(str)=-1 then
                  param.Add(str);
              end;
              cdsLinkParams.Next;
            end;
            str:='';
            msg:='Check injection "'+clbXSS.Items[j]+'"';
            l:=MemoVulnerOut.Lines.Add(msg);
            if cbxRepXSSFormat.ItemIndex=1 then
            begin
              m:=Report.Add(msg);
            end;
            purl:=PrepareParam(url, param);
            try
              resp:=IdHTTP.Get(purl);
            except
              resp:=IdHTTP.ResponseText;
            end;
            RespCode:=IdHTTP.ResponseCode;
            //SaveStringToFile('dump1.txt',resp);
            f:=false;
            estr:=HTTPEncode(clbXSS.Items[j]);
            str:=clbXSS.Items[j];
            if (Pos(str, resp)>0) or (Pos(estr, resp)>0) then
            begin
              if cbxRepXSSFormat.ItemIndex=1 then
              begin
                Report[m]:=Report[m]+' - INJECTION';
                Report.Add('Injection='+str);
              end
              else
              begin
                Report.Add('Injection in LINK '+cdsLinks.FieldByName('Name').AsString+' URL='+url);
                Report.Add('Injection='+clbXSS.Items[j]+' Response='+str);
                Report.Add('PARAMETERS:');
                Report.AddStrings(param);
                Report.Add('');
              end;
              f:=True;
            end;
            if f then
              MemoVulnerOut.Lines[l]:=msg+' - INJECTION'
            else
              MemoVulnerOut.Lines[l]:=msg+' - PASSED';

            if (RespCode>=500) and (RespCode<510) then
            begin
              f:=true;
              // http error
              MemoVulnerOut.Lines[l]:=msg+' - INJECTION';
              Report.Add('HTTP Error = '+resp);
              if cbxRepXSSFormat.ItemIndex=0 then
              begin
                Report.Add('Injection in LINK '+url);
                Report.Add('Injection='+clbXSS.Items[j]);
                Report.Add('POST:');
                Report.AddStrings(param);
                Report.Add('');
              end;
            end;

            if not f and (cbxRepXSSFormat.ItemIndex=1) then
              Report[m]:=Report[m]+' - PASSED';
          end;
          if StopTestXSS then Break;
          Application.ProcessMessages;
        end;
      end;
    end;
    if StopTestXSS then Break;
  end;

  MemoVulnerOut.Lines.Clear;
  MemoVulnerOut.Lines.Add('List of XSS-INJECTION:');
  if cbxRepXSSFormat.ItemIndex=0 then
  begin
    if Report.Count=0 then
      MemoVulnerOut.Lines.Add('Not found')
    else
      MemoVulnerOut.Lines.AddStrings(Report);
  end
  else
    MemoVulnerOut.Lines.AddStrings(Report);

  Report.SaveToFile(FilePrefix+'xss_report.txt');
  Report.Free;
end;

// load extra data
procedure TfrmMain.LoadExtraData;
var
  i, k, n: Integer;
  p, str: string;
begin
  if ExtraData.Count>0 then
    sgOpt.RowCount:=ExtraData.Count+1;

  for i := 0 to ExtraData.Count-1 do
  begin
    p:=ExtraData[i];
    k:=0;
    repeat
      n:=Pos(';', p);
      if n>0 then
      begin
        str:=LeftStr(p, n-1);
        sgOpt.Cells[k, i+1]:=str;
        p:=Copy(p, n+1, Length(p)-n);
        k:=k+1;
      end;
    until n=0;
  end;
end;

// log procedure
procedure TfrmMain.Log(msg: string);
begin
  Memo.Lines.Add(msg);
end;

// check unique values and merge two list
procedure TfrmMain.MergeAndCheckList(aUnique:boolean;var aStrListVal, aStrListUrl,
  aStrListOut: TStringList);
var
  UniqList: TStringList;
  CopyList: TStringList;
  CopyListUrl, CopyListVal: TStringList;
  str: string;
  i, p: integer;
begin
  i:=aStrListUrl.Count;
  UniqList:=TStringList.Create;
  CopyList:=TStringList.Create;
  CopyListUrl:=TStringList.Create;
  CopyListVal:=TStringList.Create;
  for i := 0 to aStrListVal.Count-1 do
  begin
    str:=aStrListVal[i];
    if aUnique then
    begin
      if UniqList.IndexOf(str)=-1 then
      begin
        CopyList.Add(aStrListUrl[i]+DelimiterChar+aStrListVal[i]);
        CopyListUrl.Add(aStrListUrl[i]);
        CopyListVal.Add(aStrListVal[i]);
        UniqList.Add(str);
      end;
    end
    else
      CopyList.Add(aStrListUrl[i]+DelimiterChar+aStrListVal[i]);
  end;
  aStrListOut.Clear;
  if aUnique then
  begin
    aStrListVal.Clear;
    aStrListUrl.Clear;
  end;

  for i := 0 to CopyList.Count-1 do
  begin
    aStrListOut.Add(CopyList[i]);
    if aUnique then
    begin
      aStrListVal.Add(CopyListVal[i]);
      aStrListUrl.Add(CopyListUrl[i]);
    end;
  end;

  UniqList.Free;
  CopyList.Free;
  CopyListUrl.Free;
  CopyListVal.Free;
end;

//function for normalize line
function TfrmMain.NormalizeLink(BaseUrl, Link: string): string;
var
  uHost, uHostPath: string;
  flag: Boolean;
  p: integer;
  idURL: TIdURI;
begin
  IdURL:=TIdURI.Create(BaseUrl);
  Result:='';
  p:=PosEx('/', BaseUrl, 9);
  if p>0 then uHost:=LeftStr(BaseUrl, p-1)
  else uHost:=BaseUrl;

  uHostPath:=uHost+idURL.Path;

  if (Pos('../', Link)>0) or (Pos('/?', Link)=1) then
  begin
    if Pos('/',Link)=1 then Link:=Copy(Link, 2, Length(Link)-1);
      Result:=uHostPath+Link;
  end
  else
  begin
    if Pos('/', Link)=1 then
      Result:=uHost+Link
    else
    begin
      Result:=uHostPath+Link;
    end;
  end;
  idURL.Free;
end;

function TfrmMain.PrepareParam(url: string; param: TStringList): string;
var
  res: string;
  i, n: Integer;
begin
  res:=url+'?';
  n:=param.Count-1;
  for i := 0 to n do
  begin
    res:=res+HTTPEncode(param[i]);
    if i<>n then
      res:=res+'&';
  end;
  Result:=res;
end;

procedure TfrmMain.PrepareVulnerabilityTest;
var
  i, idf, idp: Integer;
  p, n: Integer;
  str, nam, val, expr, fname, fact, fmeth, ptype, pname, pval, frm: string;
begin
  InitFormDataSets;
  InitLinksDataSets;

  frmFormsSQL.clbFormsSQL.Items.Clear;
  i:=0;
  cdsForms.First;
  while not cdsForms.Eof do
  begin
    frmFormsSQL.clbFormsSQL.Items.Add(cdsForms.FieldByName('Name').AsString+ ' ('+cdsForms.FieldByName('Method').AsString+') '+
     cdsForms.FieldByName('Action').AsString + ' (URL='+cdsForms.FieldByName('URL').AsString+')');
    frmFormsSQL.clbFormsSQL.Checked[i]:=True;
    Inc(i);
    cdsForms.Next;
  end;

  frmFormsSQL.clbLinksSQL.Items.Clear;
  i:=0;
  cdsLinks.First;
  while not cdsLinks.Eof do
  begin
    frmFormsSQL.clbLinksSQL.Items.Add(cdsLinks.FieldByName('Name').AsString+ ' (URL='+cdsLinks.FieldByName('URL').AsString+')');
    frmFormsSQL.clbLinksSQL.Checked[i]:=True;
    Inc(i);
    cdsLinks.Next;
  end;

  frmFormsXSS.clbFormsXSS.Items.Clear;
  i:=0;
  cdsForms.First;
  while not cdsForms.Eof do
  begin
    frmFormsXSS.clbFormsXSS.Items.Add(cdsForms.FieldByName('Name').AsString+' (URL='+cdsForms.FieldByName('URL').AsString+')');
    frmFormsXSS.clbFormsXSS.Checked[i]:=True;
    Inc(i);
    cdsForms.Next;
  end;

  frmFormsXSS.clbLinksXSS.Items.Clear;
  i:=0;
  cdsLinks.First;
  while not cdsLinks.Eof do
  begin
    frmFormsXSS.clbLinksXSS.Items.Add(cdsLinks.FieldByName('Name').AsString+ ' (URL='+cdsLinks.FieldByName('URL').AsString+')');
    frmFormsXSS.clbLinksXSS.Checked[i]:=True;
    Inc(i);
    cdsLinks.Next;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  Registry: TRegistry;
  ExtStr, s1, s2: string;
  p, str: string;
  flag: boolean;
  i, k, n, w: Integer;
  gstr: string;

function GetKey:string;
var
  s: string;
  i: integer;
begin
  s:='-9,HWHLMHW#/)2';
  for i:=1 to Length(s) do
    s[i]:=chr((ord('z') xor ord(s[i])));
  Result:=s;
end;

begin
  Links:=TLinkArray.Create;

  Groups:=TStringList.Create;

  btStop.Visible:=false;

  sgOpt.Cells[0,0]:='Group';
  sgOpt.Cells[1,0]:='Name';
  sgOpt.Cells[2,0]:='Type';
  sgOpt.Cells[3,0]:='Value';

  // lists for links and base urls
  Images:=TStringList.Create;
  Emails:=TStringList.Create;
  Forms:=TStringList.Create;
  Files:=TStringList.Create;
  Comments:=TStringList.Create;
  Cookies:=TStringList.Create;
  ImagesUrl:=TStringList.Create;
  EmailsUrl:=TStringList.Create;
  FormsUrl:=TStringList.Create;
  FilesUrl:=TStringList.Create;
  CommentsUrl:=TStringList.Create;
  CookiesUrl:=TStringList.Create;
  ExtDomains:=TStringList.Create;

  ResponseList:=TStringList.Create;

  Robots:=TStringList.Create;
  Extras:=TStringList.Create;

  edOutDir.Text:=ExtractFilePath(Application.ExeName)+'Output';

  try
    Registry := TRegistry.Create;
    Registry.RootKey := HKEY_CURRENT_USER;
    Registry.OpenKey('Software\'+ProgramName,true);
    ExtStr:=Registry.ReadString('IgnoreExtSetConst');
    ExtraGroups:=Registry.ReadString('ExtraGroups');
    P:=Registry.ReadString('P');
    if (P='') or (Decrypt(P,StartKey, MultKey, AddKey)<>GetKey) then
    begin
      flag:=false;
      P:='';
      if InputQuery('Unregistered software!!!', 'Enter key', p) then
      begin
        if P<>GetKey then flag:=true;
      end
      else
        flag:=true;
      if flag then
      begin
        ShowMessage('Wrong key!');
        Application.Terminate;
      end
      else
      begin
        Registry.WriteString('P', Encrypt(P, StartKey, MultKey, AddKey));
      end;
    end;
    if ExtStr='' then ExtStr:=IgnoreExtSetConst;
    Registry.Free;
  except
    ExtStr:=IgnoreExtSetConst;
    ExtraGroups:=ExtraGroupsDef;
  end;

  if ExtraGroups='' then ExtraGroups:=ExtraGroupsDef;

  Groups.Clear;
  gstr:=ExtraGroups;
  repeat
    n:=Pos(';', gstr);
    str:=LeftStr(gstr, n-1);
    gstr:=Copy(gstr, n+1, Length(gstr)-n);
    if str<>'' then
      Groups.Add(str)
  until n=0;

  ExtraData:=TStringList.Create;
  ExtraData.LoadFromFile(ExtractFilePath(Application.ExeName)+'Data\wcextras.dat', TEncoding.ASCII);
  MemoExt.Text:=ExtStr;

  // change User Agent for some sites
  IdHTTP.Request.UserAgent:= 'Mozilla/5.0 (Windows NT 6.1; rv:2.0) Gecko/20100101 Firefox/4.0';

  PanelCrawler.Visible:=True;
  PanelVulner.Visible:=False;
  PanelSetup.Visible:=False;

  edSQLFile.Text:=ExtractFilePath(Application.ExeName)+'Data\sql.txt';
  edRespFile.Text:=ExtractFilePath(Application.ExeName)+'Data\Response.txt';
  edXSSFile.Text:=ExtractFilePath(Application.ExeName)+'Data\xss.txt';
  OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName)+'Data\';

  clbSQLs.Items.LoadFromFile(edSQLFile.Text);
  clbXSS.Items.LoadFromFile(edXSSFile.Text);

  ResponseList.Clear;
  ResponseList.LoadFromFile(edRespFile.Text);

  w:=PanelTop.ClientWidth div 3;
  sbtnCrawler.Width:=w;
  sbtnVulner.Width:=w;

  LoadExtraData;

  pgcSettings.ActivePageIndex:=0;

  btnFTypesXSSCheck.Click;
  btnFTypesSQLCheck.Click;
  btnCheckSQL.Click;
  btnCheckXSS.Click;

  SortColumn:=-1;
  SortType:=gstNone;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  Links.Free;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  edHost.SetFocus;
end;

function TfrmMain.GetDataFromURL(var url: string; follow: Boolean): string;
var
  curl_res, str, addr: string;
  re, re2: TRegExpr;
begin
  addr:=url;
  re:=TRegExpr.Create;
  re2:=TRegExpr.Create;
  url:=addr;
  try
    IdHTTP.Request.AcceptEncoding:='identity';
    curl_res:=IdHTTP.Get(url);
    addr:=IdHTTP.URL.URI;
  except on E:Exception do
    begin
      Log(E.Message);
      curl_res:='';
    end;
  end;

  if follow and (curl_res<>'') then
  begin
    re.Expression:='(?is)meta http-equiv=['',"]refresh['',"] content=['',"](.*?);*url=(.*?)['',"]';
    str:='';
    if re.Exec(curl_res) then
    begin
      str:=Trim(re.Match[1]);
      url:=Trim(re.Match[2]);
      re2.Expression:='http*://*';
      if (str='0') or (str='0;') then //redirect
      begin
        if not re2.Exec(url) then
          url:=addr+'/'+url;
        curl_res:=GetDataFromURL(url);
      end
      else
      begin
        if Pos('?', url)<>1 then
        begin
          url:=AnsiLowerCase(url);
          if not re2.Exec(url) then
            url:=addr+'/'+url;
        end;
      end;
    end;
  end;
  Result:=curl_res;
end;

function TfrmMain.GetDomain(lnk: string): string;
var
  IdURL: TIdURI;
begin
  idURL:=TIdURI.Create(lnk);
  Result:=IdURL.Host;
  IdURL.Free;
end;

function TfrmMain.GetDomainEx(url: string): string;
var
  domain: string;
  p: Integer;
begin
  p:=PosEx('/', url, 9);
  if p>0 then domain:=LeftStr(url, p-1)
  else  domain:=url;
  Result:=domain;
end;

procedure TfrmMain.InitFormDataSets;
var
  i, idf, idp: Integer;
  p, n: Integer;
  str, nam, val, expr, fname, fact, fmeth, ptype, pname, pval, frm: string;
  re, re2: TRegExpr;
begin
  //Forms.LoadFromFile('forms.txt');

  cdsForms.Close;
  cdsParams.Close;
  cdsForms.Open;
  cdsParams.Open;

  //delete all records
  cdsForms.EmptyDataSet;
  cdsParams.EmptyDataSet;

  idf:=-1;  //id form
  idp:=0;  //id params

  re:=TRegExpr.Create;
  re2:=TRegExpr.Create;
  for i := 0 to Forms.Count-1 do
  begin
    frm:=Forms[i];
    fname:='';
    fact:='';
    fmeth:='';
    re.Expression:='(?is)<form(.*?)>';
    if re.Exec(frm) then
    begin
      str:=Trim(re.Match[1])+' ';
      re2.Expression:='method=(.*?)\s';
      if re2.Exec(str) then fmeth:=re2.Match[1];
      re2.Expression:='action=(.*?)\s';
      if re2.Exec(str) then fact:=re2.Match[1];
      re2.Expression:='name=(.*?)\s';
      if re2.Exec(str) then fname:=re2.Match[1];
    end;

    fmeth:=DeQuote(fmeth);
    fact:=DeQuote(fact);
    fname:=DeQuote(fname);

    if fact='' then fact:=FormsUrl[i];

    if Pos('http', fact)=1 then
      if GetDomain(fact)<>GetDomain(FormsUrl[i]) then
        fact:='';

    if (fact<>'') then
    begin

      fname := fname + '   ['+fact+']';

      if cdsForms.Locate('Name', fname, []) then
        idf:=cdsForms.FieldByName('ID').AsInteger
      else
      begin
        Inc(idf);
        cdsForms.Append;
        cdsForms.FieldByName('ID').Value:=idf;
        cdsForms.FieldByName('Name').Value:=fname;
        cdsForms.FieldByName('Action').Value:=fact;
        cdsForms.FieldByName('Method').Value:=fmeth;
        cdsForms.FieldByName('URL').Value:=FormsUrl[i];
        cdsForms.Post;
      end;

      ptype:='';
      pval:='';
      pname:='';
      re.Expression:='(?is)<input\s+(.*?)>';
      if re.Exec(frm) then
      begin
        str := Trim(re.Match[1])+' ';
        re2.Expression:='type=(.*?)\s';
        if re2.Exec(str) then ptype:=re2.Match[1];
        re2.Expression:='name=(.*?)\s';
        if re2.Exec(str) then pname:=re2.Match[1];
        re2.Expression:='value=(.*?)\s';
        if re2.Exec(str) then pval:=re2.Match[1];
      end;

      cdsParams.Append;
      cdsParams.FieldByName('ID').Value:=idp;
      cdsParams.FieldByName('ID_F').Value:=idf;
      cdsParams.FieldByName('Name').Value:=DeQuote(pname);
      cdsParams.FieldByName('Type').Value:=DeQuote(ptype);
      cdsParams.FieldByName('Value').Value:=DeQuote(pval);
      cdsParams.Post;
      Inc(idp);
    end;
  end;
end;

procedure TfrmMain.InitLinksDataSets;
var
  idf, idp: integer;
  i: integer;
  BaseUrl, Url: string;
  IdURL: TIdURI;
  p, p1: Integer;
  params, pname, pval, ppar: string;
begin
  cdsLinks.Close;
  cdsLinkParams.Close;
  cdsLinks.Open;
  cdsLinkParams.Open;

  //delete all records
  cdsLinks.EmptyDataSet;
  cdsLinkParams.EmptyDataSet;

  idf:=-1;  //id form
  idp:=0;  //id params

  IdURL:=TIdURI.Create;

  for i := 0 to Links.Count-1 do
    if not Links.Items[i].Outter then
    begin
      Url:=Links.Items[i].Url;
      BaseUrl:=Links.Items[i].BaseUrl;
      if Pos('http', Url)<>1 then
        Url:=NormalizeLink(BaseUrl, Url);

      Url:=DeAmpUrl(Url);

      IdURL.URI:=Url;

      params:=IdURL.Params;
      if params<>'' then
      begin
        p:=Pos('?', Url);
        if p>0 then url:=LeftStr(Url, p-1);

        BaseUrl:=IdURL.Host+IdURL.Path;

        if not cdsLinks.Locate('Name', BaseUrl, []) then
        begin
          Inc(idf);
          cdsLinks.Append;
          cdsLinks.FieldByName('ID').Value:=idf;
          cdsLinks.FieldByName('Name').Value:=BaseUrl;
          cdsLinks.FieldByName('Url').Value:=Url;

          //params
          repeat
            p:=Pos('&', params);
            if p>0 then
            begin
              ppar:=LeftStr(params, p-1);
              params:=Copy(params, p+1, Length(params)-p);
            end
            else
              ppar:=params;

            p1:=Pos('=', ppar);
            pname:=LeftStr(ppar, p1-1);

            if not cdsLinkParams.Locate('ID_F;Name', VarArrayOf([idf, pname]),[]) then
            begin
              cdsLinkParams.Append;
              cdsLinkParams.FieldByName('ID').Value:=idp;
              cdsLinkParams.FieldByName('ID_F').Value:=idf;
              cdsLinkParams.FieldByName('Name').Value:=pname;
              cdsLinkParams.Post;
              Inc(idp);
            end;
          until (p=0);
        end;
      end;
    end;
end;

function TfrmMain.CheckDomain(aDom1, aDom2: string; aLevel: integer): Boolean;
var
  s1, s2: TStringList;
  p, i: Integer;
  s: string;
  flag: Boolean;
begin
  Result:=false;
  if rgDomainCheck.ItemIndex=0 then
  begin
    if (AnsiLowerCase(aDom1)=AnsiLowerCase(aDom2))
        or (AnsiLowerCase('www.'+aDom1)=AnsiLowerCase(aDom2))
        or (AnsiLowerCase(aDom1)=AnsiLowerCase('www.'+aDom2))
    then Result:=true;
  end;
  if rgDomainCheck.ItemIndex=1 then
    if LowerCase(aDom1)=LowerCase(aDom2) then Result:=true;
  if rgDomainCheck.ItemIndex=2 then
  begin
    s1:=TStringList.Create;
    s2:=TStringList.Create;
    repeat
      p:=Pos('.', aDom1);
      if p>0 then
      begin
        s:=LeftStr(aDom1, p-1);
        s1.Insert(0, s);
        aDom1:=Copy(aDom1, p+1, Length(aDom1)-p);
      end;
    until p=0;
    s1.Insert(0,aDom1);

    s:='';
    repeat
      p:=Pos('.', aDom2);
      if p>0 then
      begin
        s:=LeftStr(aDom2, p-1);
        s2.Insert(0, s);
        aDom2:=Copy(aDom2, p+1, Length(aDom2)-p);
      end;
    until p=0;
    s2.Insert(0,aDom2);

    if aLevel<2 then aLevel:=2;

    if (s1.Count>=aLevel) and (s2.Count>=aLevel) then
    begin
      flag:=True;
      for i:= 0 to aLevel-1 do
        if LowerCase(s1[i])<>LowerCase(s2[i]) then flag:=false;
      Result:=flag;
    end;
  end;
end;

function TfrmMain.CheckLink(lnk: string): Boolean;
var
  doc, ext: string;
  IdURL: TIdURI;
begin
  Result:=false;
  idURL:=TIdURI.Create(lnk);
  doc:=IdURL.Document;
  ext:=ExtractFileExt(doc);
  if (ext<>'') and (Pos(ext+' ', IgnoreExtSet)>0) then Result:=true;
  IdURL.Free;
end;

procedure TfrmMain.cmbSQLChange(Sender: TObject);
begin
  sbtnFormsLinksSQL.Enabled:=cmbSQL.ItemIndex=1;
  if cmbSQL.ItemIndex=0 then
  begin
    with frmFormsSQL do
    begin
      clbFormsSQL.CheckAll(cbChecked, false, false);
      clbLinksSQL.CheckAll(cbChecked, false, false);
    end;
  end;
end;

// main procedure for crawl
procedure TfrmMain.DoCrawl;
var
  lnk: TLinkRec;
  url, purl: string;
  uHost, uHostPath: string;
  flag: Boolean;
  idx, cnt: Integer;
  p: integer;
  idURL: TIdURI;
begin

  IdCookies.CookieCollection.Clear;

  // auth
  if cbxAuth.Checked then
  begin
    purl:=DoAuth;
    lnk.BaseUrl:=edHost.Text;
    lnk.Url:=purl;
    lnk.Outter:=false;
    lnk.Short:=False;
    lnk.Processed:=true;
    Links.Add(lnk);
  end;

  StopCrawl:=false;
  url:=edHost.Text;

  lnk.BaseUrl:=edHost.Text;
  lnk.Url:=url;
  lnk.Outter:=false;
  lnk.Short:=False;
  lnk.Processed:=true;
  if purl<>'' then
    lnk.Processed:=false;

  Links.Add(lnk);
  if purl<>'' then url:=purl;

  flag:=true;

  IsFirstPage:=True;

  cnt:=0;
  // begin loop for crawl
  while flag do
  begin
    Inc(cnt);
    Url:=DeAmpUrl(url);
    if not (cbxAuth.Checked and (edLogoutURL.Text<>'') and (url=edLogoutURL.Text)) then
      DoCrawlUrl(url);

    //flag:=False;

    idx:=Links.GetNextLinkIndex;
    if idx>0 then
    begin
      lnk:=Links.Items[idx];

      if lnk.Short then
      begin
        IdURL:=TIdURI.Create(lnk.BaseUrl);

        p:=PosEx('/', lnk.BaseUrl, 9);
        if p>0 then uHost:=LeftStr(lnk.BaseUrl, p-1)
        else uHost:=lnk.BaseUrl;

        uHostPath:=uHost+idURL.Path;

        if (Pos('../', lnk.Url)>0) or (Pos('/?', lnk.url)=1) then
        begin
          if Pos('/',lnk.Url)=1 then lnk.Url:=Copy(lnk.Url, 2, Length(lnk.Url)-1);
          url:=uHostPath+lnk.Url;
        end
        else
        begin
          if Pos('/', lnk.Url)=1 then
            url:=uHost+lnk.Url
          else
          begin
            url:=uHostPath+lnk.Url;
          end;
        end;
        idURL.Free;
      end
      else url:=lnk.Url;
      Links.MarkProcessed(idx);
    end
    else
      flag:=false;
    LabelCount.Caption:=IntToStr(Links.Count);
    LabelNP.Caption:=IntToStr(Links.CountNoProc);
    LabelProc.Caption:=IntToStr(cnt);
    Application.ProcessMessages;
    if StopCrawl then
    begin
      flag:=false;
      Log('Stoped!');
    end;
  end;
  // logout
  if cbxAuth.Checked and (edLogoutURL.Text<>'') then
  begin
    url:=edLogoutURL.Text;
    Log('<-- Logout: '+url+' -->');
    try
      IdHTTP.Get(url);
    except on E:Exception do
      Log(E.Message);
    end;
  end;
end;

procedure TfrmMain.acStopExecute(Sender: TObject);
begin
  StopCrawl:=true;
  StopTestSQL:=true;
  StopTestXSS:=true;
end;

procedure TfrmMain.BitBtnAddClick(Sender: TObject);
var
  i: Integer;
begin
  frmEdit.ComboBox1.Items.Clear;
  for i := 0 to Groups.Count-1 do
    frmEdit.ComboBox1.Items.Add(Groups[i]);

  frmEdit.ComboBox1.ItemIndex:=0;
  frmEdit.ComboBox2.ItemIndex:=0;
  frmEdit.edValue.Text:='';
  frmEdit.edName.Text:='';

  if frmEdit.ShowModal=mrOk then
  begin
    if sgOpt.Cells[0, sgOpt.RowCount-1]<>'' then
      sgOpt.RowCount:= sgOpt.RowCount+1;
    sgOpt.Cells[0, sgOpt.RowCount-1] := Groups[frmEdit.ComboBox1.ItemIndex];
    if frmEdit.ComboBox2.ItemIndex=0 then
      sgOpt.Cells[2, sgOpt.RowCount-1] := 'RE'
    else
      sgOpt.Cells[2, sgOpt.RowCount-1] := 'KW';
    sgOpt.Cells[1, sgOpt.RowCount-1] := frmEdit.edName.Text;
    sgOpt.Cells[3, sgOpt.RowCount-1] := frmEdit.edValue.Text;
  end;
end;

procedure TfrmMain.BitBtnDeleteClick(Sender: TObject);
var
  r, i, j: integer;
begin
  r:=sgOpt.Row;
  if sgOpt.RowCount=2 then
  begin
    for i := 0 to sgOpt.ColCount-1 do
      sgOpt.Cells[i, r]:='';
  end
  else
  begin
    for j:= r to sgOpt.RowCount-2 do
      for i := 0 to sgOpt.ColCount-1 do
        sgOpt.Cells[i, j]:=sgOpt.Cells[i, j+1];
    sgOpt.RowCount:= sgOpt.RowCount-1;
  end;
end;

procedure TfrmMain.BitBtnEditClick(Sender: TObject);
var
  i, k, r: integer;
begin
  r:=sgOpt.Row;
  if sgOpt.Cells[0, r]='' then Exit;
  frmEdit.ComboBox1.Items.Clear;
  for i := 0 to Groups.Count-1 do
    frmEdit.ComboBox1.Items.Add(Groups[i]);

  frmEdit.ComboBox1.ItemIndex:=Groups.IndexOf(sgOpt.Cells[0, r]);
  if sgOpt.Cells[2, r]='RE' then
    frmEdit.ComboBox2.ItemIndex:=0
  else
    frmEdit.ComboBox2.ItemIndex:=1;

  frmEdit.edName.Text:=sgOpt.Cells[1,r];
  frmEdit.edValue.Text:=sgOpt.Cells[3,r];

  if frmEdit.ShowModal=mrOk then
  begin
    sgOpt.Cells[0, r] := Groups[frmEdit.ComboBox1.ItemIndex];
    if frmEdit.ComboBox2.ItemIndex=0 then
      sgOpt.Cells[2, r] := 'RE'
    else
      sgOpt.Cells[2, r] := 'KW';
    sgOpt.Cells[1, r] := frmEdit.edName.Text;
    sgOpt.Cells[3, r] := frmEdit.edValue.Text;
  end;
end;

function TfrmMain.DeAmpUrl(Url: string): string;
begin
  Result:=ReplaceStr(Url, '&amp;', '&');
end;

procedure TfrmMain.DecodeCookieParam(expr: string; i: integer);
var
  p, n: Integer;
  nam, val: string;
begin
  n:=Pos('=', expr);
  nam:='';
  val:='';
  if n>0 then
  begin
    nam:=LeftStr(expr, n-1);
    val:=Copy(expr, n+1, Length(expr)-n);
    expr:=LowerCase(nam);
    if expr='expires' then
      sgResult.Cells[3, i+1]:=val
    else
    begin
      if expr='path' then
        sgResult.Cells[4, i+1]:=val
      else
      begin
        if expr='domain' then
          sgResult.Cells[5, i+1]:=val
        else
        begin
          sgResult.Cells[1, i+1]:=nam;
          sgResult.Cells[2, i+1]:=val;
        end;
      end;
    end;
  end;
end;

function TfrmMain.DeQuote(Val: string): string;
var
  re: TRegExpr;
begin
  re:=TRegExpr.Create;
  Result:=val;
  re.Expression:='"(.*?)"';
  if re.Exec(Val) then
    Result:=re.Match[1];
  re.Expression:='''(.*?)''';
  if re.Exec(Val) then
    Result:=re.Match[1];
  re.Free;
end;

function TfrmMain.DoAuth: string;
var
  curl_res, url, str, ws, ptype, pname, pval: string;
  PostInfo: TStringList;
  re, re2, re3: TRegExpr;
  mthd, actn: string;
  r: integer;
  flag: Boolean;
begin
  flag:=False;
  url:=edLoginURL.Text;

  Result:='';

  if url='' then Exit;

  PostInfo:=TStringList.Create;
  if rbManual.Checked then
  begin
    PostInfo.Add(edParam.Text);
    curl_res:=IdHTTP.Post(url, PostInfo);
    Result:=IdHTTP.URL.URI;
  end;

  if rbParse.Checked then
  begin
    try
      IdHTTP.Request.AcceptEncoding:='identity';
      //curl_res:=IdHTTP.Get(url);
      curl_res:=GetDataFromURL(url);
      //SaveStringToFile('dump1.txt', curl_res);
    except on E:Exception do
      begin
        Log(E.Message);
        curl_res:='';
      end;
    end;

    if curl_res<>'' then
    begin
      re:=TRegExpr.Create;
      re2:=TRegExpr.Create;
      re3:=TRegExpr.Create;
      re.Expression:='(?is)[^'',"]<form(.*?)>(.*?)<\/form>';
      //re.Expression:='(?is)<form(.*?)>(.*?)<\/form>';
      str:='';
      if re.Exec(curl_res) then
      begin
        repeat
          str:=Trim(re.Match[1]);
          re2.Expression:='method=['',"](.*?)['',"]';
          if re2.Exec(str) then mthd:=re2.Match[1];
          re2.Expression:='action=['',"](.*?)['',"]';
          if re2.Exec(str) then actn:=re2.Match[1];
          str:=re.Match[2];
          if (LowerCase(mthd)='post') and (actn<>'') then
          begin
            ws := str;
            re2.Expression := '(?is)<input\s+(.*?)>';
            if re2.Exec(ws) then
            begin
              repeat
                flag:=true;
                str := re2.Match[1];
                ptype:='';
                pval:='';
                pname:='';
                re3.Expression:='type=['',"](.*?)['',"]';
                if re3.Exec(str) then ptype:=re3.Match[1];
                re3.Expression:='name=['',"](.*?)['',"]';
                if re3.Exec(str) then pname:=re3.Match[1];
                re3.Expression:='value=['',"](.*?)['',"]';
                if re3.Exec(str) then pval:=re3.Match[1];
                if (Pos('image', ptype)=0) and (Pos('submit', ptype)=0) then
                begin
                  if (frmParams.sgParams.RowCount=2)
                    and (frmParams.sgParams.Cells[0,1]='')
                  then r:=1
                  else
                  begin
                    r:=frmParams.sgParams.RowCount;
                    frmParams.sgParams.RowCount:=frmParams.sgParams.RowCount+1;
                  end;
                  with frmParams.sgParams do
                  begin
                    Cells[0,r]:=ptype;
                    Cells[1,r]:=pname;
                    Cells[2,r]:=pval;
                  end;
                end;
              until not re2.ExecNext;
            end;
            Break;
          end;
        until not re.ExecNext;
      end;
    end;
    if flag then
    begin
      if frmParams.ShowModal=mrOk then
      begin
        for r := 1 to frmParams.sgParams.RowCount-1 do
        begin
          with frmParams.sgParams do
            str:=Cells[1,r]+'='+Cells[2,r];
          PostInfo.Add(str);
        end;
        if Pos('http', actn)<>1 then
          url:=NormalizeLink(url, actn)
        else
          url:=actn;
        curl_res:=IdHTTP.Post(url, PostInfo);
        Result:=IdHTTP.URL.URI;
      end;
    end
    else
      Log('Not found form and params for Auth');
  end;
  PostInfo.Free;
end;

procedure TfrmMain.DoClear;
begin
  Memo.Lines.Clear;
  Links.Clear;
  Images.Clear;
  Emails.Clear;
  Forms.Clear;
  Files.Clear;
  Comments.Clear;
  Cookies.Clear;
  ImagesUrl.Clear;
  EmailsUrl.Clear;
  FormsUrl.Clear;
  FilesUrl.Clear;
  CommentsUrl.Clear;
  CookiesUrl.Clear;
  Robots.Clear;
  Extras.Clear;
  ExtDomains.Clear;
end;

procedure TfrmMain.acStartExecute(Sender: TObject);
var
  path, prefix, hst, Domain: string;
  fmt: TFormatSettings;
  IdURL: TIdURI;
  i: Integer;
  lnk: TLinkRec;
  DelimStr: AnsiString;
  Enc: TEncoding;
  StrListOut: TStringList;
begin
  if edHost.Text='' then Exit;

  StrListOut:=TStringList.Create;

  btStop.Visible:=true;
  btStop.Left:=btStart.Left;
  btStart.Visible:=False;
  IgnoreExtSet:=MemoExt.Text;
  DelimStr:=edDelimiterChar.Text;
  if rgDelimiter.ItemIndex=0 then
    DelimiterChar:=#32;
  if rgDelimiter.ItemIndex=1 then
    DelimiterChar:=#9;
  if rgDelimiter.ItemIndex=2 then
    DelimiterChar:=DelimStr[1];

  edHost.Text:=Trim(edHost.Text);

  IdURL:=TIdURI.Create(edHost.Text);

  if IdURL.Protocol='' then
    edHost.Text:='http://'+edHost.Text;

  Domain:=GetDomain(edHost.Text);
  CurDomain:=Domain;

  if Domain='' then Exit;

  Host:=edHost.Text;

  path:=edOutDir.Text;
  prefix:='';
  fmt.ShortDateFormat:='yyyy_mm_dd';
  fmt.LongDateFormat:='yyyy_mm_dd';
  fmt.LongTimeFormat:='hh_nn_ss';
  if cbxDomainOpt.Checked then
    prefix:=prefix+Domain+'_';
  if cbxDateTimeOpt.Checked then
    prefix:=prefix+DateToStr(Now,fmt)+'_'+TimeToStr(Now,fmt)+'_';

  FilePrefix:=path+'\'+prefix;

  Application.ProcessMessages;

  RobotsFlag:=False;

  sgResult.Enabled:=false;

  DoClear;

  DoCrawl;

  if cmbOutFormat.ItemIndex=0 then Enc:=TEncoding.ASCII;
  if cmbOutFormat.ItemIndex=1 then Enc:=TEncoding.UTF8;
  if cmbOutFormat.ItemIndex=2 then Enc:=TEncoding.Unicode;

  Links.SaveToFileByType(path+'\'+prefix+'links.txt', true, DelimiterChar);
  if cbxExExternalOpt.Checked then
  begin
    Links.SaveToFileByType(path+'\'+prefix+'links_external.txt', false, DelimiterChar);
    ExtDomains.Clear;
    ExtDomains.Duplicates:=dupIgnore;
    for i:=0 to Links.Count-1 do
    begin
      lnk:=Links.Items[i];
      if lnk.Outter then
      begin
        IdURL.URI:=lnk.Url;
        if ExtDomains.IndexOf(IdURL.Host)<0 then
          ExtDomains.Add(IdURL.Host);
      end;
    end;
    ExtDomains.Sort;
    ExtDomains.SaveToFile(path+'\'+prefix+'domains.txt', Enc);
  end;

  if cbxExImagesOpt.Checked then
  begin
    MergeAndCheckList(cbxUniqValues.Checked, Images, ImagesUrl, StrListOut);
    //Images.SaveToFile(path+'\'+prefix+'images.txt',Enc);
    StrListOut.SaveToFile(path+'\'+prefix+'images.txt',Enc);
  end;
  if cbxExEMailsOpt.Checked then
  begin
    MergeAndCheckList(cbxUniqValues.Checked, Emails, EmailsUrl, StrListOut);
    //Emails.SaveToFile(path+'\'+prefix+'emails.txt',Enc);
    StrListOut.SaveToFile(path+'\'+prefix+'emails.txt',Enc);
  end;
  if cbxExFilesOpt.Checked then
  begin
    MergeAndCheckList(cbxUniqValues.Checked, Files, FilesUrl, StrListOut);
    //Files.SaveToFile(path+'\'+prefix+'files.txt',Enc);
    StrListOut.SaveToFile(path+'\'+prefix+'files.txt',Enc);
  end;
  if cbxExFormsOpt.Checked then
  begin
    MergeAndCheckList(cbxUniqValues.Checked, Forms, FormsUrl, StrListOut);
    //Forms.SaveToFile(path+'\'+prefix+'forms.txt',Enc);
    StrListOut.SaveToFile(path+'\'+prefix+'forms.txt',Enc);
  end;
  if cbxExCommentsOpt.Checked then
  begin
    MergeAndCheckList(cbxUniqValues.Checked, Comments, CommentsUrl, StrListOut);
    //Comments.SaveToFile(path+'\'+prefix+'comments.txt',Enc);
    StrListOut.SaveToFile(path+'\'+prefix+'comments.txt',Enc);
  end;
  if cbxExCookiesOpt.Checked then
  begin
    MergeAndCheckList(cbxUniqValues.Checked, Cookies, CookiesUrl, StrListOut);
    //Cookies.SaveToFile(path+'\'+prefix+'cookies.txt',Enc);
    StrListOut.SaveToFile(path+'\'+prefix+'cookies.txt',Enc);
  end;
  if cbxExRobots.Checked then
    Robots.SaveToFile(path+'\'+prefix+'robots.txt',Enc);

  Extras.SaveToFile(path+'\'+prefix+'extras.txt',Enc);

  Log('Saved!');
  Log('Finished!');
  btStop.Visible:=false;
  btStart.Visible:=True;
  //GroupBoxSet.Enabled:=true;

  // prepare output
  cbxShowFilter.Items.Clear;
  if cbxExFormsOpt.Checked then cbxShowFilter.Items.Add('Forms');
  if cbxExEMailsOpt.Checked then cbxShowFilter.Items.Add('E-mails');
  if cbxExCommentsOpt.Checked then cbxShowFilter.Items.Add('Comments');
  if cbxExImagesOpt.Checked then cbxShowFilter.Items.Add('Images');
  if cbxExFilesOpt.Checked then cbxShowFilter.Items.Add('Files');
  if cbxExCookiesOpt.Checked then cbxShowFilter.Items.Add('Cookies');
  if cbxExExternalOpt.Checked then cbxShowFilter.Items.Add('Domains');

  cbxShowFilter.ItemIndex:=0;
  cbxShowFilterChange(Self);

  sgResult.Enabled:=true;
//  TabSheet2.Visible:=true;
  IdURL.Free;
end;

procedure TfrmMain.btFileSqlClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    edSQLFile.Text:=OpenDialog1.FileName;
    clbSQLs.Items.LoadFromFile(edSQLFile.Text);
    btnCheckSQL.Click;
  end;
end;

procedure TfrmMain.btFolderClick(Sender: TObject);
var
  dir: string;
begin
  dir:=edOutDir.Text;
  if AdvSelectDirectory('Please specify a directory', '', dir, True, False, True) then
    edOutDir.Text:=dir;
end;

procedure TfrmMain.btGEditClick(Sender: TObject);
var
  i: Integer;
begin
  with frmGroupsEdit.Memo1.Lines do
  begin
    Clear;
    AddStrings(Groups);
  end;
  if frmGroupsEdit.ShowModal=mrOk then
  begin
    Groups.Clear;
    Groups.AddStrings(frmGroupsEdit.Memo1.Lines);
  end;
end;

procedure TfrmMain.btnFTypesXSSCheckClick(Sender: TObject);
begin
  clbFTypesX.CheckAll(cbChecked, false, false);
end;

procedure TfrmMain.btnCheckXSSClick(Sender: TObject);
begin
  clbXSS.CheckAll(cbChecked, false, false);
end;

procedure TfrmMain.btnOpenXClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    edXSSFile.Text:=OpenDialog1.FileName;
    clbXSS.Items.Clear;
    clbXSS.Items.LoadFromFile(edSQLFile.Text);
    btnCheckXSS.Click;
  end;
end;

procedure TfrmMain.btnRespShowClick(Sender: TObject);
var
  T: TfrmRespList;
begin
  T:=TfrmRespList.Create(self);
  T.Memo1.Lines.AddStrings(ResponseList);
  if T.ShowModal=mrOk then
  begin
    ResponseList.Clear;
    ResponseList.AddStrings(T.Memo1.Lines);
  end;
  T.Free;
end;

procedure TfrmMain.btnFTypesXSSUnCheckClick(Sender: TObject);
begin
  clbFTypesX.CheckAll(cbUnchecked, false, false);
end;

procedure TfrmMain.btnUncheckXSSClick(Sender: TObject);
begin
  clbXSS.CheckAll(cbUnchecked, false, false);
end;

procedure TfrmMain.btnFTypesSQLUnCheckClick(Sender: TObject);
begin
  clbFTypes.CheckAll(cbUnchecked, false, false);
end;

procedure TfrmMain.btnFTypesSQLCheckClick(Sender: TObject);
begin
  clbFTypes.CheckAll(cbChecked, false, false);
end;

procedure TfrmMain.btnCheckSQLClick(Sender: TObject);
begin
  clbSQLs.CheckAll(cbChecked, false, false);
end;

procedure TfrmMain.btnUnCheckSQLClick(Sender: TObject);
begin
  clbSQLs.CheckAll(cbUnchecked, false, false);
end;

procedure TfrmMain.cmbCrossChange(Sender: TObject);
begin
  sbtnFormsLinksCross.Enabled:=cmbCross.ItemIndex=1;
  if cmbCross.ItemIndex=0 then
  begin
    with frmFormsXSS do
    begin
      clbFormsXSS.CheckAll(cbChecked, false, false);
      clbLinksXSS.CheckAll(cbChecked, false, false);
    end;
  end;
end;

procedure TfrmMain.cbxShowFilterChange(Sender: TObject);
var
  i, w: integer;
  p, n: Integer;
  str, nam, val, expr, fname, fact, fmeth, ptype, pname, pval, frm: string;
  re, re2: TRegExpr;
begin
  SortColumn := -1;
  SortType:=gstNone;

  w:=sgResult.ClientWidth;

  if cbxShowFilter.Text='E-mails' then
  begin
    sgResult.ColCount:=2;
    sgResult.Cells[0, 0] := 'Source URL';
    sgResult.Cells[1, 0] := 'E-Mail';
    sgResult.ColWidths[0]:= Round(w * 0.7);
    sgResult.ColWidths[1]:= Round(w * 0.3)-5;

    if Emails.Count<=2 then
      sgResult.RowCount:=2
    else
      sgResult.RowCount:=Emails.Count+1;
    for i := 0 to Emails.Count-1 do
    begin
      sgResult.Cells[0, i+1]:=EmailsUrl[i];
      sgResult.Cells[1, i+1]:=Emails[i];
    end;
  end;

  if cbxShowFilter.Text='Forms' then
  begin
    sgResult.ColCount:=7;
    sgResult.Cells[0, 0] := 'Source URL';
    sgResult.Cells[1, 0] := 'Name';
    sgResult.Cells[2, 0] := 'Method';
    sgResult.Cells[3, 0] := 'Action';
    sgResult.Cells[4, 0] := 'Variable name';
    sgResult.Cells[5, 0] := 'Variable type';
    sgResult.Cells[6, 0] := 'Variable value';

    sgResult.ColWidths[0]:= Round(w * 0.4);
    sgResult.ColWidths[1]:= Round(w * 0.1);
    sgResult.ColWidths[2]:= Round(w * 0.1);
    sgResult.ColWidths[3]:= Round(w * 0.2);
    sgResult.ColWidths[4]:= Round(w * 0.1);
    sgResult.ColWidths[5]:= Round(w * 0.1);
    sgResult.ColWidths[6]:= Round(w * 0.1);

    if Forms.Count<=2 then
      sgResult.RowCount:=2
    else
      sgResult.RowCount:=Forms.Count+1;

    re:=TRegExpr.Create;
    re2:=TRegExpr.Create;

    for i := 0 to Forms.Count-1 do
    begin
      sgResult.Cells[0, i+1]:=FormsUrl[i];
      frm:=Forms[i];
      fname:='';
      fact:='';
      fmeth:='';
      re.Expression:='(?is)<form(.*?)>';
      if re.Exec(frm) then
      begin
        str:=Trim(re.Match[1])+' ';
        //re2.Expression:='method=[''|"](.*?)[''|"]';
        re2.Expression:='method=(.*?)\s';
        if re2.Exec(str) then fmeth:=re2.Match[1];
        //re2.Expression:='action=[''|"](.*?)[''|"]';
        re2.Expression:='action=(.*?)\s';
        if re2.Exec(str) then fact:=re2.Match[1];
        //re2.Expression:='name=[''|"](.*?)[''|"]';
        re2.Expression:='name=(.*?)\s';
        if re2.Exec(str) then fname:=re2.Match[1];
      end;

      ptype:='';
      pval:='';
      pname:='';
      re.Expression:='(?is)<input\s+(.*?)>';
      if re.Exec(frm) then
      begin
        str := Trim(re.Match[1])+' ';
        //re2.Expression:='type=['',"](.*?)['',"]';
        re2.Expression:='type=(.*?)\s';
        if re2.Exec(str) then ptype:=re2.Match[1];
        //re2.Expression:='name=['',"](.*?)['',"]';
        re2.Expression:='name=(.*?)\s';
        if re2.Exec(str) then pname:=re2.Match[1];
        //re2.Expression:='value=['',"](.*?)['',"]';
        re2.Expression:='value=(.*?)\s';
        if re2.Exec(str) then pval:=re2.Match[1];
      end;
      sgResult.Cells[1, i+1]:=DeQuote(fname);
      sgResult.Cells[2, i+1]:=DeQuote(fmeth);
      sgResult.Cells[3, i+1]:=DeQuote(fact);
      sgResult.Cells[4, i+1]:=DeQuote(pname);
      sgResult.Cells[5, i+1]:=DeQuote(ptype);
      sgResult.Cells[6, i+1]:=DeQuote(pval);
    end;
    re.Free;
  end;

  if cbxShowFilter.Text='Comments' then
  begin
    sgResult.ColCount:=2;
    sgResult.Cells[0, 0] := 'Source URL';
    sgResult.Cells[1, 0] := 'Comment';
    sgResult.ColWidths[0]:= Round(w * 0.4);
    sgResult.ColWidths[1]:= Round(w * 0.6)-5;
    sgResult.RowCount:=Comments.Count+1;
    for i := 0 to Comments.Count-1 do
    begin
      sgResult.Cells[0, i+1]:=CommentsUrl[i];
      sgResult.Cells[1, i+1]:=Comments[i];
    end;
  end;
  if cbxShowFilter.Text='Images' then
  begin
    sgResult.ColCount:=2;
    sgResult.Cells[0, 0] := 'Source URL';
    sgResult.Cells[1, 0] := 'Link';
    sgResult.ColWidths[0]:= Round(w * 0.4);
    sgResult.ColWidths[1]:= Round(w * 0.6)-5;
    sgResult.RowCount:=Images.Count+1;
    for i := 0 to Images.Count-1 do
    begin
      sgResult.Cells[0, i+1]:=ImagesUrl[i];
      sgResult.Cells[1, i+1]:=Images[i];
    end;
  end;

  if cbxShowFilter.Text='Files' then
  begin
    sgResult.ColCount:=2;
    sgResult.Cells[0, 0] := 'Source URL';
    sgResult.Cells[1, 0] := 'Link';
    sgResult.ColWidths[0]:= Round(w * 0.4);
    sgResult.ColWidths[1]:= Round(w * 0.6)-5;
    sgResult.RowCount:=Files.Count+1;
    for i := 0 to Files.Count-1 do
    begin
      sgResult.Cells[0, i+1]:=FilesUrl[i];
      sgResult.Cells[1, i+1]:=Files[i];
    end;
  end;

  if cbxShowFilter.Text='Cookies' then
  begin
    sgResult.ColCount:=7;
    sgResult.Cells[0, 0] := 'Source URL';
    sgResult.Cells[1, 0] := 'Name';
    sgResult.Cells[2, 0] := 'Value';
    sgResult.Cells[3, 0] := 'Expires';
    sgResult.Cells[4, 0] := 'Path';
    sgResult.Cells[5, 0] := 'Domain';
    sgResult.Cells[6, 0] := 'Other';
    sgResult.ColWidths[0]:= Round(w * 0.4);
    sgResult.ColWidths[1]:= Round(w * 0.2);
    sgResult.ColWidths[2]:= Round(w * 0.3);
    sgResult.ColWidths[3]:= Round(w * 0.2);
    sgResult.ColWidths[4]:= Round(w * 0.3);
    sgResult.ColWidths[5]:= Round(w * 0.3);
    sgResult.ColWidths[6]:= Round(w * 0.3)-5;
    sgResult.RowCount:=Cookies.Count+1;
    for i := 0 to Cookies.Count-1 do
    begin
      sgResult.Cells[0, i+1]:=CookiesUrl[i];
      str:=Cookies[i];
      if Pos('httponly', LowerCase(str))>0 then sgResult.Cells[6, i+1]:=sgResult.Cells[6, i+1]+' HttpOnly';
      if Pos('secure', LowerCase(str))>0 then sgResult.Cells[6, i+1]:=sgResult.Cells[6, i+1]+' Secure';
      repeat
        p:=Pos(';', str);
        if p>0 then
        begin
          expr:=Trim(LeftStr(str, p-1));
          DecodeCookieParam(expr, i);
          str:=Copy(str, p+1, Length(str)-p);
        end;
      until p=0;
      DecodeCookieParam(Trim(str), i);
    end;
  end;

  if cbxShowFilter.Text='Domains' then
  begin
    sgResult.ColCount:=1;
    sgResult.Cells[0, 0] := 'Domain';
    sgResult.ColWidths[0]:= w;
    sgResult.RowCount:=ExtDomains.Count+1;

    for i := 0 to ExtDomains.Count-1 do
    begin
      sgResult.Cells[0, i+1]:=ExtDomains[i];
    end;
  end;
end;

procedure TfrmMain.rgDelimiterClick(Sender: TObject);
begin
  if rgDelimiter.ItemIndex=2 then
    edDelimiterChar.Enabled:=True
  else
    edDelimiterChar.Enabled:=False;
end;

procedure TfrmMain.rgDomainCheckClick(Sender: TObject);
begin
  if rgDomainCheck.ItemIndex=2 then
    SpinEditLevel.Enabled:=True
  else
    SpinEditLevel.Enabled:=False;
end;

procedure TfrmMain.sbtnCrawlerClick(Sender: TObject);
begin
  sbtnCrawler.Font.Style:=[];
  sbtnVulner.Font.Style:=[];
  sbtnSettings.Font.Style:=[];
  PanelCrawler.Visible:=False;
  PanelVulner.Visible:=False;
  PanelSetup.Visible:=False;
  if sbtnCrawler.Down then
  begin
    sbtnCrawler.Font.Style:=[fsBold];
    PanelCrawler.Visible:=True;
  end;
end;

procedure TfrmMain.sbtnFormsLinksCrossClick(Sender: TObject);
begin
  frmFormsXSS.ShowModal;
end;

procedure TfrmMain.sbtnFormsLinksSQLClick(Sender: TObject);
begin
  frmFormsSQL.ShowModal;
end;

procedure TfrmMain.sbtnSettingsClick(Sender: TObject);
begin
  sbtnCrawler.Font.Style:=[];
  sbtnVulner.Font.Style:=[];
  sbtnSettings.Font.Style:=[];
  PanelCrawler.Visible:=False;
  PanelVulner.Visible:=False;
  PanelSetup.Visible:=False;
  if sbtnSettings.Down then
  begin
    sbtnSettings.Font.Style:=[fsBold];
    PanelSetup.Visible:=True;
  end;
end;

procedure TfrmMain.sbtnVulnerClick(Sender: TObject);
begin
  sbtnCrawler.Font.Style:=[];
  sbtnVulner.Font.Style:=[];
  sbtnSettings.Font.Style:=[];
  PanelCrawler.Visible:=False;
  PanelVulner.Visible:=False;
  PanelSetup.Visible:=False;
  if sbtnVulner.Down then
  begin
    sbtnVulner.Font.Style:=[fsBold];
    PanelVulner.Visible:=True;
  end;
  PrepareVulnerabilityTest;
end;

procedure TfrmMain.sgResultDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  CRect: TRect;
  ColorOld: TColor;
begin
  if (ACol=SortColumn) and (ARow=0) then
  begin
    CRect.Left:=Rect.Right-16;
    CRect.Top:=Rect.Top;
    CRect.Right:=Rect.Right;
    CRect.Bottom:=Rect.Bottom;
    ColorOld:=sgResult.Canvas.Brush.Color;
    sgResult.Canvas.Brush.Color:=sgResult.FixedColor;
    if SortType=gstAsc then
    begin
      sgResult.Canvas.FillRect(CRect);
      ImageList1.Draw(sgResult.Canvas, Rect.Right-16, 4, 0);
    end;
    if SortType=gstDesc then
    begin
      sgResult.Canvas.FillRect(CRect);
      ImageList1.Draw(sgResult.Canvas, Rect.Right-16, 4, 1);
    end;
    sgResult.Canvas.Brush.Color:=ColorOld;
  end;
end;

procedure TfrmMain.sgResultFixedCellClick(Sender: TObject; ACol, ARow: Integer);
var
  title: string;
  i: Integer;
begin
  if SortColumn=ACol then
  begin
    case SortType of
      gstNone: SortType:=gstAsc;
      gstAsc: SortType:=gstDesc;
      gstDesc: SortType:=gstNone;
    end;
    if SortType=gstNone then
      SortColumn:=-1;
  end
  else
  begin
    SortColumn:=ACol;
    SortType:= gstAsc;
  end;
  {
  for i := 0 to sgResult.ColCount-1 do
  begin
    title:=sgResult.Cells[i, 0];
    //title:=StringReplace(title, '˄', '', []);
    //title:=StringReplace(title, '˅', '', []);
    title:=Trim(title);
    if i=SortColumn then
      case SortType of
        gstAsc: title:='  '+title;
        gstDesc: title:='  '+title;
      end;
    sgResult.Cells[i, 0]:=title;
  end;
  }
  if SortType<>gstNone then
    SortStringGrid(SortColumn)
  else
  begin
    i:=cbxShowFilter.ItemIndex;
    cbxShowFilter.ItemIndex:=i;
    cbxShowFilterChange(self);
  end;

end;

procedure TfrmMain.SortStringGrid(ACol: Integer);
const
  TheSeparator = #9;
var
  CountItem, I, J, K, ThePosition: integer;
  MyList: TStringList;
  MyString, TempString: string;
begin
  CountItem := sgResult.RowCount;
  MyList        := TStringList.Create;
  MyList.Sorted := False;
  try
    begin
      for I := 1 to (CountItem - 1) do
        MyList.Add(sgResult.Rows[I].Strings[ACol] + TheSeparator +
           sgResult.Rows[I].Text);

      if SortType=gstAsc then
        Mylist.Sort;

      if SortType=gstDesc then
        MyList.CustomSort(DescSort);

      for K := 1 to Mylist.Count do
      begin
        MyString := MyList.Strings[(K - 1)];
        ThePosition := Pos(TheSeparator, MyString);
        TempString  := '';
        TempString := Copy(MyString, (ThePosition + 1), Length(MyString));
        MyList.Strings[(K - 1)] := '';
        MyList.Strings[(K - 1)] := TempString;
      end;
      for J := 1 to (CountItem - 1) do
        sgResult.Rows[J].Text := MyList.Strings[(J - 1)];
    end;
  finally
    MyList.Free;
  end;
end;

procedure TfrmMain.btnVulnerStartClick(Sender: TObject);
begin
  btnVulnerStart.Enabled:=false;
  if cbxCheckCross.Checked then
    DoTestXSSVulnerability;
  if cbxCheckSQL.Checked then
    DoTestSQLVulnerability;
  btnVulnerStart.Enabled:=true;
end;

procedure TfrmMain.Button4Click(Sender: TObject);
begin
  cbxExCommentsOpt.Checked:=True;
  cbxExEMailsOpt.Checked:=true;
  cbxExExternalOpt.Checked:=true;
  cbxExFormsOpt.Checked:=true;
  cbxExImagesOpt.Checked:=true;
  cbxExRobots.Checked:=true;
  cbxExCookiesOpt.Checked:=true;
  cbxExCSSOpt.Checked:=true;
  cbxExScriptOpt.Checked:=true;
  cbxExFilesOpt.Checked:=true;
end;

procedure TfrmMain.Button5Click(Sender: TObject);
begin
  cbxExCommentsOpt.Checked:=false;
  cbxExEMailsOpt.Checked:=false;
  cbxExExternalOpt.Checked:=false;
  cbxExFormsOpt.Checked:=false;
  cbxExImagesOpt.Checked:=false;
  cbxExRobots.Checked:=false;
  cbxExCookiesOpt.Checked:=false;
  cbxExCSSOpt.Checked:=false;
  cbxExScriptOpt.Checked:=false;
  cbxExFilesOpt.Checked:=false;
end;

procedure TfrmMain.btFileRespClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    edRespFile.Text:=OpenDialog1.FileName;
    ResponseList.Clear;
    ResponseList.LoadFromFile(edSQLFile.Text);
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  Registry: TRegistry;
  ExtStr, str: string;
  OptList: TStringList;
  i, j: integer;
begin
  try
    ExtStr:=MemoExt.Text;
    Registry := TRegistry.Create;
    Registry.RootKey := HKEY_CURRENT_USER;
    Registry.OpenKey('Software\'+ProgramName,true);
    Registry.WriteString('IgnoreExtSetConst',ExtStr);
    Registry.WriteString('ExtraGroups',ExtraGroups);
    Registry.CloseKey;
  finally
    Registry.Free;
  end;

  //save options
  ExtraData.Clear;
  for i:=1 to sgOpt.RowCount-1 do
  begin
    str:='';
    for j:=0 to sgOpt.ColCount-1 do
      str:=str+sgOpt.Cells[j, i]+';';
    ExtraData.Add(str);
  end;
  ExtraData.Sort;
  ExtraData.SaveToFile(ExtractFilePath(Application.ExeName)+'Data\wcextras.dat', TEncoding.ASCII);
  ExtraData.Free;
end;

end.
