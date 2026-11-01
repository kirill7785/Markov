unit Unit2;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  SynEdit, SynEditMiscClasses, SynEditTypes, SynEditMarkup,
  SynEditMarkupSpecialLine, SynEditMarkupHighAll, LazSynEditText;
       type

         TStringDynArray = array of string;


          TRowHighlight = record
    StartPos: Integer;
    Length: Integer;
    Color: TColor;
  end;

  TRowHighlights = array of TRowHighlight;

  TRowHighlighter = class(TSynEditMarkup)
  private
    FCurHighlights: TRowHighlights;
  protected
    procedure PrepareMarkupForRow(aRow: Integer); override;
    function GetMarkupAttributeAtRowCol(
      const aRow: Integer;
      const aStartCol: TLazSynDisplayTokenBound;
      const AnRtlInfo: TLazSynDisplayRtlInfo): TSynSelectedColor; override;
    procedure GetNextMarkupColAfterRowCol(
      const aRow: Integer;
      const aStartCol: TLazSynDisplayTokenBound;
      const AnRtlInfo: TLazSynDisplayRtlInfo;
      out ANextPhys, ANextLog: Integer); override;
  public
    constructor Create(ASynEdit: TSynEditBase);
  end;

type

  { TFormprotocol }

  TFormprotocol = class(TForm)
    GroupBox1: TGroupBox;
    SynEdit1: TSynEdit;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    RowMarkup: TRowHighlighter;
  public

  end;

var
  Formprotocol: TFormprotocol;
   Highlights: array of TRowHighlights;

implementation


{$R *.lfm}

{ TFormprotocol }

procedure TFormprotocol.FormCreate(Sender: TObject);
begin
  // Создаём markup для подсветки строк
  RowMarkup := TRowHighlighter.Create(Formprotocol.SynEdit1);
  Formprotocol.SynEdit1.MarkupManager.AddMarkUp(RowMarkup);
  Formprotocol.SynEdit1.ReadOnly:=True; // Только программа имеет право редактировать протокол замен.
end;

procedure TFormprotocol.FormClose(
  Sender: TObject;
  var CloseAction: TCloseAction
);
begin
  // Не уничтожаем форму, а только скрываем.
  CloseAction := caHide;
end;

constructor TRowHighlighter.Create(ASynEdit: TSynEditBase);
begin
  inherited Create(ASynEdit);
end;

procedure TRowHighlighter.PrepareMarkupForRow(aRow: Integer);
begin
  // Кэшируем подсветки для текущей строки (aRow — 1-базисный)
  FCurHighlights := nil;
  if (aRow >= 1) and (aRow <= Length(Highlights)) then
    FCurHighlights := Highlights[aRow - 1];
end;

function TRowHighlighter.GetMarkupAttributeAtRowCol(
  const aRow: Integer;
  const aStartCol: TLazSynDisplayTokenBound;
  const AnRtlInfo: TLazSynDisplayRtlInfo): TSynSelectedColor;
var
  I: Integer;
  Col: Integer;
begin
  Result := nil;
  if FCurHighlights = nil then Exit;

  // aStartCol.Logical — 1-базисная позиция символа в строке
  Col := aStartCol.Logical;

  for I := 0 to High(FCurHighlights) do
  begin
    if (Col >= FCurHighlights[I].StartPos) and
       (Col < FCurHighlights[I].StartPos + FCurHighlights[I].Length) then
    begin
      Result := MarkupInfo;
      MarkupInfo.Foreground := FCurHighlights[I].Color;
      MarkupInfo.Background := clNone;
      MarkupInfo.FrameColor := clNone;
      MarkupInfo.Style := [];
      MarkupInfo.StyleMask := [];
      MarkupInfo.SetFrameBoundsPhys(1, MaxInt);
      Exit;
    end;
  end;
end;

procedure TRowHighlighter.GetNextMarkupColAfterRowCol(
  const aRow: Integer;
  const aStartCol: TLazSynDisplayTokenBound;
  const AnRtlInfo: TLazSynDisplayRtlInfo;
  out ANextPhys, ANextLog: Integer);
var
  I: Integer;
  Col: Integer;
  NextLog: Integer;
  RegionStart, RegionEnd: Integer;
begin
  ANextPhys := -1;
  ANextLog := -1;

  if FCurHighlights = nil then Exit;

  Col := aStartCol.Logical; // текущая позиция (1-базисная)
  NextLog := MaxInt;

  for I := 0 to High(FCurHighlights) do
  begin
    RegionStart := FCurHighlights[I].StartPos;
    RegionEnd := FCurHighlights[I].StartPos + FCurHighlights[I].Length;

    if Col < RegionStart then
    begin
      // Ещё не дошли до начала региона — следующая граница = начало
      if RegionStart < NextLog then
        NextLog := RegionStart;
    end
    else if Col < RegionEnd then
    begin
      // Внутри региона — следующая граница = конец региона
      if RegionEnd < NextLog then
        NextLog := RegionEnd;
    end;
    // Если Col >= RegionEnd — регион уже пройден, пропускаем
  end;

  if NextLog <> MaxInt then
  begin
    ANextLog := NextLog;
    ANextPhys := NextLog; // для не-RTL физическая = логическая
  end;
end;



end.

