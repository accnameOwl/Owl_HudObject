mob/verb

	//As an example, lets use a verb to provide details on how this library works.
	//Let us call the verb:

	createHUD()

		//	First we need to create a new HudObject, to act as a parent to other objects.
		//	By parent, i mean a propper group holder and not a type path
		//
		//	mobs has a list to which you need to attach the HudObject to.
		//	It is called:
		//
		//		mob/HudGroups = list()
		//

		//	This is how we do it:
		//			we create a new list, in which we insert the a new /HudObject
		//			We attach a name to this group, so we have a prefix to look for.
		//			This makes it easier to refer to specific groups!
		//
		//			In this example, we use HudGroup_row1 as prefix to this list.
		//			Then we create a new /HudObject and give it it's propper arguments.
		HudGroups += list("HudGroup_row1" =  new/HudObject(client=src.client, icon='exampleIcon.dmi'))

		//	Since this HudObject is acting as a parent, there are a few arguments we can skip.
		//	You can look up the reference on either the hub or HudObject.dmi file to see arguments.

		//	Next step: Add more objects to our HudObject group.
		//	First we need to create a variable with /HudObject as type.
		//
		//		I.E: var/HudObject/
		//
		//	And we call it hudrow_1.
		//	My objective is to add 5 buttons in a row, and later add another row of objects.
		//
		//	We then attach a value to our variable. This is specificly from our HudGroup list!
		//	And now you will see why we wanted to add a prefix to our HudObject in the first place.

		var/HudObject/hudrow_1 = HudGroups["HudGroup_row1"]
								//list[prefix_to_HudObject]


		//	Now comes the easy part!
		//	We can use the procs from our HudGroup object inside HudGroups[], because we have already
		//	declaired our variable type.
		//
		//	This way we can call addObject()
		//
		//	Then we create a new HudObject as an argument.
		//	This HudObject will then be added as a child to our HudGroup[HudObject]
		//
		//	It is very important that you add arument: parent, client
		//	Or else you will have runtime errors!
		hudrow_1.addObject(new/HudObject(hudrow_1, client=usr,icon_state="1", screen_loc="1,1"))

		//Then we add some more!
		hudrow_1.addObject(new/HudObject(hudrow_1, client=usr,icon_state="2", screen_loc="2,1"))
		hudrow_1.addObject(new/HudObject(hudrow_1, client=usr,icon_state="3", screen_loc="3,1"))
		hudrow_1.addObject(new/HudObject(hudrow_1, client=usr,icon_state="4", screen_loc="4,1"))
		hudrow_1.addObject(new/HudObject(hudrow_1, client=usr,icon_state="5", screen_loc="5,1"))


		//The good future of this library, is the ability to create more groups!
		//This will make it much simpler for you to organize objects!

		// In this example, we create our second row of HudObjects!
		HudGroups += list("HudGroup_row2" = new/HudObject(client=src.client, icon='exampleIcon.dmi'))
		var/HudObject/hudrow_2 = HudGroups["HudGroup_row2"]
		hudrow_2.addObject(new/HudObject(hudrow_2, client=usr,icon_state="1", screen_loc="1,2"))
		hudrow_2.addObject(new/HudObject(hudrow_2, client=usr,icon_state="2", screen_loc="2,2"))
		hudrow_2.addObject(new/HudObject(hudrow_2, client=usr,icon_state="3", screen_loc="3,2"))
		hudrow_2.addObject(new/HudObject(hudrow_2, client=usr,icon_state="4", screen_loc="4,2"))
		hudrow_2.addObject(new/HudObject(hudrow_2, client=usr,icon_state="5", screen_loc="5,2"))

		//	At the end it is important to call renderObject()
		//
		// 	We do that for both our HudGroups
		hudrow_1.renderObjects()
		hudrow_2.renderObjects()


//****************************************
//			HUDOBJECTS WITH FUNCTIONS
//*****************************************

/*

	If you whish to add HudObject with a function, you can do this by creating a subtype, I.E child

*/

HudObject/objectWithFunction

	Click()
		world << "hello!"


mob/verb
	createHUDWithFunction()
		HudGroups += list("HudGroup_row3" =  new/HudObject(client=src.client, icon='exampleIcon.dmi'))
		var/HudObject/hudrow_3 = HudGroups["HudGroup_row3"]
		hudrow_3.addObject(new/HudObject/objectWithFunction(hudrow_3, client=usr,icon_state="1", screen_loc="5,5"))

		hudrow_3.renderObjects()