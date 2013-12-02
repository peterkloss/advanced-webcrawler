unit uRespForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmRespList = class(TForm)
    btOk: TBitBtn;
    btCancel: TBitBtn;
    Memo1: TMemo;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRespList: TfrmRespList;

implementation

{$R *.dfm}

procedure TfrmRespList.FormCreate(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

end.
