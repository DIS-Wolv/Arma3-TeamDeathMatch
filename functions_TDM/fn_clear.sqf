/*
* Author: Wolv
* Fonction de nettoyage
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

//if there are some WOLV_var_Props delete (delete the old flag)
{
	deleteVehicle _x;
} forEach WOLV_var_Props;


//delete all marker
{
	//if(markerType _x == "hd_objective")then { 
		deleteMarker(_x);
	//}
}foreach allMapMarkers; 

//reset WOLV_var_Props variable
WOLV_var_Props = [];
publicVariable "WOLV_var_Props";
