program WebCrawler;

uses
  Forms,
  uFrmMain in 'uFrmMain.pas' {frmMain},
  uClasses in 'uClasses.pas',
  uGroupsEdit in 'uGroupsEdit.pas' {frmGroupsEdit},
  uValueEdit in 'uValueEdit.pas' {frmEdit},
  uParams in 'uParams.pas' {frmParams},
  uRespForm in 'uRespForm.pas' {frmRespList},
  uFormsSQL in 'uFormsSQL.pas' {frmFormsSQL},
  uFormsXSS in 'uFormsXSS.pas' {frmFormsXSS},
  uLibs in 'uLibs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmGroupsEdit, frmGroupsEdit);
  Application.CreateForm(TfrmEdit, frmEdit);
  Application.CreateForm(TfrmParams, frmParams);
  Application.CreateForm(TfrmFormsSQL, frmFormsSQL);
  Application.CreateForm(TfrmFormsXSS, frmFormsXSS);
  Application.Run;
end.
