unit uFormsSQL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ExtCtrls, Buttons;

type
  TfrmFormsSQL = class(TForm)
    Panel11: TPanel;
    Panel10: TPanel;
    clbLinksSQL: TCheckListBox;
    Panel1: TPanel;
    clbFormsSQL: TCheckListBox;
    BitBtn1: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFormsSQL: TfrmFormsSQL;

implementation

{$R *.dfm}

end.
