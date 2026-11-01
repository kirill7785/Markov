unit unitZamena;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFormZamena }

  TFormZamena = class(TForm)
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
  FormZamena: TFormZamena;

implementation

{$R *.lfm}

{ TFormZamena }

procedure TFormZamena.Button1Click(Sender: TObject);
begin
  if Trim(Edit1.Text) = '' then
  begin
    bOk := False;
    ShowMessage('Искомое значение не может быть пустым.');
    Exit;
  end;

  bOk := True;
  ModalResult := mrOk;
end;

procedure TFormZamena.Button2Click(Sender: TObject);
begin
  bOk := False;
  ModalResult := mrCancel;
end;

end.

