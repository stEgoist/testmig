move /Y *.log old
ADMT USER /F "C:\!mig\u.txt"  /IF:no /SD:"target.local" /SO:"!mig" /TD:"void.int" /TO:"!mig" /migratesids:no /mgs:yes /dot:targetsameassource  
ADMT GROUP /F "C:\!mig\g.txt"  /IF:no /SD:"target.local" /SO:"!mig" /TD:"void.int" /TO:"!mig" /migratesids:no /mgs:yes
ADMT TASK /last:2 /getlog:yes /folder:"c:\!mig"
erase "c:\!mig\u.txt" /f
erase "c:\!mig\g.txt" /f
