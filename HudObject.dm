/*******************
	Author: Tafe

	Describtion:
		HudObject is very easy to use. It simplifies the use of HUD elements into a list, which is attached to /mob.
			o The list is called: HudGroups
		You can create one HudObject, and insert it into this list. This HudObject now acts as a group holder in which you can add more objects into.
		You can look into the example for further description!



	Reference:

		New proc(/HudObject)

			Format:

				New(parent, client, icon, icon_state, screen_loc, screen_x, screen_y)

			args:
				parent: The HudObject which stores current object as a group, expects type /HudObject
				cl: a client, in this instance the user who acts as owner of said object.
				icon: icon file, in which to take appearance of. If null, it takes the icon file of it's parent.
				icon_state: Which icon state to use. This argument is not asscociated with it's parent icon_state.
				screen_loc: The location on which object is to take place. if null then use screen_x and screen_y.
				screen_x: changes said object's screen_x location, but still holds y location of parent.
				screen_y: changes said object's screen_y location, but still holds x location of parent.


		addObject proc(/HudObject)

			Format:

				addObject(/HudObject)

			args:
				HudObject: adds an object as a child inside itself. Used by parent to add more objects as children.


		remove proc(/HudObject)

			Format:

				remove()

			args: none

			This is used by parent, to unrender all objects inside children list.
			Used to remove all objects from client.screen


		setLocation proc(/HudObject)

			Format:
				setLocation()

			args: none

			sets current screen_x and screen_y values to screen_loc variable. used in HudObject/New()

		renderObjects proc(/HudObject)

			Format:
				renderObjects()

			args: none

			Used by parent to render all children objects to client.screen
**************/



#define HUD_LAYER 10



mob/var/list/HudGroups = list()
//****************************************
HudObject
	parent_type=/obj

	layer = HUD_LAYER

	var
		list/children = list()	//contains child datum in list. added by using add()
		client/client //contains client as owner. added by using add()
		HudObject/parent
		visible = true


		screen_x	//group screen location, x value
		screen_y	//gropu screen location, y value

	New(HudObject/parent = null, client, icon = null,icon_state = null, screen_loc, screen_x = null, screen_y = null);	//on creating a new HUD group.

		if(parent)
			src.parent = parent

		if(client)
			src.client = client
		else
			throw EXCEPTION("/HudGroup/New() : Expecting client as argument!")

		if(icon)	//if icon = null, give it same value as parent
			src.icon = icon

		else if(parent)
			src.icon = parent.icon

		if(icon_state)
			src.icon_state = icon_state

		if(screen_loc)
			src.screen_loc = screen_loc

		if(screen_x)
			src.screen_x = screen_x
		else if(parent)
			src.screen_x = parent.screen_x

		if(screen_y)
			src.screen_y = screen_y
		else if(parent)
			src.screen_y = parent.screen_y

		if(screen_x && screen_y)
			setLocation()



	proc
		hide()
			for(var/HudObject/o in children)
				if(o.visible)
					o.visible = false
		show()
			for(var/HudObject/o in children)
				if(!o.visible)
					o.visible = true

		addObject(var/HudObject/o)
			if(istype(o, /HudObject))
				children += o
			else
				throw EXCEPTION("/HudObject: [src].addObject() Expecting /HudObject as argument. got [o] instead")

		remove()
			for(var/HudObject/o in children)
				client.screen -= o
				CHECK_TICK

		setLocation()
			if(screen_x & screen_y)
				screen_loc = "[screen_x],[screen_y]"
		renderObjects()	// renders all childs in objects list, to client in clients list's screen.
			for(var/HudObject/o in children)
				if(o.visible)
					client.screen += o
					CHECK_TICK
				else
					client.screen -= o
					CHECK_TICK

