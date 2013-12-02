unit uExtraOpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, StrUtils, Grids, ExtCtrls;

type
  TfrmExtraOpt = class(TForm)
    Panel1: TPanel;
    btOk: TBitBtn;
    Panel2: TPanel;
    btGEdit: TSpeedButton;
    sgOpt: TStringGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    cbxExExtra: TCheckBox;
    procedure btOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    GroupsStr: string;
    Groups: TStringList;
  end;

var
  frmExtraOpt: TfrmExtraOpt;

implementation

{$R *.dfm}

procedure TfrmExtraOpt.btOkClick(Sender: TObject);
var
  str: string;
  i: Integer;
begin
  str:='';
  for i := 0 to Groups.Count-1 do
    str := str + Groups[i]+';';
  GroupsStr:=str;
  ModalResult:=mrOk;
end;

procedure TfrmExtraOpt.FormCreate(Sender: TObject);
begin
  sgOpt.Cells[0,0]:='Group';
  sgOpt.Cells[1,0]:='Name';
  sgOpt.Cells[2,0]:='Type';
  sgOpt.Cells[3,0]:='Value';
  Groups:=TStringList.Create;
end;

end.
