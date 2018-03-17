unit ICDtranslator;

interface

type

  TICDlng = (lng_fr, lng_nl);

  TICDtranslator = class
    class function GUItranslate(const aICDlng: TICDlng): string;
    class function ADOtranslate(const aICDlng: TICDlng): string;
  end;

implementation

uses
  ICDconst;

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
  result := CST_FR_DESC_FIELD;
  case aICDlng of
    lng_fr: result := CST_FR_DESC_FIELD;
    lng_nl: result := CST_NL_DESC_FIELD;
  end;
end;

end.
