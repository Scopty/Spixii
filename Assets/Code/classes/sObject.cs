/*	sObject.cs
 * 
 * 	Class for a .obj+.mtl file loaded as gameObject with additional info
 * 	includes:
 * 		- OBJ class (external function), instatiates a OBJ gameObject with materials 
 * 		- id for loaded .obj/.mtl in database
 * 		- parent of loaded .obj/.mtl (null if outermost parent)
 * 		- layerClass for .obj/.mtl (e.g. skin, skeleton, organ system)
 * 		- coords array 2 dim for positions with info/media content from db,
 * 			structured as [infoID,x,y,z]
 * 	Detailed description goes here
 * 
 * 
 * 
 */

using UnityEngine;
using System.Collections;

public class sObject {
		private OBJ obj = new OBJ();
		private	int id;
		private	int parent;
		private	string layerClass;
		private double[,] coords;
}


