namespace SBR_Server;

interface

uses
  System.Collections.Generic,
  System.Linq,
  System.Text,
  System.IO;

type
  Logger = public class
  private
  protected
  public
    class method Log(aMsg, aType: String);
    class method Log(aMsg: String);
    class method IsConsoleApp: Boolean;
  end;

implementation

class method Logger.Log(aMsg: String; aType: String);
begin
  var s: String := aType;
  if s <> '' then s := s + ' ';
  s := s + aMsg;
  s := DateTime.Now.ToString('yy-MM-dd hh:mm:ss') + ' ' + s;
//  var LogParth: String := Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location); // + '\Log\';
//  var LogParth: String := System.Reflection.Assembly.GetExecutingAssembly().Location; // + '\Log\';
  var LogParth: String := System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location) + '\Log\';

  var LogFile: String := LogParth + 'SBR_Server_' + DateTime.Now.ToString('yyyy-MM-dd') + '.log';
  System.IO.Directory.CreateDirectory(LogParth);
  var sw: System.IO.StreamWriter := new System.IO.StreamWriter(LogFile,true);
  sw.WriteLine(s);
  sw.Close;
  if IsConsoleApp then
    Console.WriteLine(s);
end;

class method Logger.Log(aMsg: String);
begin
  Log(aMsg,'');
end;

class method Logger.IsConsoleApp: Boolean;
begin
  result := Console.OpenStandardInput(1) ≠ Stream.Null;
end;

end.
