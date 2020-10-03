unit Threads;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Threading,
  Vcl.ComCtrls;

type
  TfThreads = class(TForm)
    btnThread01: TButton;
    lblTituloTempo: TLabel;
    edtTempo: TEdit;
    pgbStatus: TProgressBar;
    procedure edtTempoExit(Sender: TObject);
    procedure btnThread01Click(Sender: TObject);
  private
    { Private declarations }
     procedure FinalizarThread( Sender: TObject );
  public
    { Public declarations }
  end;

var
  fThreads: TfThreads;

implementation

{$R *.dfm}

procedure TfThreads.btnThread01Click(Sender: TObject);
var
  FThreadPrincipal : TThread;
begin
  pgbStatus.Max       := 200;
  pgbStatus.Min       := 0;
  pgbStatus.Position  := pgbStatus.Min;

  btnThread01.Enabled := False;
  FThreadPrincipal    := TThread.CreateAnonymousThread(procedure()
    var
      tasks: array [0..1] of ITask;
    begin

      tasks[0] := TTask.Create(procedure
      var
        i: Integer;
      begin
        for i := 0 to 100 do
        begin
          Sleep( StrToIntDef( edtTempo.Text, 0) );
          pgbStatus.Position := pgbStatus.Position + 1;
        end;

      end);

      tasks[1] := TTask.Create(procedure
      var
        i: Integer;
      begin
        for i := 0 to 100 do
        begin
          Sleep( StrToIntDef( edtTempo.Text, 0) );
          pgbStatus.Position := pgbStatus.Position + 1;
        end;

      end);

      tasks[0].Start;
      tasks[1].Start;

      TTask.WaitForAll(tasks);

    end);
   FThreadPrincipal.FreeOnTerminate := true;
   FThreadPrincipal.OnTerminate     := FinalizarThread;
   FThreadPrincipal.Start;
end;

procedure TfThreads.edtTempoExit(Sender: TObject);
begin
  edtTempo.Text := strtoIntDef( edtTempo.Text,0).ToString ;
end;

procedure TfThreads.FinalizarThread(Sender: TObject);
begin
 if TThread(Sender).FatalException <> nil then
  begin
    ShowMessage(TThread(Sender).FatalException.ToString);
    Exit;
  end
  else
    btnThread01.Enabled := true;

end;

end.
