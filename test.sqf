
locationType = ['NameCityCapital','NameCity','NameVillage','Name','NameLocal','Hill'];


locationBlkList =["Almyra", "Ochrolimni"];
//, "Agia Stemma", "Xirolimni Dam","Surf Club", "Limni", "Cape Kategidis", "Cape Thelos", "Pyrsos", "Krya Nera", "Faros", "quarry", "Edoris", "Agela","Fournos", "Neochori", "Monisi", "Agios Kosmas", "dump", "Agios Minas", "Cape Makrinos", "Pyrgi", "Sagonisi", "Agios Panagiotis", "Savri", "Cape Drakontas","Riga","Skopos","Amoni","Amfissa","Kira","Bomos","Synneforos","Atsalis","Thronos","Cape Agrios","Nychi","Zeloran","Cape Zefyris","Agios Georgios","Almyra","Agios Andreas","Sideras","Polemistia","Skiptro","Ochrolimni","Chelonisi","Didymos","Mazi",""];


hint "TEST \n _____________________\nPlayer 1 : \n";

if ((count Props) != 0) then {
	{
		deleteVehicle _x;
	} forEach Props;
};

{
	//if(markerType _x == "hd_objective")then { 
		deleteMarker(_x);
	//}
}foreach allMapMarkers; 

Props = [];
publicVariable "Props";

_location = nearestLocations[[15000,15000], locationType, 30000];
{
	_pos = getpos _x;
	// if( _forEachIndex == 75) then {
	if (!(text _x in locationBlkList) //and text _x == "Polemistia"
		) then {
	// if (text _x in ["dump"]) then {
		//préparation des variables pour le calcule du nombre de groupe
		_taille = size _x select 0;		// Taille de la Zone
		
		_marker = createMarker [(format ["obj P x %1, y %2, z %3", (_pos select 0), (_pos select 1), (_pos select 2)]), _pos]; 
		_marker setMarkerType "hd_objective";
		_marker setMarkerColor "colorOPFOR";

		/*
		_markerG = createMarker [(format ["obj Z x %1, y %2, z %3", (_pos select 0), (_pos select 1), (_pos select 2)]), _pos]; 
		_markerG setMarkerShape "ELLIPSE";
		//_markerG setMarkerSize [size _x select 0, size _x select 0];
		_markerG setMarkerSize [(size _x select 1) + 20, (size _x select 1) + 20];
		_markerG setMarkerBrush "SolidBorder";
		_markerG setMarkerAlpha 0.5; 
		_markerG setMarkerColor "colorOPFOR";//*/
		
		//*
		_markerG2 = createMarker [(format ["obj Z2 x %1, y %2, z %3", (_pos select 0), (_pos select 1), (_pos select 2)]), _pos]; 
		_markerG2 setMarkerShape "ELLIPSE";
		_markerG2 setMarkerSize [size _x select 1, size _x select 1];
		_markerG2 setMarkerBrush "SolidBorder";
		_markerG2 setMarkerAlpha 0.3; 
		_markerG2 setMarkerColor "ColorGreen";//*/

		private _setSpawn = True;
		
		private _SpawnA = [0,0,0];
		private _SpawnB = [0,0,0];
		while {_setSpawn} do {
			private _Orientation = random 180;

			_SpawnA = _pos getPos [(size _x select 1) * 0.9, _Orientation];
			_SpawnB = _pos getPos [(size _x select 1) * 0.9, _Orientation + 180];
			systemChat(str(_SpawnA));
			
			private _UW_SpawnA = true;
			private _iA = 0;
			while {_UW_SpawnA and ((size _x select 1) * 0.9 + 20) > (1 * _iA)
				} do {
				if ((_SpawnA select 2) > -0.01) then {
					_UW_SpawnA = False;
				};
				systemChat(Format["%1 | %2 ",_SpawnA, ((size _x select 1) * 0.9) < (1 * _iA)]);

				_iA = _iA + 1;
				_SpawnA = _pos getPos [((size _x select 1) * 0.9)- 1 * _iA, _Orientation]; 
			};

			private _UW_SpawnB = true;
			private _iB = 0;
			while {_UW_SpawnB and ((size _x select 1) * 0.9 + 20) > (1 * _iB)
				} do {
				if ((_SpawnB select 2) > -0.01) then {
					_UW_SpawnB = False;
				};
				systemChat(Format["%1 | %2 ",_SpawnB, ((size _x select 1) * 0.9) < (1 * _iB)]);

				_iB = _iB + 1;
				_SpawnB = _pos getPos [((size _x select 1) * 0.9)- 1 * _iB, _Orientation + 180]; 
			};
			if (_SpawnA distance _SpawnB >= 20)then {
				_setSpawn = False;
			};
			
		};

		_marker_SpawnA = createMarker [(format ["obj P x %1, y %2, z %3", (_SpawnA select 0), (_SpawnA select 1), (_SpawnA select 2)]), _SpawnA]; 
		_marker_SpawnA setMarkerType "hd_dot";
		_marker_SpawnA setMarkerColor "ColorRed";
		//_marker_SpawnA setMarkerText format["%1 | %2 | %3 | %4", text _x, type _x, size _x select 0, _forEachIndex];
		_FlagA = ("Flag_Red_F" createvehicle _SpawnA);
		/*if (((getPos _FlagA) select 2) < 0) then {
			_FlagA setPosASL _SpawnA;
		};//*/
		Props pushBack _FlagA;
		
		_marker_SpawnB = createMarker [(format ["obj P x %1, y %2, z %3", (_SpawnB select 0), (_SpawnB select 1), (_SpawnB select 2)]), _SpawnB]; 
		_marker_SpawnB setMarkerType "hd_dot";
		_marker_SpawnB setMarkerColor "ColorBlue";
		//_marker_SpawnB setMarkerText format["%1 | %2 | %3 | %4", text _x, type _x, size _x select 0, _forEachIndex];
		_FlagB = ("Flag_Blue_F" createvehicle _SpawnB);
		/*if (((getPos _FlagB) select 2) < 0) then {
			_FlagB setPosASL _SpawnB;
		};//*/
		Props pushBack _FlagB;
		
		_marker setMarkerText format["%1 | %2 | %3 | %4", text _x, type _x, _SpawnA distance _SpawnB, _forEachIndex];

		sleep 0.01;
	}
	else {
		/*
		_marker = createMarker [(format ["obj P x %1, y %2, z %3", (_pos select 0), (_pos select 1), (_pos select 2)]), _pos]; 
		_marker setMarkerType "hd_destroy_noShadow";
		_marker setMarkerColor "ColorBlack";
		_marker setMarkerText format["%1 | %2 | %3 | %4", text _x, type _x, size _x select 0, _forEachIndex];
		//*/
	};
}forEach _location;
publicVariable "Props";


// _caller = _this select 1;
// _caller setPos (getpos _random); */

//systemChat(str(count Maison))

