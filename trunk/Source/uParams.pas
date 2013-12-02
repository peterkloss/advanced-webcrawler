unit uParams;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids;

type
  TfrmParams = class(TForm)
    sgParams: TStringGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmParams: TfrmParams;

implementation

{$R *.dfm}

procedure TfrmParams.FormCreate(Sender: TObject);
begin
  sgParams.ColWidths[0]:=100;
  sgParams.ColWidths[1]:=100;
  sgParams.ColWidths[2]:=290;
  sgParams.Cells[0, 0]:='Type';
  sgParams.Cells[1, 0]:='Name';
  sgParams.Cells[2, 0]:='Value';
end;

end.
