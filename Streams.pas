unit Streams;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TfStreams = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FPath: string;

    function LoadStream: TMemoryStream;
  public
  end;

var
  fStreams: TfStreams;

implementation

{$R *.dfm}

procedure TfStreams.Button1Click(Sender: TObject);
var
  S: TStream;
begin
  S := LoadStream;

  Label1.Caption := 'Size: ' + (S.Size div 1024).ToString + ' MB';
end;

procedure TfStreams.Button2Click(Sender: TObject);
var
  i, SizeInc: Integer;
  S: TStream;
begin
  Button2.Enabled       := False;
  S                     := LoadStream;
  try
    SizeInc               := 0;
    ProgressBar1.Position := 0;
    ProgressBar1.Max      := (S.Size div 1024);
    try
      for i := 0 to ProgressBar1.Max do
      begin
        SizeInc               := i;
        ProgressBar1.Position := ProgressBar1.Position + 1;
        Label2.Caption        := 'Size: ' + (SizeInc).ToString + ' MB';
        Application.ProcessMessages;
      end;
      Button2.Enabled         := true;
      ShowMessage( ' Processado Com Sucesso!' );
    except on E:Exception do
      begin
        raise Exception.Create('Erro ao Processar o Arquivo ' + E.Message );
      end;
    end;
  finally
    FreeAndNIl( S )
  end;

end;

procedure TfStreams.FormCreate(Sender: TObject);
begin
  FPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'pdf.pdf';
end;

function TfStreams.LoadStream: TMemoryStream;
begin
  Result := nil;
  if FileExists(FPath) then
  begin
    Result := TMemoryStream.Create;
    Result.LoadFromFile(FPath);
  end;
end;

end.
