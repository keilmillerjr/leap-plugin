// Layout User Options
class UserConfig </ help="A plugin that helps to leap over empty filters." /> {
	</ label="Exception",
		help="Leap plugin will not leap over this filter. This will prevent an infinite loop, should your romlist for the current display == 0..",
		order=1 />
	exception="All";
}

// Debug
class Leap {
	config = null;
	exception = "";

	constructor() {
		config = fe.get_config();
		exception =  config["exception"];

		fe.add_transition_callback(this, "transitions");
	}

	function transitions(ttype, var, ttime) {
		if (ttype == Transition.StartLayout || Transition.ToNewSelection || Transition.ToNewList) logic(var);
	}

	function logic(direction) {
		if ((fe.filters[fe.list.filter_index].name != exception) && (fe.list.size == 0)) {
	 		if (direction < 0) fe.signal("prev_filter");
	 		else fe.signal("next_filter");
		}
	}
}
fe.plugin["Leap"] <- Leap();