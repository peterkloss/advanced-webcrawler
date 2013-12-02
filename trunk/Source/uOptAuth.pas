unit uOptAuth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmAuthOpt = class(TForm)
    Label1: TLabel;
    edLoginURL: TEdit;
    Label2: TLabel;
    edLogoutURL: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    rbParse: TRadioButton;
    rbManual: TRadioButton;
    edParam: TEdit;
    cbxAuth: TCheckBox;
    procedure rbManualClick(Sender: TObject);
    procedure rbParseClick(Sender: TObject);
    procedure cbxAuthClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAuthOpt: TfrmAuthOpt;

implementation

{$R *.dfm}
uses uFrmMain;

procedure TfrmAuthOpt.cbxAuthClick(Sender: TObject);
begin
  if cbxAuth.Checked and (edLoginURL.Text='') then
    edLoginURL.Text:=frmMain.edHost.Text;
end;

procedure TfrmAuthOpt.rbManualClick(Sender: TObject);
begin
  edParam.Enabled:=rbManual.Checked;
end;

procedure TfrmAuthOpt.rbParseClick(Sender: TObject);
begin
  edParam.Enabled:=rbManual.Checked;
end;

end.
