program Alpha;

uses
  Forms,windows,
  MainUnit in 'MainUnit.pas' {MainForm},
  FindUnit in 'FindUnit.pas' {DlgFindWindow},
  AboutUnit in 'AboutUnit.pas' {AboutBox};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Alpha tool';
  SetWindowLong(Application.Handle, GWL_EXSTYLE,
        GetWindowLong(Application.Handle, GWL_EXSTYLE) or
        WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
