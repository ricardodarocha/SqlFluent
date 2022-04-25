unit TesteSql;

interface

uses
  Winapi.Windows, 
  Winapi.Messages, 
  Classes, 
  SysUtils,
  Variants, 
  Vcl.Graphics,
  Vcl.Controls, 
  Vcl.Forms,
  Vcl.Dialogs, 
  Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses SQLPattern, TSql;

procedure TForm2.Button1Click(Sender: TObject);
begin
    Memo1
    .Lines
    .Text := TMotorSql
    .Select
    .ADD('CUSTOMER', [
                 'ID_CUSTOMER',
                 'ID_CONFIGURATION',
                 'NAME',
                 'REGION'])
    .FROM('ORDER AS ORD'        )
    .JOINOn('CUSTOMEROBJETO AS CUSTOMER', 'CUSTOMER.ID_CUSTOMER = ORD.ID_CUSTOMER', 'LEFT')
    .WHERE([
                 'CUSTOMER.ID_CUSTOMER > 1',
                 'NAME LIKE "%MARIA"', //SOME EMPTY EXPRESSION DOES NOT CRASHES THE FINAL SQL
                 '',
                 'CUSTOMER.REGION > 1'])
    .GROUPBY('1,2,3,4')
    .ORDERBY('1,2,3,4')
    .ToSql;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
 Memo1
    .Lines
    .Text := TMotorSql
    .Select('CFG.STATUS, ')
       .ADD('COUNT(CAST(1 as Integer)) as QTD')
      .FROM('JOBCONFIGURACAO CFG' )
    .JOINOn('JOBOBJETO JO', 'CFG.CODIGOJOB = JO.CODIGOJOB', '')

    .JOINOn('JOBCONFIGURACAODET CFGDET', 'CFG.CODIGOJOB = CFGDET.CODIGOJOB', '')
       .&AND('CFG.CODIGOJOBCFG = CFGDET.CODIGOJOBCFG')
       .&AND('JO.CODIGOJOBOBJETO = CFGDET.CODIGOJOBOBJETO')

    .JOINOn('JOBCONFIGURACAODET CFGDET', 'CFG.CODIGOJOB = CFGDET.CODIGOJOB', '')
    .WHERE('_AFiltro')

    .GROUPBY('CFG.STATUS')
    .ORDERBY('CFG.STATUS')
    .ToSql;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
{
'SELECT JB.STATUS '+
                 ', COUNT(CAST(1 as Integer)) as QTD '+
              'FROM JOBCONFIGURACAO CFG '+

              'JOIN JOBOBJETO JO '+
                'ON CFG.CODIGOJOB = JO.CODIGOJOB '+

              'JOIN JOBCONFIGURACAODET CFGDET '+
                'ON CFG.CODIGOJOB = CFGDET.CODIGOJOB '+
               'AND CFG.CODIGOJOBCFG = CFGDET.CODIGOJOBCFG '+
               'AND JO.CODIGOJOBOBJETO = CFGDET.CODIGOJOBOBJETO '+

              'JOIN JOBBUILD JB '+
                'ON CFG.CODIGOJOB = JB.CODIGOJOB '+
               'AND CFG.CODIGOJOBCFG = JB.CODIGOJOBCFG '+
               'AND JB.CODIGOJOBOBJETO = JO.CODIGOJOBOBJETO ' +
               'AND JB.CODIGOBUILD = CFGDET.CODIGOBUILDULTIMO '+

               ' '+ Trim(_AFiltro) + ' '+

          'GROUP BY JB.STATUS '+
          'ORDER BY JB.STATUS';}
    Memo1
    .Lines
    .Text := TMotorSql
    .Select
    .ADD('CUSTOMER', [
                 'ID_CUSTOMER',
                 'ID_CONFIGURATION',
                 'NAME',
                 'REGION'])
    .FROM('ORDER AS ORD'        )
    .JOINOn('CUSTOMEROBJETO AS CUSTOMER', 'CUSTOMER.ID_CUSTOMER = ORD.ID_CUSTOMER', 'LEFT')
    .WHERE([
                 'CUSTOMER.ID_CUSTOMER > 1',
                 'NAME LIKE "%MARIA"', //SOME EMPTY EXPRESSION DOES NOT CRASHES THE FINAL SQL
                 '',
                 'CUSTOMER.REGION > 1'])
    .GROUPBY('1,2,3,4')
    .ORDERBY('1,2,3,4')
    .ToSql;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
 {Result := '
             'WHERE ' + GetColunaStatus(_AAlias) +
               ' IN (' + GetSatusFiltroCard(_AStatusJob, _AExibirDesativados) + ')';

  if not trim(_AFiltro).IsEmpty then
    Add(Result, ' (' + _AFiltro + ') ', ' AND ');

  Result := Result + ' ORDER BY ' + GetOrderBy(_AStatusJob);}
    Memo1
    .Lines
    .Text := TMotorSql
    .Select('CAST(0 AS INTEGER) SELECIONADO')
    .ADD(', CFG',   ['CODIGOJOB',
                     'CODIGOJOBCFG'])
    .ADD(', JCA',   ['NOMEJOB'])
    //', '+ GetColunaStatus(_AAlias) +
    .ADD(', AGE',   ['DATAINICIAL',
                     'DATAFINAL',
                     'CODIGOJOBAGENDA'])
    .ADD(', BDJ',   ['DATAHORAEXECUCAO',
                     'DURACAO',
                     'CODIGOBUILD',
                     'CODIGOBUILDROTINA',
                     'CODIGOJOBOBJETO',
                     'NOMEROTINA'])
    .ADD(', JO',    ['DESCRICAOOBJETO DESCRICAOROTINA'])
    .ADD(', CFG',   ['CODIGOGRUPOPROC',
                     'CODIGOEMPRESA',
                     'CODIGOESTAB'])
    .ADD(', BDJ',   ['TOTALARQUIVO',
                     'CAMINHOLOG CAMINHO',
                     'DATAINIEXEC',
                     'DATAFIMEXEC'])
    .ADD(', ESTAB', ['NOMEESTAB'])
    .ADD(', CFG',   ['LOGUSUARIO'])

    .FROM('JOBCADASTRO JCA'        )

    .JOINON('JOBCONFIGURACAO CFG', 'JCA.CODIGOJOB = CFG.CODIGOJOB ')
    .JOINON('JOBAGENDA AGE', 'JCA.CODIGOJOB = CFG.CODIGOJOB ', 'LEFT')
                'ON (CFG.CODIGOJOB = AGE.CODIGOJOB '+
               'AND CFG.CODIGOJOBAGENDA = AGE.CODIGOJOBAGENDA) '+
              'JOIN JOBOBJETO JO '+
                'ON JO.CODIGOJOB = CFG.CODIGOJOB '+
              'JOIN JOBCONFIGURACAODET CFGDET '+
                'ON CFG.CODIGOJOB = CFGDET.CODIGOJOB '+
               'AND CFG.CODIGOJOBCFG = CFGDET.CODIGOJOBCFG '+
               'AND JO.CODIGOJOBOBJETO = CFGDET.CODIGOJOBOBJETO '+
                    GetJoin(_ATipoJoin) + 'JOBBUILD BDJ '+
                'ON ((CFG.CODIGOJOB = BDJ.CODIGOJOB) '+
               'AND (CFG.CODIGOJOBCFG = BDJ.CODIGOJOBCFG) '+
               'AND (BDJ.CODIGOJOBOBJETO = JO.CODIGOJOBOBJETO)'+
                    GetUltimoBuild(GetProcessando, GetAgendado) + ') '+
         'LEFT JOIN EMPRESA '+
                'ON EMPRESA.CODIGOEMPRESA = CFG.CODIGOEMPRESA '+
         'LEFT JOIN ESTAB '+
                'ON ESTAB.CODIGOEMPRESA = CFG.CODIGOEMPRESA '+
               'AND ESTAB.CODIGOESTAB = CFG.CODIGOESTAB '+


    .JOINOn('CUSTOMEROBJETO AS CUSTOMER', 'CUSTOMER.ID_CUSTOMER = ORD.ID_CUSTOMER', 'LEFT')
    .WHERE([
                 'CUSTOMER.ID_CUSTOMER > 1',
                 'NAME LIKE "%MARIA"', //SOME EMPTY EXPRESSION DOES NOT CRASHES THE FINAL SQL
                 '',
                 'CUSTOMER.REGION > 1'])
    .GROUPBY('1,2,3,4')
    .ORDERBY('1,2,3,4')
    .ToSql;




    SELECT CAST(0 AS INTEGER) SELECIONADO'+
                 ', CFG.CODIGOJOB'+
                 ', CFG.CODIGOJOBCFG'+
                 ', JCA.NOMEJOB'+
                 ', CFG.DATAHORAPROXEXEC'+
                 ', '+ GetColunaStatus(_AAlias) +
                 ', AGE.DATAINICIAL'+
                 ', AGE.DATAFINAL'+
                 ', AGE.CODIGOJOBAGENDA'+
                 ', BDJ.DATAHORAEXECUCAO'+
                 ', BDJ.DURACAO'+
                 ', BDJ.CODIGOBUILD'+
                 ', BDJ.CODIGOBUILDROTINA'+
                 ', BDJ.CODIGOJOBOBJETO'+
                 ', BDJ.NOMEROTINA'+
                 ', JO.DESCRICAOOBJETO DESCRICAOROTINA'+
                 ', CFG.CODIGOGRUPOPROC'+
                 ', CFG.CODIGOEMPRESA'+
                 ', CFG.CODIGOESTAB'+
                 ', BDJ.TOTALARQUIVO'+
                 ', BDJ.CAMINHOLOG CAMINHO'+
                 ', BDJ.DATAINIEXEC'+
                 ', BDJ.DATAFIMEXEC'+
                 ', ESTAB.NOMEESTAB'+
                 ', CFG.LOGUSUARIO '+
              'FROM JOBCADASTRO JCA '+
              'JOIN JOBCONFIGURACAO CFG '+
                'ON JCA.CODIGOJOB = CFG.CODIGOJOB '+
         'LEFT JOIN JOBAGENDA AGE '+
                'ON (CFG.CODIGOJOB = AGE.CODIGOJOB '+
               'AND CFG.CODIGOJOBAGENDA = AGE.CODIGOJOBAGENDA) '+
              'JOIN JOBOBJETO JO '+
                'ON JO.CODIGOJOB = CFG.CODIGOJOB '+
              'JOIN JOBCONFIGURACAODET CFGDET '+
                'ON CFG.CODIGOJOB = CFGDET.CODIGOJOB '+
               'AND CFG.CODIGOJOBCFG = CFGDET.CODIGOJOBCFG '+
               'AND JO.CODIGOJOBOBJETO = CFGDET.CODIGOJOBOBJETO '+
                    GetJoin(_ATipoJoin) + 'JOBBUILD BDJ '+
                'ON ((CFG.CODIGOJOB = BDJ.CODIGOJOB) '+
               'AND (CFG.CODIGOJOBCFG = BDJ.CODIGOJOBCFG) '+
               'AND (BDJ.CODIGOJOBOBJETO = JO.CODIGOJOBOBJETO)'+
                    GetUltimoBuild(GetProcessando, GetAgendado) + ') '+
         'LEFT JOIN EMPRESA '+
                'ON EMPRESA.CODIGOEMPRESA = CFG.CODIGOEMPRESA '+
         'LEFT JOIN ESTAB '+
                'ON ESTAB.CODIGOEMPRESA = CFG.CODIGOEMPRESA '+
               'AND ESTAB.CODIGOESTAB = CFG.CODIGOESTAB '+
             'WHERE ' + GetColunaStatus(_AAlias) +
               ' IN (' + GetSatusFiltroCard(_AStatusJob, _AExibirDesativados) + ')'
end;

end.
