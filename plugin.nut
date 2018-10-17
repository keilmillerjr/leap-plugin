// --------------------
// Plugin User Options
// --------------------

class UserConfig </ help="Plugin helps to leap over empty filters." /> {
	</ label="Exception",
		help="Plugin will not leap over this filter. This will prevent an infinite loop, should your romlist for the current display != 0. You must have a filter with roms in it.",
		order=1 />
	exception="All";
}

// --------------------
// Leap
// --------------------

class Leap {
	config = null;
	exception = null;

	constructor() {
		config = fe.get_config();
		exception =  config["exception"];

		fe.add_transition_callback(this, "transitions");
	}

	function transitions(ttype, var, ttime) {
		switch (ttype) {
			case Transition.ToNewList:
				// Return if filter exception
				try {
					if (fe.filters[fe.list.filter_index].name == exception) return false;
				}
				catch (e) {
					// error is because fe.list.filter_index == -1 when display menu is shown
					return false;
				}

				if (fe.list.size == 0) {
					switch (var) {
						case -1:
							fe.signal("prev_filter");
							break;
						case 0:
						case 1:
							fe.signal("next_filter");
							break;
					}
				}
				break;
		}
		return false;
	}
}
fe.plugin["Leap"] <- Leap();
