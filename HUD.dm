#define HUD_LAYER 10

mob/var/list/HUD = list()	//the list in which to store datum /HudGroup
var
	HudGroup = /HudGroup //typecasting
//****************************************
HudGroup
	//***********************
	//	datum tree:
	//
	//		HudGroup
	//		>	object
	//
	//***********************
	//
	//	HudGroup variables:
	//		group_x
	//		group_y
	//		visible
	//		objects = list()
	//		clients = list()
	//
	parent_type=/obj

	layer = HUD_LAYER

	var
		list/objects = list()	//contains child datum in list.
		list/clients = list() //contains client as owner. added by using add()

		visible = true


		group_x	//group screen location, x value
		group_y	//gropu screen location, y value

	New(client/c,icon=null, icon_state=null, group_x=null, group_y = null)	//on creating a new HUD group.
		if(istype(c, /client))	add(c)
		if(icon)
			src.icon=icon
			world.log << "HudGroup.New(icon=[icon])"
		if(icon_state)
			src.icon_state = icon_state
			world.log << "HudGroup.New(icon_state=[icon_state])"
		if(group_x) src.group_x = group_x
		else	src.group_x = 1
		if(group_y)	src.group_y = group_y
		else	src.group_y = 1



	proc
		add(type, icon=null, icon_state=null, screen_loc=null)
			world << "add()"
		//arg type: redirects to proc corresponding to type. if(type=/HUD/object) > addObject()
			if(istype(type, /client))	//client
				clients += type
			if(istype(type, /HudGroup/object))	//object
				world << "add(): istype([type], /object)"
				if(screen_loc)
					objects += new/HudGroup/object(parent=src, icon, icon_state, screen_loc)
				else throw EXCEPTION("[src].add(type = /object): Expecting screen_loc argument! got null instead!")

		///////    Not complete!!!!
		_set(var/argument, var/value)			//arg variable: changes variable corresponding to arg.
			var/A = src.vars[argument]
			world << "_set(): returns: [A] = [value]"
			A = value

		remove(var/HudGroup/object/o)
			for(var/client/c in clients)
				for(o in objects)
					c.screen -= o

		renderObjects()	// renders all childs in objects list, to client in clients list's screen.
			for(var/client/c in clients)
				for(var/HudGroup/object/o in objects)
					if(o.visible)
						c.screen += o


//****************************************
HudGroup/object

	var
		HudGroup/parent

	New(parent=null, icon = null, icon_state = null, screen_loc=null)
		world << "object.New()"
		if(istype(parent, /HudGroup))
			src.parent = parent
		if(icon)	//if icon = null, give it same value as parent
			src.icon = icon
		if(icon_state)
			src.icon_state = icon_state
		if(screen_loc)
			src.screen_loc = screen_loc