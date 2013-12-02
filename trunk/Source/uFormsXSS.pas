unit uFormsXSS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ExtCtrls, Buttons;

type
  TfrmFormsXSS = class(TForm)
    Panel11: TPanel;
    clbFormsXSS: TCheckListBox;
    Panel10: TPanel;
    clbLinksXSS: TCheckListBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFormsXSS: TfrmFormsXSS;

implementation

{$R *.dfm}

end.
