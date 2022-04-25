program MotorSql;

uses
  Vcl.Forms,
  TesteSql in 'TesteSql.pas' {Form2},
  TSql in 'TSql.pas',
  SQLPattern in 'SQLPattern.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := true;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
