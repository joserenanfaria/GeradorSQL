unit GeradorSQL.GeradorConsultas;

interface

uses
  System.SysUtils, System.Classes;

type
  EInfoNaoPreenchida = Exception;

  TGeradorConsultas = class
  private
    FTabelas: TStringList;
    FCondicoes: TStringList;
    FColunas: TStringList;
  published
    procedure AdicionarColuna(AColuna: String);
    procedure AdicionarTabela(ATabela: String);
    procedure AdicionarCondicao(ACondicao: String);
    function GerarSQL: String;

    constructor Create;

    Destructor Destroy; Override;
  end;

implementation

uses
  StrUtils;

{ TGeradorConsultas }

procedure TGeradorConsultas.AdicionarColuna(AColuna: String);
begin
  if AColuna.IsEmpty then
    raise EInfoNaoPreenchida.Create('Coluna não preenchida');

  {if length(Trim(AColuna)) = 0 then
    raise EInfoNaoPreenchida.Create('Não é permitido coluna em branco');   }

  FColunas.Append(AColuna);
end;

procedure TGeradorConsultas.AdicionarCondicao(ACondicao: String);
begin
  if ACondicao.IsEmpty then
    raise EInfoNaoPreenchida.Create('Condição não preenchida');

  {if length(Trim(ACondicao)) = 0 then
    raise EInfoNaoPreenchida.Create('Não é permitido condição em branco'); }

  FCondicoes.Append(ACondicao);
end;

procedure TGeradorConsultas.AdicionarTabela(ATabela: String);
begin
  if ATabela.IsEmpty then
    raise EInfoNaoPreenchida.Create('Tabela não preenchida');

  {if length(Trim(ATabela)) = 0 then
    raise EInfoNaoPreenchida.Create('Não é permitido tabela em branco');   }

  FTabelas.Append(ATabela);
end;

constructor TGeradorConsultas.Create;
begin
  inherited;

  FTabelas := TStringList.Create;
  FCondicoes := TStringList.Create;
  FColunas := TStringList.Create;
end;

destructor TGeradorConsultas.Destroy;
begin
  if Assigned(FTabelas) then
    FTabelas.Free;

  if Assigned(FCondicoes) then
    FCondicoes.Free;

  if Assigned(FColunas) then
    FColunas.Free;

  inherited;
end;

function TGeradorConsultas.GerarSQL: String;
var
  _select : String;
  _from : String;
  _where : String;
  i: Integer;
begin
  Result := '';

  if FColunas.Count = 0 then
    raise EInfoNaoPreenchida.Create('Coluna(s) não preenchida(s)');

  if FTabelas.Count = 0 then
    raise EInfoNaoPreenchida.Create('Tabela(s) não preenchida(s)');

  if FCondicoes.Count = 0 then
    raise EInfoNaoPreenchida.Create('Condições não preenchidas');

  for i := 0 to pred(FColunas.Count) do
  begin
    if i = pred(FColunas.Count) then
    begin
       _select := _select + FColunas.Strings[i] + ' ';
       Break;
    end;
    _select := _select + FColunas.Strings[i] + ', ';
  end;

  for i := 0 to pred(FTabelas.Count) do
  begin
    if i = pred(FTabelas.Count) then
    begin
       _from := _from + FTabelas.Strings[i] + ' ';
       Break;
    end;
    _from := _from + FTabelas.Strings[i] + ', ';
  end;

  for i := 0 to pred(FCondicoes.Count) do
  begin
    if i = pred(FCondicoes.Count) then
    begin
       _where := _where + FCondicoes.Strings[i] + ' ';
       Break;
    end;
    _where := _where + FCondicoes.Strings[i] + ' AND ';
  end;


  Result :=
    'SELECT ' +
      _select +
    'FROM ' +
      _from +
    'WHERE ' +
      _where;

end;

end.
