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
missionNamespace setVariable ["WOLV_var_Hide", [], true];

// array of props (Flag)
missionNamespace setVariable ["WOLV_var_Props", [], true];

// array of blacklist location 
missionNamespace setVariable ["WOLV_var_LocationBlkList", ["Almyra", "Ochrolimni"], true];

// array of type of location 
missionNamespace setVariable ["WOLV_var_LocationBlkList", ['NameCityCapital','NameCity','NameVillage','Name','NameLocal','Hill'], true];


//missionNamespace getVariable ["WOLV_var_allPlayers", []];

