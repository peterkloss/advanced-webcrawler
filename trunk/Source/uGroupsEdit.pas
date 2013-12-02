unit uGroupsEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmGroupsEdit = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGroupsEdit: TfrmGroupsEdit;

implementation

{$R *.dfm}

procedure TfrmGroupsEdit.FormCreate(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

end.
