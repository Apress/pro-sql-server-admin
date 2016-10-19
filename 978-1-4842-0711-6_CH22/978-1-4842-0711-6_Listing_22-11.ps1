sl "C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Policies\DatabaseEngine"

Invoke-PolicyEvaluation -Policy " C:\Program Files (x86)\Microsoft SQL Server 
\120\Tools\Policies\DatabaseEngine\DatabaseNameConvention.xml DatabaseNameConvention.xml" -TargetServer" .\MASTERSERVER"
