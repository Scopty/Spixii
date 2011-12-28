/*	sObject.cs
 * 
 * 	struct for information related to an indiviudal .obj file
 * 	includes:
 * 		- OBJ struct (external function) with ids for individual meshes
 * 		- MAT struct with .mtl/.mat for .obj
 * 		- id for .obj in database
 * 		- parent .obj (null if outermost parent)
 * 		- layerClass for .obj (e.g. skin, skeleton, organ system)
 * 
 * 	Detailed description goes here
 * 
 * 
 * 
 */

using System;

namespace Application
{
	public class sObject
	{
		public	OBJ OBJ
		public	sMaterial MAT
		public	int id
		public	int parentId
		public	string layerClass
	}
}

