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
  result := 'français';
  case aICDlng of
    lng_fr: result := 'français';
    lng_nl: result := 'néerlandais';
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
