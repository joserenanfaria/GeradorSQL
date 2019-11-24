program GeradorSQL;

uses
  Vcl.Forms,
  GeradorSQL.Principal in 'GeradorSQL.Principal.pas' {frmPrincipal},
  GeradorSQL.GeradorConsultas in 'GeradorSQL.GeradorConsultas.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook<>0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
