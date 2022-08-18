/*
* Author: Wolv
* Fonction d'initialisation des variables de missions.
*
* Arguments:
*
* Return Value:
* nil
*
* Example:
* [] call WOLV_fnc_var
*
* Public:
*/

// array of hide object
if (isNil WOLV_var_HideProps) then {
	missionNamespace setVariable ["WOLV_var_HideProps", [], true];
};

// array of props (Flag)
if (isNil WOLV_var_Props) then {
	missionNamespace setVariable ["WOLV_var_Props", [], true];
};

// array of blacklist location 
if (isNil WOLV_var_LocationBlkList) then {
	missionNamespace setVariable ["WOLV_var_LocationBlkList", ["Almyra", "Ochrolimni", "Cape Makrinos"], true];
};

// array of type of location 
if (isNil WOLV_var_LocationType) then {
	missionNamespace setVariable ["WOLV_var_LocationType", ['NameCityCapital','NameCity','NameVillage','Name','NameLocal','Hill'], true];
};


//missionNamespace getVariable ["WOLV_var_allPlayers", []];

