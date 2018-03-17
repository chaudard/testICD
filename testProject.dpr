program testProject;

uses
  Forms,
  UnitGUI in 'UnitGUI.pas' {ApplicationGUIForm},
  ICDsearcher in 'ICDsearcher.pas',
  ICDrecord in 'ICDrecord.pas',
  ICDtranslator in 'ICDtranslator.pas',
  ICDconst in 'ICDconst.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TApplicationGUIForm, ApplicationGUIForm);
  Application.Run;
end.
