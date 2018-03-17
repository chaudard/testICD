unit ICDtranslator;

interface

type

  TICDlng = (lng_fr, lng_nl);

  TICDtranslator = class
    class function GUItranslate(const aICDlng: TICDlng): string;
    class function ADOtranslate(const aICDlng: TICDlng): string;
  end;

implementation

class function TICDtranslator.GUItranslate(const aICDlng: TICDlng): string;
begin
  result := 'fran�ais';
  case aICDlng of
    lng_fr: result := 'fran�ais';
    lng_nl: result := 'n�erlandais';
  end;
end;

class function TICDtranslator.ADOtranslate(const aICDlng: TICDlng): string;
begin
  result := 'FR_DESCRIPTION';
  case aICDlng of
    lng_fr: result := 'FR_DESCRIPTION';
    lng_nl: result := 'NL_DESCRIPTION';
  end;
end;

end.
