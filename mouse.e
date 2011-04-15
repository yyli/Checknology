mouse_loop      in      70              mouse_valid
	            be	    mouse_loop	    mouse_valid	    mouse_zero
	            in	    72	            mouse_deltax
	            in	    73	            mouse_deltay
	            in	    74	            mouse_left
	            in	    75	            mouse_center
	            in	    76	            mouse_right
mouse_ack	    out	    71	            mouse_one
	            in	    70	            mouse_valid
	            be	    mouse_ack	    mouse_valid	    mouse_one
	            out	    71	            mouse_zero
	            ret	    mouse_holder
	
	
mouse_holder    .data   0
mouse_zero	    .data	0
mouse_valid	    .data	0
mouse_one	    .data	1
mouse_deltax    .data	0
mouse_deltay	.data	0
mouse_left	    .data	0
mouse_center	.data	0
mouse_right	    .data	0
