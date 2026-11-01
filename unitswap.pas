unit unitSwap;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFormSwap }

  TFormSwap = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public
      bOk : Boolean;
  end;

var
  FormSwap: TFormSwap;

implementation

{$R *.lfm}

{ TFormSwap }

procedure TFormSwap.Button1Click(Sender: TObject);
begin
  if (Trim(Edit1.Text) = '') or
     (Trim(Edit2.Text) = '') then
  begin
    bOk := False;
    ShowMessage('Оба значения должны быть заполнены.');
    Exit;
  end;

  bOk := True;
  ModalResult := mrOk;
end;

procedure TFormSwap.Button2Click(Sender: TObject);
begin
  bOk := False;
  ModalResult := mrCancel;
end;

end.

