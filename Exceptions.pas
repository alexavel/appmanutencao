unit Exceptions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Generics.Collections,
   System.Threading;

type
  TfExceptions = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Memo2: TMemo;
    Label2: TLabel;
    Button2: TButton;
    Memo3: TMemo;
    Label1: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FPath: string;
    FListaErro : TList<String>;

    procedure LoadNumbers(AIgnore: Integer);
    function TempoDecorrido(aTimer1, aTimer2: TDateTime): String;
  public
  end;

var
  fExceptions: TfExceptions;

implementation

uses
  System.SyncObjs;
{$R *.dfm}

procedure TfExceptions.Button1Click(Sender: TObject);
var
  I: integer;
  DataIni: TDateTime;
  DataFim: TDateTime;
begin
  try
    Memo1.Lines.Clear;
    Memo2.Lines.Clear;
    FListaErro := TList<String>.Create;
    DataIni := Now;
    try
      LoadNumbers(1);
    except on E: Exception do
      begin
        Memo1.Lines.Add('Classe Exception: ' + E.ClassName);
        Memo1.Lines.Add('Erro: ' + E.Message);
        raise;
      end;
    end;

    if FListaErro.Count > 0 then
      for I := 0 to Pred( FListaErro.Count ) do
        Memo1.Lines.Add( FListaErro[i] );

  finally
    FListaErro.Free;
    DataFim := Now;
  end;
  Label1.Caption := 'Tempo de processamento: ' + TempoDecorrido(DataIni, DataFim) + ' ms';
end;

procedure TfExceptions.Button2Click(Sender: TObject);
var
  i: Integer;
  DataIni: TDateTime;
  DataFim: TDateTime;
begin
  Memo1.Lines.Clear;
  Memo2.Lines.Clear;
  FListaErro := TList<String>.Create;
  try
    DataIni := Now;
    for i := 0 to 7 do
    begin
        LoadNumbers(i);
    end;
    DataFim := Now;

    if FListaErro.Count > 0 then
      for I := 0 to Pred( FListaErro.Count ) do
        Memo1.Lines.Add( FListaErro[i] );

     Label1.Caption := 'Tempo de processamento: ' + TempoDecorrido(DataIni, DataFim) + ' ms';
  finally
     FListaErro.Free;
  end;


end;

procedure TfExceptions.FormCreate(Sender: TObject);
begin
  FPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'text.txt';
end;

procedure TfExceptions.LoadNumbers(AIgnore: Integer);
var
  st: TStringList;
begin
  Memo2.Lines.Add( '<<<<<<<< Removendo Numero ' +  AIgnore.ToString + ' >>>>>>>>>>>>>'  );
  st := TStringList.Create;
  try
    try
      st.LoadFromFile(FPath);
      Memo2.Lines.Add( StringReplace(st.Text, AIgnore.ToString, '', [rfReplaceAll, rfIgnoreCase]) );
      StrToInt(' ');
    except
      FListaErro.Add( Format('Erro ao tentar retirar número %d', [AIgnore]) );
    end;
  finally
    FreeAndNil( st );
  end;
end;

function TfExceptions.TempoDecorrido(aTimer1, aTimer2: TDateTime): String;
begin
  Result := FloatToStr((aTimer2 - aTimer1 ) * 24 * 60 * 60);
end;

end.
