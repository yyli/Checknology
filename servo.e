servo					be		servo_done		servo_turns		zero
				out		3		servo_turns
				out		4		servo_port
						out     135             servo_turns
						out		139				one
						out		138				servo_port
                		out     136             one
servo_loop      		in      137             servo_finish
                		bne     servo_loop      servo_finish    one
                		out     136             zero
servo_done				ret		servo_retvar

servo_finish	.data	0
servo_retvar	.data	0
servo_turns		.data	0
servo_port		.data	0
