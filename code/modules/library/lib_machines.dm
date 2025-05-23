/* Library Machines
 *
 * Contains:
 *		Borrowbook datum
 *		Library Public Computer
 *		Library Computer
 *		Library Scanner
 *		Book Binder
 */

/*
 * Borrowbook datum
 */
/datum/borrowbook // Datum used to keep track of who has borrowed what when and for how long.
	var/bookname
	var/mobname
	var/getdate
	var/duedate

/*
 * Library Public Computer
 */
/obj/machinery/librarypubliccomp
	name = "visitor computer"
	icon = 'icons/obj/library.dmi'
	icon_state = "computer"
	anchored = 1
	density = 1
	var/screenstate = 0
	var/title
	var/category = "Any"
	var/author

/obj/machinery/librarypubliccomp/attack_hand(mob/user, datum/event_args/actor/clickchain/e_args)
	usr.set_machine(src)
	var/dat = "<HEAD><TITLE>Library Visitor</TITLE></HEAD><BODY>\n" // <META HTTP-EQUIV='Refresh' CONTENT='10'>
	switch(screenstate)
		if(0)
			dat += {"<h2>Search Settings</h2><br>
			<A href='?src=\ref[src];settitle=1'>Filter by Title: [title]</A><BR>
			<A href='?src=\ref[src];setcategory=1'>Filter by Category: [category]</A><BR>
			<A href='?src=\ref[src];setauthor=1'>Filter by Author: [author]</A><BR>
			<A href='?src=\ref[src];search=1'>\[Start Search\]</A><BR>"}
		if(1)
			if(!SSdbcore.Connect())
				dat += "<font color=red><b>ERROR</b>: Unable to contact External Archive. Please contact your system administrator for assistance.</font><BR>"
			else
				dat += {"<table>
				<tr><td>AUTHOR</td><td>TITLE</td><td>CATEGORY</td><td>SS<sup>13</sup>BN</td></tr>"}

				var/datum/db_query/query = SSdbcore.RunQuery(
					"SELECT author, title, category, id FROM [DB_PREFIX_TABLE_NAME("library")] WHERE author LIKE '%:author%' AND title LIKE '%:title%'[category == "Any"? "" : " AND category = :category"]",
					category == "Any"? list("author" = author, "title" = title) : list("author" = author, "title" = title, "category" = category)
				)

				while(query.NextRow())
					var/author = query.item[1]
					var/title = query.item[2]
					var/category = query.item[3]
					var/id = query.item[4]
					dat += "<tr><td>[author]</td><td>[title]</td><td>[category]</td><td>[id]</td></tr>"
				dat += "</table><BR>"
			dat += "<A href='?src=\ref[src];back=1'>\[Go Back\]</A><BR>"
	user << browse(dat, "window=publiclibrary")
	onclose(user, "publiclibrary")

/obj/machinery/librarypubliccomp/Topic(href, href_list)
	if(..())
		usr << browse(null, "window=publiclibrary")
		onclose(usr, "publiclibrary")
		return

	if(href_list["settitle"])
		var/newtitle = input("Enter a title to search for:") as text|null
		if(newtitle)
			title = sanitize(newtitle)
		else
			title = null
		title = sanitizeSQL(title)
	if(href_list["setcategory"])
		var/newcategory = input("Choose a category to search for:") in list("Any", "Fiction", "Non-Fiction", "Adult", "Reference", "Religion")
		if(newcategory)
			category = sanitize(newcategory)
		else
			category = "Any"
		category = sanitizeSQL(category)
	if(href_list["setauthor"])
		var/newauthor = input("Enter an author to search for:") as text|null
		if(newauthor)
			author = sanitize(newauthor)
		else
			author = null
		author = sanitizeSQL(author)
	if(href_list["search"])
		screenstate = 1

	if(href_list["back"])
		screenstate = 0

	src.add_fingerprint(usr)
	src.updateUsrDialog()
	return


/*
 * Library Computer
 */
// TODO: Make this an actual /obj/machinery/computer that can be crafted from circuit boards and such
// It is August 22nd, 2012... This TODO has already been here for months.. I wonder how long it'll last before someone does something about it. // Nov 2019. Nope.
/obj/machinery/librarycomp
	name = "Check-In/Out Computer"
	icon = 'icons/obj/library.dmi'
	icon_state = "computer"
	anchored = 1
	density = 1
	var/arcanecheckout = 0
	var/screenstate = 0 // 0 - Main Menu, 1 - Inventory, 2 - Checked Out, 3 - Check Out a Book
	var/sortby = "author"
	var/buffer_book
	var/buffer_mob
	var/upload_category = "Fiction"
	var/list/checkouts = list()
	var/list/inventory = list()
	var/checkoutperiod = 5 // In minutes
	var/obj/machinery/libraryscanner/scanner // Book scanner that will be used when uploading books to the Archive

	var/bibledelay = 0 // LOL NO SPAM (1 minute delay) -- Doohl

	var/static/list/all_books

	var/static/list/base_genre_books

/obj/machinery/librarycomp/Initialize(mapload)
	. = ..()

	if(!base_genre_books || !base_genre_books.len)
		base_genre_books = list(
			/obj/item/book/custom_library/fiction,
			/obj/item/book/custom_library/nonfiction,
			/obj/item/book/custom_library/reference,
			/obj/item/book/custom_library/religious,
			/obj/item/book/bundle/custom_library/fiction,
			/obj/item/book/bundle/custom_library/nonfiction,
			/obj/item/book/bundle/custom_library/reference,
			/obj/item/book/bundle/custom_library/religious
			)

	if(!all_books || !all_books.len)
		all_books = list()

		for(var/path in subtypesof(/obj/item/book/codex/lore))
			var/obj/item/book/C = new path(null)
			all_books[C.name] = C

		for(var/path in subtypesof(/obj/item/book/custom_library) - base_genre_books)
			var/obj/item/book/B = new path(null)
			all_books[B.title] = B

		for(var/path in subtypesof(/obj/item/book/bundle/custom_library) - base_genre_books)
			var/obj/item/book/M = new path(null)
			all_books[M.title] = M

/obj/machinery/librarycomp/attack_hand(mob/user, datum/event_args/actor/clickchain/e_args)
	usr.set_machine(src)
	var/dat = "<HEAD><TITLE>Book Inventory Management</TITLE></HEAD><BODY>\n" // <META HTTP-EQUIV='Refresh' CONTENT='10'>
	switch(screenstate)
		if(0)
			// Main Menu
			dat += {"<A href='?src=\ref[src];switchscreen=1'>1. View General Inventory</A><BR>
			<A href='?src=\ref[src];switchscreen=2'>2. View Checked Out Inventory</A><BR>
			<A href='?src=\ref[src];switchscreen=3'>3. Check out a Book</A><BR>
			<A href='?src=\ref[src];switchscreen=4'>4. Connect to External Archive</A><BR>
			<A href='?src=\ref[src];switchscreen=5'>5. Upload New Title to Archive</A><BR>
			<A href='?src=\ref[src];switchscreen=6'>6. Print a Bible</A><BR>
			<A href='?src=\ref[src];switchscreen=8'>8. Access NT Internal Archive</A><BR>"}
			if(src.emagged)
				dat += "<A href='?src=\ref[src];switchscreen=7'>7. Access the Forbidden Lore Vault</A><BR>"
			if(src.arcanecheckout)
				new /obj/item/book/tome(src.loc)
				var/datum/gender/T = GLOB.gender_datums[user.get_visible_gender()]
				to_chat(user, "<span class='warning'>Your sanity barely endures the seconds spent in the vault's browsing window. The only thing to remind you of this when you stop browsing is a dusty old tome sitting on the desk. You don't really remember printing it.</span>")
				user.visible_message("<span class='notice'>\The [user] stares at the blank screen for a few moments, [T.his] expression frozen in fear. When [T.he] finally awakens from it, [T.he] looks a lot older.</span>", 2)
				src.arcanecheckout = 0
		if(1)
			// Inventory
			dat += "<H3>Inventory</H3><BR>"
			for(var/obj/item/book/b in inventory)
				dat += "[b.name] <A href='?src=\ref[src];delbook=\ref[b]'>(Delete)</A><BR>"
			dat += "<A href='?src=\ref[src];switchscreen=0'>(Return to main menu)</A><BR>"
		if(2)
			// Checked Out
			dat += "<h3>Checked Out Books</h3><BR>"
			for(var/datum/borrowbook/b in checkouts)
				var/timetaken = world.time - b.getdate
				//timetaken *= 10
				timetaken /= 600
				timetaken = round(timetaken)
				var/timedue = b.duedate - world.time
				//timedue *= 10
				timedue /= 600
				if(timedue <= 0)
					timedue = "<font color=red><b>(OVERDUE)</b> [timedue]</font>"
				else
					timedue = round(timedue)
				dat += {"\"[b.bookname]\", Checked out to: [b.mobname]<BR>--- Taken: [timetaken] minutes ago, Due: in [timedue] minutes<BR>
				<A href='?src=\ref[src];checkin=\ref[b]'>(Check In)</A><BR><BR>"}
			dat += "<A href='?src=\ref[src];switchscreen=0'>(Return to main menu)</A><BR>"
		if(3)
			// Check Out a Book
			dat += {"<h3>Check Out a Book</h3><BR>
			Book: [src.buffer_book]
			<A href='?src=\ref[src];editbook=1'>\[Edit\]</A><BR>
			Recipient: [src.buffer_mob]
			<A href='?src=\ref[src];editmob=1'>\[Edit\]</A><BR>
			Checkout Date : [world.time/600]<BR>
			Due Date: [(world.time + checkoutperiod)/600]<BR>
			(Checkout Period: [checkoutperiod] minutes) (<A href='?src=\ref[src];increasetime=1'>+</A>/<A href='?src=\ref[src];decreasetime=1'>-</A>)
			<A href='?src=\ref[src];checkout=1'>(Commit Entry)</A><BR>
			<A href='?src=\ref[src];switchscreen=0'>(Return to main menu)</A><BR>"}
		if(4)
			dat += "<h3>External Archive</h3>"

			dat += "<h3><font color=red>Warning: System Administrator has slated this archive for removal. Personal uploads should be taken to the NT board of internal literature.</font></h3>"

			if(!SSdbcore.Connect())
				dat += "<font color=red><b>ERROR</b>: Unable to contact External Archive. Please contact your system administrator for assistance.</font>"
			else
				dat += {"<A href='?src=\ref[src];orderbyid=1'>(Order book by SS<sup>13</sup>BN)</A><BR><BR>
				<table>
				<tr><td><A href='?src=\ref[src];sort=author>AUTHOR</A></td><td><A href='?src=\ref[src];sort=title>TITLE</A></td><td><A href='?src=\ref[src];sort=category>CATEGORY</A></td><td></td></tr>"}
				var/datum/db_query/query = SSdbcore.RunQuery(
					"SELECT id, author, title, category FROM [DB_PREFIX_TABLE_NAME("library")] ORDER BY :sortby",
					list(
						"sortby" = sortby
					)
				)

				while(query.NextRow())
					var/id = query.item[1]
					var/author = query.item[2]
					var/title = query.item[3]
					var/category = query.item[4]
					dat += "<tr><td>[author]</td><td>[title]</td><td>[category]</td><td><A href='?src=\ref[src];targetid=[id]'>\[Order\]</A></td></tr>"
				dat += "</table>"
			dat += "<BR><A href='?src=\ref[src];switchscreen=0'>(Return to main menu)</A><BR>"
		if(5)
			dat += "<H3>Upload a New Title</H3>"
			if(!scanner)
				for(var/obj/machinery/libraryscanner/S in range(9))
					scanner = S
					break
			if(!scanner)
				dat += "<FONT color=red>No scanner found within wireless network range.</FONT><BR>"
			else if(!scanner.cache)
				dat += "<FONT color=red>No data found in scanner memory.</FONT><BR>"
			else
				dat += {"<TT>Data marked for upload...</TT><BR>
				<TT>Title: </TT>[scanner.cache.name]<BR>"}
				if(!scanner.cache.author)
					scanner.cache.author = "Anonymous"
				dat += {"<TT>Author: </TT><A href='?src=\ref[src];setauthor=1'>[scanner.cache.author]</A><BR>
				<TT>Category: </TT><A href='?src=\ref[src];setcategory=1'>[upload_category]</A><BR>
				<A href='?src=\ref[src];upload=1'>\[Upload\]</A><BR>"}
			dat += "<A href='?src=\ref[src];switchscreen=0'>(Return to main menu)</A><BR>"
		if(7)
			dat += {"<h3>Accessing Forbidden Lore Vault v 1.3</h3>
			Are you absolutely sure you want to proceed? EldritchTomes Inc. takes no responsibilities for loss of sanity resulting from this action.<p>
			<A href='?src=\ref[src];arccheckout=1'>Yes.</A><BR>
			<A href='?src=\ref[src];switchscreen=0'>No.</A><BR>"}
		if(8)
			dat += "<h3>NT Internal Archive</h3>"
			if(!all_books || !all_books.len)
				dat +=	"<font color=red><b>ERROR</b> Something has gone seriously wrong. Contact System Administrator for more information.</font>"
			else
				dat += {"<table>
				<tr><td><A href='?src=\ref[src];sort=author>AUTHOR</A></td><td><A href='?src=\ref[src];sort=title>TITLE</A></td><td><A href='?src=\ref[src];sort=category>CATEGORY</A></td><td></td></tr>"}

				for(var/name in all_books)
					var/obj/item/book/masterbook = all_books[name]
					var/id = masterbook.type
					var/author = masterbook.author
					var/title = masterbook.name
					var/category = masterbook.libcategory
					dat += "<tr><td>[author]</td><td>[title]</td><td>[category]</td><td><A href='?src=\ref[src];hardprint=[id]'>\[Order\]</A></td></tr>"
				dat += "</table>"
			dat += "<BR><A href='?src=\ref[src];switchscreen=0'>(Return to main menu)</A><BR>"

	//dat += "<A HREF='?src=\ref[user];mach_close=library'>Close</A><br><br>"
	user << browse(dat, "window=library")
	onclose(user, "library")

/obj/machinery/librarycomp/emag_act(var/remaining_charges, var/mob/user)
	if (src.density && !src.emagged)
		src.emagged = 1
		return 1

/obj/machinery/librarycomp/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/barcodescanner))
		var/obj/item/barcodescanner/scanner = W
		scanner.computer = src
		to_chat(user, "[scanner]'s associated machine has been set to [src].")
		for (var/mob/V in hearers(src))
			V.show_message("[src] lets out a low, short blip.", 2)
	else
		..()

/obj/machinery/librarycomp/Topic(href, href_list)
	if(..())
		usr << browse(null, "window=library")
		onclose(usr, "library")
		return

	if(href_list["switchscreen"])
		switch(href_list["switchscreen"])
			if("0")
				screenstate = 0
			if("1")
				screenstate = 1
			if("2")
				screenstate = 2
			if("3")
				screenstate = 3
			if("4")
				screenstate = 4
			if("5")
				screenstate = 5
			if("6")
				if(!bibledelay)

					var/obj/item/storage/bible/B = new /obj/item/storage/bible(src.loc)
					if(SSticker && ( SSticker.Bible_icon_state && SSticker.Bible_item_state) )
						B.icon_state = SSticker.Bible_icon_state
						B.item_state = SSticker.Bible_item_state
						B.name = SSticker.Bible_name
						B.deity_name = SSticker.Bible_deity_name

					bibledelay = 1
					spawn(60)
						bibledelay = 0

				else
					for (var/mob/V in hearers(src))
						V.show_message("<b>[src]</b>'s monitor flashes, \"Bible printer currently unavailable, please wait a moment.\"")

			if("7")
				screenstate = 7
			if("8")
				screenstate = 8
	if(href_list["arccheckout"])
		if(src.emagged)
			src.arcanecheckout = 1
		src.screenstate = 0
	if(href_list["increasetime"])
		checkoutperiod += 1
	if(href_list["decreasetime"])
		checkoutperiod -= 1
		if(checkoutperiod < 1)
			checkoutperiod = 1
	if(href_list["editbook"])
		buffer_book = sanitizeSafe(input("Enter the book's title:") as text|null)
	if(href_list["editmob"])
		buffer_mob = sanitize(input("Enter the recipient's name:") as text|null, MAX_NAME_LEN)
	if(href_list["checkout"])
		var/datum/borrowbook/b = new /datum/borrowbook
		b.bookname = sanitizeSafe(buffer_book)
		b.mobname = sanitize(buffer_mob)
		b.getdate = world.time
		b.duedate = world.time + (checkoutperiod * 600)
		checkouts.Add(b)
	if(href_list["checkin"])
		var/datum/borrowbook/b = locate(href_list["checkin"])
		checkouts.Remove(b)
	if(href_list["delbook"])
		var/obj/item/book/b = locate(href_list["delbook"])
		inventory.Remove(b)
	if(href_list["setauthor"])
		var/newauthor = sanitize(input("Enter the author's name: ") as text|null)
		if(newauthor)
			scanner.cache.author = newauthor
	if(href_list["setcategory"])
		var/newcategory = input("Choose a category: ") in list("Fiction", "Non-Fiction", "Adult", "Reference", "Religion")
		if(newcategory)
			upload_category = newcategory

	if(href_list["upload"])
		if(scanner)
			if(scanner.cache)
				var/choice = input("Are you certain you wish to upload this title to the Archive?") in list("Confirm", "Abort")
				if(choice == "Confirm")
					if(scanner.cache.unique)
						alert("This book has been rejected from the database. Aborting!")
					else
						if(!SSdbcore.Connect())
							alert("Connection to Archive has been severed. Aborting.")
						else
							var/sqltitle = sanitizeSQL(scanner.cache.name)
							var/sqlauthor = sanitizeSQL(scanner.cache.author)
							var/sqlcontent = sanitizeSQL(scanner.cache.dat)
							var/sqlcategory = sanitizeSQL(upload_category)
							var/datum/db_query/query = SSdbcore.NewQuery(
								"INSERT INTO [DB_PREFIX_TABLE_NAME("library")] (author, title, content, category) VALUES (:author, :title, :content, :category)",
								list(
									"author" = sqlauthor,
									"title" = sqltitle,
									"content" = sqlcontent,
									"category" = sqlcategory
								)
							)
							if(!query.Execute())
								to_chat(usr, query.ErrorMsg())
							else
								log_game("[usr.name]/[usr.key] has uploaded the book titled [scanner.cache.name], [length(scanner.cache.dat)] signs")
								alert("Upload Complete.")
							qdel(query)

	if(href_list["targetid"])
		var/sqlid = sanitizeSQL(href_list["targetid"])
		if(!SSdbcore.Connect())
			alert("Connection to Archive has been severed. Aborting.")
		if(bibledelay)
			for (var/mob/V in hearers(src))
				V.show_message("<b>[src]</b>'s monitor flashes, \"Printer unavailable. Please allow a short time before attempting to print.\"")
		else
			bibledelay = 1
			spawn(6)
				bibledelay = 0
			var/datum/db_query/query = SSdbcore.RunQuery(
				"SELECT * FROM [DB_PREFIX_TABLE_NAME("library")] WHERE id = :id",
				list(
					"id" = sqlid
				)
			)

			while(query.NextRow())
				var/author = query.item[2]
				var/title = query.item[3]
				var/content = query.item[4]
				var/obj/item/book/B = new(src.loc)
				B.name = "Book: [title]"
				B.title = title
				B.author = author
				B.dat = content
				B.icon_state = "book[rand(1,7)]"
				src.visible_message("[src]'s printer hums as it produces a completely bound book. How did it do that?")
				break

	if(href_list["orderbyid"])
		var/orderid = input("Enter your order:") as num|null
		if(orderid)
			if(isnum(orderid))
				var/nhref = "src=\ref[src];targetid=[orderid]"
				spawn() src.Topic(nhref, params2list(nhref), src)
	if(href_list["sort"] in list("author", "title", "category"))
		sortby = href_list["sort"]
	if(href_list["hardprint"])
		var/newpath = href_list["hardprint"]
		var/obj/item/book/NewBook = new newpath(get_turf(src))
		NewBook.name = "Book: [NewBook.name]"
	src.add_fingerprint(usr)
	src.updateUsrDialog()
	return

/*
 * Library Scanner
 */
/obj/machinery/libraryscanner
	name = "scanner"
	icon = 'icons/obj/library.dmi'
	icon_state = "bigscanner"
	anchored = 1
	density = 1
	var/obj/item/book/cache		// Last scanned book

/obj/machinery/libraryscanner/attackby(obj/item/I, mob/living/user, params, clickchain_flags, damage_multiplier)
	if(istype(I, /obj/item/book))
		if(!user.attempt_insert_item_for_installation(I, src))
			return

/obj/machinery/libraryscanner/attack_hand(mob/user, datum/event_args/actor/clickchain/e_args)
	usr.set_machine(src)
	var/dat = "<HEAD><TITLE>Scanner Control Interface</TITLE></HEAD><BODY>\n" // <META HTTP-EQUIV='Refresh' CONTENT='10'>
	if(cache)
		dat += "<FONT color=#005500>Data stored in memory.</FONT><BR>"
	else
		dat += "No data stored in memory.<BR>"
	dat += "<A href='?src=\ref[src];scan=1'>\[Scan\]</A>"
	if(cache)
		dat += "       <A href='?src=\ref[src];clear=1'>\[Clear Memory\]</A><BR><BR><A href='?src=\ref[src];eject=1'>\[Remove Book\]</A>"
	else
		dat += "<BR>"
	user << browse(dat, "window=scanner")
	onclose(user, "scanner")

/obj/machinery/libraryscanner/Topic(href, href_list)
	if(..())
		usr << browse(null, "window=scanner")
		onclose(usr, "scanner")
		return

	if(href_list["scan"])
		for(var/obj/item/book/B in contents)
			cache = B
			break
	if(href_list["clear"])
		cache = null
	if(href_list["eject"])
		for(var/obj/item/book/B in contents)
			B.loc = src.loc
	src.add_fingerprint(usr)
	src.updateUsrDialog()
	return


/*
 * Book binder
 */
/obj/machinery/bookbinder
	name = "Book Binder"
	icon = 'icons/obj/machines/fabricators/book.dmi'
	icon_state = "binder"
	base_icon_state = "binder"
	anchored = TRUE
	density = TRUE

/obj/machinery/bookbinder/update_icon_state()
	. = ..()
	if(machine_stat & NOPOWER)
		icon_state = "[base_icon_state]-off"
	else
		icon_state = base_icon_state

/obj/machinery/bookbinder/update_overlays()
	. = ..()
	cut_overlays()
	if(panel_open)
		add_overlay("[base_icon_state]-panel")

/obj/machinery/bookbinder/attackby(obj/item/I, mob/living/user, params, clickchain_flags, damage_multiplier)
	if(istype(I, /obj/item/paper))
		if(!user.attempt_insert_item_for_installation(I, src))
			return
		user.visible_message("[user] loads some paper into [src].", "You load some paper into [src].")
		flick_overlay_view("[base_icon_state]-load-paper", 10)
		flick_overlay_view("[base_icon_state]-active", 12)
		visible_message("[src] begins to hum as it warms up its printing drums.")
		sleep(rand(200,400))
		visible_message("[src] whirs as it prints and binds a new book.")
		var/obj/item/book/b = new(loc)
		b.dat = I:info
		b.name = "Print Job #" + "[rand(100, 999)]"
		b.icon_state = "book[rand(1,7)]"
		qdel(I)
	else
		..()
