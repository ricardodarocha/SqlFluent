# SqlFluent
Write Sql Sentences inline in delphi code, without create big strings

# How to start

Add both dependencies in your project **/src/**

```Delphi
uses TSql, SQLPattern;
```

Then Create Sql expressions as you expect
```Delphi
procedure TForm2.Button1Click(Sender: TObject);
begin
    Memo1
    .Lines
    .Text := TMotorSql
    .Select
    .ADD('JOB', [
                 'CODIGOJOB',
                 'CODIGOJOBCFG',
                 'COFIGOJOBAGENDA',
                 'CODIGOJOBBUILD'])
    .FROM('JOBAGENDA JA'        )
    .JOINOn('JOBOBJETO JOB', 'JOB.CODIGOJOB = JA.CODIGOJOB', 'LEFT')
    .WHERE([
                 'JOB.CODIGOJOB > 1',
                 '',
                 '',
                 'JOB.CODIGOJOBBUILD > 1'])
    .GROUPBY('1,2,3,4')
    .ORDERBY('1,2,3,4')
    .TOSql;
    ```
