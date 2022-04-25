unit TesteSql;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
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
end;

end.
