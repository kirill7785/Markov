unit UnitNam;
// Эмулятор исполнения нормальных алгоритмов Маркова
// 11 февраля 2023 (revised 20.08.2026)

{$MODE Delphi}

// Нормальные алгоритмы Маркова

interface

uses
  LCLIntf, LCLType, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Menus, Grids, PopupNotifier,
  TAIntervalSources, SynEdit, SynEditMiscClasses, SynEditTypes, SynEditMarkup,
  SynEditMarkupSpecialLine, SynEditMarkupHighAll, LazSynEditText, ShellAPI;

// одна команда в программе по Маркову.
type
  command = record
    sl, sr: string;
    bterminate: Boolean;
    SourceRow: Integer;
  end;

  TRunMode = (
    rmIdle,   // программа не выполняется
    rmRun,
    rmDemo    // выполняется пошаговая демонстрация
  );

   TEditorMode = (emGrid, emText);

   TOneStepResult = (osrRule, osrTermRule, osrNotFoundRule);

  type

    TStringDynArray = array of string;



type

  { TNAM }

  TNAM = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    LabelInterval: TLabel;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog2: TOpenDialog;
    Panel1: TPanel;
    Eribbon: TEdit;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SaveDialog2: TSaveDialog;
    SaveDialog3: TSaveDialog;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    StringGrid1: TStringGrid;
    SynEdit2: TSynEdit;
    DemoTimer: TTimer;

    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure DemoTimerTimer(Sender: TObject);
    procedure EribbonKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState); // Нажата клавиша
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject); // Инициализация при создании формы
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject); // читает программу из файла
    procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);

    procedure MenuItem2Click(Sender: TObject);  // записывает программу в файл
    procedure MenuItem4Click(Sender: TObject);  // выход из программы
    procedure MenuItem6Click(Sender: TObject);  // выполняет один шаг по Маркову
    procedure MenuItem7Click(Sender: TObject);  // Запуск программы на выполнение
    procedure MenuItem8Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure StringGrid1PrepareCanvas(Sender: TObject; aCol, aRow: Integer;
      aState: TGridDrawState);
    procedure StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
    procedure StringGrid1UTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);



  private
    { Private declarations }
     FChangingMode: Boolean;

     FRunMode: TRunMode;
  FDemoPaused: Boolean;
  FDemoStep: Integer;
  FDemoMaxSteps: Integer;
  FInTimer: Boolean;

  procedure StartDemo(Sender: TObject);
  procedure StopDemo;
  procedure FinishDemo(const AMessage: string);
  //procedure DemoTimerTimer(Sender: TObject);
  procedure UpdatePauseCaption;

  procedure ResetHistory;
  procedure SetTextModeFlag(ATextMode: Boolean);


    procedure compile(Sender: TObject);  // интерпретирует программу

  public
    { Public declarations }
    bcont : Boolean;
    task_s : string;
    speed_demo : Integer;
    smark_for_log : string;
    programm : array of command; // программа по Маркову
    n : Integer; // количество подстановок
    stack : array of string;// хранение предыдущей строки в ленте
    top : Integer;
    bmemoedt, LOck : Boolean;
    state : TEditorMode;



    function OneStep(s : string; var  bcom : Boolean; bdemo : Boolean) : TOneStepResult;
    procedure AddColoredLine(
  const AText: string;
  const AStart1, ALen1: Integer;
  const AColor1: TColor;
  const AStart2, ALen2: Integer;
  const AColor2: TColor
);
    procedure GridToText();
    function TextToGrid(Sender: TObject) : Boolean;
    function modelcheck():Boolean;
  end;

var
  NAM: TNAM;


implementation

  uses Unit2, unitZamena, unitSwap;

{$R *.lfm}

function QuotesBalanced(const S: string): Boolean;
var
  I: Integer;
  Quote: Char;
