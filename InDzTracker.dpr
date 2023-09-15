program InDzTracker;

uses
  System.StartUpCopy,
  FMX.Forms,
  pktu1 in 'pktu1.pas' {Form1},
  brows in 'brows.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
