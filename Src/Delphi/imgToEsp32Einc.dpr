program imgToEsp32Einc;

uses
  Vcl.Forms,
  Unit2 in 'Unit2.pas' {Form2},
  uCEFApplication,
  uCEFWorkScheduler;

{$R *.res}

const
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;

begin
  CreateGlobalCEFApp;

  if GlobalCEFApp.StartMainProcess then
  begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TForm2, Form2);
  Application.Run;

    Form2.Free;
    GlobalCEFWorkScheduler.StopScheduler;

  end;

  DestroyGlobalCEFApp;
  DestroyGlobalCEFWorkScheduler;

end.
