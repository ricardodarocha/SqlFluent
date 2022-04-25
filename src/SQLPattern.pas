unit SQLPattern;

interface

function SELECT  (Campos: string; Template: string = 'SELECT %s'): string; overload;
function SELECT2  (Campo1, Campo2: string; Template: string = 'SELECT %s, %s'): string;
function SELECT  (Campos: array of const; Template: string = 'SELECT %s, %s'): string; overload;

function FROM (Tabela: string; Template: string = 'from %s'): string;
function FromJoin (Tabela, JOIN: string; const TipoJoin: string = 'INNER'; Template: string = 'from %s %s JOIN %s'): string;
function JOIN (JoinExpressao: string; const TipoJoin: string = 'INNER'; Template: string = '%s JOIN %s'): string;
function JoinON (JoinTabela, ExpressaoOn: string; const TipoJoin: string = 'INNER'; Template: string = '%s JOIN %s on %s'): string;
function WHERE (Condicoes: string; Template: string = 'WHERE %s'): string; overload;
function WHERE2 (Condicao1, Condicao2: string; const Operador: string = 'AND'; Template: string = 'WHERE %s %s %s'): string;
function WHERE (Expressoes: array of string; const Operador: string = 'AND'; Template: string = 'WHERE %s'): string; overload;

function GROUPBY(Campos: string; Template: string = 'GROUP BY %s'): string; //overload;

function ORDERBY(Campos: string; Template: string = 'ORDER BY %s'): string; //overload;

implementation

uses
  SysUtils, StrUtils;

function SELECT(Campos: string; Template: string): string;
begin
  Result := Format(Template, [Campos]);
end;

function SELECT2(Campo1, Campo2: string; Template: string): string;
begin
  Result := Format(Template, [Campo1, Campo2]);
end;

function SELECT(Campos: array of const; Template: string): string;
begin
  Result := Format(Template, Campos);
end;

function FROM(Tabela: string; Template: string = 'from %s'): string;
begin
  Result := Format(Template, [Tabela]);
end;

function FROMJoin(Tabela, JOIN: string; const TipoJoin: string = 'INNER'; Template: string = 'from %s %s JOIN %s'): string;
begin
  Result := Format(Template, [Tabela, TipoJoin, Join]);
end;

function JOIN(JoinExpressao: string; const TipoJoin: string = 'INNER'; Template: string = '%s JOIN %s'): string;
begin
  Result := Format(Template, [TipoJoin, JoinExpressao]);
end;

function JOINon(JoinTabela, ExpressaoOn: string; const TipoJoin: string = 'INNER'; Template: string = '%s JOIN %s on %s'): string;
begin
  Result := Format(Template, [TipoJoin, JoinTabela, ExpressaoOn]);
end;

function WHERE(Condicoes: string; Template: string = 'WHERE %s'): string;
begin
  if (Trim(Condicoes) = emptyStr) and (trim(Template).EndsWith('%s')) then
    Exit('');

  Result := Format(Template, [Condicoes]);
end;

function WHERE2(Condicao1, Condicao2: string; const Operador: string = 'AND'; Template: string = 'WHERE %s %s %s'): string;
begin
  if Trim(Condicao1) = emptyStr then
    Exit(Where(Condicao2) );

  if Trim(Condicao2) = emptyStr then
    Exit(Where(Condicao1) );

  Result := Format(Template, [Condicao1, Operador, Condicao2]);
end;

function WHERE(Expressoes: array of string; const Operador: string = 'AND'; Template: string = 'WHERE %s'): string;
begin
  Result := '';
  for var i := 0 to High(Expressoes) do
    if trim(Expressoes[i]) <> '' then
      Result := Result + '(' + Expressoes[i] + ') ' + Operador + ' ';

  Result := Result + '$END$';
  Result := StringReplace (Result, Operador + ' ' + '$END$', '', []);

  if (Trim(Result) = emptyStr) and (Template.EndsWith('%s')) then
    Exit('');

  Result := Format(Template, [Result]);
end;

function GROUPBY(Campos: string; Template: string = 'GROUP BY %s'): string;
begin
  if (Trim(Campos) = emptyStr) and (Template.EndsWith('%s')) then
    Exit('');

  Result := Format(Template, [Campos]);
end;

function ORDERBY(Campos: string; Template: string = 'ORDER BY %s'): string;
begin
  if (Trim(Campos) = emptyStr) and (Template.EndsWith('%s')) then
    Exit('');

  Result := Format(Template, [Campos]);
end;

end.
