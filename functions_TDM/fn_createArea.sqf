
_location = nearestLocations[[15000,15000], WOLV_var_LocationType, 30000];

_ZO = selectRandom _location;

_pos = getpos _ZO; // get location position 

// if( _forEachIndex == 75) then {
if ( //if the location is good
	!(text _ZO in WOLV_var_LocationBlkList) //and text _ZO == "Polemistia" // this comment is usefull to debug only 1 location
) then {
// if (text _ZO in ["dump"]) then {
	//préparation des variables pour le calcule du nombre de groupe
	_taille = size _ZO select 0;		// selecte the size of the area
	
	// create the circle area marker 
	_markerG2 = createMarker [(format ["obj Z2 x %1, y %2, z %3", (_pos select 0), (_pos select 1), (_pos select 2)]), _pos]; 
	_markerG2 setMarkerShape "ELLIPSE";
	_markerG2 setMarkerSize [size _ZO select 1, size _ZO select 1];
	_markerG2 setMarkerBrush "SolidBorder";
	_markerG2 setMarkerAlpha 0.3; 
	_markerG2 setMarkerColor "ColorGreen";//*/

	// define the spawn have to be set
	private _setSpawn = True; 
	//set the default spwan position in 0 0 0
	private _SpawnA = [0,0,0];
	private _SpawnB = [0,0,0];
	//while the spawn have to be set 
	while {_setSpawn} do {
		//select a random bearing for the spawn
		private _Orientation = random 180;

		//set the A spawn at 90% of the distance between the center and the border of the objectif in the bearing
		_SpawnA = _pos getPos [(size _ZO select 1) * 0.9, _Orientation];
		//set the A spawn at 90% of the distance between the center and the border of the objectif in the bearing + 180° 
		_SpawnB = _pos getPos [(size _ZO select 1) * 0.9, _Orientation + 180];
		
		//systemChat(str(_SpawnA));

		//define the spawn ar under water
		private _UW_SpawnA = true;
		//Set the itteration to 0
		private _iA = 0;
		// while the spawn are under water and between the center -20 and the border
		while {_UW_SpawnA and ((size _ZO select 1) * 0.9 + 20) > (1 * _iA) } do {

			//test if the spawn is under water
			if ((_SpawnA select 2) > -0.01) then {
				_UW_SpawnA = False;
			};
			//systemChat(Format["%1 | %2 ",_SpawnA, ((size _ZO select 1) * 0.9) < (1 * _iA)]);

			//set the iteration +1
			_iA = _iA + 1;

			//set the new spawn position
			_SpawnA = _pos getPos [((size _ZO select 1) * 0.9)- 1 * _iA, _Orientation]; 
		};
		
		//Same as upper
		//define the spawn ar under water
		private _UW_SpawnB = true;
		//Set the itteration to 0
		private _iB = 0;
		// while the spawn are under water and between the center -20 and the border
		while {_UW_SpawnB and ((size _ZO select 1) * 0.9 + 20) > (1 * _iB)} do {
			//test if the spawn is under water
			if ((_SpawnB select 2) > -0.01) then {
				_UW_SpawnB = False;
			};
			//systemChat(Format["%1 | %2 ",_SpawnB, ((size _ZO select 1) * 0.9) < (1 * _iB)]);

			//set the iteration +1
			_iB = _iB + 1;
			//set the new spawn position
			_SpawnB = _pos getPos [((size _ZO select 1) * 0.9)- 1 * _iB, _Orientation + 180]; 
		};
		//if the distance between the spawn are far enough
		if (_SpawnA distance _SpawnB >= 20)then {
			//set the spawn as correct
			_setSpawn = False;
		};
		
	};


	//hide object near the spawn
	_toHide = nearestObjects [_SpawnA, [], 15];
	{
		WOLV_var_HideProps pushBack _x;
		_x hideObjectGlobal True;
	} forEach _toHide;

	_toHide = nearestObjects [_SpawnB, [], 15];
	{
		WOLV_var_HideProps pushBack _x;
		_x hideObjectGlobal True;
	} forEach _toHide;

	//create spawn A marker
	_marker_SpawnA = createMarker [(format ["obj P x %1, y %2, z %3", (_SpawnA select 0), (_SpawnA select 1), (_SpawnA select 2)]), _SpawnA]; 
	_marker_SpawnA setMarkerType "hd_dot";
	_marker_SpawnA setMarkerColor "ColorRed";
	//_marker_SpawnA setMarkerText format["%1 | %2 | %3 | %4", text _ZO, type _ZO, size _ZO select 0, _forEachIndex];

	//create Red Flag 
	_FlagA = ("Flag_Red_F" createvehicle _SpawnA);
	//add the flag to the WOLV_var_Props
	WOLV_var_Props pushBack _FlagA;
	
	//create spawn B marker
	_marker_SpawnB = createMarker [(format ["obj P x %1, y %2, z %3", (_SpawnB select 0), (_SpawnB select 1), (_SpawnB select 2)]), _SpawnB]; 
	_marker_SpawnB setMarkerType "hd_dot";
	_marker_SpawnB setMarkerColor "ColorBlue";
	//_marker_SpawnB setMarkerText format["%1 | %2 | %3 | %4", text _ZO, type _ZO, size _ZO select 0, _forEachIndex];

	//create Blue Flag
	_FlagB = ("Flag_Blue_F" createvehicle _SpawnB);
	//add the flag to the WOLV_var_Props
	WOLV_var_Props pushBack _FlagB;
	
	//create the red center marker
	// _marker = createMarker [(format ["obj P x %1, y %2, z %3", (_pos select 0), (_pos select 1), (_pos select 2)]), _pos]; 
	// _marker setMarkerType "hd_objective";
	// _marker setMarkerColor "colorOPFOR";
	// _marker setMarkerText format["%1 | %2 | %3 | %4", text _ZO, type _ZO, _SpawnA distance _SpawnB, _forEachIndex]; 	// add text to the marker whit the name, the type of location, the distance between spawn, and index
	publicVariable "WOLV_var_HideProps";
	publicVariable "WOLV_var_Props";
};
