unit TSql;

interface

uses SQLPattern;


type

  TMotorSql = class
  private
    FSQL: String;
    function _SELECT(Campos: string; Template: string = 'SELECT %s'): TMotorSql; overload;
    function _SELECT2(Campo1, Campo2: string; Template: string = 'SELECT %s, %s'): TMotorSql; overload;
    function _SELECT(Campos: array of const; Template: string = 'SELECT %s, %s'): TMotorSql; overload;
  public
    class function SELECT(Campos: string = ''; Template: string = 'SELECT %s'): TMotorSql; overload;
    class function SELECT2(Campo1, Campo2: string; Template: string = 'SELECT %s, %s'): TMotorSql; overload;
    class function SELECT(Campos: array of const; Template: string = 'SELECT %s, %s'): TMotorSql; overload;

    function FROM(Tabela: string; Template: string = 'from %s'): TMotorSql;
    function FROMJoin(Tabela, JOIN: string; const TipoJoin: string = 'INNER'; Template: string = 'from %s %s JOIN %s'): TMotorSql;
    function JOIN(JoinExpressao: string; const TipoJoin: string = 'INNER'; Template: string = '%s JOIN %s'): TMotorSql;
    function JOINOn(JoinTabela, Expressao: string; const TipoJoin: string = 'INNER'; Template: string = '%s JOIN %s on %s'): TMotorSql;
    function WHERE(Condicoes: string; Template: string = 'WHERE %s'): TMotorSql; overload;
    function WHERE(Condicao1, Condicao2: string; const Operador: string; Template: string = 'WHERE %s %s %s'): TMotorSql; overload;
    function WHERE(Expressoes: array of string; const Operador: string = 'AND'; Template: string = 'WHERE %s'): TMotorSql; overload;
    function GROUPBY(Campos: string; Template: string = 'GROUP BY %s'): TMotorSql;
    function ORDERBY(Campos: string; Template: string = 'ORDER BY %s'): TMotorSql;

    function Add(AExpressao: String): TMotorSql; overload;
    function Add(AExpressao1, AExpressao2: String; Template: string = '%s %s'): TMotorSql; overload;
    function Add(AAlias: string; AColunas: array of String; const ASep: string = ','#$D#$A): TMotorSql; overload;
    function AddAlias(AAlias, AColuna: String): TMotorSql;
    function AddTipo(AColuna, ATipo: String): TMotorSql;
    function ToSql: string;
  end;

implementation

uses
  SysUtils;

{ TMotorSql }

class function TMotorSql.SELECT(Campos, Template: string): TMotorSql;
begin
  Result := TMotorSql.Create._SELECT(Campos, Template);
end;

class function TMotorSql.SELECT2(Campo1, Campo2, Template: string): TMotorSql;
begin
  Result := TMotorSql.Create._SELECT2(Campo1, Campo2, Template);
end;

class function TMotorSql.SELECT(Campos: array of const; Template: string): TMotorSql;
begin
  Result := TMotorSql.Create._SELECT(Campos, Template);
end;

function TMotorSql.Add(AExpressao: String): TMotorSql;
begin
  FSql := FSql + (AExpressao) + #13;
  Result := Self;
end;

function TMotorSql._SELECT(Campos, Template: string): TMotorSql;
begin
  Result := Add(SQLPattern.SELECT(Campos, Template));
end;

function TMotorSql._SELECT2(Campo1, Campo2, Template: string): TMotorSql;
begin
  Result := Add(SQLPattern.SELECT2(Campo1, Campo2, Template));
end;

function TMotorSql._SELECT(Campos: array of const; Template: string): TMotorSql;
begin
  Result := Add(SQLPattern.SELECT(Campos, Template));
end;

function TMotorSql.Add(AExpressao1, AExpressao2, Template: string): TMotorSql;
begin
  Result := Add(format(Template, [AExpressao1, AExpressao2]));
end;

function TMotorSql.AddAlias(AAlias, AColuna: String): TMotorSql;
begin
  Result := Add(AAlias, AColuna, '%s.%s');
end;

function TMotorSql.Add(AAlias: string; AColunas: array of String; const ASep: string): TMotorSql;
begin
  var Expressao := '';
  for var i := 0 to High(AColunas) do
    Expressao := Expressao + Format('%s.%s%s', [AAlias, AColunas[i], ASep] );

  Expressao := Expressao + '$END$';
  Expressao := StringReplace(Expressao, ASep + '$END$', '', []);
  Result := Add(Expressao);
end;

function TMotorSql.AddTipo(AColuna, ATipo: String): TMotorSql;
begin
  Result := Add(AColuna, ATipo, '%s:%s');
end;

function TMotorSql.FROM(Tabela, Template: string): TMotorSql;
begin
  Result := Add(SQLPattern.FROM(Tabela, Template));
end;

function TMotorSql.FROMJoin(Tabela, JOIN: string; const TipoJoin: string = 'INNER'; Template: string = 'from %s %s JOIN %s'): TMotorSql;
begin
  Result := Add(SQLPattern.FROMJoin(Tabela, JOIN, TipoJoin, Template));
end;

function TMotorSql.JOIN(JoinExpressao: string; const TipoJoin: string = 'INNER'; Template: string = '%s JOIN %s'): TMotorSql;
begin
  Result := Add(SQLPattern.JOIN(JoinExpressao, TipoJoin, Template));
end;

function TMotorSql.JOINOn(JoinTabela, Expressao: string; const TipoJoin: string = 'INNER'; Template: string = '%s JOIN %s on %s'): TMotorSql;
begin
  Result := Add(SQLPattern.JOINon(JoinTabela, Expressao, TipoJoin, Template));
end;

function TMotorSql.WHERE(Condicoes, Template: string): TMotorSql;
begin
 Result := Add(SQLPattern.WHERE(Condicoes, Template));
end;

function TMotorSql.WHERE(Condicao1, Condicao2: string; const Operador: string; Template: string): TMotorSql;
begin
  Result := Add(SQLPattern.WHERE2(Condicao1, Condicao2, Operador, Template));
end;

function TMotorSql.WHERE(Expressoes: array of string; const Operador: string; Template: string): TMotorSql;
begin
  Result := Add(SQLPattern.WHERE(Expressoes, Operador, Template));
end;

function TMotorSql.GROUPBY(Campos, Template: string): TMotorSql;
begin
  Result := Add(SQLPattern.GROUPBY(Campos, Template));
end;

function TMotorSql.ORDERBY(Campos, Template: string): TMotorSql;
begin
  Result := Add(SQLPattern.ORDERBY(Campos, Template));
end;

function TMotorSql.ToSql: string;
begin
  Result := StringReplace(FSQL, '"', '''', [rfReplaceAll]);
  FreeAndNil(Self);
end;


end.
