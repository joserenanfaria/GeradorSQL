unit GeradorSQL.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    pnlPrincipal: TPanel;
    pnlBottom: TPanel;
    pnlTop: TPanel;
    pnlCondicoes: TPanel;
    lblCondicoes: TLabel;
    memCondicoes: TMemo;
    pnlTabelas: TPanel;
    lblTabelas: TLabel;
    memTabelas: TMemo;
    pnlColunas: TPanel;
    lblColunas: TLabel;
    memColunas: TMemo;
    pnlBtnGerarSQL: TPanel;
    btnGerarSQL: TButton;
    lblSQL: TLabel;
    memSQL: TMemo;
    procedure btnGerarSQLClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses GeradorSQL.GeradorConsultas;

{$R *.dfm}

procedure TfrmPrincipal.btnGerarSQLClick(Sender: TObject);
var
  _GeradorConsultas : TGeradorConsultas;

  I: Integer;
begin
  try
    _GeradorConsultas := TGeradorConsultas.Create;

    try
      for I := 0 to pred(memColunas.Lines.Count) do
        _GeradorConsultas
          .AdicionarColuna(memColunas.Lines[i]);

      for I := 0 to pred(memTabelas.Lines.Count) do
        _GeradorConsultas
          .AdicionarTabela(memTabelas.Lines[i]);

      for I := 0 to pred(memCondicoes.Lines.Count) do
        _GeradorConsultas
          .AdicionarCondicao(memCondicoes.Lines[i]);

      memSQL.Clear;
      memSQL.Lines.Append(_GeradorConsultas.GerarSQL);
    except
      On e:EInfoNaoPreenchida do
      begin
        ShowMessage(
          e.Message + #13 + 'Verifique as informações e gere novamente');
      end;
      On e:exception do
      begin
        ShowMessage(
          'Ocorreu um erro ao gerar a consulta.' +
          #13 +
          'Entre em contato com o desenvolvedor');
      end;
    end;

  finally
    _GeradorConsultas.Free;
  end;
end;

end.
