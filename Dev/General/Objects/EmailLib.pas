unit EmailLib;

interface

  function EmailTempDir: string;
  function EmailTempMessageDir: string;
  function EmailTempAttachmentDir: string;
  function EmailTempInlineDir: string;
  function EmailTempSignatureDir: string;


implementation

uses
  SystemLib, SysUtils;

function EmailTempDir: string;
begin
  result := SystemLib.GetAppTempDir + '\Email\';
  ForceDirectories(result);
end;

function EmailTempMessageDir: string;
begin
  result := EmailTempDir + 'Message\';
  ForceDirectories(result);
end;

function EmailTempAttachmentDir: string;
begin
  result := EmailTempDir + 'Attachment\';
  ForceDirectories(result);
end;

function EmailTempInlineDir: string;
begin
  result := EmailTempDir + 'Inline\';
  ForceDirectories(result);
end;

function EmailTempSignatureDir: string;
begin
  result := EmailTempDir + 'Signature\';
  ForceDirectories(result);
end;

end.
