
private _briefing = "ADMIN BRIEFING<br/><br/>";


/* In this briefing page you should provide the admin with any information that will aid them doing their job.
	- If mission has no automatic ending system. All conditions for the mission ending should be mentioned here so the session host knows what to do.


*/

// Insert custom text
_briefing = _briefing + 
"
Mission ends at admin's discretion.

Chat commands:
#ace-fortify on turns fortify mode on<br/>
#ace-fortify off turns fortify mode off<br/>
#ace-fortify west small 500 registers the 'small' preset for the west side with a budget of 500<br/>
#ace-fortify west medium registers the 'medium' preset for the west side with no budget<br/>
#ace-fortify o big registers the 'big' preset for the east side with no budget<br/>
rats is also a preset. :)<br/>
Don't forget fortify tools!
";

player createDiaryRecord ["diary", ["Admin",_briefing]];