begin
  Quote := #0;

  for I := 1 to Length(S) do
  begin
    if Quote = #0 then
    begin
      if S[I] in ['"', #39] then
        Quote := S[I];
    end
    else
    if S[I] = Quote then
      Quote := #0;
  end;

  Result := Quote = #0;
end;


function IsQuotedPart(const S: string): Boolean;
var
  V: string;
  L: Integer;
begin
  V := Trim(S);
  L := Length(V);

  Result :=
    (L >= 2) and
    (
      ((V[1] = '"') and (V[L] = '"')) or
      ((V[1] = #39) and (V[L] = #39))
    );
end;

function UnquotePart(const S: string): string;
var
  V: string;
  L: Integer;
begin
  V := Trim(S);

  if SameText(V, 'NULL') then
  begin
    Result := '';
    Exit;
  end;

  L := Length(V);

  if (L >= 2) and
     (
       ((V[1] = '"') and (V[L] = '"')) or
       ((V[1] = #39) and (V[L] = #39))
     ) then
  begin
    Result := Copy(V, 2, L - 2);
  end
  else
    Result := V;
end;

function FindArrowOutsideQuotes(const S: string): Integer;
var
  I: Integer;
  Quote: Char;
begin
  Result := 0;
  Quote := #0;
  I := 1;

  while I <= Length(S) do
  begin
    if Quote <> #0 then
    begin
      if S[I] = Quote then
        Quote := #0;

      Inc(I);
      Continue;
    end;

    if S[I] in ['"', #39] then
    begin
      Quote := S[I];
      Inc(I);
      Continue;
    end;

    if (S[I] = '-') and
       (I < Length(S)) and
       (S[I + 1] = '>') then
    begin
      Result := I;
      Exit;
    end;

    Inc(I);
  end;
end;

function FindSeparatorOutsideQuotes(const S: string): Integer;
var
  I: Integer;
  Quote: Char;
begin
  Result := 0;
  Quote := #0;

  for I := 1 to Length(S) do
  begin
    if Quote <> #0 then
    begin
      if S[I] = Quote then
        Quote := #0;

      Continue;
    end;

    if S[I] in ['"', #39] then
    begin
      Quote := S[I];
      Continue;
    end;

    if S[I] in [' ', #9] then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

function RemoveRuleNumber(const S: string): string;
var
  V: string;
  P: Integer;
begin
  V := Trim(S);
  P := 1;

  while (P <= Length(V)) and
        (V[P] in ['0'..'9']) do
    Inc(P);

  // Удаляется только конструкция вида:
  // 1. правило
  // 12. правило
  //
  // Точка внутри обычного текста не удаляется.
  if (P > 1) and
     (P <= Length(V)) and
     (V[P] = '.') and
     (
       (P = Length(V)) or
       (V[P + 1] in [' ', #9])
     ) then
  begin
    Result := Trim(Copy(V, P + 1, Length(V)));
  end
  else
    Result := V;
end;

function EncodePart(const S: string;
  EmptyAsNull: Boolean): string;
var
  V: string;
begin
  V := Trim(S);

  if (Pos('"', V) > 0) and (Pos('''', V) > 0) then
    raise EConvertError.Create(
      'Значение содержит одновременно одинарную и двойную кавычку. ' +
      'Измените значение перед сохранением.');

  if V = '' then
  begin
    if EmptyAsNull then
      Result := 'NULL'
    else
      Result := '';

    Exit;
  end;

  if IsQuotedPart(V) then
  begin
    Result := V;
    Exit;
  end;

  // NULL в исходной программе зарезервирован для пустого значения.
  // Поэтому буквальное слово NULL заключаем в кавычки.
  if SameText(V, 'NULL') or
     (Pos(' ', V) > 0) or
     (Pos(#9, V) > 0) or
     (Pos('->', V) > 0) then
  begin
     if Pos('"', V) = 0 then
        Result := '"' + V + '"'
     else if Pos('''', V) = 0 then
        Result := '''' + V + ''''
     else
       raise EConvertError.Create(
    'Значение содержит одновременно одинарную и двойную кавычку. ' +
    'Его нельзя безопасно сохранить в текущем формате.');
  end
  else
    Result := V;
end;

function SwapText(const Text, A, B: string): string;
var
  P, LA, LB: Integer;
  MatchA, MatchB: Boolean;
begin
  if (A = '') or (B = '') or (A = B) then
  begin
    Result := Text;
    Exit;
  end;

  LA := Length(A);
  LB := Length(B);
  P := 1;
  Result := '';

  while P <= Length(Text) do
  begin
    MatchA := Copy(Text, P, LA) = A;
    MatchB := Copy(Text, P, LB) = B;

    if MatchA and ((not MatchB) or (LA >= LB)) then
    begin
      Result := Result + B;
      Inc(P, LA);
    end
    else if MatchB then
    begin
      Result := Result + A;
      Inc(P, LB);
    end
    else
    begin
      Result := Result + Text[P];
      Inc(P);
    end;
  end;
end;

  procedure TNAM.ResetHistory;
  begin
    top := 0;
    SetLength(stack, 1);
    stack[0] := Eribbon.Text;
  end;

  procedure TNAM.SetTextModeFlag(ATextMode: Boolean);
  begin
    FChangingMode := True;
    try
      CheckBox1.Checked := ATextMode;
    finally
      FChangingMode := False;
    end;
  end;


procedure TNAM.AddColoredLine(
  const AText: string;
  const AStart1, ALen1: Integer;
  const AColor1: TColor;
  const AStart2, ALen2: Integer;
  const AColor2: TColor
);
var
  Row: Integer;
begin
  if Formprotocol = nil then
    Exit;

  Formprotocol.SynEdit1.Lines.Add(AText);

  Row := Formprotocol.SynEdit1.Lines.Count;

  SetLength(Highlights, Row);

  SetLength(Highlights[Row - 1], 0);

  if (ALen1 > 0) and (AStart1 > 0) then
  begin
    SetLength(Highlights[Row - 1], Length(Highlights[Row - 1]) + 1);

    with Highlights[Row - 1][High(Highlights[Row - 1])] do
    begin
      StartPos := AStart1;
      Length := ALen1;
      Color := AColor1;
    end;
  end;

  if (ALen2 > 0) and (AStart2 > 0) then
  begin
    SetLength(Highlights[Row - 1], Length(Highlights[Row - 1]) + 1);

    with Highlights[Row - 1][High(Highlights[Row - 1])] do
    begin
      StartPos := AStart2;
      Length := ALen2;
      Color := AColor2;
    end;
  end;

  Formprotocol.SynEdit1.Invalidate;
end;

{function HasNumberDot(const S: string): Boolean;
var
  P: Integer;
begin
  P := 1;

  while (P <= Length(S)) and (S[P] in ['0'..'9']) do
    Inc(P);

  Result :=
    (P > 1) and
    (P <= Length(S)) and
    (S[P] = '.');
end;
 }

 function HasAmbiguousRuleNumber(const S: string): Boolean;
var
  V: string;
  P: Integer;
begin
  V := Trim(S);
  P := 1;

  while (P <= Length(V)) and
        (V[P] in ['0'..'9']) do
    Inc(P);

  Result :=
    (P > 1) and
    (P <= Length(V)) and
    (V[P] = '.') and
    (
      (P = Length(V)) or
      (V[P + 1] in [' ', #9])
    );
end;

// выполняет построение программы по Маркову
procedure TNAM.compile(Sender: TObject);
var
  WasText: Boolean;
  Row, Index: Integer;
  SL, Cmd, SR, RawSL: string;
  bOk : Boolean;
begin
  bOk:=true;

  WasText := (state = emText);
  bmemoedt := WasText;

  if WasText then
    bOk:=TextToGrid(Sender)
  else
    bOk := modelcheck;


  SetLength(programm, 0);
  n := 0;

  if (bOk) then
  begin



  for Row := 1 to StringGrid1.RowCount - 1 do
  begin
    Cmd := Trim(StringGrid1.Cells[2, Row]);

    // Пустая строка таблицы или комментарий.
    if Cmd = '' then
      Continue;

    if (Cmd <> '->') and (Cmd <> '->.') then
    begin
      ShowMessage(
        'Недопустимая команда в строке ' +
        IntToStr(Row) + ': ' + Cmd
      );

      SetLength(programm, 0);
      n := 0;
      Exit;
    end;

    RawSL := Trim(StringGrid1.Cells[1, Row]);


    if (not IsQuotedPart(RawSL)) and
   HasAmbiguousRuleNumber(RawSL) then
begin
  ShowMessage(
    'Левая часть правила в строке ' +
    IntToStr(Row) +
    ' неоднозначна: она похожа на номер правила.'
  );

  SetLength(programm, 0);
  n := 0;
  Exit;
end;

    SL := UnquotePart(StringGrid1.Cells[1, Row]);

    SR := UnquotePart(StringGrid1.Cells[3, Row]);

    Index := Length(programm);
    SetLength(programm, Index + 1);

    programm[Index].sl := SL;
    programm[Index].sr := SR;
    programm[Index].bterminate := Cmd = '->.';
    programm[Index].SourceRow := Row;
  end;

  n := Length(programm);


  end;
end;



function TNAM.OneStep(
  s: string;
  var bcom: Boolean;
  bdemo: Boolean
): TOneStepResult;
var
  I, MatchPos: Integer;
  Sm, NewText, ArrowStr: string;
  PosSlInSm, PosSrInRibbon: Integer;
  StartSl, StartSr: Integer;
  SourceRow: Integer;
begin
  Result := osrNotFoundRule;
  bcom := True;

  if n <= 0 then
    Exit;

  bcom := False;

  // Если лента была изменена вручную,
  // начинаем новую ветку истории.
  if Length(stack) = 0 then
  begin
    top := 0;
    SetLength(stack, 1);
    stack[0] := s;
  end
  else if (top < 0) or (top > High(stack)) then
  begin
    ResetHistory;
  end
  else if stack[top] <> s then
  begin
    top := 0;
    SetLength(stack, 1);
    stack[0] := s;
  end;

  I := 0;

  while I < n do
  begin
    if (programm[I].sl = '') or
       (Pos(programm[I].sl, s) > 0) then
      Break;

    Inc(I);
  end;

  // Подходящего правила нет.
  if I >= n then
  begin
    Result := osrNotFoundRule; //применимого правила нет.
    Exit;
  end;

  Sm := s;

  if programm[I].sl = '' then
    MatchPos := 1
  else
    MatchPos := Pos(programm[I].sl, s);

  NewText :=
    Copy(s, 1, MatchPos - 1) +
    programm[I].sr +
    Copy(
      s,
      MatchPos + Length(programm[I].sl),
      Length(s)
    );

  Eribbon.Text := NewText;
  smark_for_log := programm[I].sr;

  SourceRow := programm[I].SourceRow;

  if (SourceRow >= 1) and
     (SourceRow < StringGrid1.RowCount) then
    StringGrid1.Row := SourceRow;

  if programm[I].bterminate then
    ArrowStr := '->.'
  else
    ArrowStr := '->';

  AddColoredLine(
    IntToStr(SourceRow) + ': ' +
    programm[I].sl + ' ' +
    ArrowStr + ' ' +
    programm[I].sr,
    0, 0, clBlack,
    0, 0, clBlack
  );

  if Length(programm[I].sl) > 0 then
    PosSlInSm := MatchPos
  else
    PosSlInSm := 0;

  // Правая часть начинается в новой строке
  // с позиции вставки MatchPos.
  if Length(programm[I].sr) > 0 then
    PosSrInRibbon := MatchPos
  else
    PosSrInRibbon := 0;

  if PosSlInSm > 0 then
    StartSl := 3 + PosSlInSm
  else
    StartSl := 0;

  if PosSrInRibbon > 0 then
    StartSr :=
      5 + Length(Sm) +
      Length(ArrowStr) +
      PosSrInRibbon
  else
    StartSr := 0;

  AddColoredLine(
    '   ' + Sm + ' ' +
    ArrowStr + ' ' + NewText,
    StartSl,
    Length(programm[I].sl),
    clRed,
    StartSr,
    Length(programm[I].sr),
    clRed
  );

  // Удаляем ветку повторного выполнения,
  // если пользователь ранее нажимал "назад".
  if top < High(stack) then
    SetLength(stack, top + 1);

  SetLength(stack, top + 2);
  stack[top + 1] := NewText;
  Inc(top);

  Application.ProcessMessages;

  if (programm[I].bterminate) then
  begin
     Result :=  osrTermRule; //заключительная подстановка выполнена
  end
  else
  begin
     Result :=  osrRule;// обычная подстановка выполнена
  end;
end;




procedure TNAM.FormCreate(Sender: TObject);
var
   i : Integer;
begin

  FRunMode := rmIdle;
  FDemoPaused := False;
  FDemoStep := 0;
  FDemoMaxSteps := 5000;
  FInTimer := False;

 // DemoTimer.OnTimer := @DemoTimerTimer;
  DemoTimer.Enabled := False;

   state:=emGrid;

   LOck:=false;
   top:=0;
   SetLength(stack,top);

   task_s:='';

   bcont:=true;

   smark_for_log:='';
  speed_demo:=700;
  n:=0;

  StringGrid1.Options := StringGrid1.Options + [goRowSelect];


  //BitBtn4Click(Sender);

  smark_for_log:='';
  speed_demo:=700;
  n:=0; // програма пуста не откомпилирована.
  for i:=1 to StringGrid1.RowCount-1 do
    begin
       StringGrid1.Cells[0,i]:=IntToStr(i);
    end;
  StringGrid1.Options := StringGrid1.Options + [goRowSelect];
  //BitBtn4Click(Sender);

  FChangingMode := False;
ResetHistory;


end;

procedure TNAM.MenuItem10Click(Sender: TObject);
begin
   speed_demo:=700; // Средне
   DemoTimer.Interval:=700;
   MenuItem10.Caption:='Средне <';
   MenuItem11.Caption:='Медленно';
   MenuItem12.Caption:='Очень медленно';
end;

procedure TNAM.MenuItem11Click(Sender: TObject);
begin
    speed_demo:=1400; // Медленно
    DemoTimer.Interval:=1400;
   MenuItem10.Caption:='Средне';
   MenuItem11.Caption:='Медленно <';
   MenuItem12.Caption:='Очень медленно';
end;

procedure TNAM.MenuItem12Click(Sender: TObject);
begin
    speed_demo:=2100; // Очень медленно
    DemoTimer.Interval:=2100;
     MenuItem10.Caption:='Средне';
   MenuItem11.Caption:='Медленно';
   MenuItem12.Caption:='Очень медленно <';
end;

procedure TNAM.MenuItem14Click(Sender: TObject);
begin

  BitBtn4Click(Sender);
end;

function TNAM.modelcheck():Boolean;
var
   i,j,ic : Integer;
   b,b1,b2 : Boolean;
   s : string;

begin
  b:=true;
   for i:=1 to StringGrid1.RowCount - 1 do
    begin
  s := Trim(StringGrid1.Cells[2, i]);

if (s <> '') and
   (s <> '->') and
   (s <> '->.') then
begin
  ShowMessage(
    'Недопустимая команда в строке таблицы ' +
    IntToStr(i) + ': ' + s
  );
  Result := False;
  Exit;
end;

  if s = '' then
begin
  if (Trim(StringGrid1.Cells[1, i]) <> '') or
     (Trim(StringGrid1.Cells[3, i]) <> '') then
  begin
    ShowMessage(
      'В строке ' + IntToStr(i) +
      ' есть данные, но отсутствует команда.'
    );
    Result := False;
    Exit;
  end;

  Continue;
end;

end;

  { for i:=1 to StringGrid1.RowCount - 1 do
    begin
      if (Pos('->',StringGrid1.Cells[4, i])>0) then
      begin
          b:=false;
          ShowMessage('Комментарий в строке таблицы '+IntToStr(i)+' содержит запрещенный символ ->');
      end;

    end;    }

   if (b) then
   begin
       for i:=1 to StringGrid1.RowCount - 1 do
    begin
       s:= Trim(StringGrid1.Cells[1, i]);
       b1:=true;
       b2:=true;
       for j:=1 to length(s) do
        begin
           if not(b1 and (s[j] in ['0'..'9'])) then
           begin
             if (b2) then
             begin
              b1:=false;
              if ((s[j]='.')and(j<>1)) then
              begin
                b:=false;
                ShowMessage('Левое правило подстановки в строке таблицы '+IntToStr(i)+' содержит запрещенные  символы "число."');
                //Break;
              end;
              b2:=false;
             end;
             end;
           end;
        end;

    end;

    if (b) then
   begin
       s := Trim(StringGrid1.Cells[1, i]);

if not QuotesBalanced(s) then
begin
  ShowMessage(
    'Левая часть правила в строке ' +
    IntToStr(i) +
    ' содержит незакрытую кавычку.'
  );
  Result := False;
  Exit;
end;

s := Trim(StringGrid1.Cells[3, i]);

if not QuotesBalanced(s) then
begin
  ShowMessage(
    'Правая часть правила в строке ' +
    IntToStr(i) +
    ' содержит незакрытую кавычку.'
  );
  Result := False;
  Exit;
end;
    end;



    if (b) then
   begin
    if (Trim(Eribbon.Text)='#END#') then
    begin
        b:=false;
         ShowMessage(' строка ленты содержит запрещенное зарезервированное слово #END#');
    end;
   end;

    if (b) then
   begin
    for i:=0 to Memo1.Lines.Count-1 do
     begin
    if (Trim(Memo1.Lines[i])='#END#') then
    begin
        b:=false;
         ShowMessage(' строка '+IntToStr(i)+' постановки задачи содержит запрещенное зарезервированное слово #END#');
    end;

     end;
   end;

    if (b) then
   begin
       for i:=1 to StringGrid1.RowCount - 1 do
    begin
       s:= Trim(StringGrid1.Cells[4, i]);
        if (Trim(s)='#END#') then
    begin
        b:=false;
         ShowMessage(' строка комментария в строке таблицы '+IntToStr(i)+' содержит запрещенное зарезервированное слово #END#');
    end;
       end;
    end;
   Result:=b;
end;



// Очистить протокол замен
procedure TNAM.MenuItem15Click(Sender: TObject);
begin

   // Блокировка во время исполнения
    if LOck then
  Exit;


  if Formprotocol = nil then
  Exit;

    top:=0;
   SetLength(stack,top);
   Formprotocol.SynEdit1.Clear;
   SetLength(Highlights, 0);
   Formprotocol.SynEdit1.Invalidate;
end;

procedure TNAM.MenuItem16Click(Sender: TObject);
begin
   // Блокировка во время исполнения
    if LOck then
  Exit;

   if Formprotocol = nil then
  Exit;

   SaveDialog2.Filter := 'Текстовые файлы|*.txt';
   if SaveDialog2.Execute  then
   begin

   // записывает протокол работы программы с нормальным
   // алгоритмом Маркова в тексовый файл
    Formprotocol.SynEdit1.Lines.SaveToFile(SaveDialog2.FileName);

   end;
end;


procedure TNAM.FormCloseQuery(
  Sender: TObject;
  var CanClose: Boolean
);
begin
  if FRunMode = rmDemo then
  begin
    DemoTimer.Enabled := False;
    FRunMode := rmIdle;
    FDemoPaused := False;
    LOck := False;
  end;

  if FRunMode <> rmIdle then
begin
  CanClose := False;
  ShowMessage('Сначала остановите выполнение программы.');
  Exit;
end;

  CanClose := True;
end;

// считывает файл с протоколом замен
procedure TNAM.MenuItem17Click(Sender: TObject);
var tmp : TStringList;
begin
  StopDemo;

   // Блокировка во время исполнения
    if LOck then
  Exit;


        if Formprotocol = nil then
  Exit;

   // считывает файл с протоколом замен
   OpenDialog2.Filter := 'Текстовые файлы|*.txt';
   if OpenDialog2.Execute and FileExists(OpenDialog2.FileName) then
   begin
      Formprotocol.SynEdit1.ReadOnly:=True;
      try
      tmp:=TStringList.Create;
      tmp.LoadFromFile(OpenDialog2.FileName);

      tmp.Free;
         // Очищаем старое.
       SetLength(Highlights, 0);
       Formprotocol.SynEdit1.Clear;

       Formprotocol.SynEdit1.Lines.LoadFromFile(OpenDialog2.FileName);

         finally
         Formprotocol.SynEdit1.ReadOnly:=True; // Только программа имеет право редактировать протокол замен.
      end;
   end;
end;

// Открыть файл в новом формате
procedure TNAM.MenuItem18Click(Sender: TObject);
var
  FileSrc: TStringList;

  i, Row: Integer;
  FirstSep, SecondSep, RulesEnd: Integer;
  RuleCount, RequiredRows: Integer;

   ArrowPos, ArrowLen, SepPos: Integer;

  s, RightPart, Replacement: string;
  Tape: string;

begin

  // Блокировка во время исполнения
    if LOck then
  Exit;

  OpenDialog1.Filter := 'Текстовые файлы|*.txt';

  if not OpenDialog1.Execute then
  begin
    Exit;
  end;



  if not FileExists(OpenDialog1.FileName) then
  begin
    ShowMessage('Файл не найден: ' + OpenDialog1.FileName);
    Exit;
  end;

  FileSrc := TStringList.Create;
  try
    // Сначала читаем файл. Текущую программу пока не изменяем.
    try
      FileSrc.LoadFromFile(OpenDialog1.FileName);
    except
      on E: Exception do
      begin
        ShowMessage('Не удалось прочитать файл:' +
          sLineBreak + E.Message);
        Exit;
      end;
    end;

    //CheckBox1.Checked:=false; // Загружаем только в таблицу и файла

    // Формат:
    // описание
    // #END#
    // лента
    // #END#
    // правила
    // #END# — необязательный завершающий разделитель

    FirstSep := -1;
    SecondSep := -1;
    RulesEnd := FileSrc.Count;

    for i := 0 to FileSrc.Count - 1 do
    begin
      if Trim(FileSrc[i]) = '#END#' then
      begin
        if FirstSep < 0 then
          FirstSep := i
        else if SecondSep < 0 then
          SecondSep := i
        else
        begin
          RulesEnd := i;
          Break;
        end;
      end;
    end;

    if (FirstSep < 0) or (SecondSep < 0) then
    begin
      ShowMessage(
        'Неверный формат файла: необходимы два разделителя #END#.' +
        sLineBreak + 'Текущая программа не изменена.'
      );
      Exit;
    end;

    // Сохраняем прежнее поведение:
    // последняя непустая строка раздела ленты становится лентой.
    Tape := '';

    for i := FirstSep + 1 to SecondSep - 1 do
    begin
      if Trim(FileSrc[i]) <> '' then
        Tape := FileSrc[i];
    end;

    // Каждая исходная строка раздела правил занимает одну строку
    // таблицы, включая пустые строки и отдельные комментарии.
    RuleCount := RulesEnd - SecondSep - 1;
    RequiredRows := RuleCount + 1; // Плюс строка заголовков.

    // Оставляем хотя бы одну строку для редактирования.
    if RequiredRows < 2 then
      RequiredRows := 2;

    // Файл прочитан и обязательные разделители найдены.
    // Теперь можно сбросить состояние предыдущей программы.
    SetLength(programm, 0);
     n := 0;
    SetLength(Highlights, 0);
    Formprotocol.SynEdit1.Clear;

    // Подготавливаем таблицу без вызова обработчика кнопки.
    StringGrid1.RowCount := RequiredRows;

    for i := 1 to StringGrid1.RowCount - 1 do
    begin
      StringGrid1.Cells[0, i] := IntToStr(i);
      StringGrid1.Cells[1, i] := '';
      StringGrid1.Cells[2, i] := '';
      StringGrid1.Cells[3, i] := '';
      StringGrid1.Cells[4, i] := '';
    end;

    // Загружаем описание, сохраняя в нём пустые строки.
    Memo1.Lines.BeginUpdate;
    try
      Memo1.Clear;

      for i := 0 to FirstSep - 1 do
        Memo1.Lines.Add(FileSrc[i]);
    finally
      Memo1.Lines.EndUpdate;
    end;

    Eribbon.Text := Tape;

    // Разбираем раздел правил.
    for i := SecondSep + 1 to RulesEnd - 1 do
    begin
      // Номер строки определяется её положением в файле.
      // Поэтому комментарии и пустые строки не сдвигают правила.
      Row := i - SecondSep;
      s := Trim(FileSrc[i]);

      if s = '' then
        Continue;

      // Удаляем только начальный номер вида "12.".
      // Точки в остальных местах строки не затрагиваем.
      S := RemoveRuleNumber(S);


      // Первый оператор -> определяет начало правой части.
      //ArrowPos := Pos('->', s);
      ArrowPos :=FindArrowOutsideQuotes(s);

      {if ArrowPos = 0 then
      begin
        // Отдельный комментарий сохраняем в исходном виде.
        StringGrid1.Cells[4, Row] := FileSrc[i];
        Continue;
      end;}

      if ArrowPos = 0 then
begin
  if Pos('->', S) > 0 then
  begin
    ShowMessage(
      'Строка ' + IntToStr(Row) +
      ' содержит стрелку, но её невозможно разобрать.'
    );
   // Result := False;
    Exit;
  end;

  StringGrid1.Cells[4, Row] := Trim(FileSrc[i]);
  Continue;
end;

      // Определяем тип именно найденного оператора,
      // а не ищем ->. произвольно по всей строке.
      ArrowLen := 2;

      if Copy(s, ArrowPos, 3) = '->.' then
        ArrowLen := 3;

      StringGrid1.Cells[1, Row] :=
        Trim(Copy(s, 1, ArrowPos - 1));

      StringGrid1.Cells[2, Row] :=
        Copy(s, ArrowPos, ArrowLen);

      RightPart :=
        Trim(Copy(s, ArrowPos + ArrowLen, Length(s)));

      // Первое слово справа — замена.
      // Всё после первого пробела или табуляции — комментарий.
      SepPos := FindSeparatorOutsideQuotes(RightPart);

if SepPos = 0 then
begin
  Replacement := Trim(RightPart);
  StringGrid1.Cells[4, Row] := '';
end
else
begin
  Replacement := Trim(Copy(RightPart, 1, SepPos - 1));

  StringGrid1.Cells[4, Row] :=
    Trim(Copy(RightPart, SepPos + 1, Length(RightPart)));
end;

if SameText(Replacement, 'NULL') then
  Replacement := '';

StringGrid1.Cells[3, Row] := Replacement;

    end;

    // Обновляем также текстовый редактор, чтобы в нём
    // не оставалась программа, открытая до загрузки файла.
    SynEdit2.Lines.BeginUpdate;
    try
      SynEdit2.Lines.Clear;

      for i := SecondSep + 1 to RulesEnd - 1 do
        SynEdit2.Lines.Add(FileSrc[i]);
    finally
      SynEdit2.Lines.EndUpdate;
    end;

    SynEdit2.Visible := False;
    StringGrid1.Visible := True;
    state:=emGrid;

    // Используется существующая переменная состояния,
    // локальная переменная n здесь не объявляется.
   task_s := Eribbon.Text;
ResetHistory;
SetTextModeFlag(False);
  finally
    FileSrc.Free;
  end;



end;




// установить паузу   F10
procedure TNAM.MenuItem19Click(Sender: TObject);
begin
  if FRunMode <> rmDemo then
  begin
    bcont := False;
  end
  else
  begin

     FDemoPaused := not FDemoPaused;
     DemoTimer.Enabled := not FDemoPaused;

     UpdatePauseCaption;

  end;
end;

function GetHelpFileName: string;
var
  ExeDir: string;
begin
  ExeDir := ExtractFileDir(ExpandFileName(ParamStr(0)));

  Result :=
    IncludeTrailingPathDelimiter(ExeDir) +
    'help_NAM.txt';
end;

// Показ справки
procedure TNAM.MenuItem21Click(Sender: TObject);
var
  HelpFileName: string;
begin
  HelpFileName := GetHelpFileName;

  if not FileExists(HelpFileName) then
  begin
    ShowMessage(
      'Файл справки не найден.' +
      LineEnding +
      HelpFileName
    );
    Exit;
  end;

  if ShellExecute(
       0,
       'open',
       PChar(HelpFileName),
       nil,
       nil,
       SW_SHOWNORMAL
     ) <= 32 then
  begin
    ShowMessage('Не удалось открыть файл справки.');
  end;
end;



procedure TNAM.MenuItem23Click(Sender: TObject);
var
   s1,s2 :string;
   i : integer;
   bOk : Boolean;
begin

   // Блокировка во время исполнения
    if LOck then
  Exit;


  FormZamena.bOk:=False;
  FormZamena.showModal;

  if (FormZamena.bOk) then
  begin

  bOk:=true;


  if (state=emText) then
  begin
     // Перевод в таблицу.
     bOk:=NAM.TextToGrid(Sender);
  end;

  if (bOk) then
  begin

  // Замена в таблице
  s1:= Trim(FormZamena.Edit1.Text);
  s2:=Trim(FormZamena.Edit2.Text);
    for i := 1 to StringGrid1.RowCount - 1 do
begin
  if Trim(StringGrid1.Cells[2, i]) <> '' then
  begin
    StringGrid1.Cells[1, i] :=
      StringReplace(
        StringGrid1.Cells[1, i],
        s1,
        s2,
        [rfReplaceAll]
      );

    StringGrid1.Cells[3, i] :=
      StringReplace(
        StringGrid1.Cells[3, i],
        s1,
        s2,
        [rfReplaceAll]
      );
  end;
end;

  end
  else
  begin
     ShowMessage('Ошибка при преобразовании из текста в таблицу.');
  end;

    if (bOk) then
    begin
        // Перевод обратно в текст.
        NAM.GridToText();
    end;

  end
  else
  begin
     ShowMessage('замена не выполнена.');
  end;
end;

// Обмен двух значений
procedure TNAM.MenuItem24Click(Sender: TObject);
var
   s1,s2 :string;
   i : integer;
   bOk : Boolean;
   TempMarker: string;



begin

   // Блокировка во время исполнения
    if LOck then
  Exit;


  FormSwap.bOk:=false;
  FormSwap.ShowModal;

  if (FormSwap.bOk) then
  begin

  bOk:=true;


  if (NAM.state=emText) then
  begin
     // Перевод в таблицу.
     bOk:=NAM.TextToGrid(Sender);

  end;

  if (bOk) then
  begin

  s1 := FormSwap.Edit1.Text;
s2 := FormSwap.Edit2.Text;

if Trim(s1) = '' then
begin
  ShowMessage('Первое значение не может быть пустым.');
  Exit;
end;

if Trim(s2) = '' then
begin
  ShowMessage('Второе значение не может быть пустым.');
  Exit;
end;

    for i := 1 to StringGrid1.RowCount - 1 do
begin
  if Trim(StringGrid1.Cells[2, i]) <> '' then
  begin
    StringGrid1.Cells[1, i] :=
      SwapText(StringGrid1.Cells[1, i], s1, s2);

    StringGrid1.Cells[3, i] :=
      SwapText(StringGrid1.Cells[3, i], s1, s2);
  end;
end;

     if (bOk) then
    begin
        // Перевод обратно в текст.
        NAM.GridToText();
    end;
    end
     else
  begin
      ShowMessage('Ошибка при преобразовании из текста в таблицу.');
  end;
  end
   else
  begin
      ShowMessage('Обмен не произведён.');
  end;
end;

procedure TNAM.EribbonKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key = VK_F8) then  // Клавиша F8
  begin
     MenuItem6Click(Sender);
  end;
  if (key = VK_F9) then // Клавиша F9
  begin
     MenuItem7Click(Sender);
  end;
  if (key = VK_F10) then // Клавиша F10
  begin
     BitBtn9Click(Sender);
  end;
  if (key = VK_F1) then // Клавиша F1
  begin
     MenuItem21Click(Sender);
  end;
end;

// Запоминает начальное состояние ленты.
procedure TNAM.BitBtn1Click(Sender: TObject);
begin
  // Блокировка во время исполнения
    if LOck then
  Exit;

    task_s:=Eribbon.Text;
end;

// Вставка чистой строки под текущей строкой
procedure TNAM.BitBtn10Click(Sender: TObject);
var
   i : Integer;
begin

   // Блокировка во время исполнения
    if LOck then
  Exit;


  //StringGrid1.InsertRowWithValues(StringGrid1.Row, ['', '','->','']); // неверно что создаётся пустое правило, оно портит программу.
  // Стрелочка автоматом будет добавлятся при вводе левой части и нажатии на Enter.
  StringGrid1.InsertRowWithValues(StringGrid1.Row, ['', '','','']);
  for i:=1 to StringGrid1.RowCount-1 do
    begin
       StringGrid1.Cells[0,i]:=IntToStr(i);
    end;
end;

procedure TNAM.BitBtn11Click(Sender: TObject);
begin
  if LOck then
    Exit;

  if (Length(stack) > 0) and
     (top < High(stack)) then
  begin
    Inc(top);
    Eribbon.Text := stack[top];
  end;
end;

// Восстанавливает начальное состояние ленты.
procedure TNAM.BitBtn2Click(Sender: TObject);
begin
  if LOck then
    Exit;

  Eribbon.Text := task_s;
  ResetHistory;
end;

procedure TNAM.BitBtn3Click(Sender: TObject);
begin
  if LOck then
    Exit;

  if (Length(stack) > 0) and
     (top > 0) then
  begin
    Dec(top);
    Eribbon.Text := stack[top];
  end;
end;

procedure TNAM.BitBtn4Click(Sender: TObject);
begin
  //Formprotocol.GroupBox1.Visible:=not(Formprotocol.GroupBox1.Visible);

  //Formprotocol.SynEdit1.Visible:=not(Formprotocol.SynEdit1.Visible);
    //if (Formprotocol.GroupBox1.Visible) then
  //begin
  if Formprotocol = nil then
  begin
     ShowMessage('Форма протокола не создана!');
  end
  else
  begin
     if Formprotocol.Visible then
     begin
        Formprotocol.Hide;
        MenuItem14.Caption := 'Показать';
     end
      else
     begin
        Formprotocol.Show;
        MenuItem14.Caption := 'Скрыть';
      end;
  end;
  {end
  else
  begin
     MenuItem14.Caption:='Показать';
  end;}
end;

// Выполняет один шаг по Маркову.
procedure TNAM.BitBtn5Click(Sender: TObject);
begin
  if (not(LOck)) then
  begin
     MenuItem6Click(Sender);
  end;
end;

// Выполняет программу по Маркову
procedure TNAM.BitBtn6Click(Sender: TObject);
begin
  if (not(LOck)) then
  begin
      MenuItem7Click(Sender);
  end;
end;

// Открыть модель
procedure TNAM.BitBtn7Click(Sender: TObject);
begin
  MenuItem18Click(Sender);
end;

// Записать модель
procedure TNAM.BitBtn8Click(Sender: TObject);
begin
  MenuItem2Click(Sender);
end;

// Команда сделать паузу.
procedure TNAM.BitBtn9Click(Sender: TObject);
begin
 if FRunMode = rmDemo then
    MenuItem19Click(Sender)
  else
    bcont := False;
end;

procedure TNAM.GridToText;
var
  Row: Integer;
  SL, SR, Cmd, CommentText: string;
  LeftText, RightText, LineText: string;
  MaxLeft, MaxRight: Integer;

  function PadRight(const S: string; Len: Integer): string;
  begin
    Result := S;

    while Length(Result) < Len do
      Result := Result + ' ';
  end;

begin
  if not modelcheck then
  begin
    SetTextModeFlag(False);
    Exit;
  end;

  MaxLeft := 1;
  MaxRight := 1;

  for Row := 1 to StringGrid1.RowCount - 1 do
  begin
    Cmd := Trim(StringGrid1.Cells[2, Row]);

    if Cmd = '' then
      Continue;

    LeftText := EncodePart(
      StringGrid1.Cells[1, Row], False
    );

    RightText := EncodePart(
      StringGrid1.Cells[3, Row], True
    );

    if Length(LeftText) > MaxLeft then
      MaxLeft := Length(LeftText);

    if Length(RightText) > MaxRight then
      MaxRight := Length(RightText);
  end;

  SynEdit2.Lines.BeginUpdate;
  try
    SynEdit2.Clear;

    for Row := 1 to StringGrid1.RowCount - 1 do
    begin
      SL := Trim(StringGrid1.Cells[1, Row]);
      Cmd := Trim(StringGrid1.Cells[2, Row]);
      SR := Trim(StringGrid1.Cells[3, Row]);
      CommentText := Trim(StringGrid1.Cells[4, Row]);

      // Отдельный комментарий или пустая строка.
      if Cmd = '' then
      begin
        SynEdit2.Lines.Add(StringGrid1.Cells[4, Row]);
        Continue;
      end;

      LeftText := EncodePart(SL, False);
      RightText := EncodePart(SR, True);

      LineText :=
        PadRight(LeftText, MaxLeft) +
        '   ' +
        PadRight(Cmd, 3) +
        '   ' +
        PadRight(RightText, MaxRight);

      if CommentText <> '' then
        LineText := LineText + '  ' + CommentText;

      SynEdit2.Lines.Add(LineText);
    end;
  finally
    SynEdit2.Lines.EndUpdate;
  end;

  state := emText;
  StringGrid1.Visible := False;
  SynEdit2.Visible := True;
  SetTextModeFlag(True);
end;

function TNAM.TextToGrid(Sender: TObject): Boolean;
var
  I, Row, RequiredRows: Integer;
  S, OriginalLine: string;
  RightPart, Replacement, CommentText: string;
  ArrowPos, ArrowLen, SepPos: Integer;
  b7 : Boolean;
begin

  b7 := True;





  if StringGrid1.ColCount < 5 then
    StringGrid1.ColCount := 5;

  RequiredRows := SynEdit2.Lines.Count + 1;

  if RequiredRows < 2 then
    RequiredRows := 2;

  if StringGrid1.RowCount < RequiredRows then
    StringGrid1.RowCount := RequiredRows;

  for Row := 1 to StringGrid1.RowCount - 1 do
  begin
    StringGrid1.Cells[1, Row] := '';
    StringGrid1.Cells[2, Row] := '';
    StringGrid1.Cells[3, Row] := '';
    StringGrid1.Cells[4, Row] := '';
  end;

  for I := 0 to SynEdit2.Lines.Count - 1 do
  begin
    Row := I + 1;
    OriginalLine := SynEdit2.Lines[I];
    S := Trim(OriginalLine);

    if S = '' then
      Continue;

    S := RemoveRuleNumber(S);
    ArrowPos := FindArrowOutsideQuotes(S);

    // Строка без стрелки считается комментарием.
    if ArrowPos = 0 then
    begin
      StringGrid1.Cells[4, Row] := Trim(OriginalLine);
      Continue;
    end;

    ArrowLen := 2;

    if (ArrowPos + 2 <= Length(S)) and
       (S[ArrowPos + 2] = '.') then
      ArrowLen := 3;

    StringGrid1.Cells[1, Row] :=
      Trim(Copy(S, 1, ArrowPos - 1));

    if ArrowLen = 3 then
      StringGrid1.Cells[2, Row] := '->.'
    else
      StringGrid1.Cells[2, Row] := '->';

    RightPart := Trim(
      Copy(S, ArrowPos + ArrowLen, Length(S))
    );

    SepPos := FindSeparatorOutsideQuotes(RightPart);

    if SepPos = 0 then
    begin
      Replacement := Trim(RightPart);
      CommentText := '';
    end
    else
    begin
      Replacement := Trim(Copy(RightPart, 1, SepPos - 1));
      CommentText := Trim(
        Copy(RightPart, SepPos + 1, Length(RightPart))
      );
    end;

    // Только незаключённое слово NULL означает пустое значение.
    if SameText(Replacement, 'NULL') then
      Replacement := '';

    StringGrid1.Cells[3, Row] := Replacement;
    StringGrid1.Cells[4, Row] := CommentText;
  end;

  for Row := 1 to StringGrid1.RowCount - 1 do
    StringGrid1.Cells[0, Row] := IntToStr(Row);

  state := emGrid;
  SynEdit2.Visible := False;
  StringGrid1.Visible := True;
  SetTextModeFlag(False);

  b7:=modelcheck;

  if not b7 then
begin
  state := emText;
  SynEdit2.Visible := True;
  StringGrid1.Visible := False;
  SetTextModeFlag(True);
  Result := False;
  Exit;
end;

state := emGrid;
SynEdit2.Visible := False;
StringGrid1.Visible := True;
SetTextModeFlag(False);

Result := True;

  {if not modelcheck then
  begin
    SetTextModeFlag(False);
    Exit;
  end;
  }
  //Result:=b7;
end;

procedure TNAM.CheckBox1Change(Sender: TObject);
begin
  if FChangingMode then
    Exit;

  if LOck then
  begin
    SetTextModeFlag(state = emText);
    Exit;
  end;

  if state = emGrid then
    GridToText
  else
    TextToGrid(Sender);
end;

procedure TNAM.DemoTimerTimer(Sender: TObject);
  var
    Status: TOneStepResult;
     bcom : Boolean;
  begin
    if FRunMode <> rmDemo then
    begin
      DemoTimer.Enabled := False;
      Exit;
    end;

    if FDemoPaused then
      Exit;

    if FInTimer then
      Exit;

    FInTimer := True;

    try
      {
        Здесь должен быть ровно тот же вызов OneStep,
        который раньше находился внутри while.

        Например, если сигнатура у вас такая:
      }
      bcom:=true; // инициализация
      Status := OneStep(Eribbon.Text,bcom,true);

      case Status of

        osrRule:
          begin
            Inc(FDemoStep);

            if FDemoStep >= FDemoMaxSteps then
            begin
              FinishDemo(
                Format(
                  'Достигнут лимит в %d шагов. Выполнение остановлено.',
                  [FDemoMaxSteps]
                )
              );
              Exit;
            end;
          end;

        osrTermRule:
          begin
            Inc(FDemoStep);

            FinishDemo(
              Format(
                'Программа завершена за %d шаг(ов).',
                [FDemoStep]
              )
            );
            Exit;
          end;

        osrNotFoundRule:
          begin
            FinishDemo(
              Format(
                'Нет применимого правила. Выполнено подстановок: %d.',
                [FDemoStep]
              )
            );
            Exit;
          end;
      end;

    finally
      FInTimer := False;
    end;
end;

 // записывает программу и комментарии в файл
procedure TNAM.MenuItem2Click(Sender: TObject);
var
   filename : String; // имя файла
   filesrc : TStringList;  // временное хранилище исходный код и комменетарии
   i, n1 : Integer;
   i1,i2,i3, Row : Integer;
    b1 : Boolean;
     s , SL,SR,Cmd : string;
      LeftText, RightText, LineText, CommentText: string;
  MaxLeft, MaxRight: Integer;
  bOk : Boolean;

   function PadRight(const S: string; Len: Integer): string;
begin
  Result := S;
  while Length(Result) < Len do
    Result := Result + ' ';
end;

function PadLeft(const S: string; Len: Integer): string;
begin
  Result := S;
  while Length(Result) < Len do
    Result := ' ' + Result;
end;

function IsEmptyPart(const S: string): Boolean;
begin
  Result := (S = '') or
            (S = '""') or
            (S = '''') or
            SameText(S, 'NULL');
end;


begin
  if LOck then
  Exit;

   bOk:=true;

  // считывает файл с компьютерной программой
   SaveDialog1.Filter := 'Текстовые файлы|*.txt';


   if SaveDialog1.Execute  then
   begin

     b1:=(state=emText);
    bmemoedt:=b1;

    try


  if (b1) then
  begin
    // Переводим в таблицу
     bOk:=TextToGrid(Sender);
  end;

  if (bOk) then
  begin

  if not modelcheck then
  begin
    SetTextModeFlag(False);
    Exit;
  end;

   // записывает программу с нормальным
   // алгоритмом Маркова в тексовый файл
    filename:=SaveDialog1.FileName;
    //if not InputQuery('Ввод имени файла', 'Введите уникальное имя записываемой программы', filename)
      //   then exit; // срочное завершение обработки данного события, т.к. имя не введено
    //filename:=filename+'.txt';

    // Определение объекта списка строк, и указание нашей переменной на него
    filesrc:= TStringList.Create;
    try
    for i:=0 to Memo1.Lines.Count-1 do
    begin
        filesrc.Add(Memo1.Lines[i]);
    end;

    filesrc.Add('#END#');
    filesrc.Add(Eribbon.Text);
    filesrc.Add('#END#');

    MaxLeft := 1;
  MaxRight := 1;

   for Row := 1 to StringGrid1.RowCount - 1 do
  begin
    Cmd := Trim(StringGrid1.Cells[2, Row]);

    if Cmd = '' then
      Continue;

    LeftText := EncodePart(
      StringGrid1.Cells[1, Row], False
    );

    RightText := EncodePart(
      StringGrid1.Cells[3, Row], True
    );

    if Length(LeftText) > MaxLeft then
      MaxLeft := Length(LeftText);

    if Length(RightText) > MaxRight then
      MaxRight := Length(RightText);
  end;



    i:=0;
    for Row:=1 to StringGrid1.RowCount-1 do
    begin
      SL := Trim(StringGrid1.Cells[1, Row]);
      Cmd := Trim(StringGrid1.Cells[2, Row]);
      SR := Trim(StringGrid1.Cells[3, Row]);
      CommentText := Trim(StringGrid1.Cells[4, Row]);

     // Отдельный комментарий или пустая строка.
      if Cmd = '' then
      begin
        filesrc.Add(StringGrid1.Cells[4, Row]);
        Continue;
      end;

        LeftText := EncodePart(SL, False);
      RightText := EncodePart(SR, True);

      LineText :=
        PadRight(LeftText, MaxLeft) +
        '   ' +
        PadRight(Cmd, 3) +
        '   ' +
        PadRight(RightText, MaxRight);


         if CommentText <> '' then
        LineText := LineText + '  ' + CommentText;

         filesrc.Add(LineText);

    end;

    //MemoAlg.Lines.SaveToFile(filename); // сохранение в файл
     filesrc.SaveToFile(filename); // сохранение в файл

     filesrc.Clear;

    finally
      filesrc.Free;
    end;

    end
  else
  begin
      ShowMessage('Ошибка при преобразовании из текста в таблицу.');
    end;

   finally
   if (b1) then
  begin
    // Переводим в текст
    GridToText();
  end;
   end;

   end;



end;


// выход из программы
procedure TNAM.MenuItem4Click(Sender: TObject);
begin
   Close;
end;

// выполняет один шаг по Маркову
procedure TNAM.MenuItem6Click(Sender: TObject);
var
    bcom : Boolean;
    status1stp : TOneStepResult;
begin

  if LOck then
  Exit;

  LOck := True;

  try

  status1stp:=osrNotFoundRule;


      StringGrid1.Enabled := False;
SynEdit2.ReadOnly := True;
Eribbon.ReadOnly := True;

try
   compile(Sender);

   bcom:=true; // инициализация
   if (n<=0) then
   begin
      Application.MessageBox('откомпилируйте программу','требуется компиляция',MB_OK);
   end
    else
   begin
     FRunMode :=rmRun;

      // один шаг по Маркову
      status1stp:=OneStep(Eribbon.Text,bcom,false);
      if (status1stp=osrTermRule) then
      begin
         if (not(bcom)) then
         begin
            Application.MessageBox('программа успешно закончила работу. Выполнена терминальная подстановка.','завершение работы',MB_OK);
         end;
      end;
      if (status1stp=osrNotFoundRule) then
      begin
         if (not(bcom)) then
         begin
            Application.MessageBox('программа успешно закончила работу. Ни одно подходящее правило подстановки не было найдено.','завершение работы',MB_OK);
         end;
      end;
   end;


finally
  StringGrid1.Enabled := True;
  SynEdit2.ReadOnly := False;
Eribbon.ReadOnly := False;
   if (bmemoedt) then
   begin
      // Возвращаемся в режим редактора
      GridToText();
   end;

end;



  finally
      LOck:=false;
      FRunMode := rmIdle;
  end;
end;

// Выполняет программу по Маркову
procedure TNAM.MenuItem7Click(Sender: TObject);
const Program_looping=5000; // Считаем что зациклилось если более 50000шагов.
var
   bfin, bcom : Boolean;
   i7          : Integer;
     status1stp : TOneStepResult;
begin

   if LOck then
  Exit;

    LOck:=true;

   try




   StringGrid1.Enabled := False;
SynEdit2.ReadOnly := True;
Eribbon.ReadOnly := True;
   bcont:=true;
   status1stp:=osrNotFoundRule;
   task_s:=Eribbon.Text;  // Запоминаем начальное состояние ленты.


    try


   compile(Sender);
   i7:=0;
   bcom:=true; // инициализация
   if (n<=0) then
   begin
      Application.MessageBox('откомпилируйте программу','требуется компиляция',MB_OK);
   end
    else
   begin

       FRunMode := rmRun;

      // запускает программу на выполнение
       status1stp:=OneStep(Eribbon.Text,bcom,false);
      bfin:=(status1stp=osrTermRule)or(status1stp=osrNotFoundRule);
        if ((status1stp=osrTermRule)or(status1stp=osrRule)) then
           begin
              inc(i7);
           end;


      while ((bcont)and(i7<Program_looping)and(not(bfin and not(bcom)))) do
      begin
          status1stp:=OneStep(Eribbon.Text,bcom,false);
      bfin:=(status1stp=osrTermRule)or(status1stp=osrNotFoundRule);
          if ((status1stp=osrTermRule)or(status1stp=osrRule)) then
           begin
              inc(i7);
           end;
         Application.ProcessMessages;
      end;
   end;
       finally
        StringGrid1.Enabled := True;

SynEdit2.ReadOnly := False;
Eribbon.ReadOnly := False;
      if (bmemoedt) then
   begin
      // Возвращаемся в режим редактора
      GridToText();
   end;


    end;



  finally
    LOck := False;
   FRunMode := rmIdle;
  end;


   if (n<>0) then
   begin
      if (bcont) then
      begin
      if (i7<Program_looping) then
      begin
         if (status1stp=osrTermRule) then
         begin
             Application.MessageBox(PChar('программа успешно закончила работу за '+IntToStr(i7)+' шагов. Заключительная подстановка выполнена.'),'завершение работы',MB_OK);
         end;
          if (status1stp=osrNotFoundRule) then
         begin
             Application.MessageBox(PChar('программа успешно закончила работу за '+IntToStr(i7)+' шагов. Применимого правила нет.'),'завершение работы',MB_OK);
         end;
      end
      else
      begin
        //if (status1stp=osrRule) then // Обычная подстановка выполнена
          Application.MessageBox(PChar('Достигнут лимит шагов. Выполнение остановлено. Сделано более '+IntToStr(Program_looping)+' шагов.'),'ошибка алгоритма',MB_OK);
      end;

      end
      else
      begin
          Application.MessageBox(PChar('программа поставлена на паузу. Сделано '+IntToStr(i7)+' шагов.'),'пауза',MB_OK);
      end;
      end;//else программа не откомпилирована
end;


// Демонстрация исполнения программы по Маркову
procedure TNAM.MenuItem8Click(Sender: TObject);
begin
   StartDemo(Sender);
end;

// Начни с нуля
procedure TNAM.SpeedButton1Click(Sender: TObject);
var
    i : Integer;
begin
    if (not(LOck)) then
  begin

  Memo1.Clear;
  //StringGrid1.Clear;

  if (state=emGrid) then
  begin
     GridToText();
  end;
   SynEdit2.Clear;
   TextToGrid(Sender);
  Eribbon.Text:='';
   top:=0;
   SetLength(stack,top);
  task_s:='';

    // Очистить протокол замен
    MenuItem15Click(Sender);

    //очистить массив programm, n
    SetLength(programm, 0);
    n := 0;

  end;
end;

// Удаление выделенной строки НАМ программы
procedure TNAM.SpeedButton2Click(Sender: TObject);
var
    i : Integer;
begin
  if LOck then
  Exit;

  //проверка, что выбранная строка не является заголовком.
  if StringGrid1.Row <= 0 then
  Exit;
    StringGrid1.DeleteRow(StringGrid1.Row);
    for i:=1 to StringGrid1.RowCount-1 do
    begin
       StringGrid1.Cells[0,i]:=IntToStr(i);
    end;
end;

// Очистка выделенной строки НАМ программы
procedure TNAM.SpeedButton3Click(Sender: TObject);
begin
  if LOck then
  Exit;

   //проверка, что выбранная строка не является заголовком.
  if StringGrid1.Row <= 0 then
  Exit;
  StringGrid1.Rows[StringGrid1.Row].Clear;
  StringGrid1.Cells[0,StringGrid1.Row]:=IntToStr(StringGrid1.Row);
end;

// Вставка чистой строки над текущей строкой
procedure TNAM.SpeedButton4Click(Sender: TObject);
var
    i,pos : Integer;
begin
  if LOck then
  Exit;

  pos:=StringGrid1.Row+1;
  if (pos> StringGrid1.RowCount-1) then
  begin
      pos:= StringGrid1.RowCount-1;
  end;
  //StringGrid1.InsertRowWithValues(pos, ['', '','->','']); // неверно что создаётся пустое правило, оно портит программу.
  // Стрелочка автоматом будет добавлятся при вводе левой части и нажатии на Enter.
  StringGrid1.InsertRowWithValues(pos, ['', '','','']);
  for i:=1 to StringGrid1.RowCount-1 do
    begin
       StringGrid1.Cells[0,i]:=IntToStr(i);
    end;
end;

procedure TNAM.SpeedButton5Click(Sender: TObject);
begin
  if LOck then
  Exit;

   if (StringGrid1.Row>1) then
   begin
       StringGrid1.Row := StringGrid1.Row - 1;
   end;
end;

procedure TNAM.SpeedButton6Click(Sender: TObject);
begin
  if LOck then
  Exit;

    if (StringGrid1.Row<StringGrid1.RowCount-1) then
   begin
       StringGrid1.Row := StringGrid1.Row + 1;
   end;
end;

procedure TNAM.StringGrid1PrepareCanvas(Sender: TObject; aCol, aRow: Integer;
  aState: TGridDrawState);

begin
   if (aCol = 0) or (aRow = 0) then
  begin
    StringGrid1.Canvas.Brush.Color := clSilver;
    Exit;
  end;

  if aRow = StringGrid1.Row then
  begin
    StringGrid1.Canvas.Brush.Color := $00FFE8D0; // бледно-голубой
    StringGrid1.Canvas.Font.Color := clBlack;
  end
  else
  begin
    StringGrid1.Canvas.Brush.Color := clWindow;
    StringGrid1.Canvas.Font.Color := clWindowText;
  end;
end;

procedure TNAM.StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
begin
  StringGrid1.Invalidate;
end;

// Быстрое редактирование программы.
procedure TNAM.StringGrid1UTF8KeyPress(
  Sender: TObject;
  var UTF8Key: TUTF8Char
);
begin
  if LOck then
  begin
    UTF8Key := '';
    Exit;
  end;

  if StringGrid1.Row < 1 then
  begin
    UTF8Key := '';
    Exit;
  end;

  if UTF8Key = #13 then
  begin
    if StringGrid1.Col = 1 then
    begin
      if Trim(StringGrid1.Cells[1, StringGrid1.Row]) <> '' then
        StringGrid1.Cells[2, StringGrid1.Row] := '->';

      StringGrid1.Col := 3;
    end
    else
    begin
      if StringGrid1.Row < StringGrid1.RowCount - 1 then
      StringGrid1.Row := StringGrid1.Row + 1; // если мы не на последней строке таблицы.

      StringGrid1.Col := 1;
    end;

    UTF8Key := '';
  end;
end;

procedure TNAM.StartDemo(Sender: TObject);
begin
    if FRunMode <> rmIdle then
    begin
       ShowMessage('Демонстрация уже выполняется или приостановлена.');
       Exit;
    end;

  if LOck then
  begin
      ShowMessage(
        'Выполнение программы уже занято. ' +
        'Сначала завершите текущий запуск.'
      );
      Exit;
    end;

  {
    Здесь должен находиться ваш существующий код,
    который раньше выполнялся ДО старого while:

      GridToText или TextToGrid — если это нужно;
      compile;
      проверка n;
      инициализация task_s;
      очистка истории;
      очистка протокола;
      сброс top;
      подготовка массива Highlights.

    Все эти действия выполняются только один раз,
    перед запуском таймера.
  }



  compile(Sender);

  if n <= 0 then
   begin
    if bmemoedt then
      GridToText;

    ShowMessage(
      'Демонстрация не запущена: ' +
      'не найдено ни одного корректного правила.'
    );
    Exit;
  end;

  ResetHistory;
  task_s := Eribbon.Text;
  bcont := True;

  FDemoStep := 0;
  FDemoMaxSteps := 5000;
  FDemoPaused := False;
  FInTimer := False;



  FRunMode := rmDemo;
  LOck := True;

  {
    Если у вас есть отдельная процедура,
    отключающая редактирование таблицы и ленты,
    вызовите её здесь.
  }

  StringGrid1.Enabled := False;
  SynEdit2.ReadOnly := True;
  Eribbon.ReadOnly := True;

  //DemoTimer.OnTimer := @DemoTimerTimer;

  if speed_demo <= 0 then
    speed_demo := 700;

  DemoTimer.Interval := speed_demo;
  DemoTimer.Enabled := True;

  UpdatePauseCaption;
end;

procedure TNAM.StopDemo;
begin
   if FRunMode <> rmDemo then
    Exit;

  FinishDemo('Выполнение остановлено пользователем.');
end;

procedure TNAM.FinishDemo(const AMessage: string);
begin
     DemoTimer.Enabled := False;

  try
    {
      Здесь восстановите интерфейс.
      Например:
    }

    StringGrid1.Enabled := True;
    SynEdit2.ReadOnly := False;
    Eribbon.ReadOnly := False;

    {
      Если нужно вернуть текстовый режим,
      вызовите здесь вашу синхронизацию GridToText.
    }
    if bmemoedt then
      GridToText;

  finally
    FRunMode := rmIdle;
    FDemoPaused := False;
    FInTimer := False;
    LOck := False;

    UpdatePauseCaption;
  end;

  if AMessage <> '' then
    ShowMessage(AMessage);
end;


procedure TNAM.UpdatePauseCaption;
begin
  if FDemoPaused then
    MenuItem19.Caption := 'Продолжить'
  else
    MenuItem19.Caption := 'Пауза';
end;

end.
